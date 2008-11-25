Return-Path: <neko@genesi-usa.com>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.242])
	by ozlabs.org (Postfix) with ESMTP id 337E6DDE1C
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Nov 2008 07:46:48 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id d11so86974and.39
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Nov 2008 12:46:46 -0800 (PST)
Message-ID: <b5e2fc790811251246r201a9f4anad308e9a8ff7960d@mail.gmail.com>
Date: Tue, 25 Nov 2008 14:46:45 -0600
From: "Matt Sealey" <matt@genesi-usa.com>
To: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: [PATCH/RFC] Add Alternative Log Buffer Support for printk Messages
In-Reply-To: <fa686aa40811251217g6dcbef77u29e3d6ee6ad6d99f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_16821_30450542.1227646005950"
References: <20081125135519.038abf23@zod.rchland.ibm.com>
	<C5518C2F.13137%gerickson@nuovations.com>
	<b5e2fc790811251131g63ea9444x57ec0829ca0b069e@mail.gmail.com>
	<492C573E.9030309@billgatliff.com>
	<b5e2fc790811251207g38d429f3q4eb698b92162d6@mail.gmail.com>
	<fa686aa40811251217g6dcbef77u29e3d6ee6ad6d99f@mail.gmail.com>
Cc: Bill Gatliff <bgat@billgatliff.com>, Wolfgang Denx <wd@denx.de>,
	linux-embedded@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Stefan Roese <sr@denx.de>, Grant Erickson <gerickson@nuovations.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

------=_Part_16821_30450542.1227646005950
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tue, Nov 25, 2008 at 2:17 PM, Grant Likely <grant.likely@secretlab.ca>wrote:

> On Tue, Nov 25, 2008 at 1:07 PM, Matt Sealey <matt@genesi-usa.com> wrote:
>
> > But here's the real question; why do you need an opensource
> implementation?
> > Curiosity?
>
> Umm, so that it can be ported to new boards perhaps?  So that
> developers can work with it?
>

You can port closed-source firmwares to new boards just as easily as with
open source ones.

For companies who have larger production requirements than Bill Gatliff,
porting an open source firmware may not be a task they want to get into.
Linux support is a big enough moving target without adding firmware
development to it and tying up programmers implementing the same drivers
twice (even if it is practically copy&paste in U-Boot).

In this case they may just buy one in. If everything had to be open source
and freely downloadable there would be no industry at all. And if paying for
someone else to write code for you is the issue, then we wouldn't have asked
you for a quote last week, and you certainly wouldn't have given us a price
:D

Bill, as for ARM etc. support, you can imagine that most of the guts of the
firmware are fairly well abstracted. Vast portions of the same code work on
most platforms with the same peripherals - USB, Ethernet controllers & PHYs,
PCI, SDIO, etc. The device tree is how hardware designers (note; not OS
designers) are meant to abstract the differences in hardware and programming
model so that an OS can load the right drivers and Do The Right Thing. It
doesn't matter if the device tree was generated as a flattened
representation, or by an open-source firmware or closed-source firmware.

However the IEEE 1275 standard is not as big a moving target as U-Boot. It
has an ABI and a client interface which hasn't been moved around or modified
since 1994. And when your board doesn't provide a device tree entry for
something, well, you just write some Forth and can edit entries in the
device tree in-place (no recompiles required). If you're so inclined you can
even write things like scsi host controller drivers in Forth and present
them such that they are then working - no reboots or recompiles required,
just load the script - and ready to use to boot the system. You can poke
around in the FirmWorks code for how powerful this can be, or poke around
http://www.powerdeveloper.org/platforms/efika/devicetree for how mundane and
simple it can be just fixing up some entries and making sure the chip is
configured right..

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations

------=_Part_16821_30450542.1227646005950
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br><br><div class="gmail_quote">On Tue, Nov 25, 2008 at 2:17 PM, Grant Likely <span dir="ltr">&lt;<a href="mailto:grant.likely@secretlab.ca">grant.likely@secretlab.ca</a>&gt;</span> wrote:<br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div class="Ih2E3d">On Tue, Nov 25, 2008 at 1:07 PM, Matt Sealey &lt;<a href="mailto:matt@genesi-usa.com">matt@genesi-usa.com</a>&gt; wrote:<br>
<br>
&gt; But here&#39;s the real question; why do you need an opensource implementation?<br>
&gt; Curiosity?<br>
<br>
</div>Umm, so that it can be ported to new boards perhaps? &nbsp;So that<br>
developers can work with it?<br></blockquote><div><br>You can port closed-source firmwares to new boards just as easily as with open source ones. <br></div></div><br>For companies who have larger production requirements than Bill Gatliff, porting an open source firmware may not be a task they want to get into. Linux support is a big enough moving target without adding firmware development to it and tying up programmers implementing the same drivers twice (even if it is practically copy&amp;paste in U-Boot).<br>
<br>In this case they may just buy one in. If everything had to be open source and freely downloadable there would be no industry at all. And if paying for someone else to write code for you is the issue, then we wouldn&#39;t have asked you for a quote last week, and you certainly wouldn&#39;t have given us a price :D<br clear="all">
<br>Bill, as for ARM etc. support, you can imagine that most of the guts of the firmware are fairly well abstracted. Vast portions of the same code work on most platforms with the same peripherals - USB, Ethernet controllers &amp; PHYs, PCI, SDIO, etc. The device tree is how hardware designers (note; not OS designers) are meant to abstract the differences in hardware and programming model so that an OS can load the right drivers and Do The Right Thing. It doesn&#39;t matter if the device tree was generated as a flattened representation, or by an open-source firmware or closed-source firmware.<br>
<br>However the IEEE 1275 standard is not as big a moving target as U-Boot. It has an ABI and a client interface which hasn&#39;t been moved around or modified since 1994. And when your board doesn&#39;t provide a device tree entry for something, well, you just write some Forth and can edit entries in the device tree in-place (no recompiles required). If you&#39;re so inclined you can even write things like scsi host controller drivers in Forth and present them such that they are then working - no reboots or recompiles required, just load the script - and ready to use to boot the system. You can poke around in the FirmWorks code for how powerful this can be, or poke around <a href="http://www.powerdeveloper.org/platforms/efika/devicetree">http://www.powerdeveloper.org/platforms/efika/devicetree</a> for how mundane and simple it can be just fixing up some entries and making sure the chip is configured right..<br>
<br>-- <br>Matt Sealey &lt;<a href="mailto:matt@genesi-usa.com">matt@genesi-usa.com</a>&gt;<br>Genesi, Manager, Developer Relations<br>

------=_Part_16821_30450542.1227646005950--
