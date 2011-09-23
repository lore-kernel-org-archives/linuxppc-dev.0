Return-Path: <xenidis@gmail.com>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A9AD0B6F76
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 24 Sep 2011 03:54:34 +1000 (EST)
Received: by gyg4 with SMTP id 4so3132547gyg.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 23 Sep 2011 10:54:31 -0700 (PDT)
Sender: "xenidis@gmail.com" <xenidis@gmail.com>
Subject: Re: [PATCH v2] powerpc: Fix xmon for systems without MSR[RI]
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Jimi Xenidis <jimix@pobox.com>
In-Reply-To: <4E7CB4B1.3080703@freescale.com>
Date: Fri, 23 Sep 2011 12:54:27 -0500
Message-Id: <72989FF4-07B5-4BAC-BD9C-FE768296FDD8@pobox.com>
References: <1312838739-20660-1-git-send-email-jimix@pobox.com>
	<1316790104-10067-1-git-send-email-jimix@pobox.com>
	<4E7CB4B1.3080703@freescale.com>
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	David Gibson <dwg@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Sep 23, 2011, at 11:32 AM, Scott Wood wrote:

> On 09/23/2011 10:01 AM, Jimi Xenidis wrote:
>> From: David Gibson <dwg@au1.ibm.com>
>>=20
>> Based on patch by David Gibson <dwg@au1.ibm.com>
>>=20
>> xmon has a longstanding bug on systems which are SMP-capable but lack
>> the MSR[RI] bit.  In these cases, xmon invoked by IPI on secondary
>> CPUs will not properly keep quiet, but will print stuff, thereby
>> garbling the primary xmon's output.  This patch fixes it, by ignoring
>> the RI bit if the processor does not support it.
>>=20
>> There's already a version of this for 4xx upstream, which we'll need
>> to extend to other RI-lacking CPUs at some point.  For now this adds
>> Book3e processors to the mix.
>>=20
>> Signed-off-by: Jimi Xenidis <jimix@pobox.com>
>>=20
>> ---
>> Restricted it to Book3e
>> ---
>> arch/powerpc/xmon/xmon.c |    4 ++--
>> 1 files changed, 2 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
>> index 42541bb..13f82f8 100644
>> --- a/arch/powerpc/xmon/xmon.c
>> +++ b/arch/powerpc/xmon/xmon.c
>> @@ -340,8 +340,8 @@ int cpus_are_in_xmon(void)
>>=20
>> static inline int unrecoverable_excp(struct pt_regs *regs)
>> {
>> -#ifdef CONFIG_4xx
>> -	/* We have no MSR_RI bit on 4xx, so we simply return false */
>> +#if defined(CONFIG_4xx) || defined(CONFIG_BOOK3E)
>> +	/* We have no MSR_RI bit on 4xx or Book3e, so we simply return =
false */
>> 	return 0;
>> #else
>> 	return ((regs->msr & MSR_RI) =3D=3D 0);
>=20
> How is CONFIG_BOOK3E better than CONFIG_BOOKE?  Both e500mc (has RI) =
and
> e500v2 (doesn't have RI) will select both symbols.  Sounds like it
> should be a cputable flag.

Ben was not in favor of wasting a cpu feature bit on this.
I figured that since Book3e ISA does not support an RI bit than I would =
leave that too the those who extend it. :)
Any other ideas are welcome.

-JX


>=20
> -Scott
>=20
