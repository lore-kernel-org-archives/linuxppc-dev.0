Date: Mon, 26 Apr 1999 17:28:24 +0200 (CEST)
From: Alexander Larsson <alex@signum.se>
To: linuxppc-dev@lists.linuxppc.org
Subject: Flash drivers and filesystem
Message-ID: <Pine.LNX.4.04.9904261714550.31075-100000@tammy.signum.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I've noticed a lot of people on this list seem to use the ppc 8xx port in
embedded systems, running from flash memory. There have been some
questions about it.

Therefore i give you:
ftp://ftp.signum.se/pub/alex/flash.diff

The Flash drivers include:
 General detection of CFI compliant flash memories. 
 A general interface for flash-drivers
 Specific support for AMD Flash-chips (only tested on Am29LV017B 4x8bib
  configuration) 
 Implemented char device over the flash interface which can read & write
  to flash, writing on erase-sector boundaries implies automatic erase,
  ioctls exists to force sector erase and to get information about the
  chips.

FTL, for flash filesystems:
 FTL layer which implements a 512 byte blockdevice with wear-leveling from
 the flash-device (or parts of it). This is a modified version of the ftl
 code from the pcmcia code (taken with permission). 
 This can be used to place a normal ext2fs fs in flash. For optimum
 performance some modifications to ext2fs whould be done so that it
 frees blocks in the ftl layer that are not used by the fs. 
 Note that there *might* be patent problems using this code in the US.

/ Alex (alex@signum.se)

 
 


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
