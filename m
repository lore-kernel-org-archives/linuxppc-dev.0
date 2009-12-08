Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 5EFE0B7BDB
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Dec 2009 19:54:03 +1100 (EST)
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: [PATCH 1/5] powerpc: Move VMX and VSX asm code to vector.S
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: <20090603071751.AF006DDDF7@ozlabs.org>
References: <20090603071751.AF006DDDF7@ozlabs.org>
Date: Tue, 08 Dec 2009 09:53:58 +0100
Message-Id: <20091208085358.6DC3219F3F@gemini.denx.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Dear Benjamin Herrenschmidt,

In message <20090603071751.AF006DDDF7@ozlabs.org> you wrote:
> Currently, load_up_altivec and give_up_altivec are duplicated
> in 32-bit and 64-bit. This creates a common implementation that
> is moved away from head_32.S, head_64.S and misc_64.S and into
> vector.S, using the same macros we already use for our common
> implementation of load_up_fpu.
> 
> I also moved the VSX code over to vector.S though in that case
> I didn't make it build on 32-bit (yet).

It seems this commit broke ALTIVEC-enablked 32 bit systems. For
example, when trying to build 86xx/mpc8641_hpcn_defconfig I get:

arch/powerpc/kernel/vector.S: Assembler messages:
arch/powerpc/kernel/vector.S:61: Error: Unrecognized opcode: `cmpdi'
make[1]: *** [arch/powerpc/kernel/vector.o] Error 1

Segher suggests to s/cmpdi/cmplwi/ which indeed seems to work (atleast
it allows me to build the kernel image).

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Wherever you go...There you are.                    - Buckaroo Banzai
