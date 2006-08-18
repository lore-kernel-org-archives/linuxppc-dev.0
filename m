Return-Path: <billfink@mindspring.com>
Received: from elasmtp-scoter.atl.sa.earthlink.net
	(elasmtp-scoter.atl.sa.earthlink.net [209.86.89.67])
	by ozlabs.org (Postfix) with ESMTP id 95A68679FD
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Aug 2006 15:36:42 +1000 (EST)
Date: Fri, 18 Aug 2006 01:28:24 -0400
From: Bill Fink <billfink@mindspring.com>
To: Wolfgang Pfeiffer <roto@gmx.net>
Subject: Re: Broken Firewire 400/SCSI on ppc Powerbook5,8
Message-Id: <20060818012824.22e70b0f.billfink@mindspring.com>
In-Reply-To: <20060817230347.GC3440@localhost>
References: <20060817230347.GC3440@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, linux1394-devel@lists.sourceforge.net,
	stefanr@s5r6.in-berlin.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Wolfgang,

On Fri, 18 Aug 2006, Wolfgang Pfeiffer wrote:

> Hi All
> 
> Short version first:
> 
> The SCSI/FW routines seem to work like a charm with a LSILogic Model/
> SYM13FW500-Disk on my old Macintosh titanium-IV laptop, with exactly
> the same relatively fresh git-kernel that does not work on the
> PowerBook5,8.  That is I compiled the kernel on the Apple Powerbook5,8
> and installed it on both machines.
> 
> 
> SCSI/FW didn't work ever on the new PowerBook5,8.
> 
> I'll give you first some error messages for the failing FW disk,
> and at the end of this mail you'll find links to technical
> documentation for the 2 failng machines (Powerbook5,8 and FW board/disk)
> 
> First I load the drivers with this little script:
> 
> ------------------------------------------
> #!/bin/sh -x
> /bin/sh -n /home/shorty/scripts/scsi.start.sh && \
> 
> modprobe raw1394 && \
> modprobe ieee1394 disable_irm=0 disable_nodemgr=1 && \
> modprobe ohci1394 && \
> modprobe eth1394 && \
> modprobe sbp2 max_speed=3 workarounds=0x1 serialize_io=0 && \
> sleep 4 && \
> chown root.shorty /dev/raw1394
> -------------------------------------------

I don't know if it matters for you (haven't tried Firewire yet on
a PowerBook), but on my desktop PowerMac systems, I need a "sleep 2"
before the modprobe for sbp2, to get my Firewire disks to work
properly.

						-Hope this helps

						-Bill
