Return-Path: <segher@kernel.crashing.org>
In-Reply-To: <20070404162718.GC21314@mag.az.mvista.com>
References: <20070328011924.GA1586@mag.az.mvista.com>
	<20070328012206.GD1586@mag.az.mvista.com>
	<9696D7A991D0824DBA8DFAC74A9C5FA302BDAB3E@az33exm25.fsl.freescale.net>
	<20070329003550.GB25652@localhost.localdomain>
	<2cd6c2dd69700dd162e90f8b7a83a99d@kernel.crashing.org>
	<20070402182632.GI2132@mag.az.mvista.com>
	<2feac74905bf1d4fd11725f430cb4078@kernel.crashing.org>
	<20070404162718.GC21314@mag.az.mvista.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <d479ccdeb42d811cfec1d445db9f2bf5@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC 3/3] powerpc: Add DTS file for the Motorola PrPMC2800
	platform
Date: Wed, 4 Apr 2007 19:44:15 +0200
To: "Mark A. Greer" <mgreer@mvista.com>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>,
	David Gibson <david@gibson.dropbear.id.au>,
	Dale Farnsworth <dfarnsworth@mvista.com>,
	Yoder Stuart-B08248 <stuart.yoder@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> I'm not doing "device" init as in an I/O device.  I'm doing some bridge
> init (e.g, allowing pci devices to access system mem) plus getting VPD
> so I know what variant of the board I'm on.  With that info, I can
> determine the amount of memory, bus freq, etc.  Those properties
> should be correct in the dt before being passed to the kernel, IMHO.

Ah okay.  Yes if your firmware won't do this for you
this functionality belongs in the bootwrapper, agreed.

> Regarding "what you want to do is more complicated *anyway*",
> what I'm doing is in *addition* to however I get access to the regs.
> So adding page table groking code doesn't eliminate the need for what
> I'm doing.

Sure.  I'm just saying that adding memory map parsing code
wouldn't add much complexity to your case.  It will add some
code, sure ;-)

>> misusing the quick evil hack that was meant to get debug output
>> out originally isn't really warranted.
>
> While virtual-reg may be an evil hack, its also very a simple/small
> hack that saves us from adding a whole lot of code to the bootwrapper
> (i.e., either ioremap code or page table groking code).

I think you'll find it really isn't all that much code.

>> I said only _valid_ reason.
>
> And I respectfully disagree.  IMHO, my usage is entirely valid.
>
>> I know you're using it for more
>> things, that's what I'm complaining about :-)
>
> Understood (but disagreed :).

:-)

> Agreed and that's what I'm doing.  I'm configuring things that the fw
> really should have but didn't.

Yeah.

>>> For example, the VPD code
>>> in .../boot/prpmc2800.c in my patches.
>>
>> I cannot find those patches right now, but in general,
>> that kind of code belongs in the kernel (or in a run-time
>> firmware).
>
> See '***' BEGIN -> END above.

Right, you use the VPD to set up the device tree correctly.
That's perfectly fine :-)


Segher
