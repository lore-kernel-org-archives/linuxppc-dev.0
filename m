Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id BDBC6B70CF
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Dec 2009 19:16:10 +1100 (EST)
To: Vitaly Bordug <vitb@kernel.crashing.org>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: [POWERPC] add U-Boot bootcount driver.
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: <20091216024730.455b90fd@vitb-lp>
References: <20091216024730.455b90fd@vitb-lp>
Date: Thu, 17 Dec 2009 09:16:07 +0100
Message-Id: <20091217081607.4B621D43F21@gemini.denx.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Dear Vitaly Bordug,


repl: bad addresses:
	linuxppc-dev@ozlabs.org <linuxppc-dev@ozlabs.org> -- junk after local@domain (<)
In message <20091216024730.455b90fd@vitb-lp> you wrote:
> 
> From: Heiko Schocher <hs@denx.de>
> 
> This driver provides (read/write) access to the
> U-Boot bootcounter via PROC FS or sysFS.
> 
> in u-boot, it uses a 8 byte mem area (it must hold the value over a
> soft reset of course), for storing a bootcounter (it counts many soft
> resets are done, on hard reset it starts with 0). If the bootcountvalue
> exceeds the value in the env variable "bootlimit", and alternative
> bootcmd stored in the env variable "altbootcmd" is run.
> 
> The bootcountregister gets configured via DTS.
> for example on the mgsuvd board:
> 
> bootcount@0x3eb0 {
>                   device_type = "bootcount";
>                   compatible = "uboot,bootcount";
>                   reg = <0x3eb0 0x08>;
>                  };
> 
> This driver is tested on the mgcoge(82xx) and mgsuvd(8xx) board.
> 
> Signed-off-by: Heiko Schocher <hs@denx.de>
> Signed-off-by: Wolfgang Denk <wd@denx.de>
> Signed-off-by: Vitaly Bordyug <vitb@kernel.crashing.org>

I think it would be good if the text of the commit message could be
reworked by a native English speaker.

Regarding the subject: it is probably important to point out that this
driver implements the Linux kernel half of the boot count feature -
the boot counter can only be reset after it is clear that the
application has been started and is running correctly, which usually
can only be determined by the application code itself. Thus the reset
of the boot counter must be done by application code, which thus needs
an appropriate driver.

> I think there is no reason not to have this in mainline. Thoughts? And
> I'm not sure what is right direction to push this - it's representation
> of u-boot feature in fact, pretty useful tho.

It's not only useful, it's actually a required feature by the Carrier
Grade Linux Requirements Definition; see for example document "Carrier
Grade Linux Requirements Definition Overview V3.0" at
https://www.linux-foundation.org/images/1/1a/Cgl_req_def_overview_30.pdf
Page 49:

	ID PLT.4.0 (2.3 in v1.1)	Boot Cycle Detection

        Description: OSDL CGL specifies that carrier grade Linux
        shall provide support for detecting a repeating reboot cycle
        due to recurring failures and going to an offline state if
        this occurs.




Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
I read part of it all the way through.
