Date: Tue, 1 Feb 2000 22:51:22 +0100
From: Olaf Hering <olh@suse.de>
To: linuxppc-dev@lists.linuxppc.org
Subject: find the OF boot-device
Message-ID: <20000201225122.B7845@suse.de>
Reply-To: linuxppc-dev@lists.linuxppc.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

we need an app to tell us the OF device path to a file. I'm working on
that but I have a strange problem with a G4 400 AGP:

There are 3 entries /proc/device-tree/pci and all of them have the same
inode number:

4189 dr-xr-xr-x   3 root     root   0 Feb  1 22:36 openprom/
4215 dr-xr-xr-x   2 root     root   0 Feb  1 22:36 options/
4297 dr-xr-xr-x  21 root     root   0 Feb  1 22:36 packages/
4405 dr-xr-xr-x   4 root     root   0 Feb  1 22:36 pci/
4405 dr-xr-xr-x   4 root     root   0 Feb  1 22:36 pci/
4405 dr-xr-xr-x   4 root     root   0 Feb  1 22:36 pci/
4339 dr-xr-xr-x   4 root     root   0 Feb  1 22:36 psuedo-hid/
4197 dr-xr-xr-x   4 root     root   0 Feb  1 22:36 rom/
4355 dr-xr-xr-x   2 root     root   0 Feb  1 22:36 rtas/


The hd alias ist /pci@f2000000/@d/mac-io@7/ata-4@1f000/disk@0 so I guess
there must be something wrong. The first pci directory contains only the
AGP card. I'm unable to enter the other directories.

On a newer G4 400 (with gmac ethernet) everything has a symlink:

4207 dr-xr-xr-x   2 root     root     0 Feb  1 22:46 options/
4289 dr-xr-xr-x  21 root     root     0 Feb  1 22:46 packages/
4468 lr-xr-xr-x   1 root     root     0 Feb  1 22:46 pci -> pci@f0000000/
4397 dr-xr-xr-x   4 root     root     0 Feb  1 22:46 pci@f0000000/
4470 dr-xr-xr-x   3 root     root     0 Feb  1 22:46 pci@f2000000/
4897 dr-xr-xr-x   3 root     root     0 Feb  1 22:46 pci@f4000000/
4331 dr-xr-xr-x   4 root     root     0 Feb  1 22:46 psuedo-hid/
4205 lr-xr-xr-x   1 root     root     0 Feb  1 22:46 rom -> rom@ff800000/
4187 dr-xr-xr-x   4 root     root     0 Feb  1 22:46 rom@ff800000/

The kernel is a 2.2.14.
Is there a bug in the OF or in the kernel?


Gruss Olaf

--
 $ man 1 current_release

BUGS
       Users never read manuals...

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
