Return-Path: <alex.williamson@redhat.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tCV4H4pQnzDt2y
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Nov 2016 11:07:27 +1100 (AEDT)
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3tCV4H1Bctz9t14
 for <linuxppc-dev@ozlabs.org>; Tue,  8 Nov 2016 11:07:26 +1100 (AEDT)
Date: Mon, 7 Nov 2016 17:07:23 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, aik@ozlabs.ru,
 gwshan@linux.vnet.ibm.com
Subject: Re: [PATCH] vfio: Fix build break when SPAPR_TCE_IOMMU=n
Message-ID: <20161107170723.66608632@t450s.home>
In-Reply-To: <87wpgeluk0.fsf@concordia.ellerman.id.au>
References: <1478238521-32203-1-git-send-email-mpe@ellerman.id.au>
 <81900126-f1aa-b480-c2fa-f0fa04d625c1@redhat.com>
 <87zilblmcd.fsf@concordia.ellerman.id.au>
 <20161107092505.429f07d6@t450s.home>
 <87wpgeluk0.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 08 Nov 2016 10:49:35 +1100
Michael Ellerman <mpe@ellerman.id.au> wrote:

> Alex Williamson <alex.williamson@redhat.com> writes:
> > On Mon, 07 Nov 2016 19:34:42 +1100
> > Michael Ellerman <mpe@ellerman.id.au> wrote:  
> >> Paolo Bonzini <pbonzini@redhat.com> writes:  
> >> > On 04/11/2016 06:48, Michael Ellerman wrote:    
> >> >> diff --git a/drivers/vfio/Kconfig b/drivers/vfio/Kconfig
> >> >> index da6e2ce77495..6b51a4ebed8a 100644
> >> >> --- a/drivers/vfio/Kconfig
> >> >> +++ b/drivers/vfio/Kconfig
> >> >> @@ -6,12 +6,12 @@ config VFIO_IOMMU_TYPE1
> >> >>  config VFIO_IOMMU_SPAPR_TCE
> >> >>  	tristate
> >> >>  	depends on VFIO && SPAPR_TCE_IOMMU
> >> >> -	default n
> >> >> +	default VFIO    
> >> >
> >> > No need to depend on VFIO since you already have it in "default".    
> >
> > depends and defaults are different beasts though, if VFIO is not
> > enabled and we're not on a powerpc system with SPAPR,
> > VFIO_IOMMU_SPAPR_TCE should not be selectable, not just default to 'n'.  
> 
> Right. But dropping VFIO from the depends won't change that. In fact it
> has no effect because the entire directory is not built if VFIO=n.
> 
> See drivers/Makefile:
> 
> obj-$(CONFIG_VFIO)		+= vfio/
> 
> 
> So we don't need the depends on VFIO there.
> 
> >> > A shorthand is
> >> >
> >> > 	def_tristate VFIO && SPAPR_TCE_IOMMU    
> >> 
> >> Yep. My experience though is that a lot of folks don't really know what
> >> that means. So I prefer to spell it out with an explicit type, depends
> >> and default.
> >> 
> >> But I'll respin it that way if Alex prefers the shorter style.  
> >
> > Perhaps I'm one of those people.  Non-powerpc archs should not have an
> > option to select this, which is why the depends is there, AIUI.  So
> > long as we don't start exposing options that aren't relevant to a
> > platform, I'm flexible on what shorthands we use, but you may need to
> > teach me about them first.  Thanks,  
> 
> Using the def_tristate trick won't expose the option to users, because
> it has no description it's not user selectable. But it does make the
> symbol exist on an x86 build, and it appears in the .config.
> 
> eg, using def_tristate you get:
> 
> # CONFIG_VFIO_IOMMU_SPAPR_TCE is not set
> # CONFIG_VFIO is not set
> 
> Whereas using depends all you get is:
> 
> # CONFIG_VFIO is not set
> 
> 
> So using def_tristate in this case is not entirely equivalent.

I get a surprising number of users trying to manually hack on
their .config file, so I'd prefer it not appear in the .config unless
CONFIG_VFIO is y/m _and_ the user is actually building to a config
where SPAPR is relevant.  I'm sure it will save me at least a few
questions in the future.  Thanks,

Alex
