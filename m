Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40lyf84m7QzF1x4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 May 2018 12:13:36 +1000 (AEST)
Received: by mail-pg0-x241.google.com with SMTP id l2-v6so873158pgc.7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 May 2018 19:13:36 -0700 (PDT)
Date: Wed, 16 May 2018 10:13:31 +0800
From: Simon Guo <wei.guo.simon@gmail.com>
To: Paul Mackerras <paulus@ozlabs.org>
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
Subject: Re: [PATCH v2 29/30] KVM: PPC: add KVM_SET_ONE_REG/KVM_GET_ONE_REG
 to async ioctl
Message-ID: <20180516021331.GB12896@simonLocalRHEL7.x64>
References: <1519753958-11756-1-git-send-email-wei.guo.simon@gmail.com>
 <1519753958-11756-19-git-send-email-wei.guo.simon@gmail.com>
 <20180515061526.GE28451@fergus.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180515061526.GE28451@fergus.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Paul,
On Tue, May 15, 2018 at 04:15:26PM +1000, Paul Mackerras wrote:
> On Wed, Feb 28, 2018 at 01:52:37AM +0800, wei.guo.simon@gmail.com wrote:
> > From: Simon Guo <wei.guo.simon@gmail.com>
> > 
> > In both HV/PR KVM, the KVM_SET_ONE_REG/KVM_GET_ONE_REG ioctl should
> > be able to perform without load vcpu. This patch adds
> > KVM_SET_ONE_REG/KVM_GET_ONE_REG implementation to async ioctl
> > function.
> > 
> > Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>
> > ---
> >  arch/powerpc/kvm/powerpc.c | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> > 
> > diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
> > index 7987fa3..6afd004 100644
> > --- a/arch/powerpc/kvm/powerpc.c
> > +++ b/arch/powerpc/kvm/powerpc.c
> > @@ -1619,6 +1619,19 @@ long kvm_arch_vcpu_async_ioctl(struct file *filp,
> >  			return -EFAULT;
> >  		return kvm_vcpu_ioctl_interrupt(vcpu, &irq);
> >  	}
> > +
> > +	if ((ioctl == KVM_SET_ONE_REG) || (ioctl == KVM_GET_ONE_REG)) {
> > +		struct kvm_one_reg reg;
> > +
> > +		if (copy_from_user(&reg, argp, sizeof(reg)))
> > +			return -EFAULT;
> > +
> > +		if (ioctl == KVM_SET_ONE_REG)
> > +			return kvm_vcpu_ioctl_set_one_reg(vcpu, &reg);
> > +		else
> > +			return kvm_vcpu_ioctl_get_one_reg(vcpu, &reg);
> > +	}
> > +
> >  	return -ENOIOCTLCMD;
> >  }
> 
> This seems dangerous to me, since now we can have set/get one_reg
> running in parallel with vcpu execution.  Is there a really compelling
> reason to do this?  If not I'd rather not make this change.

I will remove this patch.
Thanks,
- Simon
