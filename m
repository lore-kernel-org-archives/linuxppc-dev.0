Date: Thu, 2 Nov 2000 16:07:28 +0100
From: Claus <cl.en@gmx.net>
To: Albrecht Dreﬂ <ad@mpifr-bonn.mpg.de>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Lombard Sleep Crash (Was: 2.2.18pre17 again)
Message-ID: <20001102160728.B371@olis.north.de>
Reply-To: cl.en@gmx.net
References: <14839.53124.753011.489351@argo.linuxcare.com.au> <39F96E14.C06AB6FB@mpifr-bonn.mpg.de> <20001027163923.A13804@suse.de> <3A015F72.2576BB01@mpifr-bonn.mpg.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="3MwIy2ne0vdjdPXF"
In-Reply-To: <3A015F72.2576BB01@mpifr-bonn.mpg.de>; from ad@mpifr-bonn.mpg.de on Thu, Nov 02, 2000 at 13:34:58 +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


 >:=20
 >: I attach the kernel .config and the relevant part from /var/log/message=
s, and as
 >: always, any help is _really_ welcome!
=20
if you panic'ed with the CD module inserted, would you try to snooze withou=
t it?

or try this one:

/* wakebay.c - wakes a powerbook mediabay so the system doesnt crash on acc=
essing
 * a disk mounted before sleeping.  great for CD drives.
 *
 * Joseph Palani Garcia <jpgarcia@execpc.com>
 *
 * fairly simple.  IOCTL the mediabay to tell it the media changed.  (it on=
ly forgot
 * it in sleep.  we remind it.)
 *
 * 3 cases:
 *   nothing in drive      : does nothing, exits normally
 *   in drive, not mounted : acts, no effect (?)
 *   in drive, is mounted  : drive regains status, door locked, etc.
 *
 * this is useful for PMUD.  add it to the wakeup script to prevent crashes.
 *
 */
#include <stdio.h>
#include <fcntl.h>
#include <linux/cdrom.h>

int
main(int argc, char **argv)
{
  int fd, arg=3D0;

  if(argc<2){
    fprintf(stderr,"Usage:\n\t%s <device>\n",argv[0]);
    return 1;
  }

  fd =3D open(argv[1], O_RDONLY);

  if (fd < 0) {
    fprintf(stderr,"%s cannot be opened.  exiting.\n",argv[1]);
    return 0;
  }

  if (ioctl(fd, CDROM_MEDIA_CHANGED, &arg) < 0)
    perror("CDROM_MEDIA_CHANGED ioctl");

  close(fd);
  return 0;
}



Regards

		Claus

--3MwIy2ne0vdjdPXF
Content-Type: application/pgp-signature
Content-Disposition: inline


--3MwIy2ne0vdjdPXF--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
