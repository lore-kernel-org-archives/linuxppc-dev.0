From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15362.65400.567302.796449@cargo.ozlabs.ibm.com>
Date: Tue, 27 Nov 2001 13:50:32 +1100 (EST)
To: msokolov@ivan.Harhan.ORG (Michael Sokolov)
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: VT82C686B IDE and Linux/PPC woes
In-Reply-To: <0111262205.AA22280@ivan.Harhan.ORG>
References: <0111262205.AA22280@ivan.Harhan.ORG>
Reply-To: paulus@samba.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michael Sokolov writes:

> Yet when I boot Linux/PPC, it sees the IDE ports, but doesn't see the drive
> attached to the IDE0 port (see the session log below). My port in
> arch/ppc/platforms does absolutely nothing IDE-related, in .config I have IDE
> and VT82C686B support enabled. Is there something that my Linux/PPC port has to
> do explicitly with IDE in order for it to work?

Hmmm, there shouldn't be any problem.  You do have CONFIG_BLK_DEV_IDEPCI
enabled I assume?  Your k2_ide_init_hwif_ports looks OK to me.  I
would scatter some printks through drivers/ide/ide-pci.c to try to get
an idea what it is doing and where it is going wrong.

BTW, I can't see any reason why we still need to have
ide_init_hwif_ports be platform-specific.  It is only used for
PC-style IDE interfaces and for PCI IDE interfaces.  For other types
of interface we should be adding a probe call in ide.c rather than
trying to do it with ide_default_io_base and ide_init_hwif_ports.
Not that this applies to the k2.

Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
