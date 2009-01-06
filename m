Return-Path: <leon.woestenberg@gmail.com>
Received: from mail-bw0-f10.google.com (mail-bw0-f10.google.com
	[209.85.218.10]) by ozlabs.org (Postfix) with ESMTP id 2AC37474FE
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Jan 2009 09:34:08 +1100 (EST)
Received: by bwz3 with SMTP id 3so21247276bwz.9
	for <linuxppc-dev@ozlabs.org>; Tue, 06 Jan 2009 14:34:06 -0800 (PST)
Message-ID: <c384c5ea0901061433y446f4ab4i2e18d1141734d60e@mail.gmail.com>
Date: Tue, 6 Jan 2009 23:33:35 +0100
From: "Leon Woestenberg" <leon.woestenberg@gmail.com>
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH v2 4/4] powerpc/83xx: Add PCI-E support for all MPC83xx
	boards with PCI-E
In-Reply-To: <20090106211513.GA23914@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <C96CE59B-05FA-4728-930F-D4430EFB9B99@kernel.crashing.org>
	<1F7739C2-930B-49C1-B8FF-679AF1BBAEAE@kernel.crashing.org>
	<20081231171017.6FCF585AD247@gemini.denx.de>
	<B64DF110-E26A-4229-8384-E7933732BC01@kernel.crashing.org>
	<20090105174645.GA23766@ld0162-tx32.am.freescale.net>
	<20090105180122.GA12237@oksana.dev.rtsoft.ru>
	<c384c5ea0901061053r21fbc853y3b28ae3c8e3a0e6f@mail.gmail.com>
	<20090106192747.GA3056@oksana.dev.rtsoft.ru>
	<2B8AFE67-67BF-4926-B41B-79ACD72CA505@kernel.crashing.org>
	<20090106211513.GA23914@oksana.dev.rtsoft.ru>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	Wolfgang Denk <wd@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello Anton,

On Tue, Jan 6, 2009 at 10:15 PM, Anton Vorontsov
<avorontsov@ru.mvista.com> wrote:
> On Tue, Jan 06, 2009 at 02:38:57PM -0600, Kumar Gala wrote:
>>>> Is u-boot PCIe initialization required for this kernel patch to work?
>>>
>>> Yup.
>>
>> Really?  what for?
>
> Hm. U-Boot should initialize SerDes and PCI-E controller (pcie laws,
> inbound/outbound windows, clocks, etc.)
>
> Though if PCI-E controller wasn't initialized (i.e. board reflashed
> with the community u-boot), Linux just won't probe the pcie controller:
>
> cfg_bar = in_le32(hose->cfg_data + PEX_OUTWIN0_BAR);
> if (!cfg_bar) {
>        /* PCI-E isn't configured. */
>        ret = -ENODEV;
>        goto err1;
> }
>
> Or did I misunderstand the question?
>
You understood correctly, thanks for answering.

So to summarize, we need u-boot to initialize the PCIe controller, in
order for Linux to further take it over.

What u-boot versions/releases do provide this initialization?

I know the u-boot with the board works, but it's incompatible with
recent Linux kernels.

Regards,
-- 
Leon
