Return-Path: <tim.gardner@canonical.com>
Received: from mail.tpi.com (mail.tpi.com [74.45.170.26])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EC8F01A2ADA
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Sep 2015 23:31:22 +1000 (AEST)
Subject: Re: [PATCH] powerpc: define empty enable_kernel_vsx() when
 CONFIG_VSX=n
To: Michael Ellerman <mpe@ellerman.id.au>
References: <1441735991-29199-1-git-send-email-tim.gardner@canonical.com>
 <20150908224735.GA12791@fergus.ozlabs.ibm.com>
 <55EF6D17.6050809@canonical.com> <1441764830.7854.4.camel@ellerman.id.au>
Cc: Paul Mackerras <paulus@ozlabs.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Leonidas Da Silva Barbosa <leosilva@linux.vnet.ibm.com>,
 Herbert Xu <herbert@gondor.apana.org.au>
From: Tim Gardner <tim.gardner@canonical.com>
Message-ID: <55F034A6.9010905@canonical.com>
Date: Wed, 9 Sep 2015 07:31:18 -0600
MIME-Version: 1.0
In-Reply-To: <1441764830.7854.4.camel@ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/08/2015 08:13 PM, Michael Ellerman wrote:
> On Tue, 2015-09-08 at 17:19 -0600, Tim Gardner wrote:
>> On 09/08/2015 04:47 PM, Paul Mackerras wrote:
>>> On Tue, Sep 08, 2015 at 12:13:11PM -0600, tim.gardner@canonical.com wrote:
>>>> From: Tim Gardner <tim.gardner@canonical.com>
>>>>
>>>> commit 72cd7b44bc99 ("powerpc: Uncomment and make enable_kernel_vsx()
>>>> routine available") neglected to define an empty inline replacement for
>>>> enable_kernel_vsx() when CONFIG_VSX=n.
>>>
>>> If code that wants to call enable_kernel_vsx() is getting compiled in
>>> when CONFIG_VSX=n, that's a worry.  Is this patch motivated by an
>>> actual compile failure?  If so what was the failure?
>>
>> I was having link failures after backporting 'crypto: nx' patches to a
>> 4.2 based kernel. You may have a point in that the upstream Kconfig will
>> not allow those files to be compiled if CONFIG_VSX=n. I will check in my
>> morning if to see if I can reproduce the same link error in mainline.
>
> I suspect the problem is the "vmx" crypto actually.
>
> $ git grep enable_kernel_vsx drivers/
> drivers/crypto/vmx/aes.c:       enable_kernel_vsx();
> drivers/crypto/vmx/aes.c:               enable_kernel_vsx();
> drivers/crypto/vmx/aes.c:               enable_kernel_vsx();
> drivers/crypto/vmx/aes_cbc.c:   enable_kernel_vsx();
> drivers/crypto/vmx/aes_cbc.c:           enable_kernel_vsx();
> drivers/crypto/vmx/aes_cbc.c:           enable_kernel_vsx();
> drivers/crypto/vmx/aes_ctr.c:   enable_kernel_vsx();
> drivers/crypto/vmx/aes_ctr.c:   enable_kernel_vsx();
> drivers/crypto/vmx/aes_ctr.c:                   enable_kernel_vsx();
> drivers/crypto/vmx/ghash.c:     enable_kernel_vsx();
> drivers/crypto/vmx/ghash.c:                     enable_kernel_vsx();
> drivers/crypto/vmx/ghash.c:                     enable_kernel_vsx();
> drivers/crypto/vmx/ghash.c:                     enable_kernel_vsx();
>
>
> That appears to all be controlled by CONFIG_CRYPTO_DEV_VMX_ENCRYPT, which
> depends on CONFIG_CRYPTO_DEV_VMX, which depends on PPC64.
>
> So that looks like it will break terribly if VSX is turned off.
>
> We do have an automated test build with VSX turned off, but it doesn't have
> CONFIG_CRYPTO_DEV_VMX enabled :/
>
>
> Having said all that, why are you building a ppc64 kernel with VSX turned off?
>
> cheers
>
>

I'm pretty sure my problem is that I'm building a 32bit powerpc with 
CONFIG_CRYPTO_DEV_VMX_ENCRYPT=y, though it is hard to tell for sure with 
the interleaved build output from 4 parallel builds (powerpc-smp 
powerpc64-smp powerpc-e500mc powerpc64-emb). Your proposed patch 
("[PATCH v2] crypto: vmx - VMX crypto should depend on CONFIG_VSX") 
fixes my problems (and makes more sense then my patch), so I suddenly 
don't care as much.

rtg
-- 
Tim Gardner tim.gardner@canonical.com
