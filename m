Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 518E11007D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  3 Dec 2010 22:27:15 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e35.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id oB3BEprt030981
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 3 Dec 2010 04:14:51 -0700
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	oB3BR1Yg237508
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 3 Dec 2010 04:27:01 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id oB3BR0Rx017599
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 3 Dec 2010 04:27:00 -0700
Date: Fri, 3 Dec 2010 06:26:12 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: linux-next: build failure after merge of the final tree
	(powerpc tree related)
Message-ID: <20101203112612.GA4489@zod.rchland.ibm.com>
References: <20101203163206.72258fb8.sfr@canb.auug.org.au>
	<1291355998.32570.417.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1291355998.32570.417.camel@pasglop>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-kernel@vger.kernel.org,
	linux-next@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
	Anton Blanchard <anton@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Dec 03, 2010 at 04:59:58PM +1100, Benjamin Herrenschmidt wrote:
>On Fri, 2010-12-03 at 16:32 +1100, Stephen Rothwell wrote:
>> 
>> After merging the  tree, today's linux-next build (powerpc allmodconfig)
>> failed like this:
>> 
>> arch/powerpc/lib/hweight_64.S: Assembler messages:
>> arch/powerpc/lib/hweight_64.S:52: Error: Unrecognized opcode: `popcntw'
>> arch/powerpc/lib/hweight_64.S:77: Error: Unrecognized opcode: `popcntw'
>> arch/powerpc/lib/hweight_64.S:106: Error: Unrecognized opcode: `popcntd'
>> 
>> This is with:
>> 
>> powerpc64-linux-gcc (GCC) 4.4.0
>> GNU assembler (GNU Binutils) 2.19.1
>> 
>> Caused by commit 64ff31287693c1f325cb9cb049569c1611438ef1 ("powerpc: Add
>> support for popcnt instructions"). 
>
>
>This toolchain is a bit ancient I suppose... Anton, do you reckon we

SLES 11 SP1 still uses gcc 4.3.  4.4.0 is not ancient by any means.  Neither is binutils 2.19.1.

>should use .long based macros for these for the time being or just
>require a newer binutils ?

.long macros sound like the proper solution.

josh
