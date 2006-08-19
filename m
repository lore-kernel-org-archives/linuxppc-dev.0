Return-Path: <sshebbar@gmail.com>
From: Srinivasa Hebbar <sshebbar@gmail.com>
To: Linuxppc-embedded@ozlabs.org
Subject: e2fsck error on compact flash.
Date: Sat, 19 Aug 2006 16:00:08 +0530
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200608191600.09050.sshebbar@gmail.com>
Cc: sshebbar@yahoo.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello,

Problem: 
e2fsck is unable to determine the size of the physical device on a compact flash.
/dev/hda is a compact flash disk with 4 partitions. (3primary+1extended).
ls -l /dev/hda* shows all the devices. 

If I mount any partition on /dev/hda* to /tmp/tmp
(for eg: /dev/hda1 to /tmp/tmp) and run e2fsck
on /dev/hda3 (or any other), e2fsck runs fine without problem.

All 4 partitions on the CF disk are ext3.

The output of the commands are below.

Any help is appreciated.

Thanks,
Hebbar.


# e2fsck -v /dev/hda3
e2fsck 1.38 (30-Jun-2005)
Error determining size of the physical device: No such file or directory

# ls -l /dev/hda*
brw-rw----    1 0        0          3,   5 /dev/hda5
brw-rw----    1 0        0          3,   4 /dev/hda4
brw-rw----    1 0        0          3,   3 /dev/hda3
brw-rw----    1 0        0          3,   2 /dev/hda2
brw-rw----    1 0        0          3,   1 /dev/hda1
brw-rw----    1 0        0          3,   0 /dev/hda

#mount -t ext3 /dev/hda1 /tmp/tmp

# e2fsck -v /dev/hda3
e2fsck 1.38 (30-Jun-2005)
/dev/hda3 has been mounted 21 times without being checked, check forced.
Pass 1: Checking inodes, blocks, and sizes
Pass 2: Checking directory structure
Pass 3: Checking directory connectivity
Pass 4: Checking reference counts
Pass 5: Checking group summary information
