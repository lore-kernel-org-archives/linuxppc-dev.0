Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rGFNM26szzDqZZ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 May 2016 15:45:23 +1000 (AEST)
Subject: Re: [PATCH 2/2] powerpc: Align hot loops of some string functions
To: Segher Boessenkool <segher@kernel.crashing.org>
References: <20160526083813.0f96a454@kryten> <20160526083955.3f7deda4@kryten>
 <14a46745-dd1e-2963-1c1a-7daafa5aed4b@c-s.fr>
 <20160526193728.GA883@gate.crashing.org>
Cc: Anton Blanchard <anton@samba.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>,
 acsawdey@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <91429364-b0f4-89c2-dc92-1cc40970d3e3@c-s.fr>
Date: Fri, 27 May 2016 07:45:18 +0200
MIME-Version: 1.0
In-Reply-To: <20160526193728.GA883@gate.crashing.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 26/05/2016 à 21:37, Segher Boessenkool a écrit :
> On Thu, May 26, 2016 at 09:24:51AM +0200, Christophe Leroy wrote:
>> Wouldn't it be better to add nops before the function entry in order to
>> get the hot loop aligned, instead of adding nops in the middle of the
>> function ?
> Why would that be better?  The nops are executed once per function call
> in either case, there are the same number of nops in either case, and
> on most CPUs nops aren't actually executed anyway (they are decoded and
> the thrown away).
>
The idea was to not execute them:

|.balign 16 nop nop _GLOBAL(strcpy) addi	r5,r3,-1 addi	r4,r4,-1 1:	lbzu 
r0,1(r4) cmpwi	0,r0,0 stbu	r0,1(r5) bne	1b blr |

Christophe
