Return-Path: <jrocnuck@hotmail.com>
Received: from bay0-omc1-s8.bay0.hotmail.com (bay0-omc1-s8.bay0.hotmail.com
	[65.54.246.80]) by ozlabs.org (Postfix) with ESMTP id AD5E9DE029
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 30 Jan 2007 02:45:32 +1100 (EST)
Message-ID: <BAY117-F356D4E37F804FF68E26CB2C8A70@phx.gbl>
In-Reply-To: <45BDAB22.30908@246tNt.com>
From: "Eric Nuckols" <jrocnuck@hotmail.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: mem=XXXM ioremap DMA
Date: Mon, 29 Jan 2007 10:33:25 -0500
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>



>
>Eric Nuckols wrote:
> > in my driver, I'm calling
> > my_virt_address =   ioremap( 0x1F800000, 0x800000  );
> > my_bus_address = virt_to_bus( my_virt_address );
> >
>You can't use virt_to_bus on address returned by ioremap AFAIK.
>
>I think you could do
>my_bus_address = virt_to_bus(phys_to_virt(0x1f800000));
>
>Altough it slightly misuse the functions ... but that should work.
>
>
>         Sylvain
>

If I use this approach in a driver, won't I still need to use the ioremap 
function to make sure the kernel does not reassign the virtual addresses to 
some other physical memory locations?

I want to hand off bus address descriptors to a hardware device that will 
perform bus master DMA back into the memory starting at 0x1f800000, but I 
want to make sure the virt addresses don't coincide with anything other than 
this range of memory (no matter what context I'm in 
--ISR/application...etc.etc..).

Thank,
Eric

_________________________________________________________________
Turn searches into helpful donations. Make your search count. 
http://click4thecause.live.com/search/charity/default.aspx?source=hmemtagline_donation&FORM=WLMTAG
