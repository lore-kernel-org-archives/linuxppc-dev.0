Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E6CC21A0244
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Mar 2015 17:15:32 +1100 (AEDT)
Message-ID: <1425363332.20929.1.camel@ellerman.id.au>
Subject: Re: [PATCH 1/3] powerpc/pseries: Simplify check for suspendability
 during suspend/migration
From: Michael Ellerman <mpe@ellerman.id.au>
To: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Date: Tue, 03 Mar 2015 17:15:32 +1100
In-Reply-To: <54F4D65B.5080603@linux.vnet.ibm.com>
References: <1425090283-27694-1-git-send-email-tyreld@linux.vnet.ibm.com>
 <1425090283-27694-2-git-send-email-tyreld@linux.vnet.ibm.com>
 <1425269985.2919.29.camel@cyril> <54F4D65B.5080603@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Cyril Bur <cyrilbur@gmail.com>,
 nfont@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-03-02 at 13:30 -0800, Tyrel Datwyler wrote:
> On 03/01/2015 08:19 PM, Cyril Bur wrote:
> > On Fri, 2015-02-27 at 18:24 -0800, Tyrel Datwyler wrote:
> >> During suspend/migration operation we must wait for the VASI state reported
> >> by the hypervisor to become Suspending prior to making the ibm,suspend-me
> >> RTAS call. Calling routines to rtas_ibm_supend_me() pass a vasi_state variable
> >> that exposes the VASI state to the caller. This is unnecessary as the caller
> >> only really cares about the following three conditions; if there is an error
> >> we should bailout, success indicating we have suspended and woken back up so
> >> proceed to device tree updated, or we are not suspendable yet so try calling
> >> rtas_ibm_suspend_me again shortly.
> >>
> >> This patch removes the extraneous vasi_state variable and simply uses the
> >> return code to communicate how to proceed. We either succeed, fail, or get
> >> -EAGAIN in which case we sleep for a second before trying to call
> >> rtas_ibm_suspend_me again.
> >>
> >>  		u64 handle = ((u64)be32_to_cpu(args.args[0]) << 32)
> >>  		              | be32_to_cpu(args.args[1]);
> >> -		rc = rtas_ibm_suspend_me(handle, &vasi_rc);
> >> -		args.rets[0] = cpu_to_be32(vasi_rc);
> >> -		if (rc)
> >> +		rc = rtas_ibm_suspend_me(handle);
> >> +		if (rc == -EAGAIN)
> >> +			args.rets[0] = cpu_to_be32(RTAS_NOT_SUSPENDABLE);
> > 
> > (continuing on...) so perhaps here have
> > 	rc = 0;
> > else if (rc == -EIO)
> > 	args.rets[0] = cpu_to_be32(-1);
> > 	rc = 0;
> > Which should keep the original behaviour, the last thing we want to do
> > is break BE.
> 
> The biggest problem here is we are making what basically equates to a
> fake rtas call from drmgr which we intercept in ppc_rtas(). From there
> we make this special call to rtas_ibm_suspend_me() to check VASI state
> and do a bunch of other specialized work that needs to be setup prior to
> making the actual ibm,suspend-me rtas call. Since, we are cheating PAPR
> here I guess we can really handle it however we want. I chose to simply
> fail the rtas call in the case where rtas_ibm_suspend_me() fails with
> something other than -EAGAIN. In user space librtas will log errno for
> the failure and return RTAS_IO_ASSERT to drmgr which in turn will log
> that error and fail.

We don't want to change the return values of the syscall unless we absolutely
have to. And I don't think that's the case here.

Sure we think drmgr is the only thing that uses this crap, but we don't know
for sure.

cheers
