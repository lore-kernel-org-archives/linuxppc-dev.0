Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by lists.ozlabs.org (Postfix) with ESMTP id 3qPW6H6PhzzDqgl
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Mar 2016 21:28:07 +1100 (AEDT)
Subject: Re: Pull request: scottwood/linux.git next
To: Scott Wood <oss@buserror.net>, Michael Ellerman <mpe@ellerman.id.au>,
 benh@kernel.crashing.org
References: <20160312031535.GA24351@home.buserror.net>
 <1458001168.8059.3.camel@ellerman.id.au>
 <1458025311.12370.18.camel@buserror.net>
Cc: linuxppc-dev@lists.ozlabs.org, galak@kernel.crashing.org,
 chenhui.zhao@freescale.com
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <56E7E3AC.9090905@c-s.fr>
Date: Tue, 15 Mar 2016 11:27:56 +0100
MIME-Version: 1.0
In-Reply-To: <1458025311.12370.18.camel@buserror.net>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 15/03/2016 08:01, Scott Wood a écrit :
> On Tue, 2016-03-15 at 11:19 +1100, Michael Ellerman wrote:
>> On Fri, 2016-03-11 at 21:15 -0600, Scott Wood wrote:
>>
>>> Highlights include 8xx optimizations, 32-bit checksum optimizations, 86xx
>>> consolidation, e5500/e6500 cpu hotplug, more fman and other dt bits, and
>>> minor fixes/cleanup.
>> Hi Scott,
>>
>> This one's giving me a few troubles.
[...]
>>> Christophe Leroy (31):
>>>        powerpc/8xx: Handle CPU6 ERRATA directly in mtspr() macro
>> This breaks mpc866_ads_defconfig for me, with lots of:
>>
>>    arch/powerpc/mm/8xx_mmu.c:139:2: error: memory input 1 is not directly
>> addressable
>>
>> That's using gcc < 4.9. With >= 4.9 it builds OK. So again your call on
>> whether
>> we drop support for those compilers for that config.
> I'd rather not require something that new, especially for a chip so old.
>
> I've sent an untested patch that should fix it.

The proposed patch gives a code slightly different than what Freescale's 
ERRATA recommends.

However, why do we activate CPU6 ERRATA in that config ?
CPU6 seems to be an issue with the old MPC860 and MPC855 only.
CPU6 is not listed in the MPC866 ERRATAs, so we should probably not have 
this selected in mpc866_ads_defconfig

Christophe

PS: It also builds ok with GCC 4.8.3
