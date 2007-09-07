Return-Path: <MBenedict@twacs.com>
Received: from outbound1-cpk-R.bigfish.com (outbound-cpk.frontbridge.com
	[207.46.163.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id E39EBDDEE9
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  8 Sep 2007 01:02:28 +1000 (EST)
Received: from outbound1-cpk.bigfish.com (localhost.localdomain [127.0.0.1])
	by outbound1-cpk-R.bigfish.com (Postfix) with ESMTP id B490E330A46
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  7 Sep 2007 15:02:25 +0000 (UTC)
Received: from mail61-cpk-R.bigfish.com (unknown [10.2.40.3])
	by outbound1-cpk.bigfish.com (Postfix) with ESMTP id B30635A004D
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  7 Sep 2007 15:02:25 +0000 (UTC)
Received: from mail61-cpk (localhost.localdomain [127.0.0.1])
	by mail61-cpk-R.bigfish.com (Postfix) with ESMTP id 791AD8302AF
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  7 Sep 2007 15:02:25 +0000 (UTC)
Received: from mail.twacs.com (unknown [68.89.149.4])
	by mail61-cpk.bigfish.com (Postfix) with ESMTP id E99D8AB0055
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  7 Sep 2007 15:02:24 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: futex priority based wakeup
Date: Fri, 7 Sep 2007 10:02:18 -0500
Message-ID: <BAF8B1E0BB28024A90895E746A3B610D1C2BCD@twx-exch01.twacs.local>
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

I recently upgraded to 2.6.22 to get the priority based futex wakeup
behavior.  However, when I run a simple program (see below), based on
either a pthread_mutex_t or a sem_t, it seems that threads are woken up
in FIFO order.  I am using glibc 2.3.6 with NPTL and TLS, based off
crossdev-0.43.  Could someone help me get priority-based wakeup or point
me to a better place to get this question answered?
	Thank you,
		Michael

Code:

pthread_mutex_t mymutex =3D PTHREAD_MUTEX_INITIALIZER;

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
