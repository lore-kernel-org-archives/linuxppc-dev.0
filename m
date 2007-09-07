Return-Path: <MBenedict@twacs.com>
Received: from outbound3-cpk-R.bigfish.com (outbound-cpk.frontbridge.com
	[207.46.163.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 57E64DDF1B
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  8 Sep 2007 03:25:16 +1000 (EST)
Received: from outbound3-cpk.bigfish.com (localhost.localdomain [127.0.0.1])
	by outbound3-cpk-R.bigfish.com (Postfix) with ESMTP id 279E76689BD
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  7 Sep 2007 17:25:12 +0000 (UTC)
Received: from mail34-cpk-R.bigfish.com (unknown [10.2.40.3])
	by outbound3-cpk.bigfish.com (Postfix) with ESMTP id 25C2480004D
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  7 Sep 2007 17:25:12 +0000 (UTC)
Received: from mail34-cpk (localhost.localdomain [127.0.0.1])
	by mail34-cpk-R.bigfish.com (Postfix) with ESMTP id 17ED7AE0150
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  7 Sep 2007 17:25:12 +0000 (UTC)
Received: from mail.twacs.com (unknown [68.89.149.4])
	by mail34-cpk.bigfish.com (Postfix) with ESMTP id A57F1488046
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  7 Sep 2007 17:25:11 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: futex priority based wakeup
Date: Fri, 7 Sep 2007 12:24:54 -0500
Message-ID: <BAF8B1E0BB28024A90895E746A3B610D1C2BD7@twx-exch01.twacs.local>
In-Reply-To: <000a01c7f172$e5a5e9d0$3a0d10ac@Radstone.Local>
References: <000901c7f16d$fbbc9d40$3a0d10ac@Radstone.Local>
	<000a01c7f172$e5a5e9d0$3a0d10ac@Radstone.Local>
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
>=20
> -----Original Message-----
> From: linuxppc-embedded-bounces+lipovsky=3Dcs.bu.edu@ozlabs.org
> [mailto:linuxppc-embedded-bounces+lipovsky=3Dcs.bu.edu@ozlabs.or g] On
> Behalf Of Ilya Lipovsky Sent: Friday, September 07, 2007 12:41 PM
> To: 'Benedict, Michael'; linuxppc-embedded@ozlabs.org
> Subject: RE: futex priority based wakeup
>=20
> Looks like it is a libc issue. Apparently, GNU libc supports priority
> futexes only in version 2.5 and higher.
>=20
> -----Original Message-----
> From: linuxppc-embedded-bounces+lipovsky=3Dcs.bu.edu@ozlabs.org
> [mailto:linuxppc-embedded-bounces+lipovsky=3Dcs.bu.edu@ozlabs.or g] On
> Behalf Of Benedict, Michael Sent: Friday, September 07, 2007 11:02 AM
> To: linuxppc-embedded@ozlabs.org
> Subject: futex priority based wakeup
>=20
> I recently upgraded to 2.6.22 to get the priority based futex wakeup
> behavior.  However, when I run a simple program (see below), based on
> either a pthread_mutex_t or a sem_t, it seems that threads
> are woken up
> in FIFO order.  I am using glibc 2.3.6 with NPTL and TLS, based off
> crossdev-0.43.  Could someone help me get priority-based
> wakeup or point
> me to a better place to get this question answered? 	Thank you,
> 		Michael
>=20
> Code:
>=20
> pthread_mutex_t mymutex =3D PTHREAD_MUTEX_INITIALIZER;
>=20
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
>=20
>         return NULL;
> }
>=20
>=20
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
>=20
>         return NULL;
> }
>=20
> int main()
> {
>         struct sched_param p;
>         pthread_attr_t attr;
>         pthread_t i, u;
>=20
>         pthread_mutex_lock(&mymutex);
>=20
>         p.__sched_priority =3D sched_get_priority_min(SCHED_FIFO);
>         if(-1 =3D=3D p.__sched_priority) {
>                 perror("sched_get_priority_min");
>                 return 1;
>         }
>         pthread_attr_init(&attr);
>         pthread_attr_setschedpolicy(&attr, SCHED_FIFO);
>         pthread_attr_setschedparam(&attr, &p);
>         pthread_create(&u, &attr, unimportant, NULL);
>=20
>         p.__sched_priority =3D sched_get_priority_max(SCHED_FIFO);
>         pthread_attr_setschedparam(&attr, &p);
>         pthread_create(&i, &attr, important, NULL);
>=20
>         sleep(5);
>         printf("main unlocking mutex\n");
>         pthread_mutex_unlock(&mymutex);
>=20
>         pthread_join(u, NULL);
>         pthread_join(i, NULL);
>=20
>         return 0;
> }
>=20
> Which produces:
> unimportant waiting for mutex
> important waiting for mutex
> main unlocking mutex
> unimportant got mutex!
> important got mutex!
>=20
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>=20
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
