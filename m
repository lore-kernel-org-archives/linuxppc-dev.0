Return-Path: <asolokha@kb.kras.ru>
Received: from ispman.iskranet.ru (ispman.iskranet.ru [62.213.33.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 68EEF1A03B0
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Mar 2015 17:56:53 +1100 (AEDT)
From: Arseny Solokha <asolokha@kb.kras.ru>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v3 0/4] powerpc: trivial unused functions cleanup
References: <1424768706-23150-1-git-send-email-asolokha@kb.kras.ru>
 <1426823789-949-1-git-send-email-asolokha@kb.kras.ru>
 <1426825436.2581.1.camel@ellerman.id.au>
 <87pp84w9mj.fsf@KB00016249.iskra.kb>
 <1426829993.2581.2.camel@ellerman.id.au>
Date: Sat, 21 Mar 2015 13:56:43 +0700
In-Reply-To: <1426829993.2581.2.camel@ellerman.id.au> (Michael Ellerman's
 message of "Fri, 20 Mar 2015 16:39:53 +1100")
Message-ID: <878ueqg7o4.fsf@KB00016249.iskra.kb>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Scott Wood <scottwood@freescale.com>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> On Fri, 2015-03-20 at 11:55 +0700, Arseny Solokha wrote:
>>=20
>> And by the way, while revisiting the series I've noticed that though the=
 patch
>> 4/4 basically reverts [1], it leaves
>>=20
>>   #define MPIC_GREG_GLOBAL_CONF_1		0x00030
>>=20
>> in arch/powerpc/include/asm/mpic.h untouched. That define also loses its=
 uses
>> after applying the patch. Compare the following hunk in today's patch w/=
 the one
>> you committed:
>>=20
>>   @@ -33,11 +33,6 @@
>>    #define		MPIC_GREG_GCONF_NO_BIAS			0x10000000
>>    #define		MPIC_GREG_GCONF_BASE_MASK		0x000fffff
>>    #define		MPIC_GREG_GCONF_MCK			0x08000000
>>   -#define MPIC_GREG_GLOBAL_CONF_1		0x00030
>>   -#define		MPIC_GREG_GLOBAL_CONF_1_SIE		0x08000000
>>   -#define		MPIC_GREG_GLOBAL_CONF_1_CLK_RATIO_MASK	0x70000000
>>   -#define		MPIC_GREG_GLOBAL_CONF_1_CLK_RATIO(r)	\
>>   -			(((r) << 28) & MPIC_GREG_GLOBAL_CONF_1_CLK_RATIO_MASK)
>>    #define MPIC_GREG_VENDOR_0		0x00040
>>    #define MPIC_GREG_VENDOR_1		0x00050
>>    #define MPIC_GREG_VENDOR_2		0x00060
>>=20
>> So the question is, should #define MPIC_GREG_GLOBAL_CONF_1 have been also
>> removed, or could be left as is?
>>=20
>> [1] https://lists.ozlabs.org/pipermail/linuxppc-dev/2006-June/023867.html
>
>
> OK, thanks for the thoroughness.
>
> With #defines like that it's never clear if they should be removed or not=
. On
> the one hand it's not used, so it should be removed. But, it can be usefu=
l to
> keep the #defines there as documentation.
>
> So I'm 50/50 on it. If you send me a patch to remove it I'll merge it, un=
less
> someone else objects.

So I'd abstain from removing it, for whatever it may be worth. Let it serve=
 the
documentation purposes.

Ars=C3=A9ny

> cheers
