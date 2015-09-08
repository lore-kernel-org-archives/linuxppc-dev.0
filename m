Return-Path: <tim.gardner@canonical.com>
Received: from mail.tpi.com (mail.tpi.com [74.45.170.26])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 604D11A25EC
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Sep 2015 09:39:20 +1000 (AEST)
Subject: Re: [PATCH] powerpc: define empty enable_kernel_vsx() when
 CONFIG_VSX=n
To: Paul Mackerras <paulus@ozlabs.org>
References: <1441735991-29199-1-git-send-email-tim.gardner@canonical.com>
 <20150908224735.GA12791@fergus.ozlabs.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Leonidas Da Silva Barbosa <leosilva@linux.vnet.ibm.com>,
 Herbert Xu <herbert@gondor.apana.org.au>
From: Tim Gardner <tim.gardner@canonical.com>
Message-ID: <55EF6D17.6050809@canonical.com>
Date: Tue, 8 Sep 2015 17:19:51 -0600
MIME-Version: 1.0
In-Reply-To: <20150908224735.GA12791@fergus.ozlabs.ibm.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/08/2015 04:47 PM, Paul Mackerras wrote:
> On Tue, Sep 08, 2015 at 12:13:11PM -0600, tim.gardner@canonical.com wrote:
>> From: Tim Gardner <tim.gardner@canonical.com>
>>
>> commit 72cd7b44bc99 ("powerpc: Uncomment and make enable_kernel_vsx()
>> routine available") neglected to define an empty inline replacement for
>> enable_kernel_vsx() when CONFIG_VSX=n.
> 
> If code that wants to call enable_kernel_vsx() is getting compiled in
> when CONFIG_VSX=n, that's a worry.  Is this patch motivated by an
> actual compile failure?  If so what was the failure?
> 
> Paul.
> 

I was having link failures after backporting 'crypto: nx' patches to a
4.2 based kernel. You may have a point in that the upstream Kconfig will
not allow those files to be compiled if CONFIG_VSX=n. I will check in my
morning if to see if I can reproduce the same link error in mainline.

rtg
-- 
Tim Gardner tim.gardner@canonical.com
