Subject: problems with smbfs on 2.4.18 kernel (ppc)
From: Bastien Nocera <hadess@hadess.net>
To: urban@teststation.com
Cc: "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
Date: 01 Mar 2002 17:11:42 +0000
Message-Id: <1015002703.765.74.camel@dozo>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-Mh+uIH3eEdpUkChuxq64"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--=-Mh+uIH3eEdpUkChuxq64
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

I'm having some problems with smbfs on ppc.
The attached file contains all the details. Am I doing something wrong ?

Hope you can help.

Cheers

--=20
/Bastien Nocera
http://hadess.net

--=-Mh+uIH3eEdpUkChuxq64
Content-Disposition: attachment; filename=SMBFS-bug
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable


# System details

dozo:~# uname -a
Linux dozo 2.4.18-ben0-xfs-o1-preempt #2 Wed Feb 27 07:50:49 GMT 2002 ppc u=
nknown
dozo:~# smbclient | grep -i version
Version 2.2.3a-1 for Debian
dozo:~# smbmount | grep -i version
Version 2.2.3a-1 for Debian

dozo:~# export USER=3Dhadess

# There is a Backup1 share on kara

dozo:~# smbclient -L kara=20
added interface ip=3D192.168.1.2 bcast=3D192.168.1.255 nmask=3D255.255.255.=
0
Password:=20
Domain=3D[IDORU] OS=3D[Unix] Server=3D[Samba 2.2.2]

	Sharename      Type      Comment
	---------      ----      -------
	Backup1        Disk     =20
	Backup2        Disk     =20
	IPC$           IPC       IPC Service (Samba 2.2.2 running on OSX)
	ADMIN$         Disk      IPC Service (Samba 2.2.2 running on OSX)
	hadess         Disk      Home directory of hadess

	Server               Comment
	---------            -------
	KARA                 Samba 2.2.2 running on OSX

	Workgroup            Master
	---------            -------
	IDORU                KARA

# I have a similar line in my fstab, different password obviously

dozo:~# grep backup /etc/fstab=20
//kara/Backup1	/mnt/backup/	smbfs	user,username=3Dhadess,password=3DXXX 0 0

# Mounting works

dozo:~# mount /mnt/backup/
dozo:~# mount
/dev/hda10 on / type xfs (rw,noatime)
proc on /proc type proc (rw)
none on /proc/bus/usb type usbdevfs (rw)
/dev/hda12 on /home type xfs (rw,noatime)
/dev/hda14 on /opt type xfs (rw,noatime)
/dev/cdrom on /cdrom type iso9660 (ro,noexec,nosuid,nodev,user=3Dhadess)
//kara/Backup1 on /mnt/backup type smbfs (0)

# The mount point kind of disappeared...

dozo:~# ls /mnt/backup
ls: /mnt/backup: No such file or directory

# Well, it seemed to be there though

dozo:~# umount /mnt/backup=20
dozo:~# mount
/dev/hda10 on / type xfs (rw,noatime)
proc on /proc type proc (rw)
none on /proc/bus/usb type usbdevfs (rw)
/dev/hda12 on /home type xfs (rw,noatime)
/dev/hda14 on /opt type xfs (rw,noatime)
/dev/cdrom on /cdrom type iso9660 (ro,noexec,nosuid,nodev,user=3Dhadess)


--=-Mh+uIH3eEdpUkChuxq64--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
