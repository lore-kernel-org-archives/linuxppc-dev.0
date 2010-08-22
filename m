Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id A88DEB70D2
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 22 Aug 2010 16:07:32 +1000 (EST)
Date: Sun, 22 Aug 2010 02:00:49 -0400
From: Sean MacLennan <smaclennan@pikatech.com>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Problems with compiling ldstfp.S
Message-ID: <20100822020049.05e42021@lappy.seanm.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The new file ldstfp.S is getting pulled in on the Warp due to
CONFIG_KPROBES, but does not compile:

  AS      arch/powerpc/lib/ldstfp.o
arch/powerpc/lib/ldstfp.S: Assembler messages:
arch/powerpc/lib/ldstfp.S:84: Error: Unrecognized opcode: `mtmsrd'
arch/powerpc/lib/ldstfp.S:96: Error: Unrecognized opcode: `mtmsrd'
arch/powerpc/lib/ldstfp.S:111: Error: Unrecognized opcode: `mtmsrd'
arch/powerpc/lib/ldstfp.S:123: Error: Unrecognized opcode: `mtmsrd'
arch/powerpc/lib/ldstfp.S:138: Error: Unrecognized opcode: `mtmsrd'
arch/powerpc/lib/ldstfp.S:150: Error: Unrecognized opcode: `mtmsrd'
arch/powerpc/lib/ldstfp.S:165: Error: Unrecognized opcode: `mtmsrd'
arch/powerpc/lib/ldstfp.S:177: Error: Unrecognized opcode: `mtmsrd'
make[1]: *** [arch/powerpc/lib/ldstfp.o] Error 1

The Warp has a 440EP processor which does have floating point. But it
looks like mtmsrd is only defined for PPC64.

I would hate to lose KPROBES, it has been a huge help.

Cheers,
   Sean
