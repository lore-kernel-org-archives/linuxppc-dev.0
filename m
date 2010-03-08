Return-Path: <dwg@au1.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp02.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id BF691B803A
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Mar 2010 11:46:51 +1100 (EST)
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [202.81.31.247])
	by e23smtp02.au.ibm.com (8.14.3/8.13.1) with ESMTP id o290hcDk028725
	for <linuxppc-dev@ozlabs.org>; Tue, 9 Mar 2010 11:43:38 +1100
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o290f6Q51179718
	for <linuxppc-dev@ozlabs.org>; Tue, 9 Mar 2010 11:41:06 +1100
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o290knMu017285
	for <linuxppc-dev@ozlabs.org>; Tue, 9 Mar 2010 11:46:50 +1100
Date: Tue, 9 Mar 2010 10:57:45 +1100
From: David Gibson <dwg@au1.ibm.com>
To: Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: [Patch 1/1] PPC64-HWBKPT: Implement hw-breakpoints for PPC64
Message-ID: <20100308235745.GE4993@yookeroo>
References: <20100215055605.GB3670@in.ibm.com>
	<20100215055914.GA6017@in.ibm.com> <20100221010130.GA5187@nowhere>
	<20100222131746.GA3228@in.ibm.com> <20100226015807.GF5592@nowhere>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100226015807.GF5592@nowhere>
Cc: Michael Neuling <mikey@neuling.org>,
	Benjamin Herrenschmidt <benh@au1.ibm.com>, shaggy@linux.vnet.ibm.com,
	Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
	Will Deacon <will.deacon@arm.com>, linuxppc-dev@ozlabs.org,
	Alan Stern <stern@rowland.harvard.edu>, paulus@samba.org,
	"K.Prasad" <prasad@linux.vnet.ibm.com>, Roland McGrath <roland@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Feb 26, 2010 at 02:58:12AM +0100, Frederic Weisbecker wrote:
> On Mon, Feb 22, 2010 at 06:47:46PM +0530, K.Prasad wrote:
[snip]
> > > Oh, why does ptrace use a one-shot behaviour in ppc? Breakpoints
> > > only trigger once?
> > > 
> > 
> > Yes, ptrace breakpoints on PPC64 are designed to trigger once and this
> > patch retains that behaviour. It is very convenient to use one-shot
> > behaviour on archs where exceptions are triggered-before-execute.
> 
> Ah, Why?

Because otherwise you have jump through some tricky hoops so that when
gdb (or whatever) resumes after the breakpoint, you don't immediately
retrap in the same place.  I gather x86 has hardware assistance to do
this, but powerpc doesn't.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
