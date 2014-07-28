Return-Path: <stewart@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8B3AB1A0044
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Jul 2014 08:59:26 +1000 (EST)
Received: from /spool/local
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Mon, 28 Jul 2014 16:59:24 -0600
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 0C5AA19D803D
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Jul 2014 16:59:11 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp08027.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6SMw5iK63570124
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Jul 2014 00:58:05 +0200
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6SMxKLs012280
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Jul 2014 16:59:21 -0600
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: Alexander Graf <agraf@suse.de>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org
Subject: Re: [PATCH 1/4] KVM: PPC: BOOK3S: PR: Emulate virtual timebase
 register
In-Reply-To: <53D64F4C.80208@suse.de>
References: <1401970085-14493-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1401970085-14493-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <53919B83.4070308@suse.de> <874mzyxati.fsf@linux.vnet.ibm.com>
 <53D64F4C.80208@suse.de>
Date: Tue, 29 Jul 2014 08:59:16 +1000
Message-ID: <m3y4vdqed7.fsf@oc8180480414.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org, kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Alexander Graf <agraf@suse.de> writes:
> --- a/arch/powerpc/include/asm/reg.h
> +++ b/arch/powerpc/include/asm/reg.h
> @@ -25,7 +25,6 @@
>   #ifdef CONFIG_8xx
>   #include <asm/reg_8xx.h>
>   #endif /* CONFIG_8xx */
> -#include <asm/bug.h>
>
>   #define MSR_SF_LG      63              /* Enable 64 bit mode */
>   #define MSR_ISF_LG     61              /* Interrupt 64b mode valid on 
> 630 */
> @@ -1210,12 +1209,6 @@ static inline unsigned long mfvtb (void)
>          if (cpu_has_feature(CPU_FTR_ARCH_207S))
>                  return mfspr(SPRN_VTB);
>   #endif
> -       /*
> -        * The above mfspr will be a no-op on anything before Power8
> -        * That can result in random values returned. We need to
> -        * capture that.
> -        */
> -       BUG();
>          return 0;
>   }

(i missed CCing aneesh on this mail in reply to the build robot, so
inserting the same reply here)

  the only place that calls it also does the cpu_has_feature() check and
  returns 0 ifndef CONFIG_PPC_BOOK3S_64 or !cpu_has_feature().

  Looking get_vtb (the only caller) and the places it's called (as well as
  PowerISA 2.07) I think in the emulation code we're missing invoking the
  "system privileged instruction error handler" as the VTB SPR has spr bit
  0 set to 1 (page 107 of PowerISA 2.07, mfspr docs).

  That being said... any guest sholud do the cpu_has_feature check
  themselves, so this probably isn't an issue in the real world.

  Certainly the host really shouldn't BUG() for what is really a guest
  issue (actually.. this would be a good DoS attack on < Power8 host).

  Reviewed-by: Stewart Smith <stewart@linux.vnet.ibm.com>
