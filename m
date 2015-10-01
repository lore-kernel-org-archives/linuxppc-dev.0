Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DA1A91A010A
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Oct 2015 17:05:50 +1000 (AEST)
Message-ID: <1443683150.16900.1.camel@ellerman.id.au>
Subject: Re: [RFC PATCH 1/2] scripts/kconfig/Makefile: Allow
 KBUILD_DEFCONFIG to be a target
From: Michael Ellerman <mpe@ellerman.id.au>
To: Michal Marek <mmarek@suse.com>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
 linux-kbuild@vger.kernel.org, yann.morin.1998@free.fr
Date: Thu, 01 Oct 2015 17:05:50 +1000
In-Reply-To: <560CD7A6.2040905@suse.com>
References: <1442986835-13985-1-git-send-email-mpe@ellerman.id.au>
 <560275FC.60104@suse.com>
 <FE248B88-D584-4E66-A59F-B2A2C254000C@ellerman.id.au>
 <5605B2AE.1080409@suse.com> <1443680055.16900.0.camel@ellerman.id.au>
 <560CD7A6.2040905@suse.com>
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

On Thu, 2015-10-01 at 08:50 +0200, Michal Marek wrote:
> On 2015-10-01 08:14, Michael Ellerman wrote:
> > On Fri, 2015-09-25 at 22:46 +0200, Michal Marek wrote:
> >> Dne 24.9.2015 v 00:16 Michael Ellerman napsal(a):
> >>> On 23 September 2015 19:50:52 GMT+10:00, Michal Marek
> >>> <mmarek@suse.com> wrote:
> >>>> On 2015-09-23 07:40, Michael Ellerman wrote:
> >>>>> +else ifneq ($(wildcard
> >>>> arch/$(SRCARCH)/configs/$(KBUILD_DEFCONFIG)),)
> >>>>> @$(kecho) "*** Default configuration is based on
> >>>> '$(KBUILD_DEFCONFIG)'"
> >>>>> $(Q)$< $(silent)
> >>>> --defconfig=arch/$(SRCARCH)/configs/$(KBUILD_DEFCONFIG) $(Kconfig)
> >>>>> +else +	@$(kecho) "*** Default configuration is based on target
> >>>> '$(KBUILD_DEFCONFIG)'"
> >>>>> +	$(Q)$(MAKE) -f $(srctree)/Makefile $(KBUILD_DEFCONFIG) endif
> >>>>
> >>>> What is the anticipated usage of this? The patch is not needed to
> >>>> make
> >>>>
> >>>> make ppc64le_defconfig
> >>>>
> >>>> work with the second patch. If it was, this would create a loop
> >>>> anyway.
> >>>
> >>> The idea is to make 'make defconfig' work when KBUILD_DEFCONFIG is
> >>> ppc64le_defconfig (which happens for us when uname returns ppc64le)
> >>> and additionally when ppc64le_defconfig is not a real file.
> >>
> >> Ah, that makes sense. You can add
> >>
> >> Acked-by: Michal Marek <mmarek@suse.com>
> >>
> >> if you want.
> > 
> > Thanks. I'll assume by that you mean you're happy if I take both patches
> > through the powerpc tree.
> 
> Yes, I assumed that this was your plan.

I didn't really have a plan :)

It's certainly easiest if I take it in my tree along with the new
ppc64le_defconfig, so I'll do that. Thanks.

cheers
