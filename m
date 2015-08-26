Return-Path: <ryabinin.a.a@gmail.com>
Received: from mail-wi0-x236.google.com (mail-wi0-x236.google.com
 [IPv6:2a00:1450:400c:c05::236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1F2031A0179
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Aug 2015 02:37:13 +1000 (AEST)
Received: by wicja10 with SMTP id ja10so20611093wic.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Aug 2015 09:37:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1440577578-15813-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1440577578-15813-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Date: Wed, 26 Aug 2015 19:37:09 +0300
Message-ID: <CAPAsAGyMBnGJyBCoq2n9YSgC73GXr9-w3SjCTVdfz++drzOVGw@mail.gmail.com>
Subject: Re: [PATCH V2 00/10] KASan ppc64 support
From: Andrey Ryabinin <ryabinin.a.a@gmail.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, paulus@samba.org,
 mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

2015-08-26 11:26 GMT+03:00 Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>:
> Hi,
>
> This patchset implements kernel address sanitizer for ppc64.
> Since ppc64 virtual address range is divided into different regions,
> we can't have one contigous area for the kasan shadow range. Hence
> we don't support the INLINE kasan instrumentation. With Outline
> instrumentation, we override the shadow_to_mem and mem_to_shadow
> callbacks, so that we map only the kernel linear range (ie,
> region with ID 0xc). For region with ID 0xd and 0xf (vmalloc
> and vmemmap ) we return the address of the zero page. This
> works because kasan doesn't track both vmemmap and vmalloc address.
>
> Known issues:
> * Kasan is not yet enabled for arch/powerpc/kvm
> * kexec hang
> * outline stack and global support
>

Is there any problem with globals or you just didn't try it yet?
I think it should just work. You need only to add  --param
asan-globals=0 to KBUILD_CFLAGS_MODULE
to disable it for modules.
