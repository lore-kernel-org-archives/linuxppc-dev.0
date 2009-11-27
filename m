Return-Path: <horms@verge.net.au>
Received: from kirsty.vergenet.net (kirsty.vergenet.net [202.4.237.240])
	by ozlabs.org (Postfix) with ESMTP id A555BB7B6C
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Nov 2009 22:52:00 +1100 (EST)
Date: Fri, 27 Nov 2009 22:51:59 +1100
From: Simon Horman <horms@verge.net.au>
To: "M. Mohan Kumar" <mohan@in.ibm.com>
Subject: Re: [PATCH] Reserve memory for kdump kernel within RMO region
Message-ID: <20091127115155.GA19070@verge.net.au>
References: <20091125131747.GA28857@in.ibm.com> <4B0D7CF4.8040402@bwalle.de>
	<4B0E628A.9070009@in.ibm.com> <4B0ED674.6050501@bwalle.de>
	<4B0F8F62.3050000@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4B0F8F62.3050000@in.ibm.com>
Cc: Bernhard Walle <bernhard@bwalle.de>, kexec@lists.infradead.org,
	ppcdev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Nov 27, 2009 at 02:05:46PM +0530, M. Mohan Kumar wrote:
> On 11/27/2009 12:56 AM, Bernhard Walle wrote:
> >M. Mohan Kumar schrieb:
> >>On 11/26/2009 12:22 AM, Bernhard Walle wrote:
> >>>M. Mohan Kumar schrieb:
> >>>>Reserve memory for kdump kernel within RMO region
> >>>>
> >>>>When the kernel size exceeds 32MB(observed with some distros), memory
> >>>>for kdump kernel can not be reserved as kdump kernel base is assumed to
> >>>>be 32MB always. When the kernel has CONFIG_RELOCATABLE option enabled,
> >>>>provide the feature to reserve the memory for kdump kernel anywhere in
> >>>>the RMO region.
> >>
> >>Hi Bernhard,
> >>
> >>>Correct me if I'm wrong, but: CONFIG_RELOCATABLE is for the kernel that
> >>>gets loaded as crashkernel, not for the kernel that loads the
> >>>crashkernel. So it would be perfectly fine that a kernel that has not
> >>>CONFIG_RELOCATABLE set would load another kernel that has
> >>>CONFIG_RELOCATABLE set on an address != 32 M.
> >>
> >>No, with relocatable option, the same kernel is used as both production
> >>and kdump kernel.
> >
> >Can be, but it's not strictly necessary. It depends what userland does.
> >Especially it's possible that a non-relocatable, self-compiled kernel
> >loads a relocatable distribution kernel as capture kernel.
> >
> 
> I don't understand why a non-relocatable kernel will use relocatable
> kernel for capturing kdump kernel. The idea for relocatable kernel
> is to avoid using two different kernels to capture kernel dump.

True, but that doesn't necessarily mean that using a relocatable
kdump kernel is required. Well, hopefully not.

> >Also, it would make sense to make the behaviour symmetric across
> >platforms. Currently we have:
> >
> >  - x86 and ia64: Without offset on command line, use any offset
> >                  With offset on command line, use that offset and fail
> >                  if no memory is available at that offset.
> >  - ppc64: Always use 32M and ignore the offset.
> >
> >If your patch gets applied, we have:
> >
> >  - ppc64: With CONFIG_RELOCATABLE, use any offset
> >           With offset on command
> >
> >I don't see why the behaviour on ppc64 should be completely different.
> >
> >Having maintained kdump for SUSE for x86, ia64 and partly ppc64 in the
> >past, I always felt that ppc64 is more different from x86 than ia64 is
> >from x86. That's one more step into that direction without a technical
> >reason.
> 
> Also with the crashkernel=auto parameter (patches are not yet
> merged), the crashkernel base (offset) by default would be 32MB. In
> this case if a kernel passed with crashkernel=auto and if the first
> kernel size exceeds 32MB, memory for kdump kernel will always fail.
> 
> >
> >Having that all said: If your patch gets in mainline kernel, than we
> >should change the behaviour also for x86 and ia64.
> >
> >
> >
> >Regards,
> >Bernhard
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
