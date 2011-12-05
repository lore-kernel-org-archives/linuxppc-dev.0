Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [195.58.98.146])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id A2DA31007D4
 for <linuxppc-dev@ozlabs.org>; Mon,  5 Dec 2011 19:50:19 +1100 (EST)
In-Reply-To: <1322198672.32635.24.camel@pasglop>
References: <OFD9ADD493.27DB131E-ONC125794B.002E2035-C125794B.002F715A@transmode.se>	
 <4EC544C6.3050502@us.ibm.com>
 <A8CB2347-27B6-482A-B49B-F434FBFCBC10@freescale.com>	
 <OF8F2311F0.71A00B7A-ONC125794B.007583D0-C125794B.0075E666@transmode.se>
 <20111117232027.GW15738@erda.amd.com>	
 <OFD2223A5C.914A7555-ONC125794C.002D68B7-C125794C.002DFF90@transmode.se>
 <1322198672.32635.24.camel@pasglop>
Subject: Re: oprofile callgraph support missing for common cpus
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <OFE1FEF3EC.6B76BECC-ONC125795D.002F3766-C125795D.00308AEE@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Mon, 5 Dec 2011 09:50:12 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: Robert Richter <robert.richter@amd.com>, linuxppc-dev@ozlabs.org,
 Andy Fleming <afleming@freescale.com>, oprofile-list@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote on 2011/11/25 06:24:32:
>
> On Fri, 2011-11-18 at 09:22 +0100, Joakim Tjernlund wrote:
>
> > I forgot to ask, oprofile mentions setting -no-omit-framepointer to get
> > correct backtrace but I cannot turn on frame pointers for the ppc kernel.
> > Isn't frame pointers needed for pcc? what about user space?
>
> PowerPC always has frame pointers, ignore that :-)

A bit late but consider this:

int leaf(int x)
{
	return x+3;
}

which yields(with gcc -O2 -S):
	.file	"leaf.c"
	.section	".text"
	.align 2
	.globl leaf
	.type	leaf, @function
leaf:
	addi 3,3,3
	blr
	.size	leaf, .-leaf
	.section	.note.GNU-stack,"",@progbits
	.ident	"GCC: (GNU) 3.4.6 (Gentoo 3.4.6-r2, ssp-3.4.6-1.0, pie-8.7.9)"


Here there is with frame pointer(I guess that the messing around with r11 and r31 is a defect?):
(With gcc -O2 -S -fno-omit-frame-pointer)

	.file	"leaf.c"
	.section	".text"
	.align 2
	.globl leaf
	.type	leaf, @function
leaf:
	stwu 1,-16(1)
	addi 3,3,3
	lwz 11,0(1)
	stw 31,12(1)
	mr 31,1
	lwz 31,-4(11)
	mr 1,11
	blr
	.size	leaf, .-leaf
	.section	.note.GNU-stack,"",@progbits
	.ident	"GCC: (GNU) 3.4.6 (Gentoo 3.4.6-r2, ssp-3.4.6-1.0, pie-8.7.9)"
