Return-Path: <daveg@sonartech.com.au>
Received: from sonartech.com.au (newgate.sonartech.com.au [203.28.130.2])
	by ozlabs.org (Postfix) with ESMTP id 8321A2BDB2
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 28 Sep 2004 17:28:26 +1000 (EST)
Message-ID: <415908DC.3090409@sonartech.com.au>
Date: Tue, 28 Sep 2004 16:46:52 +1000
From: David Gardiner <daveg@sonartech.com.au>
MIME-Version: 1.0
To: Matt Porter <mporter@kernel.crashing.org>
References: <4153A362.8010604@sonartech.com.au>
	<AE8972FB-0E3A-11D9-BC8B-000A95A4DC02@kernel.crashing.org>
	<4158DD68.2060707@sonartech.com.au>
	<20040927221323.A30581@home.com>
	<C617C694-1110-11D9-8370-000A95A4DC02@kernel.crashing.org>
	<20040927224825.B30772@home.com>
	<7C908338-1113-11D9-8370-000A95A4DC02@kernel.crashing.org>
	<20040927231438.D30772@home.com>
In-Reply-To: <20040927231438.D30772@home.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Segher Boessenkool <segher@kernel.crashing.org>,
	linuxppc-embedded@ozlabs.org
Subject: Re: powerpc with gigabit card hanging
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Matt Porter wrote:

Sorry about previously posting back to linuxppc-dev but this post, 
originally started on it :-\

>On Tue, Sep 28, 2004 at 12:58:57AM -0500, Segher Boessenkool wrote:
>  
>
>>>>PCI device IRQs are normally retrieved straight from the PCI device
>>>>itself.  Sounds like a firmware problem (or the bootloader, if that
>>>>sets up the PCI devices for you).
>>>>        
>>>>
>>>This assumes a world where everything is managed by magic BIOS/OF
>>>initialization. That's not the case for this user's board port.
>>>      
>>>
>>The OS (Linux, specifically) won't do it for you.  It has to be set up
>>beforehand.  Unless "embedded Linux" gets this the wrong way around
>>as well.
>>    
>>
>
>This isn't an "embedded Linux" (whatever that is) thing. It is a
>non-full-featured firmware thing.  If you take a look at MIPS, ARM,
>SH, PPC embedded platforms you'll see a similar thing. But wait,
>  
>
mvme5100 with ppcbug ( although I think all of the mvme's have ppcbug )

>you'll even see interrupt routing tables in the decidedly not embedded
>Alpha architecture. :) Linux does do it, and there is a very clear
>infrastructure for managing routing tables and standard/non-standard
>PCI swizzle mechanisms.
>  
>
> 
>  
>
>>>>I believe Linux for PowerMac actually gets the IRQ number straight
>>>>from the device.  Some other routing might be gotten out of the OF
>>>>device-tree, yes.
>>>>        
>>>>
>>>The interrupt line register is always programmed by firmware, bios,
>>>or an OS. It is a logical value that is dependent on the platform.
>>>      
>>>
>>a) Don't pretend I don't know this; and b) it is wrong.  On the
>>majority of platforms, you can route any PCI IRQ to any number you want.
>>The firmware will tell you where it ends up (over PCI config space).
>>    
>>
>
>On commodity platforms that's true. But on just about every single
>dedicated purpose platform (embedded systems), interrupt routing is
>a static board layout/design decision.
>
>  
>
The gigabit's are pmc's but ppcbug is still seeing them
i.e.
PPC6-Bug>ver
Debugger/Diagnostics Type/Revision..................=PPC6/2.2
Debugger/Diagnostics Revision Date..................=11/01/01 RM02
MicroProcessor Version/Revision.....................=800C/1104
MicroProcessor Internal Clock Speed (MHZ)...........=500
MicroProcessor External Clock Speed (MHZ)...........=100
PCI Bus Clock Speed (MHZ)...........................=33
Board Type Identifier...............................=MVME5110-2263
Board Assembly Number...............................=01-W3518F67D
Local Memory Size...................................=20000000 (512MB)
L2 Cache (External).................................=0KB
L2 Cache (P0-In-Line)...............................=2048KB
L2 Cache (P1-In-Line)...............................=0KB
Super I/O Device Offset/ID/Revision.................=UNKNOWN
PCI Function 00/00/0 (00000000) ID/Revision.........=48031057/03
PCI Function 00/0D/0 (00006800) ID/Revision.........=000010E3/02
PCI Function 00/0E/0 (00007000) ID/Revision.........=12098086/09
PCI Function 00/11/0 (00008800) ID/Revision.........=4D69105A/02
PCI Function 00/13/0 (00009800) ID/Revision.........=12098086/09
PCI Function 00/14/0 (0000A000) ID/Revision.........=00221011/04
PCI Function 01/02/0 (00011000) ID/Revision.........=44325354/04
PCI Function 01/03/0 (00011800) ID/Revision.........=16A814E4/02
PCI Function 01/03/1 (00011900) ID/Revision.........=16A814E4/02

and in linux

# lspci
00:00.0 Host bridge: Motorola Hawk (rev 03)
00:0d.0 Bridge: Tundra Semiconductor Corp. CA91C042 [Universe] (rev 02)
00:0e.0 Ethernet controller: Intel Corp. 82559ER (rev 09)
00:11.0 Unknown mass storage controller: Promise Technology, Inc. 20269 
(rev 02)
00:13.0 Ethernet controller: Intel Corp. 82559ER (rev 09)
00:14.0 PCI bridge: Digital Equipment Corporation DECchip 21150 (rev 04)
01:02.0 Sharc Processors: Sonartech Atlas SharcPmcII (rev 04)
01:03.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5704S 
Gigabit Ethernet (rev 02)
01:03.1 Ethernet controller: Broadcom Corporation NetXtreme BCM5704S 
Gigabit Ethernet (rev 02)

>>>The only thing statically available on a PCI device is the interrupt
>>>pin register value.
>>>      
>>>
>>That only tells you whether the device has any IRQ at all.
>>    
>>
>
>No, it also tells you which pin it is routed to (A-D). That's
>an important piece of information when routing interrupts.
>
>  
>
My "challenge" seems to be that from the 2.4 series kernel to the 
2.6.9-rc2 (I haven't tried any others) the interrupt routing has changed
i.e. for a 2.4 series I get from lspci -v:
01:03.1 Ethernet controller: Broadcom Corporation NetXtreme BCM5704S 
Gigabit Ethernet (rev 02)
        Subsystem: Broadcom Corporation NetXtreme BCM5704S Gigabit Ethernet
        Flags: bus master, 66Mhz, medium devsel, latency 128, IRQ 9
        Memory at f2ed0000 (64-bit, non-prefetchable) [size=64K]
        Memory at f2ec0000 (64-bit, non-prefetchable) [size=64K]
        Capabilities: [40] #07 [0000]
        Capabilities: [48] Power Management version 2
        Capabilities: [50] Vital Product Data
        Capabilities: [58] Message Signalled Interrupts: 64bit+ 
Queue=0/3 Enable-

and from 2.6.9-rc2:
01:03.1 Ethernet controller: Broadcom Corporation NetXtreme BCM5704S 
Gigabit Ethernet (rev 02)
        Subsystem: Broadcom Corporation NetXtreme BCM5704S Gigabit Ethernet
        Flags: bus master, 66Mhz, medium devsel, latency 128
        Memory at f2ed0000 (64-bit, non-prefetchable) [size=64K]
        Memory at f2ec0000 (64-bit, non-prefetchable) [size=64K]
        Capabilities: [40] #07 [0002]
        Capabilities: [48] Power Management version 2
        Capabilities: [50] Vital Product Data
        Capabilities: [58] Message Signalled Interrupts: 64bit+ 
Queue=0/3 Enable-

so where do I look ??? I'm thinking it's in the mvme5100 platform setup, 
am I assuming right?

>>>That combined with the platform-specific routing
>>>table is used to generate an arbitrary interrupt line value that
>>>is programmed into the PCI interrupt line register.
>>>      
>>>
>>interrupt line == IRQ#?  That is set up _before_ Linux runs.
>>    
>>
>
>Again, on some platforms, not this one. Let's just agree that
>not everything is a x86/BIOS or ppc64/pmac/OF machine that
>has this done in some blackbox firmware.
>
>-Matt
>  
>
