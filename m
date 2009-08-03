Return-Path: <prasad@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 38AFBB6F1F
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  4 Aug 2009 06:53:28 +1000 (EST)
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [59.145.155.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp02.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4D199DDDA0
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Aug 2009 06:53:26 +1000 (EST)
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
	by e28smtp02.in.ibm.com (8.14.3/8.13.1) with ESMTP id n73KrJPa031966
	for <linuxppc-dev@ozlabs.org>; Tue, 4 Aug 2009 02:23:19 +0530
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
	by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n73KrJj91269764
	for <linuxppc-dev@ozlabs.org>; Tue, 4 Aug 2009 02:23:19 +0530
Received: from d28av04.in.ibm.com (loopback [127.0.0.1])
	by d28av04.in.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	n73KrJXZ011576
	for <linuxppc-dev@ozlabs.org>; Tue, 4 Aug 2009 06:53:19 +1000
Date: Tue, 4 Aug 2009 02:23:16 +0530
From: "K.Prasad" <prasad@linux.vnet.ibm.com>
To: David Gibson <dwg@au1.ibm.com>
Subject: Re: [Patch 0/6] [Patch 0/6] PPC64-HWBKPT: Hardware Breakpoint
	interfaces - ver VIII
Message-ID: <20090803205316.GA3914@in.ibm.com>
References: <20090727001152.GA13562@in.ibm.com>
	<20090731061013.GG3950@yookeroo.seuss>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090731061013.GG3950@yookeroo.seuss>
Cc: Michael Neuling <mikey@neuling.org>,
	Benjamin Herrenschmidt <benh@au1.ibm.com>,
	linuxppc-dev@ozlabs.org, paulus@samba.org,
	Alan Stern <stern@rowland.harvard.edu>, Roland McGrath <roland@redhat.com>
Reply-To: prasad@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jul 31, 2009 at 04:10:13PM +1000, David Gibson wrote:
> On Mon, Jul 27, 2009 at 05:41:52AM +0530, K.Prasad wrote:

<edited>

> > Reasons
> > --------
> > - Signal delivery before execution of instruction requires complex workarounds
> > - One of the plausible workarounds is a two-pass hw-breakpoint handler which
> >   delivers the signal after the first pass (with the breakpoints enabled).
> >   In the second pass, it follows the existing semantics of
> >   disable_hbp-->enable_ss-->single_step-->disable_ss-->enable_hbp.
> 
> Yes, that's the only way I can see to do it.
> 
> > - Possibility of nested exceptions is a problem here.
> 
> Ok, why?
> 

Reason as described in the para below.

> > - Proper identification of a  second-pass of first exception and a new nested
> >   exception is difficult. Possibility of stray exceptions due to accesses in
> >   neighbouring memory regions of the breakpoint address further complicates it.

To elaborate, consider a case where a user-space address 'x' is
monitored for read or write, and the following happens (assume the
existence of the two-pass method for signal delivery).

- Instruction 'i' attempts to read/write in address 'x'
- hw-bkpt exception generated (pass I)
- Signal generated and hw-bkpt exception returns to user-space
- Signal is handled before 'i' is executed. Handler code reads/writes
  data in 'x' again. Generates nested exception.
- hw-breakpoint handler code is unable to distinguish if the new
  exception is from signal handler (nested) or due to second-pass (as
  per design above).

Thanks,
K.Prasad
