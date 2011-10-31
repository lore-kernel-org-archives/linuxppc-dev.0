Return-Path: <xenidis@gmail.com>
Received: from mail-yw0-f42.google.com (mail-yw0-f42.google.com
 [209.85.213.42]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 0BAC7B6F87
 for <linuxppc-dev@ozlabs.org>; Tue,  1 Nov 2011 05:35:37 +1100 (EST)
Received: by ywb26 with SMTP id 26so6441011ywb.15
 for <linuxppc-dev@ozlabs.org>; Mon, 31 Oct 2011 11:35:34 -0700 (PDT)
Sender: "xenidis@gmail.com" <xenidis@gmail.com>
Subject: Re: [1/4] powerpc: Revert show_regs() define for readability
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Jimi Xenidis <jimix@pobox.com>
In-Reply-To: <F8FBC967-70A0-47F4-9BB8-3E16CCEC6565@kernel.crashing.org>
Date: Mon, 31 Oct 2011 13:35:31 -0500
Message-Id: <D1AC3BEF-FCCE-4DC9-B2B4-FE29B17B479D@pobox.com>
References: <1317905621-5537-1-git-send-email-galak@kernel.crashing.org>
 <1ADB010A-A48C-4E71-91E0-94D60A3E676F@pobox.com>
 <F8FBC967-70A0-47F4-9BB8-3E16CCEC6565@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
Cc: Linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Oct 31, 2011, at 9:18 AM, Kumar Gala wrote:

>=20
> On Oct 28, 2011, at 2:40 PM, Jimi Xenidis wrote:
>=20
>>=20
>> On Oct 5, 2011, at 9:53 PM, Kumar Gala wrote:
>>=20
>>> We had an existing ifdef for 4xx & BOOKE processors that got changed =
to
>>> CONFIG_PPC_ADV_DEBUG_REGS.  The define has nothing to do with
>>> CONFIG_PPC_ADV_DEBUG_REGS.  The define really should be:
>>>=20
>>> #if defined(CONFIG_4xx) || defined(CONFIG_BOOKE)
>>>=20
>>> and not
>>>=20
>>> #ifdef CONFIG_PPC_ADV_DEBUG_REGS
>>>=20
>>> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
>>>=20
>>> ---
>>> arch/powerpc/kernel/process.c |    2 +-
>>> 1 files changed, 1 insertions(+), 1 deletions(-)
>>>=20
>>> diff --git a/arch/powerpc/kernel/process.c =
b/arch/powerpc/kernel/process.c
>>> index 8f53954..a1b5981 100644
>>> --- a/arch/powerpc/kernel/process.c
>>> +++ b/arch/powerpc/kernel/process.c
>>> @@ -657,7 +657,7 @@ void show_regs(struct pt_regs * regs)
>>> 	if ((regs->trap !=3D 0xc00) && cpu_has_feature(CPU_FTR_CFAR))
>>> 		printk("CFAR: "REG"\n", regs->orig_gpr3);
>>> 	if (trap =3D=3D 0x300 || trap =3D=3D 0x600)
>>> -#ifdef CONFIG_PPC_ADV_DEBUG_REGS
>>> +#if defined(CONFIG_4xx) || defined(CONFIG_BOOKE)
>>> 		printk("DEAR: "REG", ESR: "REG"\n", regs->dar, =
regs->dsisr);
>>=20
>> I'll be needing "|| defined(CONFIG_PPC_BOOK3E)" added to this please.
>> -jx
>=20
> Under what platform is CONFIG_PPC_BOOK3E set and CONFIG_BOOKE is not?

this was a grep typo on my part.  sorry.
-jx


>=20
> - k
>=20
