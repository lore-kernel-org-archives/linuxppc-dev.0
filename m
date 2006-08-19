Return-Path: <stefanr@s5r6.in-berlin.de>
Received: from einhorn.in-berlin.de (einhorn.in-berlin.de [192.109.42.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.vr.in-berlin.de",
	Issuer "IN-Berlin Server CA (G2)" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 24F9E679E9
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Aug 2006 19:15:27 +1000 (EST)
Message-ID: <44E6D634.3000207@s5r6.in-berlin.de>
Date: Sat, 19 Aug 2006 11:13:24 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
MIME-Version: 1.0
To: Wolfgang Pfeiffer <roto@gmx.net>
Subject: Re: Broken Firewire 400/SCSI on ppc Powerbook5,8
References: <20060817230347.GC3440@localhost> <20060818234930.GB2662@localhost>
In-Reply-To: <20060818234930.GB2662@localhost>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, linux1394-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Wolfgang Pfeiffer wrote:
>> The SCSI/FW routines seem to work like a charm with a LSILogic Model/
>> SYM13FW500-Disk on my old Macintosh titanium-IV laptop, with exactly
>> the same relatively fresh git-kernel that does not work on the
>> PowerBook5,8.  That is I compiled the kernel on the Apple Powerbook5,8
>> and installed it on both machines.
>    [ ... ]
> 
> In the meantime I suspect a hardware problem.
> 
> Here's why:
> 
> I connected the FW disk I was reporting about in previous postings to
> both an older Apple titanium Powerbook and to the newer Apple alubook
> 5,8.
> 
> In both instances I rebooted the machines with the accompanying
> different Apple OS X install CD's. Both CD's have a so-called "Disk
> Utility" tool with them, a tool that generally detects and repairs
> disks. The tool clearly detected the FW disk attached to my old
> titanium. And the same tool didn't detect the same FW disk on the
> newer alubook 5,8 ... :)
> 
> In both instances I connected the FW disk to the FW 400 connector of
> the machines.
> 
> So unless there are differing FW 400 versions available on both
> machines I'd suspect a hardware prob with the 5,8.
> 
> [Note: Do there actually exist different Firewire 400 versions?]

Yes, there are, but they should be fully interoperable --- with one 
exception that doesn't apply to Powerbooks.

A) There are old IEEE 1394-1995 only compliant PHYs. Such PHYs have not 
been used by manufacturers anymore since long ago.

B) There are IEEE 1394a-2000 compliant PHYs. IEEE 1394a added, among 
else, enhanced asynchronous arbitration, but AFAIU this is fully 
interoperable with 1394-1995 PHYs. The bridge board of your enclosure 
has a 1394a-2000 PHY (the TSB41LV03A). The SYM13FW501 appears to be only 
a 1394-1995 compliant link layer controller (probably with integrated 
PHY) but this shouldn't matter.

C) IEEE 1394b-2002 compliant PHYs with monolingual S400A port(s). They 
behave exactly like 1394a-2000 PHYs.

D) IEEE 1394b-2002 compliant PHYs with monolingual S400B port(s). These 
are not interoperable with neither of A, B, C. Therefore such ports need 
to have a 9-pin socket whose formfactor is coded as a monolingual port. 
Therefore it is physically impossible to connect such a port with ports 
of type A, B, or C. I don't know if there are actual products with 
monolingual S400B ports.

IEEE 1394b-2002 compliant PHYs may have
  - bilingual ports,
  - Beta-only ports (Beta mode is a new signaling mode introduced by
    1394b which is not interoperable with 1394-1995 and 1394a),
  - and/or ports that are forced to only use legacy signaling, i.e. the
    same as of IEEE 1394a PHYs.
The S800 9-pin port of the AlBook is a bilingual port; the S400 6-pin 
port should be a 1394b port which is forced to use only legacy signaling.

BTW, I have a portable CD-RW which I suspect to have a similar or the 
same bridge chip as your HDD. This is because it also shows two nodes 
instead of one node and because it suffered the same problem related to 
the BROADCAST_CHANNEL register as the Datafab HDD. I cannot open the 
CD-RW without damaging it therefore I cannot confirm the actual chips in 
there. This CD-RW works fine on a bilingual 1394b PCI adapter with 9-pin 
to 6-pin cable.

> I'll make this issue clear next week with a trip to the shop where I
> bought the alubook.
> 
> And I'll be back as soon as I know more ...

If you have got the TiBook around, you could connect it with the AlBook 
and look what gscanbus or OS X's system profiler have to say about it. 
If possible, also try the TiBook in target disk mode and see if it 
appears as a disk for Linux' sbp2 or under OS X.

The fact that Linux on the AlBook gets at least as far as "ieee1394: 
Error parsing configrom for node 0-00:1023" indicates that not all hope 
is lost. If you have got the time, compile the 1394 drivers for verbose 
logging and send the log. Don't crosspost the log if it gets too big.
-- 
Stefan Richter
-=====-=-==- =--- =--==
http://arcgraph.de/sr/
