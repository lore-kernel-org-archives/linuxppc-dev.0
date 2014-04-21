Return-Path: <robherring2@gmail.com>
Received: from mail-vc0-f169.google.com (mail-vc0-f169.google.com
 [209.85.220.169])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 2FBC01400E5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Apr 2014 22:56:26 +1000 (EST)
Received: by mail-vc0-f169.google.com with SMTP id ik5so952135vcb.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Apr 2014 05:56:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20140418125924.GF5904@bivouac.eciton.net>
References: <1397756521-29387-1-git-send-email-leif.lindholm@linaro.org>
 <1397756521-29387-4-git-send-email-leif.lindholm@linaro.org>
 <CAMuHMdXBNWum7UJ95uT2hwTd1b5C8ebF2LQ4T-A+RS80p7MH=A@mail.gmail.com>
 <20140418125924.GF5904@bivouac.eciton.net>
Date: Mon, 21 Apr 2014 07:56:22 -0500
Message-ID: <CAL_JsqJTMWKh3gsv0TnRap82+7BM4XaT4ZAWkQmyfvzTqOq12g@mail.gmail.com>
Subject: Re: [PATCH 3/3] of: Handle memory@0 node on PPC32 only
From: Rob Herring <robherring2@gmail.com>
To: Leif Lindholm <leif.lindholm@linaro.org>
Content-Type: text/plain; charset=UTF-8
Cc: Mark Rutland <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Linaro Patches <patches@linaro.org>, Lee Jones <lee.jones@linaro.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Grant Likely <grant.likely@linaro.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Apr 18, 2014 at 7:59 AM, Leif Lindholm <leif.lindholm@linaro.org> wrote:
> Hi Geert,
>
> On Fri, Apr 18, 2014 at 10:04:15AM +0200, Geert Uytterhoeven wrote:
>> On Thu, Apr 17, 2014 at 7:42 PM, Leif Lindholm <leif.lindholm@linaro.org> wrote:
>> > In order to deal with an firmware bug on a specific ppc32 platform
>> > (longtrail), early_init_dt_scan_memory() looks for a node called
>> > memory@0 on all platforms. Restrict this quirk to ppc32 kernels only.
>>
>> This breaks backwards compatibilty with old DTSes (at least on ARM/MIPS,
>> where you added the missing property in patches 1 and 2 of the series)?
>
> As Rob said in response to 0/3, the MIPSs would likely not be affected,
> since they embed the DT.
>
>> For the Longtrail, I don't care much anymore, as mine died in 2004.
>> AFAIK, there have never been many users anyway.
>
> There are still a few mentions of it under arch/powerpc/, so I wouldn't
> want to be the one to kill it off...
>
> How about the below v2 3/3 to address the ARM platform?
>
> Regards,
>
> Leif
>
> From 6fa0b837ad71780334eb97d63c507165b6c57add Mon Sep 17 00:00:00 2001
> From: Leif Lindholm <leif.lindholm@linaro.org>
> Date: Thu, 17 Apr 2014 14:24:47 +0100
> Subject: [PATCH] of: arm: powerpc: Restrict memory@0 node handling to
>  affected platforms
>
> In order to deal with a firmware bug on a specific ppc32 platform
> (longtrail), early_init_dt_scan_memory() looks for a node called
> memory@0 on all platforms, for all nodes lacking a device_type.
> Restrict this quirk to ppc32 and the arm mach-ux500 platforms (one of
> which has depended on this special handling).


> diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
> index 889005f..230c747 100644
> --- a/drivers/of/Kconfig
> +++ b/drivers/of/Kconfig
> @@ -77,4 +77,7 @@ config OF_RESERVED_MEM
>         help
>           Helpers to allow for reservation of memory regions
>
> +config OF_MEMORY_AT_0_QUIRK
> +       def_bool n

I do not like this because it would not scale to many quirks. As I
said,, my preference here would be to just add a WARN.

The other option is get approval to break compatibility on the ST
platform. It may not be a concern on certain platforms.

Rob
