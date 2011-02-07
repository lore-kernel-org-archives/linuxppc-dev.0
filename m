Return-Path: <prasad@linux.vnet.ibm.com>
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [122.248.162.4])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp04.in.ibm.com",
	Issuer "GeoTrust SSL CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 52A55B70A9
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  7 Feb 2011 15:52:38 +1100 (EST)
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
	by e28smtp04.in.ibm.com (8.14.4/8.13.1) with ESMTP id p174qXJY026862
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 Feb 2011 10:22:33 +0530
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
	by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p174qX7G3748054
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 Feb 2011 10:22:33 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
	by d28av03.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p174qX48025234
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 Feb 2011 15:52:33 +1100
Date: Mon, 7 Feb 2011 10:22:30 +0530
From: "K.Prasad" <prasad@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Fix call to flush_ptrace_hw_breakpoint()
Message-ID: <20110207045230.GB4287@in.ibm.com>
References: <1297032853.14982.3.camel@pasglop>
	<20110207025643.GA12223@in.ibm.com>
	<1297048239.14982.29.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1297048239.14982.29.camel@pasglop>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	David Kleikamp <shaggy@us.ibm.com>
Reply-To: prasad@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Feb 07, 2011 at 02:10:39PM +1100, Benjamin Herrenschmidt wrote:
> On Mon, 2011-02-07 at 08:26 +0530, K.Prasad wrote:
> > On Mon, Feb 07, 2011 at 09:54:13AM +1100, Benjamin Herrenschmidt wrote:
> > > A typo in the #ifdef statement makes us never call it
> > > in flush_thread()
> > >
> > 
> > I wish it never compiled for such typos :-)
> > 
> >  
> > > Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > Acked-by: K.Prasad <prasad@linux.vnet.ibm.com>
> 
> Interestingly, that 'fix' now breaks the build:
> 
> cc1: warnings being treated as errors
> /home/benh/linux-powerpc-test/arch/powerpc/kernel/process.c:356: error:
> 'set_debug_reg_defaults' defined but not used 
> 
> This file is is becoming an absolute mess of ifdef's in large part due
> to the new BookE debug stuff and your HW breakpoint stuff... Any chance
> you and Shaggy see if you can improve that situation a bit ?
> 
> Cheers,
> Ben.
> 
> 

Okay! Another wrapper of "#ifndef CONFIG_HAVE_HW_BREAKPOINT" around the
definition of 'set_debug_reg_defaults'.

There's indeed too much sprinkling of #ifdefs in the code, but most of
it would go away when the BookE code also uses the generic hw-breakpoint
interfaces. Given the advanced debug features that BookE supports, it's
unfortunately not that straight-forward (needs additions to generic
hw-breakpoint infrastructure).

Thanks,
K.Prasad
