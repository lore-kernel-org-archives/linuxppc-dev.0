Return-Path: <matt@ozlabs.org>
Message-ID: <4E2530F8.2000609@ozlabs.org>
Date: Tue, 19 Jul 2011 17:23:36 +1000
From: Matt Evans <matt@ozlabs.org>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v2] net: filter: BPF 'JIT' compiler for PPC64
References: <4E23E5C3.1070209@ozlabs.org> <4E24E867.9050909@ozlabs.org>
	<51978BAA-10A1-483D-B551-CCC2B69C72EA@kernel.crashing.org>
	<4E252CFE.4070408@ozlabs.org>
	<CBA05A49-86F1-40FF-9244-0E4D29EBBA48@kernel.crashing.org>
In-Reply-To: <CBA05A49-86F1-40FF-9244-0E4D29EBBA48@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 19/07/11 17:17, Kumar Gala wrote:
> 
> On Jul 19, 2011, at 2:06 AM, Matt Evans wrote:
> 
>> On 19/07/11 16:59, Kumar Gala wrote:
>>>
>>> On Jul 18, 2011, at 9:13 PM, Matt Evans wrote:
>>>
>>>> [snip]
>>>>
>>>> V2: Removed some cut/paste woe in setting SEEN_X even on writes.
>>>>   Merci for le review, Eric!
>>>>
>>>> arch/powerpc/Kconfig                  |    1 +
>>>> arch/powerpc/Makefile                 |    3 +-
>>>> arch/powerpc/include/asm/ppc-opcode.h |   40 ++
>>>> arch/powerpc/net/Makefile             |    4 +
>>>> arch/powerpc/net/bpf_jit.S            |  138 +++++++
>>>
>>> can we rename to bpf_jit_64.S, since this doesn't work on PPC32.
>>>
>>>> arch/powerpc/net/bpf_jit.h            |  227 +++++++++++
>>>> arch/powerpc/net/bpf_jit_comp.c       |  690 +++++++++++++++++++++++++++++++++
>>>
>>> same here, or split between bpf_jit_comp.c (shared between ppc32 & ppc64) and
>>> bpf_jit_comp_64.c
>>
>> A reasonable suggestion -- bpf_jit_64.S certainly.  I think it may not be worth
>> splitting bpf_jit_comp.c until we support both tho?  (I'm thinking
>> bpf_jit_comp_{32,64}.c would just house the stackframe generation code which is
>> the main difference, plus compile-time switched macros for the odd LD vs LWZ.)
> 
> If its most 64-bit specific than just go with bpf_jit_comp_64.c for now.  We can refactor later.

Nah, other way round -- it's almost all agnostic but with a couple of functions
that I was recommending moving out to a _64.c and _32.c later, leaving the bulk
still in bpf_jit_comp.c.


Matt
