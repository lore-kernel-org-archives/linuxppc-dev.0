Return-Path: <lipovsky@cs.bu.edu>
Received: from cs3.bu.edu (cs3.bu.edu [128.197.12.8])
	by ozlabs.org (Postfix) with ESMTP id B6410DDF14
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  8 Sep 2007 03:16:59 +1000 (EST)
From: "Ilya Lipovsky" <lipovsky@cs.bu.edu>
To: "'Benedict, Michael'" <MBenedict@twacs.com>, <linuxppc-embedded@ozlabs.org>
Subject: RE: futex priority based wakeup
Date: Fri, 7 Sep 2007 13:16:27 -0400
Message-ID: <000a01c7f172$e5a5e9d0$3a0d10ac@Radstone.Local>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <000901c7f16d$fbbc9d40$3a0d10ac@Radstone.Local>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

...Or maybe I am wrong :). Could you put fflush(stdout) after each printf,
just to be completely certain that it misbehaves?

-----Original Message-----
From: linuxppc-embedded-bounces+lipovsky=cs.bu.edu@ozlabs.org
[mailto:linuxppc-embedded-bounces+lipovsky=cs.bu.edu@ozlabs.org] On Behalf
Of Ilya Lipovsky
Sent: Friday, September 07, 2007 12:41 PM
To: 'Benedict, Michael'; linuxppc-embedded@ozlabs.org
Subject: RE: futex priority based wakeup

Looks like it is a libc issue. Apparently, GNU libc supports priority
futexes only in version 2.5 and higher.

-----Original Message-----
From: linuxppc-embedded-bounces+lipovsky=cs.bu.edu@ozlabs.org
[mailto:linuxppc-embedded-bounces+lipovsky=cs.bu.edu@ozlabs.org] On Behalf
Of Benedict, Michael
Sent: Friday, September 07, 2007 11:02 AM
To: linuxppc-embedded@ozlabs.org
Subject: futex priority based wakeup

I recently upgraded to 2.6.22 to get the priority based futex wakeup
behavior.  However, when I run a simple program (see below), based on
either a pthread_mutex_t or a sem_t, it seems that threads are woken up
in FIFO order.  I am using glibc 2.3.6 with NPTL and TLS, based off
crossdev-0.43.  Could someone help me get priority-based wakeup or point
me to a better place to get this question answered?
	Thank you,
		Michael

Code:

pthread_mutex_t mymutex = PTHREAD_MUTEX_INITIALIZER;

void *important(void *ign)
{
        sleep(1);
        printf("important waiting for mutex\n");
        if(pthread_mutex_lock(&mymutex)) {
                perror("sem_wait");
                exit(1);
        } else {
                printf("important got mutex!\n");
                pthread_mutex_unlock(&mymutex);
        }

        return NULL;
}


void *unimportant(void *ign)
{
        printf("unimportant waiting for mutex\n");
        if(pthread_mutex_lock(&mymutex)) {
                perror("sem_wait");
                exit(1);
        } else {
                printf("unimportant got mutex!\n");
                pthread_mutex_unlock(&mymutex);
        }

        return NULL;
}

int main()
{
        struct sched_param p;
        pthread_attr_t attr;
        pthread_t i, u;

        pthread_mutex_lock(&mymutex);

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
        printf("main unlocking mutex\n");
        pthread_mutex_unlock(&mymutex);

        pthread_join(u, NULL);
        pthread_join(i, NULL);

        return 0;
}

Which produces:
unimportant waiting for mutex
important waiting for mutex
main unlocking mutex
unimportant got mutex!
important got mutex!

_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded

_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded
