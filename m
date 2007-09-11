Return-Path: <lipovsky@cs.bu.edu>
Received: from cs3.bu.edu (cs3.bu.edu [128.197.12.8])
	by ozlabs.org (Postfix) with ESMTP id 4AA42DDDFC
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 12 Sep 2007 09:00:01 +1000 (EST)
From: "Ilya Lipovsky" <lipovsky@cs.bu.edu>
To: "'Benedict, Michael'" <MBenedict@twacs.com>, <linuxppc-embedded@ozlabs.org>
Subject: RE: futex priority based wakeup
Date: Tue, 11 Sep 2007 18:59:28 -0400
Message-ID: <000001c7f4c7$7a7ab5c0$3a0d10ac@Radstone.Local>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <BAF8B1E0BB28024A90895E746A3B610D1C2BE7@twx-exch01.twacs.local>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hmm. Just for kicks - inside the important thread could you add:

int curpolicy;
struct sched_param sp;
pthread_getschedparam (pthread_self (), &curpolicy, &sp)
printf("important's policy is %d and priority is %d\n", curpolicy,
sp.__sched_priority);

before the very first futex syscall and after your "printf("important got
futex!\n");" line.

Do similar for the unimportant thread, and see if you get anything weird -
e.g. priorities come out to be the same for threads.


-----Original Message-----
From: linuxppc-embedded-bounces+lipovsky=cs.bu.edu@ozlabs.org
[mailto:linuxppc-embedded-bounces+lipovsky=cs.bu.edu@ozlabs.org] On Behalf
Of Benedict, Michael
Sent: Monday, September 10, 2007 5:41 PM
To: linuxppc-embedded@ozlabs.org
Subject: RE: futex priority based wakeup

Ilya Lipovsky wrote:
> Your code looks correct to me, so if the kernel developers
> did their job
> correctly, the only potentially weak link is glibc.
> 

Well, either the kernel developers didn't do their job, or I am missing
something.  The following also fails, and it should be bypassing glibc:

#define _XOPEN_SOURCE 600

#include <linux/futex.h>
#include <sys/time.h>
#include <asm/atomic.h>

#include <sys/syscall.h>
#include <unistd.h>

#include <sched.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>

int myfutex = 0;

void *important(void *ign)
{
        sleep(1);
        printf("important waiting for futex\n");
        fflush(stdout);
        if(syscall(SYS_futex, &myfutex, FUTEX_WAIT, 0, NULL)) {
                perror("futex");
                exit(1);
        } else {
                printf("important got futex!\n");
                fflush(stdout);
                syscall(SYS_futex, &myfutex, FUTEX_WAKE, 1, NULL);
}

        return NULL;
}


void *unimportant(void *ign)
{
        printf("unimportant waiting for futex\n");
        fflush(stdout);
        if(syscall(SYS_futex, &myfutex, FUTEX_WAIT, 0, NULL)) {
                perror("futex");
                exit(1);
        } else {
                printf("unimportant got futex!\n");
                fflush(stdout);
                syscall(SYS_futex, &myfutex, FUTEX_WAKE, 1, NULL);
}

        return NULL;
}

int main()
{
        struct sched_param p;
        pthread_attr_t attr;
        pthread_t i, u;

        p.__sched_priority = sched_get_priority_min(SCHED_FIFO);
        if(-1 == p.__sched_priority) {
                perror("sched_get_priority_min");
                return 1;
        }
        pthread_attr_init(&attr);
        pthread_attr_setschedpolicy(&attr, SCHED_FIFO);
        pthread_attr_setschedparam(&attr, &p);
        pthread_create(&u, &attr, unimportant, NULL);

        p.__sched_priority = sched_get_priority_max(SCHED_FIFO);
        pthread_attr_setschedparam(&attr, &p);
        pthread_create(&i, &attr, important, NULL);

        sleep(5);
        printf("futex FUTEX_WAKE\n");
        fflush(stdout);
        syscall(SYS_futex, &myfutex, FUTEX_WAKE, 1, NULL);

        pthread_join(u, NULL);
        pthread_join(i, NULL);

        return 0;
}

Which produces:
unimportant waiting for futex
important waiting for futex
futex FUTEX_WAKE
unimportant got futex!
important got futex!


Could someone with 2.6.22 please verify?  

_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded
