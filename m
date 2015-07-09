Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FF761A0018
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Jul 2015 11:40:21 +1000 (AEST)
Message-ID: <1436406020.18682.1.camel@ellerman.id.au>
Subject: Re: [PATCH V2 2/2] powerpc/kexec: Reset HILE before kexec_sequence
From: Michael Ellerman <mpe@ellerman.id.au>
To: Stewart Smith <stewart@linux.vnet.ibm.com>
Cc: Samuel Mendoza-Jonas <sam.mj@au1.ibm.com>, linuxppc-dev@ozlabs.org
Date: Thu, 09 Jul 2015 11:40:20 +1000
In-Reply-To: <m3fv4z16sj.fsf@oc8180480414.ibm.com>
References: <1436330233-28489-1-git-send-email-sam.mj@au1.ibm.com>
 <1436330233-28489-2-git-send-email-sam.mj@au1.ibm.com>
 <1436333865.17490.4.camel@ellerman.id.au>
 <m3fv4z16sj.fsf@oc8180480414.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-07-08 at 16:51 +1000, Stewart Smith wrote:
> Michael Ellerman <mpe@ellerman.id.au> writes:
> > On Wed, 2015-07-08 at 14:37 +1000, Samuel Mendoza-Jonas wrote:
> >> On powernv secondary cpus are returned to OPAL, and will then enter the
> >> target kernel in big-endian. However if it is set the HILE bit will persist,
> >> causing the first exception in the target kernel to be delivered in
> >> litte-endian regardless of the kernel endianess.
> >> Make sure that the HILE bit is switched off before entering
> >> kexec_sequence.
> >> 
> >> Signed-off-by: Samuel Mendoza-Jonas <sam.mj@au1.ibm.com>
> >> ---
> >>  arch/powerpc/kernel/machine_kexec_64.c | 6 ++++++
> >>  1 file changed, 6 insertions(+)
> >> 
> >> diff --git a/arch/powerpc/kernel/machine_kexec_64.c b/arch/powerpc/kernel/machine_kexec_64.c
> >> index 1a74446..2266135c 100644
> >> --- a/arch/powerpc/kernel/machine_kexec_64.c
> >> +++ b/arch/powerpc/kernel/machine_kexec_64.c
> >> @@ -356,6 +358,10 @@ void default_machine_kexec(struct kimage *image)
> >>  	 * switched to a static version!
> >>  	 */
> >>  
> >> +	/* Reset HILE in case we kexec into an older BE kernel */
> >> +	if (firmware_has_feature(FW_FEATURE_OPALv3))
> >> +		opal_reinit_cpus(OPAL_REINIT_CPUS_HILE_BE);
> >
> > It's not safe to do this here.
> >
> > We are still in virtual mode and have external interrupts enabled, so you could
> > easily take an exception of some kind and then you'd blow up. Mashing the
> > keyboard during kexec might even be enough.
> 
> Hrm... interrupts are disabled in kexec_sequence, should we be doing
> this there instead I wonder? At this point we're pretty much at the
> point of no return, so maybe we just need to disable interrupts first?
> 
> > I think a better API would be that opal_return_cpu() deals with this under the
> > covers. I think we talked about that, so maybe there was some reason that
> > wasn't possible.
> 
> opal_return_cpu() acts on current CPU which if we started flipping HILE
> there we'd hit PowerISA 2.07 Section 2.11:
> "The contents of the HILE bit must be the same for all
> threads under the control of a given instance of the
> hypervisor; otherwise all results are undefined."
> 
> so we'd have to do something kind of funny in opal_return_cpu() to work
> out what's going on. Keeping in mind that opal_return_cpu() is also used
> in the fsp code update path (which I haven't gone and really looked at
> in this context though).
> 
> I'm not convinced that opal_return_cpu() doing the HILE switch is
> safe when we'd be relying on the kernel to pretty much do this all at
> the same time (when we really have opal_reinit_cpus to do that)

Yeah I agree.

What I meant is that after you return a cpu to OPAL, when you (or actually
someone else) restart it, at that point it should be put into a well defined
state, including HILE.

cheers
