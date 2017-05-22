Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wWQsz6tFXzDqLj
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 May 2017 14:39:19 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v4M4d8B2100622
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 May 2017 00:39:11 -0400
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2akmun7d3y-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 May 2017 00:39:11 -0400
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Mon, 22 May 2017 14:39:03 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v4M4cqWq45351166
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 May 2017 14:39:00 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v4M4cRgR006749
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 May 2017 14:38:27 +1000
Subject: Re: [PATCH 2/2] powerpc: Make feature-fixup tests fortify-safe
To: Daniel Axtens <dja@axtens.net>, kernel-hardening@lists.openwall.com,
 linuxppc-dev@lists.ozlabs.org
References: <20170522013233.21780-1-dja@axtens.net>
 <20170522013233.21780-3-dja@axtens.net>
Cc: Daniel Micay <danielmicay@gmail.com>, Kees Cook <keescook@chromium.org>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Mon, 22 May 2017 14:38:03 +1000
MIME-Version: 1.0
In-Reply-To: <20170522013233.21780-3-dja@axtens.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <a523ab3b-95c9-96ba-b3f0-cb374107b06e@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 22/05/17 11:32, Daniel Axtens wrote:
> Testing the fortified string functions[1] would cause a kernel
> panic on boot in test_feature_fixups() due to a buffer overflow
> in memcmp.
>
> This boils down to things like this:
>
>   extern unsigned int ftr_fixup_test1;
>   extern unsigned int ftr_fixup_test1_orig;
>
>   check(memcmp(&ftr_fixup_test1, &ftr_fixup_test1_orig, size) == 0);
>
> We know that these are asm labels so it is safe to read up to
> 'size' bytes at those addresses.
>
> However, because we have passed the address of a single unsigned
> int to memcmp, the compiler believes the underlying object is in
> fact a single unsigned int. So if size > sizeof(unsigned int),
> there will be a panic at runtime.
>
> We can fix this by changing the types: instead of calling the asm
> labels unsigned ints, call them unsigned int[]s. Therefore the
> size isn't incorrectly determined at compile time and we get a
> regular unsafe memcmp and no panic.
>
> [1] http://openwall.com/lists/kernel-hardening/2017/05/09/2
>
> Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Daniel Micay <danielmicay@gmail.com>
> Signed-off-by: Daniel Axtens <dja@axtens.net>

With this patch on top of Kees' fortify branch, my Tuleta boots 
powernv_defconfig baremetal with no obvious regressions.

Tested-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

Patch looks sane enough too.

Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>


-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
