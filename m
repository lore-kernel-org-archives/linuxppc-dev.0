Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 303821007D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  3 Dec 2010 17:00:11 +1100 (EST)
Subject: Re: linux-next: build failure after merge of the final tree
	(powerpc tree related)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <20101203163206.72258fb8.sfr@canb.auug.org.au>
References: <20101203163206.72258fb8.sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 03 Dec 2010 16:59:58 +1100
Message-ID: <1291355998.32570.417.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, linux-next@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org,
	Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2010-12-03 at 16:32 +1100, Stephen Rothwell wrote:
> 
> After merging the  tree, today's linux-next build (powerpc allmodconfig)
> failed like this:
> 
> arch/powerpc/lib/hweight_64.S: Assembler messages:
> arch/powerpc/lib/hweight_64.S:52: Error: Unrecognized opcode: `popcntw'
> arch/powerpc/lib/hweight_64.S:77: Error: Unrecognized opcode: `popcntw'
> arch/powerpc/lib/hweight_64.S:106: Error: Unrecognized opcode: `popcntd'
> 
> This is with:
> 
> powerpc64-linux-gcc (GCC) 4.4.0
> GNU assembler (GNU Binutils) 2.19.1
> 
> Caused by commit 64ff31287693c1f325cb9cb049569c1611438ef1 ("powerpc: Add
> support for popcnt instructions"). 


This toolchain is a bit ancient I suppose... Anton, do you reckon we
should use .long based macros for these for the time being or just
require a newer binutils ?

Cheers,
Ben.
