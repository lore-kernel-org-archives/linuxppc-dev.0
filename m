Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: Creating RAM disks as a non root user.
Date: Tue, 4 Feb 2003 16:24:03 -0500
Message-ID: <2702075D4DE2B043BF5EB82E9CFAD45B093BBB@mail1.mediatrix.com>
From: "Jean-Denis Boyer" <jdboyer@mediatrix.com>
To: "Rod Boyce" <rod_boyce@stratexnet.com>
Cc: "LinuxPPC-Embedded" <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Here is the recipe we use to mount ramdisk images without being a root user.

First, there must be an entry (one per user) in /etc/fstab, like the following:

 /home/jdboyer/initrd_lnk /home/jdboyer/mnt auto noauto,loop,user,rw 0 0

where 'initrd_lnk' is a soft-link to the file to mount through the loop device,
and 'mnt' is the mount point. These informations can NOT be modified by the user.

Note that the option 'user' in fstab allows any user to mount/unmount this specific entry.

Then, we can mount a ramdisk image that is located anywhere,
by first modifying the soft link, and then mounting 'mnt'.
You can either create new ramdisk images, or mount already existing ones (very useful!).

Regards,
--------------------------------------------
 Jean-Denis Boyer, B.Eng., Technical Leader
 Mediatrix Telecom Inc.
 4229 Garlock Street
 Sherbrooke (Québec)
 J1L 2C8  CANADA
 (819)829-8749 x241
--------------------------------------------

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
