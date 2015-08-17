Return-Path: <ryabinin.a.a@gmail.com>
Received: from mail-vk0-x234.google.com (mail-vk0-x234.google.com
 [IPv6:2607:f8b0:400c:c05::234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 25D6B1A0372
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Aug 2015 22:17:28 +1000 (AEST)
Received: by vkfi73 with SMTP id i73so54077092vkf.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Aug 2015 05:17:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <55D1CFE7.2070801@gmail.com>
References: <1439793400-18147-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1439793400-18147-8-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <55D1CFE7.2070801@gmail.com>
Date: Mon, 17 Aug 2015 15:17:25 +0300
Message-ID: <CAPAsAGxSpA7XYWzL9R=uewwgF7-wN9ihbXQto-csd=RBWbPZqw@mail.gmail.com>
Subject: Re: [RFC PATCH V1 7/8] powerpc/mm: kasan: Add kasan support for ppc64
From: Andrey Ryabinin <ryabinin.a.a@gmail.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, paulus@samba.org,
 mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

2015-08-17 15:13 GMT+03:00 Andrey Ryabinin <ryabinin.a.a@gmail.com>:
>
> Did you disable stack instrumentation (in scripts/Makefile.kasa),
> or you version of gcc doesn't support it (e.g. like 4.9.x on x86) ?
>
> Because this can't work with stack instrumentation as you don't have shadow for stack in early code.
>
> But this should be doable, as I think. All you need is to setup shadow for init task's
> stack before executing any instrumented function.

And you also need to define CONFIG_KASAN_SHADOW_OFFSET, so it will be
passed to GCC
via -fasan-shadow-offset= option.
