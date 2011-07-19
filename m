Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6431DB6F83
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 19 Jul 2011 17:17:36 +1000 (EST)
Subject: Re: [PATCH v2] net: filter: BPF 'JIT' compiler for PPC64
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <4E252CFE.4070408@ozlabs.org>
Date: Tue, 19 Jul 2011 02:17:31 -0500
Message-Id: <CBA05A49-86F1-40FF-9244-0E4D29EBBA48@kernel.crashing.org>
References: <4E23E5C3.1070209@ozlabs.org> <4E24E867.9050909@ozlabs.org>
	<51978BAA-10A1-483D-B551-CCC2B69C72EA@kernel.crashing.org>
	<4E252CFE.4070408@ozlabs.org>
To: Matt Evans <matt@ozlabs.org>
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jul 19, 2011, at 2:06 AM, Matt Evans wrote:

> On 19/07/11 16:59, Kumar Gala wrote:
>>=20
>> On Jul 18, 2011, at 9:13 PM, Matt Evans wrote:
>>=20
>>> An implementation of a code generator for BPF programs to speed up =
packet
>>> filtering on PPC64, inspired by Eric Dumazet's x86-64 version.
>>>=20
>>> Filter code is generated as an ABI-compliant function in =
module_alloc()'d mem
>>> with stackframe & prologue/epilogue generated if required (simple =
filters don't
>>> need anything more than an li/blr).  The filter's local variables, =
M[], live in
>>> registers.  Supports all BPF opcodes, although "complicated" loads =
from negative
>>> packet offsets (e.g. SKF_LL_OFF) are not yet supported.
>>>=20
>>> There are a couple of further optimisations left for future work; =
many-pass
>>> assembly with branch-reach reduction and a register allocator to =
push M[]
>>> variables into volatile registers would improve the code quality =
further.
>>>=20
>>> This currently supports big-endian 64-bit PowerPC only (but is =
fairly simple
>>> to port to PPC32 or LE!).
>>>=20
>>> Enabled in the same way as x86-64:
>>>=20
>>> 	echo 1 > /proc/sys/net/core/bpf_jit_enable
>>>=20
>>> Or, enabled with extra debug output:
>>>=20
>>> 	echo 2 > /proc/sys/net/core/bpf_jit_enable
>>>=20
>>> Signed-off-by: Matt Evans <matt@ozlabs.org>
>>> ---
>>>=20
>>> V2: Removed some cut/paste woe in setting SEEN_X even on writes.
>>>   Merci for le review, Eric!
>>>=20
>>> arch/powerpc/Kconfig                  |    1 +
>>> arch/powerpc/Makefile                 |    3 +-
>>> arch/powerpc/include/asm/ppc-opcode.h |   40 ++
>>> arch/powerpc/net/Makefile             |    4 +
>>> arch/powerpc/net/bpf_jit.S            |  138 +++++++
>>=20
>> can we rename to bpf_jit_64.S, since this doesn't work on PPC32.
>>=20
>>> arch/powerpc/net/bpf_jit.h            |  227 +++++++++++
>>> arch/powerpc/net/bpf_jit_comp.c       |  690 =
+++++++++++++++++++++++++++++++++
>>=20
>> same here, or split between bpf_jit_comp.c (shared between ppc32 & =
ppc64) and
>> bpf_jit_comp_64.c
>=20
> A reasonable suggestion -- bpf_jit_64.S certainly.  I think it may not =
be worth
> splitting bpf_jit_comp.c until we support both tho?  (I'm thinking
> bpf_jit_comp_{32,64}.c would just house the stackframe generation code =
which is
> the main difference, plus compile-time switched macros for the odd LD =
vs LWZ.)

If its most 64-bit specific than just go with bpf_jit_comp_64.c for now. =
 We can refactor later.

>=20
> Sorry it's not 32bit-friendly just yet (I knew you'd ask, hehe), I've =
postponed
> that for when I get a mo :-)

:)
