Mime-Version: 1.0
Message-Id: <v04220825b49f5ba6144a@[192.168.0.1]>
Date: Mon, 10 Jan 2000 01:18:42 -0900
To: debian-powerpc@lists.debian.org, linuxppc-dev@lists.linuxppc.org,
        linuxppc-user@lists.linuxppc.org
From: Ethan Benson <erbenson@alaska.net>
Subject: Yaboot Installer
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I have written a couple scripts for installing yaboot, Benjamin 
Herrenschmidt's OpenFirmware bootloader, onto a bootstrap partition 
(be it a dedicated partition or a MacOS boot partition).

The primary purpose of these scripts is to bring the quik/LILO 
installation procedure over to yaboot, and to treat the bootstrap 
partition more like a bootblock then as a filesystem.  (as far as the 
user is concerned). In other words ybin (YaBoot INstaller) takes care 
of copying the yaboot executable, it's configuration file, and 
optionally a OpenFirmware wrapper script (for creating a boot menu 
for example) to the specified bootstrap partition, and setting 
various attributes on them to allow OF to boot it as if it were a 
copy of MacOS. all of this is done by running this script, it takes 
the multiple step procedure and turns it into a single step 
procedure.  just like LILO or quik.

At the moment ybin makes no attempt to set OF environment variables, 
this is because yaboot is designed primarily for `newworld' PowerMacs 
for which it is not currently possible to change OF variables on the 
Linux side. As soon as there is a way to do this reliably I will add 
that function.  However there is still one more problem, there is no 
way to find out the OF device path of a given Linux device file, for 
example we cannot be sure what the OF device path is for /dev/sdb2. 
Until there is a way to determine this from within GNU/Linux its 
unfortunately up to the user to provide that information. (and for 
now set it on their own).

Having said that, if you happen to be using the internal ATA disk, 
and your bootstrap partition is before any MacOS boot partitions then 
the default OF settings will automatically boot yaboot when using 
ybin.  (I think anyway ;-))

more details can be found in the README file.  you can find ybin at:
<http://www.alaska.net/~erbenson/ybin/>

you can find yaboot at:
<http://calvaweb.calvacom.fr/bh40/test.html>

enjoy.

[please CC replies to me]

-- 
Ethan Benson
To obtain my PGP key: http://www.alaska.net/~erbenson/pgp/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
