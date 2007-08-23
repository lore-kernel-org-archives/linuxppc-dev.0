Return-Path: <galak@kernel.crashing.org>
In-Reply-To: <20070823033318.GJ7042@localhost.localdomain>
References: <75EDD900-3B5E-4D08-9311-13B6510EDE6E@kernel.crashing.org>
	<2F7E4C06-9AC3-458A-B1E3-CA6E0BDD189A@kernel.crashing.org>
	<20070823033318.GJ7042@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <F19C9986-9E53-47F3-835D-C93DA9C3ADED@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: asm-ppc header issues when building ARCH=powerpc
Date: Wed, 22 Aug 2007 23:16:03 -0500
To: David Gibson <david@gibson.dropbear.id.au>
Cc: "linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Aug 22, 2007, at 10:33 PM, David Gibson wrote:

> On Wed, Aug 22, 2007 at 10:33:55PM -0500, Kumar Gala wrote:
>>
>> On Aug 22, 2007, at 10:19 AM, Kumar Gala wrote:
>>
>>> Guys,
>>>
>>> I was wondering if I could get your help with looking at the
>>> following lists and determining if we have an issue or not related
>>> the following files:
>>>
>>> Getting some classification on these would be good.  Possibly
>>> classifications, doesn't build in ARCH=powerpc, remove include, real
>>> issue, etc.
>>>
>>> - k
>>
>> My analysis of <asm/bootinfo.h> usage:
>>
>> ./drivers/macintosh/adb-iop.c:#include <asm/bootinfo.h>	 remove
>> ./drivers/char/vme_scc.c:#include <asm/bootinfo.h>		68k only
>> ./drivers/char/serial167.c:#include <asm/bootinfo.h>		68k only
>> ./drivers/serial/dz.c:#include <asm/bootinfo.h>		 decstation
>> ./drivers/mtd/devices/ms02-nv.c:#include <asm/bootinfo.h>	decstation
>> ./drivers/net/macsonic.c:#include <asm/bootinfo.h>		68k
>> ./drivers/net/jazzsonic.c:#include <asm/bootinfo.h>		mips
>> ./drivers/video/pmag-aa-fb.c:#include <asm/bootinfo.h>		mips
>> ./drivers/video/maxinefb.c:#include <asm/bootinfo.h>		mips
>> ./drivers/video/logo/logo.c:#include <asm/bootinfo.h>		mips
>> ./drivers/video/macfb.c:#include <asm/bootinfo.h>		68k
>> ./drivers/video/valkyriefb.c:#include <asm/bootinfo.h>		68k
>
> Uh.. I'm pretty sure valkyriefb.c is for (old) PowerMacs, not 68k.

It appears to be both.  If you look at the include its protected by a  
#ifdef CONFIG_MAC which we is only defined on m68k.

- k
