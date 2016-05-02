Return-Path: <haris.phnx@gmail.com>
Received: from mail-yw0-x241.google.com (mail-yw0-x241.google.com
 [IPv6:2607:f8b0:4002:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qyzjJ2XYmzDqCm
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 May 2016 19:37:08 +1000 (AEST)
Received: by mail-yw0-x241.google.com with SMTP id i22so18623227ywc.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 02 May 2016 02:37:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20160430104800.0a7c1d11@kryten>
References: <20160404164457.539a55f0@kryten> <57021123.6050506@ozlabs.ru>
 <20160404204346.1cf44df8@kryten> <20160404210928.0d9ae644@kryten>
 <F99A6122-6B6D-45A3-99E2-2F56F143FB50@suse.de>
 <20160430104800.0a7c1d11@kryten>
From: haris iqbal <haris.phnx@gmail.com>
Date: Mon, 2 May 2016 15:06:46 +0530
Message-ID: <CAE_WKMzvsRzqiEXV4HsmLZ5D7jLtB+tWVo7UzhtJ9_GMC9Yicg@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v2] spapr: Don't set the TM ibm, pa-features
 bit in PR KVM mode
To: Anton Blanchard <anton@samba.org>
Cc: Alexander Graf <agraf@suse.de>, Michael Neuling <mikey@neuling.org>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, Michael Ellerman <mpe@ellerman.id.au>,
 QEMU Developers <qemu-devel@nongnu.org>, Paul Mackerras <paulus@samba.org>,
 qemu-ppc@nongnu.org,
 linuxppc-dev@lists.ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Apr 30, 2016 at 6:18 AM, Anton Blanchard <anton@samba.org> wrote:
> We don't support transactional memory in PR KVM, so don't tell
> the OS that we do.
>
> Signed-off-by: Anton Blanchard <anton@samba.org>
> ---
>
> v2: Fix build with CONFIG_KVM disabled, noticed by Alex.
>
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index b69995e..dc3e3c9 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -696,6 +696,14 @@ static void spapr_populate_cpu_dt(CPUState *cs, void *fdt, int offset,
>      } else /* env->mmu_model == POWERPC_MMU_2_07 */ {
>          pa_features = pa_features_207;
>          pa_size = sizeof(pa_features_207);
> +
> +#ifdef CONFIG_KVM
> +        /* Don't enable TM in PR KVM mode */
> +        if (kvm_enabled() &&
> +            kvm_vm_check_extension(cs->kvm_state, KVM_CAP_PPC_GET_PVINFO)) {
> +            pa_features[24] &= ~0x80;
> +        }
> +#endif
>      }
>      if (env->ci_large_pages) {
>          pa_features[3] |= 0x20;
>

This email was put in the spam folder by gmail. The message said "It
has a from address in samba.org but has failed samba.org's required
tests for authentication". Just bringing this to peoples attention. I
thought a patch might go unnoticed else.

-- 

With regards,

Md Haris Iqbal,
Placement Coordinator, MTech IT
NITK Surathkal,
Contact: +91 8861996962
