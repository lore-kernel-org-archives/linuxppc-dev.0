Return-Path: <prasad@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp05.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9E223B7DE4
	for <linuxppc-dev@ozlabs.org>; Wed, 12 May 2010 13:34:42 +1000 (EST)
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
	by e28smtp05.in.ibm.com (8.14.3/8.13.1) with ESMTP id o4C3YcHc011382
	for <linuxppc-dev@ozlabs.org>; Wed, 12 May 2010 09:04:38 +0530
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
	by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o4C3YbcS3338494
	for <linuxppc-dev@ozlabs.org>; Wed, 12 May 2010 09:04:37 +0530
Received: from d28av04.in.ibm.com (loopback [127.0.0.1])
	by d28av04.in.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o4C3YbGL008652
	for <linuxppc-dev@ozlabs.org>; Wed, 12 May 2010 13:34:38 +1000
Date: Wed, 12 May 2010 09:04:34 +0530
From: "K.Prasad" <prasad@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [Patch 2/2] PPC64-HWBKPT: Implement hw-breakpoints for PPC64
Message-ID: <20100512033434.GA6319@in.ibm.com>
References: <20100414033555.746326035@pr> <20100414034827.GC6571@in.ibm.com>
	<20100503062330.GB19365@drongo> <20100504203302.GA3894@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100504203302.GA3894@in.ibm.com>
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

On Wed, May 05, 2010 at 02:03:03AM +0530, K.Prasad wrote:
> On Mon, May 03, 2010 at 04:23:30PM +1000, Paul Mackerras wrote:
> > On Wed, Apr 14, 2010 at 09:18:27AM +0530, K.Prasad wrote:
> > 
[snipped]
> 
> It has been pointed out to me before (Roland's mail Ref:linuxppc-dev
> message-id: 20100119100335.3EB621DE@magilla.sf.frob.com) that there will
> be too many corner cases that will be difficult to foresee, however your
> above list appears to be exhaustive. While the alternatives to this being
> a fallback to one-shot breakpoints (thereby leading to confusing
> hw-breakpoint interface semantics), this is an attempt to generate
> continuous and 'trigger-after-execute' (for non-ptrace requests)
> breakpoint exceptions. I believe that, with the addressal of concerns
> cited above, the resultant patchset would be one that achieves the
> stated design goals with no loss to existing functionality.
> 

Hi Paul,

> I intend to send out another version of this patchset with fixes as
> described in my replies above (unless I hear objections to it :-)).
> 

Meanwhile, a little sickness had kept me away from working on this
patchset. I have now posted a new version of the same here () which
contains changes as described above.

A few more changes to the patch is impending post merger
of Frederic's patches (which are now in -tip) into mainline (ref: commit
73266fc1df2f94cf72b3beba3eee3b88ed0b0664 to
777d0411cd1e384115985dac5ccd42031e3eee2b);
mainly due to the new ability for a per-task breakpoint to request
kernel-space breakpoints (the notion of kernel- vs user-bp would also
become obsolete, it is better to call them per-cpu vs per-task
breakpoints).

Also, I find that possibility of a kernel-thread specific breakpoint
(which can migrate across CPUs) has not been thought and implemented well
in this patch (will be much easier after merger of Frederic's patch). I
would prefer to have atleast some version of the patch included in
mainline before bringing in support for the same.

Thanks,
K.Prasad
