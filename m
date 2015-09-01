Return-Path: <benh@au1.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 71E451A1E09
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Sep 2015 08:26:07 +1000 (AEST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <benh@au1.ibm.com>;
 Wed, 2 Sep 2015 08:26:05 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 189EF2CE802D
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Sep 2015 08:26:03 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t81MPtVW47317210
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Sep 2015 08:26:03 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t81MPUix012472
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Sep 2015 08:25:30 +1000
Message-ID: <1441146305.2668.51.camel@au1.ibm.com>
Subject: Re: [PATCH] KVM: ppc: Fix size of the PSPB register
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
Reply-To: benh@au1.ibm.com
To: Thomas Huth <thuth@redhat.com>, kvm-ppc@vger.kernel.org, Alexander Graf
 <agraf@suse.com>, Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org
Date: Wed, 02 Sep 2015 08:25:05 +1000
In-Reply-To: <1441143678-14295-1-git-send-email-thuth@redhat.com>
References: <1441143678-14295-1-git-send-email-thuth@redhat.com>
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

On Tue, 2015-09-01 at 23:41 +0200, Thomas Huth wrote:
> The size of the Problem State Priority Boost Register is only
> 32 bits, so let's change the type of the corresponding variable
> accordingly to avoid future trouble.

It's not future trouble, it's broken today for LE and this should fix
it BUT ....

The asm accesses it using lwz/stw and C accesses it as a ulong. On LE
that will mean that userspace will see the value << 32

Now "fixing" it might break migration if that field is already
stored/loaded in its "broken" form. We may have to keep the "broken"
behaviour and document that qemu sees a value shifted by 32.

Cheers,
Ben.

> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  arch/powerpc/include/asm/kvm_host.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/include/asm/kvm_host.h
> b/arch/powerpc/include/asm/kvm_host.h
> index d91f65b..c825f3a 100644
> --- a/arch/powerpc/include/asm/kvm_host.h
> +++ b/arch/powerpc/include/asm/kvm_host.h
> @@ -473,7 +473,7 @@ struct kvm_vcpu_arch {
>  	ulong ciabr;
>  	ulong cfar;
>  	ulong ppr;
> -	ulong pspb;
> +	u32 pspb;
>  	ulong fscr;
>  	ulong shadow_fscr;
>  	ulong ebbhr;
