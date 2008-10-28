Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 6C58EDDE00
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Oct 2008 10:08:33 +1100 (EST)
To: Grant Erickson <gerickson@nuovations.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: Reserving Early RAM Regions and Porting Denx's CONFIG_LOGBUFFER
	to arch/powerpc
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: <C52CE317.12884%gerickson@nuovations.com>
References: <C52CE317.12884%gerickson@nuovations.com>
Date: Wed, 29 Oct 2008 00:01:26 +0100
Message-Id: <20081028230126.6471081C98E0@gemini.denx.de>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Dear Grant,

In message <C52CE317.12884%gerickson@nuovations.com> you wrote:
> I am working on attempting to migrate the Denx CONFIG_LOGBUFFER feature from
> arch/ppc:
> 
> http://git.denx.de/?p=linux-2.6-denx.git;a=blob_plain;f=arch/ppc/mm/init.c;h
> b=3df65660bbfa769b10b141351b0ea10427b0b709
> http://git.denx.de/?p=linux-2.6-denx.git;a=blob_plain;f=kernel/printk.c;hb=3
> df65660bbfa769b10b141351b0ea10427b0b709
> 
> In the historical implementation, basically, u-boot (if so configured)
> allocates 16 KiB + 4 KiB of memory at the end of physical RAM to store log
> messages that are compatible with the Linux kernel's printk. When Linux (if

Note that recent versions also can put the  log  buffer  in  SRAM  or
other similar storage areas like the OCM on some 4xx PowerPC systems;
this  is  actively used for example on PPC440EPx to make sure the log
buffer data remain unchanged by a system reset.

> so configured with CONFIG_LOGBUFFER) starts up, it redirects the normal
> log_buf to this "external log buffer" and appends any existing printk
> messages to those already pushed by u-boot. Future printk messages are then
> sent off to this new "external log buffer".

A short explanation for those who don't know what this is used for:

1) This allos to pass power-on selft test results from theboot loader
   (U-Boot) to the Linux kenrel, where it then can retrieved by
   application code using standard methods (syslog).

2) After a system crash, the log buffer is kept and can be read either
   by U-Boot or after rebooting into Linux. There are cases where the
   log buffer contains information that didn't make it any more to the
   console - if there is some console at all.

> What is the preferred method for hiding/reserving chunks of memory such as
> this during early boot? The device tree? The 'mem=' parameter? Adding an
> lmb_reserve() in prom.c:early_reserve_mem()? Twiddling things auto-magically
> such as the historical implementation? Some combination thereof?
> 
> The arch/ppc historical implementation simply twiddled total_memory and
> total_lowmem and then ioremap'd the 20 KiB off the end of memory.

That's a good question -  such  a  mechanism  is  needed  in  several
places,  for  example to pass a pre-initialized video buffer to Linux


Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Let's say the docs present a simplified view of reality...    :-)
                      - Larry Wall in  <6940@jpl-devvax.JPL.NASA.GOV>
