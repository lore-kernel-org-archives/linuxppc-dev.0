Return-Path: <prasad@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp08.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id AE23DDDE0F
	for <linuxppc-dev@ozlabs.org>; Fri, 15 May 2009 04:52:40 +1000 (EST)
Received: from d23relay01.au.ibm.com (d23relay01.au.ibm.com [202.81.31.243])
	by e23smtp08.au.ibm.com (8.13.1/8.13.1) with ESMTP id n4EImR1K026340
	for <linuxppc-dev@ozlabs.org>; Fri, 15 May 2009 04:48:27 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay01.au.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n4EIqdTd409628
	for <linuxppc-dev@ozlabs.org>; Fri, 15 May 2009 04:52:39 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n4EIqdna020902
	for <linuxppc-dev@ozlabs.org>; Fri, 15 May 2009 04:52:39 +1000
Date: Fri, 15 May 2009 00:22:34 +0530
From: "K.Prasad" <prasad@linux.vnet.ibm.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org,
	Benjamin Herrenschmidt <benh@au1.ibm.com>, paulus@samba.org
Subject: Re: [RFC] Hardware Breakpoint interfaces implementation for PPC64
Message-ID: <20090514185234.GB30963@in.ibm.com>
References: <20090511200355.GA17988@in.ibm.com>
	<20090512115149.GA1885@yoda.jdub.homelinux.org>
	<20090512202545.GE6033@in.ibm.com>
	<20090513025717.GN24338@yookeroo.seuss>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090513025717.GN24338@yookeroo.seuss>
Reply-To: prasad@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, May 13, 2009 at 12:57:17PM +1000, David Gibson wrote:
> On Wed, May 13, 2009 at 01:55:45AM +0530, K.Prasad wrote:
> > On Tue, May 12, 2009 at 07:51:49AM -0400, Josh Boyer wrote:
> > > On Tue, May 12, 2009 at 01:33:55AM +0530, K.Prasad wrote:
> [snip]
> 
> It seems to me that a kind of minimal requirement for a sensible
> generic debug interface is that if no processes actually ask to use
> the debug regs, then we should never touch them in the hardware.  This
> means that debugging hacks in the kernel can just use the debug regs
> directly and don't have to go through the interface to avoid having
> their stuff clobbered on context switch.
> 

All that we do additionally for kernel users (when no process is
currently using the debug regs) is to account for the usage just so that
any new requests (kernel or user-space) are denied.

> -- 
> David Gibson			| I'll have my music baroque, and my code
> david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
> 				| _way_ _around_!
> http://www.ozlabs.org/~dgibson

Thanks,
K.Prasad
