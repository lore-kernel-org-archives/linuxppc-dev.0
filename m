Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 8FEC767B90
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 11 Feb 2006 12:20:29 +1100 (EST)
To: atul.sabharwal@exgate.tek.com
From: Wolfgang Denk <wd@denx.de>
Subject: Re: kernel startup 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 10 Feb 2006 16:28:28 PST."
	<4A062D477D842B4C8FC48EA5AF2D41F201BA2089@us-bv-m23.global.tektronix.net>
Date: Sat, 11 Feb 2006 02:20:27 +0100
Sender: wd@denx.de
Message-Id: <20060211012027.DD9C8353B42@atlas.denx.de>
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

In message <4A062D477D842B4C8FC48EA5AF2D41F201BA2089@us-bv-m23.global.tektronix.net> you wrote:
> 
> Not much choice with IMMR as it can be 0x0 or 0x00f00000 or 0xFF000000
> Or 0xFFF00000.  

Initially. But you can change it.

> Flash is from 0xfe000000 thru 0xffffffff.  Now on POR,
> Processor goes to offset 0x100 on CS0.  So, if IMMR is overlapping with
> flash, it might not boot.

Just fix your memory map.

> On 870, it seems that reset value for BR0/OR0 is undefined.

Please RTFM. The steps how the processor  comes  up  from  reset  are
documented  in  great  detail.  Especially  the  handling of the boot
device chip select.

> Data fetch goes on CS0 and then in cpu_init_f BR0 & OR0
> Are remapped.  So, I could put flash at a non-standard address like
> 0xDE000000 and move IMMR to 0xFF000000.

There is no such thing as a "non-standard" address, as  there  is  no
"standard" address either.

> The problem this creates is that I can set IIP to 0 or 1. So, exception
> Vector prefix can be 0 or 0xfff.  Since no flash at 0xfff00000 base 
> Address I cannot have any exceptions in my code till the u-boot code
> has relocated to RAM.  Which should be acceptable as what can I do
> if there is exception so early in the system. 

In most cases it is useful to configure a system for low-boot, i.  e.
let  it  start  at  0x0100.  Then  just set up your memory map as you
like...

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
You don't need a weatherman to know which way the wind blows.
                                                          - Bob Dylan
