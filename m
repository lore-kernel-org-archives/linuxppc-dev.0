Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8BEAF1A0246
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Dec 2015 13:42:08 +1100 (AEDT)
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 5A1211402ED
 for <linuxppc-dev@ozlabs.org>; Tue, 15 Dec 2015 13:42:08 +1100 (AEDT)
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Tue, 15 Dec 2015 12:42:06 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id CBE9A357804F
 for <linuxppc-dev@ozlabs.org>; Tue, 15 Dec 2015 13:41:53 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tBF2fjL152428850
 for <linuxppc-dev@ozlabs.org>; Tue, 15 Dec 2015 13:41:53 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tBF2fL9Z029587
 for <linuxppc-dev@ozlabs.org>; Tue, 15 Dec 2015 13:41:21 +1100
Subject: Re: [RFC] powerpc: Enable UBSAN support
To: Daniel Axtens <dja@axtens.net>, linuxppc-dev@ozlabs.org
References: <1449708123-7340-1-git-send-email-dja@axtens.net>
Cc: akpm@linux-foundation.org, Andrey Ryabinin <aryabinin@virtuozzo.com>,
 linux-kernel@vger.kernel.org
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Message-ID: <566F7D9A.4050806@au1.ibm.com>
Date: Tue, 15 Dec 2015 13:40:26 +1100
MIME-Version: 1.0
In-Reply-To: <1449708123-7340-1-git-send-email-dja@axtens.net>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/12/15 11:42, Daniel Axtens wrote:
> This hooks up UBSAN support for PowerPC.
>
> So far it's found some interesting cases where we don't properly sanitise
> input to shifts, including one in our futex handling. Nothing critical,
> but interesting and worth fixing.
>
> CC: Andrey Ryabinin <aryabinin@virtuozzo.com>
> ---
>
> This to be applied on top of next with Andrey's patches:
>   1) https://patchwork.kernel.org/patch/7761341/
>   2) https://patchwork.kernel.org/patch/7761351/
>   3) https://patchwork.kernel.org/patch/7761361/
>   4) https://patchwork.kernel.org/patch/7785791/
>
> This is RFC for a couple of reasons:
>
>   - I'd like the original patches to
>     s/ARCH_HAS_UBSAN_SANTIZE_ALL/ARCH_HAS_UBSAN_SAN*I*TIZE_ALL/
>     (I'm about to send an email about that)
>
>   - I've only tested on LE pseries so far - I want to test on powernv,
>     and on BE.
>
> Signed-off-by: Daniel Axtens <dja@axtens.net>

I tested this patch as found in linux-next, along with the SANITIZE_ALL 
typo fix, on a big-endian BML system, with gcc 5.2.1. It successfully 
picked up one of the shift input issues that Daniel found, so therefore...

Tested-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

-- 
Andrew Donnellan              Software Engineer, OzLabs
andrew.donnellan@au1.ibm.com  Australia Development Lab, Canberra
+61 2 6201 8874 (work)        IBM Australia Limited
