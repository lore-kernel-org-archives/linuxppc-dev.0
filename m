Message-ID: <3AB0DE72.959AE34F@inn.ericsson.se>
Date: Thu, 15 Mar 2001 16:23:30 +0100
From: Kenneth Johansson <kenneth.johansson@inn.ericsson.se>
MIME-Version: 1.0
To: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: Installing debian on embedded ppc Micro-HOWTO
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I got a request for the howto so here it is.

-------------------
Installing debian on embedded ppc Micro-HOWTO

1.  What you need.

A PowerPC CPU that is compatible with 601 userspace.
This means that you have to compile in math emulation on most
embedded version of ppc and that the 8xx series from motorola
dose not work.

It is assumed that you have set up the system so that it is
booting to the point of mounting / from a nfs server.

And last you need the debian base system for ppc located at
http://ftp.se.debian.org/debian/dists/potato/main/disks-powerpc/current/base2_2.tgz



2. Create the root file system

Since the first part of a debian installation never was done a few manual
changes has to be done.

Unpack base2_2.tgz into the directory that is used as root mount point.
>From now on / will mean this directory on the server.

do the following changes

/etc/passwd
	put in a valid root entry with password. Debian has some sanity checks that
	fails if no password is used for root.

/sbin/unconfigured.sh
	remove/rename

/etc/fstab
	To get a rw root change the / entry to
	"/dev/root	/		none	rw		0	0"

/etc/securetty
	We need to login as root add the tty used to this file
	ex.
	console
	ttyS0
	ttyS1

/etc/resolv.conf
	fill in nameserver

/etc/inittab
	comment out

	# Format:
	#  <id>:<runlevels>:<action>:<process>
	#1:2345:respawn:/sbin/getty 38400 tty1
	#2:23:respawn:/sbin/getty 38400 tty2
	#3:23:respawn:/sbin/getty 38400 tty3
	#4:23:respawn:/sbin/getty 38400 tty4
	#5:23:respawn:/sbin/getty 38400 tty5
	#6:23:respawn:/sbin/getty 38400 tty6

	and uncomment

	T0:23:respawn:/sbin/getty -L ttyS0 9600 vt100


The above has to be done but changing the following can't hurt

/etc/hostname
/ets/hosts



3. Booting the system.

Now you boot and login as root.

If you are behind a firewall set http_proxy with
Export http_proxy="http://<your_proxy>"

Start dselect
      first you need to do a update. Then just chose install and wait.


This should result in a complete install of debian.

------

if you run a 405 and at any point starts to get segmentation faults just reboot and
restart deselect.

--
Kenneth Johansson
Ericsson Business Innovation AB   Tel: +46 8 404 71 83
Viderögatan 3                     Fax: +46 8 404 72 72
164 80 Stockholm                  kenneth.johansson@inn.ericsson.se

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
