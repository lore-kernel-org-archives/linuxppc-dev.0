Return-Path: <bharata.rao@gmail.com>
Received: from mail-vc0-x22c.google.com (mail-vc0-x22c.google.com
 [IPv6:2607:f8b0:400c:c03::22c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D54401A030A
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Mar 2015 14:25:20 +1100 (AEDT)
Received: by mail-vc0-f172.google.com with SMTP id le20so2213027vcb.3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 15 Mar 2015 20:25:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1425879055-20628-1-git-send-email-bharata.rao@gmail.com>
References: <1425879055-20628-1-git-send-email-bharata.rao@gmail.com>
Date: Mon, 16 Mar 2015 08:55:17 +0530
Message-ID: <CAGZKiBpehotoUUtU+vcasXV+ABNGJs9iiBqJiXkMFNpTCoN0Pg@mail.gmail.com>
Subject: Re: [RFC v0 PATCH] kvm: powerpc: Allow reuse of vCPU object
From: Bharata B Rao <bharata.rao@gmail.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 bharata <bharata@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Any feedback on the below patch ?

On Mon, Mar 9, 2015 at 11:00 AM,  <bharata.rao@gmail.com> wrote:
> From: Bharata B Rao <bharata@linux.vnet.ibm.com>
>
> Since KVM isn't equipped to handle closure of vcpu fd from userspace(QEMU)
> correctly, certain work arounds have to be employed to allow reuse of
> vcpu array slot in KVM during cpu hot plug/unplug from guest. One such
> proposed workaround is to park the vcpu fd in userspace during cpu unplug
> and reuse it later during next hotplug.
>
> More details can be found here:
> KVM: https://www.mail-archive.com/kvm@vger.kernel.org/msg102839.html
> QEMU: http://lists.gnu.org/archive/html/qemu-devel/2014-12/msg00859.html
>
> In order to support this workaround with PowerPC KVM, don't create or
> initialize ICP if the vCPU is found to be already associated with an ICP.
>
> Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
> ---
> Note: It is not sure at the moment if "park vcpu and reuse" approach will
> be acceptable to KVM/QEMU community, but nevertheless I wanted to check
> if this little patch is harmful or not.
>
>  arch/powerpc/kvm/book3s_xics.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/kvm/book3s_xics.c b/arch/powerpc/kvm/book3s_xics.c
> index a4a8d9f..ead3a35 100644
> --- a/arch/powerpc/kvm/book3s_xics.c
> +++ b/arch/powerpc/kvm/book3s_xics.c
> @@ -1313,8 +1313,13 @@ int kvmppc_xics_connect_vcpu(struct kvm_device *dev, struct kvm_vcpu *vcpu,
>                 return -EPERM;
>         if (xics->kvm != vcpu->kvm)
>                 return -EPERM;
> -       if (vcpu->arch.irq_type)
> -               return -EBUSY;
> +
> +       /*
> +        * If irq_type is already set, don't reinialize but
> +        * return success allowing this vcpu to be reused.
> +        */
> +       if (vcpu->arch.irq_type != KVMPPC_IRQ_DEFAULT)
> +               return 0;
>
>         r = kvmppc_xics_create_icp(vcpu, xcpu);
>         if (!r)
> --
> 2.1.0
>



-- 
http://raobharata.wordpress.com/
