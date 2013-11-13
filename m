Return-Path: <Emilian.Medve@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe002.messaging.microsoft.com [216.32.180.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4DDF62C00A3
 for <linuxppc-dev@ozlabs.org>; Thu, 14 Nov 2013 05:33:20 +1100 (EST)
Received: from mail101-co1 (localhost [127.0.0.1])	by
 mail101-co1-R.bigfish.com (Postfix) with ESMTP id 879C63C06B0	for
 <linuxppc-dev@ozlabs.org>; Wed, 13 Nov 2013 18:33:17 +0000 (UTC)
Received: from CO1EHSMHS014.bigfish.com (unknown [10.243.78.225])	by
 mail101-co1.bigfish.com (Postfix) with ESMTP id 75CD9700081	for
 <linuxppc-dev@ozlabs.org>; Wed, 13 Nov 2013 18:33:13 +0000 (UTC)
Received: from [10.214.80.42] ([10.214.80.42])	by az84smr01.freescale.net
 (8.14.3/8.14.0) with ESMTP id rADIX7I4002470	for <linuxppc-dev@ozlabs.org>;
 Wed, 13 Nov 2013 11:33:11 -0700
Message-ID: <5283C51F.9090708@Freescale.com>
Date: Wed, 13 Nov 2013 12:29:51 -0600
From: Emil Medve <Emilian.Medve@Freescale.com>
MIME-Version: 1.0
To: <linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH V2] powerpc/85xx: Merge 85xx/p1023_defconfig into
 mpc85xx_smp_defconfig and mpc85xx_defconfig
References: <1383952632-5770-1-git-send-email-Lijun.Pan@freescale.com>	
 <1384197913-24610-1-git-send-email-Lijun.Pan@freescale.com>	
 <1384293891.1403.70.camel__45039.5534084693$1384293935$gmane$org@snotra.buserror.net>	
 <5282B277.4090300@Freescale.com>	
 <1384307175.1403.118.camel__32063.4016803981$1384307228$gmane$org@snotra.buserror.net>	
 <5282E52B.2040306@Freescale.com>
 <1384366750.1403.154.camel@snotra.buserror.net>
In-Reply-To: <1384366750.1403.154.camel@snotra.buserror.net>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Scott,


On 11/13/2013 12:19 PM, Scott Wood wrote:
> On Tue, 2013-11-12 at 20:34 -0600, Emil Medve wrote:
>> Hello Scott,
>>
>>
>> On 11/12/2013 07:46 PM, Scott Wood wrote:
>>> On Tue, 2013-11-12 at 16:57 -0600, Emil Medve wrote:
>>>> Hello Scott,
>>>>
>>>>
>>>> On 11/12/2013 04:04 PM, Scott Wood wrote:
>>>>> On Mon, 2013-11-11 at 13:25 -0600, Lijun Pan wrote:
>>>>>> mpc85xx_smp_defconfig and mpc85xx_defconfig already have CONFIG_P1023RDS=y.
>>>>>> Merge CONFIG_P1023RDB=y and other relevant configurations into mpc85xx_smp_defconfig and mpc85_defconfig.
>>>>>>
>>>>>> Signed-off-by: Lijun Pan <Lijun.Pan@freescale.com>
>>>>>> ---
>>>>>>  arch/powerpc/configs/85xx/p1023_defconfig  |  188 ----------------------------
>>>>>>  arch/powerpc/configs/mpc85xx_defconfig     |   18 +++
>>>>>>  arch/powerpc/configs/mpc85xx_smp_defconfig |   17 +++
>>>>>>  3 files changed, 35 insertions(+), 188 deletions(-)
>>>>>>  delete mode 100644 arch/powerpc/configs/85xx/p1023_defconfig
>>>>>
>>>>> Are we still going to want to have one defconfig if and when we finally
>>>>> get datapath support upstream?  That's a lot of code to add to the 85xx
>>>>> config just for this one chip.
>>>>
>>>> Yes. But for mpc85xx_/smp_defconfig the datapath support shouldn't be
>>>> enabled by default given that just one SoC in that family has the
>>>> datapath (and we don't plan to put it in another e500v2 based SoC). For
>>>> regression/automation purposes config fragments should be used
>>>
>>> Is there any way to specify a meta-config for p1023 (or e500v2-dpaa or
>>> whatever) that says to combine mpc85xx_smp_defconfig with a dpaa
>>> fragment?
>>
>> Not aware of it
> 
> Then it's not yet a substitute for having a defconfig.
> 
>>> Do we have any config fragments in the tree so far?
>>
>> Nope. However, just to make sure, the fragment was my secondary point
>> and not necessarily as a candidate for upstreaming. My main point was
>> that the datapath support should simply not be enabled by default in the
>> mpc85xx_[smp_]defconfig
> 
> I think we should get numbers on how big the datapath code is (in its
> eventual upstream form) before deciding that, but if we do end up
> deciding not to enable it in mpc85xx_smp_defconfig, then there should be
> a separate defconfig for p1023 (possibly with a more generic name as
> discussed earlier).  If and when there's support for defconfigs that
> direct fragments to be included, then we can change the p1023 defconfig
> to use that, but I don't want to just leave it up to the user to enable
> manually.
> 
> If there's any way we can get the datapath code down to a reasonable
> size for inclusion in mpc85xx_smp_defconfig, that would be ideal.

Somebody gratuitously added a P1023 defconfig more then two years ago
with the notion that P1023 is special due to its datapath and we're
still one year out before we'll have the (P1023) datapath driver
upstream.  As of now this defconfig is just bit-rotting in the tree
creating confusion. Let's just remove it for now and we'll deal with the
entire e500v2_dpaa business when the datapath support will be upstreamed


Cheers,
