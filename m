Return-Path: <groug@kaod.org>
Received: from 6.mo177.mail-out.ovh.net (6.mo177.mail-out.ovh.net
 [46.105.51.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yCXpm58vrzDr4T
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Oct 2017 01:11:58 +1100 (AEDT)
Received: from player688.ha.ovh.net (b6.ovh.net [213.186.33.56])
 by mo177.mail-out.ovh.net (Postfix) with ESMTP id 0E3FF7C6B5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Oct 2017 14:52:11 +0200 (CEST)
Date: Thu, 12 Oct 2017 14:51:57 +0200
From: Greg Kurz <groug@kaod.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: kvm@vger.kernel.org, kvm-ppc@vger.kernel.org, Paul Mackerras
 <paulus@samba.org>, stable@vger.kernel.org, Paolo Bonzini
 <pbonzini@redhat.com>, linuxppc-dev@lists.ozlabs.org, Sam Bobroff
 <sam.bobroff@au1.ibm.com>, David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH] KVM: PPC: fix oops when checking KVM_CAP_PPC_HTM
Message-ID: <20171012145157.1879b34f@bahia>
In-Reply-To: <87wp40txl1.fsf@concordia.ellerman.id.au>
References: <150542618501.6859.11512107352972110416.stgit@bahia.lan>
 <87wp40txl1.fsf@concordia.ellerman.id.au>
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

On Thu, 12 Oct 2017 22:27:54 +1100
Michael Ellerman <mpe@ellerman.id.au> wrote:

> Greg Kurz <groug@kaod.org> writes:
> > The following program causes a kernel oops:
> >
> > #include <sys/types.h>
> > #include <sys/stat.h>
> > #include <fcntl.h>
> > #include <sys/ioctl.h>
> > #include <linux/kvm.h>
> >
> > main()
> > {
> >     int fd = open("/dev/kvm", O_RDWR);
> >     ioctl(fd, KVM_CHECK_EXTENSION, KVM_CAP_PPC_HTM);
> > }
> >
> > This happens because when using the global KVM fd with
> > KVM_CHECK_EXTENSION, kvm_vm_ioctl_check_extension() gets
> > called with a NULL kvm argument, which gets dereferenced
> > in is_kvmppc_hv_enabled(). Spotted while reading the code.
> >
> > Let's use the hv_enabled fallback variable, like everywhere
> > else in this function.
> >
> > Fixes: 23528bb21ee2 ("KVM: PPC: Introduce KVM_CAP_PPC_HTM")
> > Cc: stable@vger.kernel.org # v4.7+
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > ---
> >  arch/powerpc/kvm/powerpc.c |    3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
> > index 3480faaf1ef8..ee279c7f4802 100644
> > --- a/arch/powerpc/kvm/powerpc.c
> > +++ b/arch/powerpc/kvm/powerpc.c
> > @@ -644,8 +644,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
> >  		break;
> >  #endif
> >  	case KVM_CAP_PPC_HTM:
> > -		r = cpu_has_feature(CPU_FTR_TM_COMP) &&
> > -		    is_kvmppc_hv_enabled(kvm);
> > +		r = cpu_has_feature(CPU_FTR_TM_COMP) && hv_enabled;
> >  		break;
> >  	default:
> >  		r = 0;  
> 
> Did this go anywhere?
> 
> cheers

I'm afraid not... and I haven't tried to ping Paul yet, since he's
supposed to be on vacation from what I've been told.
