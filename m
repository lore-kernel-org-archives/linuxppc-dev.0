Return-Path: <MBenedict@twacs.com>
Received: from mail103-dub-R.bigfish.com (mail-dub.bigfish.com
	[213.199.154.10])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id C730FDDE43
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 11 Sep 2007 07:59:03 +1000 (EST)
Received: from mail103-dub (localhost.localdomain [127.0.0.1])
	by mail103-dub-R.bigfish.com (Postfix) with ESMTP id D9504190059C
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 10 Sep 2007 21:40:08 +0000 (UTC)
Received: from mail.twacs.com (unknown [68.89.149.4])
	by mail103-dub.bigfish.com (Postfix) with ESMTP id DB7B73D8079
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 10 Sep 2007 21:40:06 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: futex priority based wakeup
Date: Mon, 10 Sep 2007 16:41:06 -0500
Message-ID: <BAF8B1E0BB28024A90895E746A3B610D1C2BE7@twx-exch01.twacs.local>
In-Reply-To: <000e01c7f177$05ab1990$3a0d10ac@Radstone.Local>
References: <BAF8B1E0BB28024A90895E746A3B610D1C2BD7@twx-exch01.twacs.local>
	<000e01c7f177$05ab1990$3a0d10ac@Radstone.Local>
From: "Benedict, Michael" <MBenedict@twacs.com>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Ilya Lipovsky wrote:
> Your code looks correct to me, so if the kernel developers
> did their job
> correctly, the only potentially weak link is glibc.
>=20

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

int myfutex =3D 0;

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

        p.__sched_priority =3D sched_get_priority_min(SCHED_FIFO);
        if(-1 =3D=3D p.__sched_priority) {
                perror("sched_get_priority_min");
                return 1;
        }
        pthread_attr_init(&attr);
        pthread_attr_setschedpolicy(&attr, SCHED_FIFO);
        pthread_attr_setschedparam(&attr, &p);
        pthread_create(&u, &attr, unimportant, NULL);

        p.__sched_priority =3D sched_get_priority_max(SCHED_FIFO);
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


Could someone with 2.6.22 please verify? =20
