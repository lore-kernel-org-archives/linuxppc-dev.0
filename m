Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (2.236.17.93.rev.sfr.net [93.17.236.2])
 by lists.ozlabs.org (Postfix) with ESMTP id 05C411A2BD7
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Sep 2015 18:06:30 +1000 (AEST)
Subject: Re: [PATCH v3] powerpc32: memcpy: only use dcbz once cache is enabled
To: Scott Wood <scottwood@freescale.com>, Michael Ellerman <mpe@ellerman.id.au>
References: <20150911143348.F1D9F1A2420@localhost.localdomain>
 <1442007315.2909.49.camel@freescale.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, sojkam1@fel.cvut.cz,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
From: christophe leroy <christophe.leroy@c-s.fr>
Message-ID: <55F3DD01.9020507@c-s.fr>
Date: Sat, 12 Sep 2015 10:06:25 +0200
MIME-Version: 1.0
In-Reply-To: <1442007315.2909.49.camel@freescale.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Le 11/09/2015 23:35, Scott Wood a écrit :
> On Fri, 2015-09-11 at 16:33 +0200, Christophe Leroy wrote:
>> memcpy() uses instruction dcbz to speed up copy by not wasting time
>> loading cache line with data that will be overwritten.
>> Some platform like mpc52xx do no have cache active at startup and
>> can therefore not use memcpy(). Allthough no part of the code
>> explicitly uses memcpy(), GCC makes calls to it.
>>
>> This patch modifies memcpy() such that at startup, memcpy()
>> unconditionally jumps to generic_memcpy() which doesn't use
>> the dcbz instruction.
>>
>> Once the initial MMU is set up, in machine_init() we patch memcpy()
>> by replacing this inconditional jump by a NOP
>>
>> Reported-by: Michal Sojka <sojkam1@fel.cvut.cz>
>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>> ---
>> changes in v2:
>>    Using feature-fixups instead of hardcoded call to patch_instruction()
>>    Handling of memset() added
>> changes in v3:
>>    Not using anymore feature-fixups
>>    Handling of memset() removed
> Why was handling of memset() removed?
>
>

Initially, the issue was reported for memcpy() only. v1 was only 
handling memcpy()
When it came to using fixups with v2, it took the opportunity to also 
handle memset() just in case, as it was quite simple.
Now with v3, we are back to using simple solution with 
patch_instruction() as recommended by Michael, having to point to the 
instruction to be replaced by a NOP.
For memcpy() it is quite easy, we just put a jump to generic_memcpy() as 
first instruction of memcpy().
For memset() we don't have a generic_memset() to jump to in the begining 
of memset(). We have to skip the handling of complete cache lines (block 
starting with "clrlwi    r7,r6,32-LG_CACHELINE_BYTES"). This means we 
have to add a global symbol for that to use with patch_instruction()

memset() doesn't seem to be an issue for the time being. Should we do it 
anyway ?

Christophe

---
L'absence de virus dans ce courrier électronique a été vérifiée par le logiciel antivirus Avast.
https://www.avast.com/antivirus
