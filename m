Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xdhWJ3JRbzDrJx
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Aug 2017 10:15:08 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe LEROY <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 4/4] powerpc/32: remove a NOP from memset()
In-Reply-To: <4fcbdc51-b170-d4a2-5344-c55b2ec71cbb@c-s.fr>
References: <cover.1503277387.git.christophe.leroy@c-s.fr>
 <ae2205dedfe437e4df2dd0cc7605d62189833221.1503277387.git.christophe.leroy@c-s.fr>
 <871so1w86g.fsf@concordia.ellerman.id.au>
 <4fcbdc51-b170-d4a2-5344-c55b2ec71cbb@c-s.fr>
Date: Fri, 25 Aug 2017 10:15:08 +1000
Message-ID: <87k21sv6yb.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Christophe LEROY <christophe.leroy@c-s.fr> writes:

> Le 24/08/2017 =C3=A0 12:51, Michael Ellerman a =C3=A9crit=C2=A0:
>> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>>=20
>>> memset() is patched after initialisation to activate the
>>> optimised part which uses cache instructions.
>>>
>>> Today we have a 'b 2f' to skip the optimised patch, which then gets
>>> replaced by a NOP, implying a useless cycle consumption.
>>> As we have a 'bne 2f' just before, we could use that instruction
>>> for the live patching, hence removing the need to have a
>>> dedicated 'b 2f' to be replaced by a NOP.
>>>
>>> This patch changes the 'bne 2f' by a 'b 2f'. During init, that
>>> 'b 2f' is then replaced by 'bne 2f'
>>=20
>> I'm not sure what the sequence is during boot for the 32-bit code, but
>> can you use an ALT_FTR section for this? Possibly that doesn't get done
>> at the right time though.
>
> Unfortunately, as we discussed in 2015=20
> (https://lkml.org/lkml/2015/9/10/608),

Haha, you expect me to remember things I said then! ;)

> the ALT_FTR does things too early, while the cache is not enabled yet.

OK. Ben did do some reworks to the early init since then, but I don't
think he changed that.

I notice we do setup_feature_keys() in machine_init(), which is the jump
label equivalent of apply_feature_fixups(). So I wonder if we could
actually move apply_feature_fixups() to there. But it would need some
serious review.

cheers
