Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 0BCADDE2A6
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Apr 2009 17:31:10 +1000 (EST)
To: "Lixin Yao" <Lixin.Yao@HSTX.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: powerpc-linux-gcc vs ppx_8xx-gcc and ppc_6xx-gcc
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: <03D77CA4AC7F4D48A6AB5DA3F1001B3FB5BAC7@exchtxus2.HSTX.global.vpn>
References: <03D77CA4AC7F4D48A6AB5DA3F1001B3FB5BAC7@exchtxus2.HSTX.global.vpn>
Date: Fri, 17 Apr 2009 09:31:07 +0200
Message-Id: <20090417073107.1C18983420E8@gemini.denx.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Dear "Lixin Yao",

you should ask ELDK related questions on the ELDK mailing list, see
http://lists.denx.de/mailman/listinfo/eldk

In message <03D77CA4AC7F4D48A6AB5DA3F1001B3FB5BAC7@exchtxus2.HSTX.global.vpn> you wrote:
> 
> I use ELDK 4.2 to work on platforms, one with MPC860 and the other with
> MPC8248.
> 
> In installation, I see links:
> ppc_8xx-gcc -> ppc-linux-gcc
> ppc_6xx-gcc -> ppc-linux-gcc
> ppc-linux-gcc -> powerpc-linux-gcc
>
> I understand ppc_8xx-gcc needs to be used for MPC860 and ppc_6xx-gcc
> needs to be used for MPC8248. But both point to the same
> "powerpc-linux-gcc". 
>
> What are the differences between powerpc-linux-gcc, ppx_8xx-gcc and
> ppc_6xx-gcc? What's the default target processorr of powerpc-linux-gcc?

You must always specify the wanted target architecture in the
CROSS_COMPILE environment variable. If you run ppc_6xx-gcc or
powerpc-linux-gcc (which is possible, but NOT recommended because
it's often difficult to detect misconfigurations like incorrect
CROSS_COMPILE settings) then the target architecture is taken from
the CROSS_COMPILE value.

It is recommended to set CROSS_COMPILE and then run
${CROSS_COMPILE}gcc because this allows easy switching between
different target architectures, i. e. you can write Makefiles that
work both natively and for cross development, and for any of the
supported target architectures without changes to the code.

See for example the Linux or U-Boot Makefiles which work this way.

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
"Success covers a multitude of blunders."       - George Bernard Shaw
