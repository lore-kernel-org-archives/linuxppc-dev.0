Return-Path: <jangiels@speakeasy.net>
Received: from mail2.sea5.speakeasy.net (mail2.sea5.speakeasy.net
	[69.17.117.4])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.speakeasy.net", Issuer "Equifax" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 8494867B8C
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 17 Aug 2006 10:51:49 +1000 (EST)
Subject: Re: Linux hanging on Xilinx SystemACE
From: Jeff Angielski <jangiels@speakeasy.net>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <528646bc0608161448y26e13398v3b818ed5f1124295@mail.gmail.com>
References: <3C02138692C13C4BB675FE7EA240952918DBED@bluefin.Soneticom.local>
	<528646bc0608161448y26e13398v3b818ed5f1124295@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 16 Aug 2006 20:51:57 -0400
Message-Id: <1155775917.10357.37.camel@sumo-jaa>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, 2006-08-16 at 15:48 -0600, Grant Likely wrote:
> On 8/16/06, Clint Thomas <cthomas@soneticom.com> wrote:
> >
> >
> > Hey,
> >
> > Using the powerpc development tree of Linux 2.4, I am trying to boot my
> > system from CompactFlash using Xilinx SystemACE. My compact flash card has
> > two partitions, a 16MB FAT16 that holds the combination FPGA image / Linux
> > Kernel ELF file, and an Ext2 partition that holds the root file system. The
> > system starts the boot process, uncompresses the Linux kernel and begins
> > loading drivers. Part way into this process, it conducts a partition check
> > of the drive being reported to it by SystemACE, however, it hangs at that
> > point. No kernel panic, no error message, it simply hangs. Here is the
> > output at that point...
> >
> > Partition check:
> >  xsysacea:
> >
> > what I am trying to find out is if this problem has been seen/fixed in the
> > past? or did I format the CF card incorrectly?

I forgot to mention that we used to see this problem when the identify
command that is sent during intialization fails.  The driver is written
in such a way that if any of this fails, the system hangs because it
sits in a polling loop waiting for the correct response.  There are no
timeout failures... :(  In our case we saw this error because we forgot
to put a CF into the system [usually during development with NFS
rootfs].

It is fairly easy to printk() the drivers init code to find out which
step is stuck in the polling loop.

> Checking partitions is a user-space activity (fsck).  Remove it from
> your init scripts.  Besides, unless your using a microdrive, your ext2
> rootfs should be mounted read-only which greatly reduces the need for
> fsck.  (because FLASH will wear out after too many writes)

The partition check he is referring to is part of a block device driver
initialization.  It is not fsck.  If he were only so luck to be that far
in the startup sequence... :)



Jeff Angielski
The PTR Group
