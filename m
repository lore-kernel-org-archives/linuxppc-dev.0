Return-Path: <dwg@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 5AE79B6EDE
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  5 Aug 2009 12:46:39 +1000 (EST)
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp04.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C9C4FDDD0C
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Aug 2009 12:46:37 +1000 (EST)
Received: from d23relay02.au.ibm.com (d23relay02.au.ibm.com [202.81.31.244])
	by e23smtp04.au.ibm.com (8.14.3/8.13.1) with ESMTP id n752htZ6006555
	for <linuxppc-dev@ozlabs.org>; Wed, 5 Aug 2009 12:43:55 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay02.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n752kX6e1323198
	for <linuxppc-dev@ozlabs.org>; Wed, 5 Aug 2009 12:46:33 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n752kWLK020968
	for <linuxppc-dev@ozlabs.org>; Wed, 5 Aug 2009 12:46:33 +1000
Date: Wed, 5 Aug 2009 12:08:30 +1000
From: David Gibson <dwg@au1.ibm.com>
To: "K.Prasad" <prasad@linux.vnet.ibm.com>
Subject: Re: [Patch 0/6] [Patch 0/6] PPC64-HWBKPT: Hardware Breakpoint
	interfaces - ver VIII
Message-ID: <20090805020830.GB3464@yookeroo.seuss>
References: <20090727001152.GA13562@in.ibm.com>
	<20090731061013.GG3950@yookeroo.seuss>
	<20090803205316.GA3914@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090803205316.GA3914@in.ibm.com>
Cc: Michael Neuling <mikey@neuling.org>,
	Benjamin Herrenschmidt <benh@au1.ibm.com>,
	linuxppc-dev@ozlabs.org, paulus@samba.org,
	Alan Stern <stern@rowland.harvard.edu>, Roland McGrath <roland@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Aug 04, 2009 at 02:23:16AM +0530, K.Prasad wrote:
> On Fri, Jul 31, 2009 at 04:10:13PM +1000, David Gibson wrote:
> > On Mon, Jul 27, 2009 at 05:41:52AM +0530, K.Prasad wrote:
> 
> <edited>
> 
> > > Reasons
> > > --------
> > > - Signal delivery before execution of instruction requires complex workarounds
> > > - One of the plausible workarounds is a two-pass hw-breakpoint handler which
> > >   delivers the signal after the first pass (with the breakpoints enabled).
> > >   In the second pass, it follows the existing semantics of
> > >   disable_hbp-->enable_ss-->single_step-->disable_ss-->enable_hbp.
> > 
> > Yes, that's the only way I can see to do it.
> > 
> > > - Possibility of nested exceptions is a problem here.
> > 
> > Ok, why?
> > 
> 
> Reason as described in the para below.
> 
> > > - Proper identification of a  second-pass of first exception and a new nested
> > >   exception is difficult. Possibility of stray exceptions due to accesses in
> > >   neighbouring memory regions of the breakpoint address further complicates it.
> 
> To elaborate, consider a case where a user-space address 'x' is
> monitored for read or write, and the following happens (assume the
> existence of the two-pass method for signal delivery).
> 
> - Instruction 'i' attempts to read/write in address 'x'
> - hw-bkpt exception generated (pass I)
> - Signal generated and hw-bkpt exception returns to user-space
> - Signal is handled before 'i' is executed. Handler code reads/writes
>   data in 'x' again. Generates nested exception.
> - hw-breakpoint handler code is unable to distinguish if the new
>   exception is from signal handler (nested) or due to second-pass (as
>   per design above).

Ah, ok, I understand now.  Hrm.  I'll have to think about this.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
