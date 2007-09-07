Return-Path: <lipovsky@cs.bu.edu>
Received: from cs3.bu.edu (cs3.bu.edu [128.197.12.8])
	by ozlabs.org (Postfix) with ESMTP id EC19CDDEE3
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  8 Sep 2007 03:46:32 +1000 (EST)
From: "Ilya Lipovsky" <lipovsky@cs.bu.edu>
To: "'Benedict, Michael'" <MBenedict@twacs.com>, <linuxppc-embedded@ozlabs.org>
Subject: RE: futex priority based wakeup
Date: Fri, 7 Sep 2007 13:45:56 -0400
Message-ID: <000e01c7f177$05ab1990$3a0d10ac@Radstone.Local>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <BAF8B1E0BB28024A90895E746A3B610D1C2BD7@twx-exch01.twacs.local>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Yes, I am uncertain. If it isn't a major headache, I think you can try the
newest version (I think it's 2.6.1) and see if you get some resolution.

Your code looks correct to me, so if the kernel developers did their job
correctly, the only potentially weak link is glibc.

I think pthread priority inheritance is an independent concept, but you
shouldn't care since you explicitly set priorities.

My kernel is 2.6.21, so I am of no help here, unfortunately.

By the way, kudos to you for making crosstool compile glibc with NPTL
support, I had issues getting there (I have 2.4 with NPTL, but it is
natively installed)! How did you manage to get around the intermediate's
compiler's lack of "__thread" support issue?

Please do share the outcome!!

-Ilya

-----Original Message-----
From: linuxppc-embedded-bounces+lipovsky=cs.bu.edu@ozlabs.org
[mailto:linuxppc-embedded-bounces+lipovsky=cs.bu.edu@ozlabs.org] On Behalf
Of Benedict, Michael
Sent: Friday, September 07, 2007 1:25 PM
To: linuxppc-embedded@ozlabs.org
Subject: RE: futex priority based wakeup

Thank you for the help!

Same result with fflush :(.

Are you maybe wrong because you have tested 2.5 and it doesn't work?  Or
just uncertain?

The only thing I have read that mentions glibc version is the work Ingo
did against 2.4 glibc and in the 2.6.16-mm1 patches...
http://people.redhat.com/mingo/PI-futex-patches/.  I can not detrmine
how this relates to the 2.6.22 priority based futex wakeup commit.

I am currently fighting crosstool-0.43 to build a newer glibc and I will
share results if/when I get that to work.
	-Michael

Ilya Lipovsky wrote:
> ...Or maybe I am wrong :). Could you put fflush(stdout) after
> each printf,
> just to be completely certain that it misbehaves?
> 
> -----Original Message-----
> From: linuxppc-embedded-bounces+lipovsky=cs.bu.edu@ozlabs.org
> [mailto:linuxppc-embedded-bounces+lipovsky=cs.bu.edu@ozlabs.or g] On
> Behalf Of Ilya Lipovsky Sent: Friday, September 07, 2007 12:41 PM
> To: 'Benedict, Michael'; linuxppc-embedded@ozlabs.org
> Subject: RE: futex priority based wakeup
> 
> Looks like it is a libc issue. Apparently, GNU libc supports priority
> futexes only in version 2.5 and higher.
> 
> -----Original Message-----
> From: linuxppc-embedded-bounces+lipovsky=cs.bu.edu@ozlabs.org
> [mailto:linuxppc-embedded-bounces+lipovsky=cs.bu.edu@ozlabs.or g] On
> Behalf Of Benedict, Michael Sent: Friday, September 07, 2007 11:02 AM
> To: linuxppc-embedded@ozlabs.org
> Subject: futex priority based wakeup
> 
> I recently upgraded to 2.6.22 to get the priority based futex wakeup
> behavior.  However, when I run a simple program (see below), based on
> either a pthread_mutex_t or a sem_t, it seems that threads
> are woken up
> in FIFO order.  I am using glibc 2.3.6 with NPTL and TLS, based off
> crossdev-0.43.  Could someone help me get priority-based
> wakeup or point
> me to a better place to get this question answered? 	Thank you,
> 		Michael
> 
> Code:
> 
> pthread_mutex_t mymutex = PTHREAD_MUTEX_INITIALIZER;
> 
> void *important(void *ign)
> {
>         sleep(1);
>         printf("important waiting for mutex\n");
>         if(pthread_mutex_lock(&mymutex)) {
>                 perror("sem_wait");
>                 exit(1);
>         } else {
>                 printf("important got mutex!\n");
>                 pthread_mutex_unlock(&mymutex);
>         }
> 
>         return NULL;
> }
> 
> 
> void *unimportant(void *ign)
> {
>         printf("unimportant waiting for mutex\n");
>         if(pthread_mutex_lock(&mymutex)) {
>                 perror("sem_wait");
>                 exit(1);
>         } else {
>                 printf("unimportant got mutex!\n");
>                 pthread_mutex_unlock(&mymutex);
>         }
> 
>         return NULL;
> }
> 
> int main()
> {
>         struct sched_param p;
>         pthread_attr_t attr;
>         pthread_t i, u;
> 
>         pthread_mutex_lock(&mymutex);
> 
>         p.__sched_priority = sched_get_priority_min(SCHED_FIFO);
>         if(-1 == p.__sched_priority) {
>                 perror("sched_get_priority_min");
>                 return 1;
>         }
>         pthread_attr_init(&attr);
>         pthread_attr_setschedpolicy(&attr, SCHED_FIFO);
>         pthread_attr_setschedparam(&attr, &p);
>         pthread_create(&u, &attr, unimportant, NULL);
> 
>         p.__sched_priority = sched_get_priority_max(SCHED_FIFO);
>         pthread_attr_setschedparam(&attr, &p);
>         pthread_create(&i, &attr, important, NULL);
> 
>         sleep(5);
>         printf("main unlocking mutex\n");
>         pthread_mutex_unlock(&mymutex);
> 
>         pthread_join(u, NULL);
>         pthread_join(i, NULL);
> 
>         return 0;
> }
> 
> Which produces:
> unimportant waiting for mutex
> important waiting for mutex
> main unlocking mutex
> unimportant got mutex!
> important got mutex!
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded


_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded
