Return-Path: <prasad@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp03.au.ibm.com",
	Issuer "GeoTrust SSL CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D5FD71007D1
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Nov 2010 18:22:43 +1100 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.31.245])
	by e23smtp03.au.ibm.com (8.14.4/8.13.1) with ESMTP id oAT7IRwR006381
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Nov 2010 18:18:27 +1100
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	oAT7Mdn61667326
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Nov 2010 18:22:39 +1100
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	oAT7McZ8000968
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Nov 2010 18:22:39 +1100
Date: Mon, 29 Nov 2010 12:52:33 +0530
From: "K.Prasad" <prasad@linux.vnet.ibm.com>
To: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: ppc_set_hwdebug vs ptrace_set_debugreg
Message-ID: <20101129072233.GA15560@in.ibm.com>
References: <m2lj4ezhhd.fsf@igel.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <m2lj4ezhhd.fsf@igel.home>
Cc: linuxppc-dev@ozlabs.org, Dave Kleikamp <shaggy@linux.vnet.ibm.com>
Reply-To: prasad@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Nov 27, 2010 at 08:36:30PM +0100, Andreas Schwab wrote:
> Why does ptrace_set_debugreg call register_user_hw_breakpoint, but
> ppc_set_hwdebug doesn't?  Shouldn't ppc_set_hwdebug set the
> DABR_DATA_(READ|WRITE|TRANSLATION) bits in the dabr?
> 
> Andreas.

The hw-breakpoint interfaces were initially planned for the old ptrace
option PTRACE_SET_DEBUGREG,while, the newer ptrace options are mostly
to exploit the advanced debug features of Book3E processors.

Although ppc_set_hwdebug() can set DABR through set_dabr() in
arch/powerpc/kernel/process.c, it is good to have it converted to use
register_user_hw_breakpoint(). This was planned to be done alongside the
conversion of all ptrace options enabled by CONFIG_PPC_ADV_DEBUG_REGS,
which is yet to be done.

Are you looking to use debug registers through perf, or somesuch, that
you need register_user_hw_breakpoint() to be used for these new ptrace
flags?

Thanks,
K.Prasad
