Return-Path: <albert_herranz@yahoo.es>
Received: from smtp101.mail.ukl.yahoo.com (smtp101.mail.ukl.yahoo.com
	[77.238.184.33]) by ozlabs.org (Postfix) with SMTP id 4B90D1007D4
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 27 Nov 2009 08:38:25 +1100 (EST)
Message-ID: <4B0EF54C.6020101@yahoo.es>
Date: Thu, 26 Nov 2009 22:38:20 +0100
From: Albert Herranz <albert_herranz@yahoo.es>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC PATCH 04/19] powerpc: wii: device tree
References: <1258927311-4340-1-git-send-email-albert_herranz@yahoo.es>	
	<1258927311-4340-2-git-send-email-albert_herranz@yahoo.es>	
	<1258927311-4340-3-git-send-email-albert_herranz@yahoo.es>	
	<1258927311-4340-4-git-send-email-albert_herranz@yahoo.es>	
	<1258927311-4340-5-git-send-email-albert_herranz@yahoo.es>	
	<49436.84.105.60.153.1259171377.squirrel@gate.crashing.org>	
	<1259211061.16367.260.camel@pasglop> <4B0E9C5F.50304@yahoo.es>
	<1259269265.18084.14.camel@pasglop>
In-Reply-To: <1259269265.18084.14.camel@pasglop>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
>>> Good point. I can't even guarantee that the kernel will work reliably
>>> with nobats :-) At least you really want the kernel .text to be fully
>>> covered by an IBAT.
>>>
>> It works with nobats.
> 
> But does it work -reliably- ? :-)
> 

It does AFAICT. My Wii is a 24x7 linux box although it is not stressed in any way usually.

> Any ways, not a big deal right now, as I said, we really want the BATs
> for performances anyways, so we should probably just add some kind of
> hack in mmu_mapin_ram() for the time being.
> 

Yup. The idea is to map the first 16MB of MEM1 with a BAT.
Mapping the whole 24MB with BATs may not be possible because we want the framebuffer in MEM1 for performance reasons.

>> I must say that all the patches posted (and the device drivers, which haven't
>> been posted yet) are tested and working code.
> 
> That was my impression too, but in this case, I'm talking about a
> potential very hard to hit problem that you may well have never managed
> to actually trigger.
> 

I haven't actually, if that applies :)

>> There you can find the hardware interface that supports the IPC mechanism.
>> It is made up of a pair of registers to pass data between the processors and a
>> pair of control/flags registers.
>> The hardware can interrupt the PowerPC side when there is data available for it.
> 
> Ok. So the right way to do that would be to have a node purely
> representing the HW IPC, unrelated to whatever is running on the
> secondary processor.
> 

Totally agreed.

> However, it's ok to have -below- that node, a set of device nodes or a
> node with properties or whatever representing the FW in there and the
> function it exposes.
> 
> That can be discussed later tho. I'm not that keen on having those info
> be in the .dts coming with the kernel since those functions essentially
> depend on what FW is loaded on the aux. processor.
> 

I think we can leave this for later as you said.

> What might do however is to have a way for that FW itself to provide you
> with the nodes and properties for the functions it provides :-) Then you
> can have the boot wrapper or the kernel platform init code use some well
> defined (and as stable as possible) IPC API to identify the FW there and
> expose all that stuff.
> 

Segher was playing with an OF implementation...

> Of course that wouldn't work with FW we don't have control on. Can Linux
> run on the wii with the original N. FW on the aux. processor ? Can we
> detect what is running there ? Do we care ?
> 

Yes, it can. And it is done. But I think we don't care/need that in mainline.

>> It is what Nintendo calls the "Serial Interface" (SI) which is a proprietary
>> serial hardware to drive the gamepads (and a custom keyboard too, once available
>> for an RPG game).
> 
> So I would give it a different name than "serial" then. Make it gpsi
> maybe ? (game pad serial interface ?) :-) Or invent something else...
> 

I'd choose "gcnsi" with a compatible like "nintendo,gamecube-si" :)

(gcn is the official short abbreviation for the Nintendo GameCube)

> Cheers,
> Ben.
> 

Thanks,
Albert
