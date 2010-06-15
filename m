Return-Path: <prasad@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp05.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 15169B7D9B
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jun 2010 16:07:37 +1000 (EST)
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
	by e28smtp05.in.ibm.com (8.14.4/8.13.1) with ESMTP id o5F67Z8L017719
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jun 2010 11:37:35 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
	by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o5F67Zw74006090
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jun 2010 11:37:35 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
	by d28av01.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o5F67Yfv014699
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jun 2010 11:37:35 +0530
Date: Tue, 15 Jun 2010 11:37:33 +0530
From: "K.Prasad" <prasad@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [Patch 5/5] PPC64-HWBKPT: Discard extraneous interrupt due to
	accesses outside symbol length
Message-ID: <20100615060733.GA2971@in.ibm.com>
References: <20100609101417.644628763@linux.vnet.ibm.com>
	<20100609102559.GF20332@in.ibm.com>
	<20100610124024.GA28613@brick.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100610124024.GA28613@brick.ozlabs.ibm.com>
Cc: Michael Neuling <mikey@neuling.org>,
	Benjamin Herrenschmidt <benh@au1.ibm.com>, shaggy@linux.vnet.ibm.com,
	Frederic Weisbecker <fweisbec@gmail.com>, David Gibson <dwg@au1.ibm.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
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

On Thu, Jun 10, 2010 at 10:40:24PM +1000, Paul Mackerras wrote:
> On Wed, Jun 09, 2010 at 03:55:59PM +0530, K.Prasad wrote:
> 
> > +	if (!((bp->attr.bp_addr <= dar) &&
> > +	     (dar <= (bp->attr.bp_addr + bp->attr.bp_len)))) {
> > +		/*
> > +		 * This exception is triggered not because of a memory access
> > +		 * on the monitored variable but in the double-word address
> > +		 * range in which it is contained. We will consume this
> > +		 * exception, considering it as 'noise'.
> > +		 */
> > +		info->extraneous_interrupt = true;
> > +	}
> 
> Ummm, don't you need to add "else info->extraneous_interrupt = false;"
> here?  I don't see anywhere that you ever clear it otherwise.
> 
> Also, I think you need to do the "if (!info->extraneous_interrupt)"
> check around the call to perf_bp_event() later on in
> hw_breakpoint_handler() as well as around the call in
> single_step_dabr_instruction().
> 
> Paul.

True, I've added the check before perf_bp_event() (wherever it was
missing before) in the patchset ver XXIV.

Thanks,
K.Prasad
