Return-Path: <joerg@dorchain.net>
Received: from Redstar.dorchain.net (153-133-088-212.ip-addr.teresto.net
	[212.88.133.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6411B67A6C
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Mar 2005 02:45:09 +1100 (EST)
Received: (from joerg@localhost)
	by Redstar.dorchain.net (8.13.3/8.13.2) id j2EFj4nY011763
	for linuxppc-dev@ozlabs.org; Mon, 14 Mar 2005 16:45:04 +0100
Date: Mon, 14 Mar 2005 16:45:04 +0100
From: Joerg Dorchain <joerg@dorchain.net>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Message-ID: <20050314154504.GA7267@Redstar.dorchain.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bg08WKrSYDhXBjb5"
Subject: Heartbeat apps thoughts
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi list,

I am pondering a heartbeat functionality implementation. Currently, I
have a patch that adds a few line to the timer interrupt to switch the
led on and off when appropriate.

On the list, there were opinions that switching the led on and off would
be best done via userspace. While I in principle agree, I have some
considerations:

- The heartbeat frequency is calculated dynamically as a function of the
  current load. While this is available e.g. via /proc/loadavg, there is
  the effect that a daemon serving the led would need more cpu on high
  loads (led is blinking faster), even though it is less likely to be
  scheduled. This leads the heartbeat idea ad absurdum.
- Can real time scheduling of the heartbeat daemon avoid the effect
  described above?
- If so, is locking some pages of memory and a real time process still
  more adequate than a few lines in the timer interrupt?

For a discussion base I've attached my current idea of an heartbeatd.
(The DEBUG define might help those without an ibook to get something
running ;-)

Curous for any comments,

Joerg


/*
 * heartbeatd 2005-03-14 Joerg Dorchain <joerg@dorchain.net>
 * led code taken from ibook-led Nico Schottelius (nico-linux@schottelius.o=
rg) 2005-02-18 v0.3
 *
 * might replace the kernel heartbeat code in arch/.../time.c
 *
 */

/* open() */
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>

/* write */
#include <unistd.h>

/* fopen.. */
#include <stdio.h>
/* exit */
#include <stdlib.h>
/* nanosleep..*/
#include <time.h>
/* sigaction */
#include <signal.h>

/* HZ */
#include <sys/param.h>
/* ioctl */
#include <sys/ioctl.h>

/* realtime scheduling */
#include <sched.h>
/* mlockall */
#include <sys/mman.h>

/* Linux */
#define FSHIFT 11
#define ADB_DEVICE "/dev/adb"
#define LOADAVG "/proc/loadavg"
#define PIDFILE "/var/run/heartbeatd.pid"

#undef DEBUG
#ifdef DEBUG
#undef LOADAVG
#define LOADAVG "/tmp/loadavg"
#endif

int adbfd;

inline void heartbeat_init(void)
{
#ifndef DEBUG
   /* open /dev/adb */
   if((adbfd =3D open(ADB_DEVICE,O_RDWR)) =3D=3D -1) exit(1);
#endif
}

inline void heartbeat(int i)
{
	char adb_on[5] =3D {0x06, 0xee, 0x04, 0x00, 0x01};
	char adb_off[5] =3D {0x06, 0xee, 0x04, 0x00, 0x00};

#ifndef DEBUG
	if (i)
		write(adbfd, adb_on, 5);
	else
		write(adbfd, adb_off, 5);
#else
	if (i)
		printf("pump\r");
	else
		printf("    \r");
	fflush(stdout);
#endif
}

inline unsigned int period_calc(void)
{
	FILE *lf;
	unsigned int ldint, ldfrac, load;

	if (( lf =3D fopen(LOADAVG, "r")) =3D=3D NULL)
		exit(1);
	fscanf(lf, "%u.%u", &ldint, &ldfrac);
	fclose(lf);
	load =3D (ldint << FSHIFT) + (ldfrac << FSHIFT) / 100;
	return ((672<<FSHIFT)/(5*load+(7<<FSHIFT))) + 30;
}

void cleanup(int unused_signal)
{
	unlink(PIDFILE);
	exit(1);
}

int main(int argc, char **argv)
{
   unsigned int period;
   struct timespec ts0, ts1, ts2, ts3;
   int fd;
   struct sched_param sp;
   FILE *pidf;
   struct sigaction sa;
 =20
#ifndef DEBUG
   /* daemonize */
   if (fork() !=3D 0)
	   exit(0);
   if ((fd =3D open("/dev/tty", O_RDWR)) >=3D 0) {
	   ioctl(fd, TIOCNOTTY);
	   close(fd);
   }
   /* make pidfile and remove once done */
   if ((pidf =3D fopen(PIDFILE,"w+")) !=3D NULL) {
	   fprintf(pidf, "%d\n", getpid());
	   fclose(pidf);
	   sa.sa_handler =3D cleanup;
	   sigemptyset(&sa.sa_mask);
	   sa.sa_flags=3D SA_ONESHOT;
	   sigaction(SIGHUP, &sa, NULL);
	   sigaction(SIGQUIT, &sa, NULL);
	   sigaction(SIGTERM, &sa, NULL);
   }
   /* get priority */
   if (nice(-19) !=3D 0)
	   perror("nice");
   if (mlockall(MCL_CURRENT|MCL_FUTURE) !=3D 0)
	   perror("mlockall");
   sp.sched_priority=3D10;
   if (sched_setscheduler(0, SCHED_RR, &sp) !=3D 0)
	   perror("sched_setscheduler");
#endif

   heartbeat_init();

   while (1) {
	   period =3D period_calc();
	   ts0.tv_sec =3D 0;
	   ts0.tv_nsec =3D 7*(1000000000/HZ);
	   ts1.tv_sec =3D 0;
	   ts1.tv_nsec =3D (period/4)*(1000000000/HZ) - ts0.tv_nsec;
	   ts2.tv_sec =3D 0;
	   ts2.tv_nsec =3D (period/4+7)*(1000000000/HZ) - ts0.tv_nsec - ts1.tv_nse=
c;
	   ts3.tv_sec =3D 0;
	   ts3.tv_nsec =3D (period)*(1000000000/HZ) - ts0.tv_nsec - ts1.tv_nsec - =
ts2.tv_nsec;

	   heartbeat(1);
	   nanosleep(&ts0,NULL);
	   heartbeat(0);
	   nanosleep(&ts1,NULL);
	   heartbeat(1);
	   nanosleep(&ts2,NULL);
	   heartbeat(0);
	   nanosleep(&ts3,NULL);
   }
}

--bg08WKrSYDhXBjb5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCNbGAjY4+4PdzvOARAsA5AJ9+1ZkwOD/Va6V3gnxy+zYAXy/RYACfX9U/
HfLALifsCREDaut+NLByhNE=
=Nkpj
-----END PGP SIGNATURE-----

--bg08WKrSYDhXBjb5--
