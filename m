Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 51562B70A3
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  7 Feb 2011 14:11:03 +1100 (EST)
Subject: Re: [PATCH] powerpc: Fix call to flush_ptrace_hw_breakpoint()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: prasad@linux.vnet.ibm.com
In-Reply-To: <20110207025643.GA12223@in.ibm.com>
References: <1297032853.14982.3.camel@pasglop>
	<20110207025643.GA12223@in.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 07 Feb 2011 14:10:39 +1100
Message-ID: <1297048239.14982.29.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	David Kleikamp <shaggy@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2011-02-07 at 08:26 +0530, K.Prasad wrote:
> On Mon, Feb 07, 2011 at 09:54:13AM +1100, Benjamin Herrenschmidt wrote:
> > A typo in the #ifdef statement makes us never call it
> > in flush_thread()
> >
> 
> I wish it never compiled for such typos :-)
> 
>  
> > Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Acked-by: K.Prasad <prasad@linux.vnet.ibm.com>

Interestingly, that 'fix' now breaks the build:

cc1: warnings being treated as errors
/home/benh/linux-powerpc-test/arch/powerpc/kernel/process.c:356: error:
'set_debug_reg_defaults' defined but not used 

This file is is becoming an absolute mess of ifdef's in large part due
to the new BookE debug stuff and your HW breakpoint stuff... Any chance
you and Shaggy see if you can improve that situation a bit ?

Cheers,
Ben.
