Return-Path: <robherring2@gmail.com>
Received: from mail-oa0-x236.google.com (mail-oa0-x236.google.com
 [IPv6:2607:f8b0:4003:c02::236])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 452FA2C00E4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Oct 2013 10:30:37 +1100 (EST)
Received: by mail-oa0-f54.google.com with SMTP id o20so4442019oag.13
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Oct 2013 16:30:34 -0700 (PDT)
Message-ID: <526EF397.4080802@gmail.com>
Date: Mon, 28 Oct 2013 18:30:31 -0500
From: Rob Herring <robherring2@gmail.com>
MIME-Version: 1.0
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: linux-next: build failure after merge of the dt-rh tree
References: <20131028193814.6d9416904eb8fac2f441c8af@canb.auug.org.au>
In-Reply-To: <20131028193814.6d9416904eb8fac2f441c8af@canb.auug.org.au>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-kernel@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>,
 linux-next@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/28/2013 03:38 AM, Stephen Rothwell wrote:
> Hi Rob,
> 
> After merging the dt-rh tree, today's linux-next build (powerpc 
> ppc64_defconfig) failed like this:
> 
> arch/powerpc/platforms/powernv/rng.c: In function
> 'rng_init_per_cpu': arch/powerpc/platforms/powernv/rng.c:64:2:
> error: implicit declaration of function 'of_get_ibm_chip_id'
> [-Werror=implicit-function-declaration] chip_id =
> of_get_ibm_chip_id(dn); ^ arch/powerpc/platforms/powernv/rng.c: In
> function 'rng_create': arch/powerpc/platforms/powernv/rng.c:85:2:
> error: implicit declaration of function 'of_iomap'
> [-Werror=implicit-function-declaration] rng->regs= of_iomap(dn, 0);
>   ^
> arch/powerpc/platforms/powernv/rng.c:85:12: error: assignment makes pointer from integer without a cast [-Werror]
>   rng->regs = of_iomap(dn, 0);
>             ^
> 
> Caused by commit a4da0d50b2a0 ("powerpc: Implement
> arch_get_random_long/int() for powernv") from the powerpc tree
> interacting with commit b5b4bb3f6a11 ("of: only include prom.h on sparc")
> from the dt-rh tree.
> 
> I added this merge fix patch (which will need to be sent to Linus when
> these two trees get merged, or could be applied now to the powerpc tree):

Applying to the powerpc tree now seems like the better path.

> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Mon, 28 Oct 2013 19:34:41 +1100
> Subject: [PATCH] powerpc: add include of prom.h to fix powernv/rng.c build
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

Acked-by: Rob Herring <rob.herring@calxeda.com>

Rob
