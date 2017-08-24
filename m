Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xdQr60YsLzDrJ3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Aug 2017 23:58:46 +1000 (AEST)
Subject: Re: [PATCH 4/4] powerpc/32: remove a NOP from memset()
To: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <cover.1503277387.git.christophe.leroy@c-s.fr>
 <ae2205dedfe437e4df2dd0cc7605d62189833221.1503277387.git.christophe.leroy@c-s.fr>
 <871so1w86g.fsf@concordia.ellerman.id.au>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <4fcbdc51-b170-d4a2-5344-c55b2ec71cbb@c-s.fr>
Date: Thu, 24 Aug 2017 15:58:41 +0200
MIME-Version: 1.0
In-Reply-To: <871so1w86g.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 24/08/2017 à 12:51, Michael Ellerman a écrit :
> Christophe Leroy <christophe.leroy@c-s.fr> writes:
> 
>> memset() is patched after initialisation to activate the
>> optimised part which uses cache instructions.
>>
>> Today we have a 'b 2f' to skip the optimised patch, which then gets
>> replaced by a NOP, implying a useless cycle consumption.
>> As we have a 'bne 2f' just before, we could use that instruction
>> for the live patching, hence removing the need to have a
>> dedicated 'b 2f' to be replaced by a NOP.
>>
>> This patch changes the 'bne 2f' by a 'b 2f'. During init, that
>> 'b 2f' is then replaced by 'bne 2f'
> 
> I'm not sure what the sequence is during boot for the 32-bit code, but
> can you use an ALT_FTR section for this? Possibly that doesn't get done
> at the right time though.

Unfortunately, as we discussed in 2015 
(https://lkml.org/lkml/2015/9/10/608), the ALT_FTR does things too 
early, while the cache is not enabled yet.

Christophe
