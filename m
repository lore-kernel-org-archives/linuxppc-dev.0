Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2298F1A0795
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Sep 2015 10:52:40 +1000 (AEST)
Message-ID: <1441846359.31931.2.camel@ellerman.id.au>
Subject: Re: [PATCH] powerpc: define empty enable_kernel_vsx() when
 CONFIG_VSX=n
From: Michael Ellerman <mpe@ellerman.id.au>
To: Tim Gardner <tim.gardner@canonical.com>
Cc: Paul Mackerras <paulus@ozlabs.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>,  Leonidas Da Silva Barbosa
 <leosilva@linux.vnet.ibm.com>, Herbert Xu <herbert@gondor.apana.org.au>
Date: Thu, 10 Sep 2015 10:52:39 +1000
In-Reply-To: <55F034A6.9010905@canonical.com>
References: <1441735991-29199-1-git-send-email-tim.gardner@canonical.com>
 <20150908224735.GA12791@fergus.ozlabs.ibm.com>
 <55EF6D17.6050809@canonical.com> <1441764830.7854.4.camel@ellerman.id.au>
 <55F034A6.9010905@canonical.com>
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

On Wed, 2015-09-09 at 07:31 -0600, Tim Gardner wrote:
> On 09/08/2015 08:13 PM, Michael Ellerman wrote:
> > On Tue, 2015-09-08 at 17:19 -0600, Tim Gardner wrote:
> >> On 09/08/2015 04:47 PM, Paul Mackerras wrote:
> >>> On Tue, Sep 08, 2015 at 12:13:11PM -0600, tim.gardner@canonical.com wrote:
> >>>> From: Tim Gardner <tim.gardner@canonical.com>
> >>>>
> >>>> commit 72cd7b44bc99 ("powerpc: Uncomment and make enable_kernel_vsx()
> >>>> routine available") neglected to define an empty inline replacement for
> >>>> enable_kernel_vsx() when CONFIG_VSX=n.
> >>>
> >>> If code that wants to call enable_kernel_vsx() is getting compiled in
> >>> when CONFIG_VSX=n, that's a worry.  Is this patch motivated by an
> >>> actual compile failure?  If so what was the failure?
> >>
> >> I was having link failures after backporting 'crypto: nx' patches to a
> >> 4.2 based kernel. You may have a point in that the upstream Kconfig will
> >> not allow those files to be compiled if CONFIG_VSX=n. I will check in my
> >> morning if to see if I can reproduce the same link error in mainline.
> >
> > I suspect the problem is the "vmx" crypto actually.
> >
> > $ git grep enable_kernel_vsx drivers/
> > drivers/crypto/vmx/aes.c:       enable_kernel_vsx();
> > drivers/crypto/vmx/aes.c:               enable_kernel_vsx();
> > drivers/crypto/vmx/aes.c:               enable_kernel_vsx();
> > drivers/crypto/vmx/aes_cbc.c:   enable_kernel_vsx();
> > drivers/crypto/vmx/aes_cbc.c:           enable_kernel_vsx();
> > drivers/crypto/vmx/aes_cbc.c:           enable_kernel_vsx();
> > drivers/crypto/vmx/aes_ctr.c:   enable_kernel_vsx();
> > drivers/crypto/vmx/aes_ctr.c:   enable_kernel_vsx();
> > drivers/crypto/vmx/aes_ctr.c:                   enable_kernel_vsx();
> > drivers/crypto/vmx/ghash.c:     enable_kernel_vsx();
> > drivers/crypto/vmx/ghash.c:                     enable_kernel_vsx();
> > drivers/crypto/vmx/ghash.c:                     enable_kernel_vsx();
> > drivers/crypto/vmx/ghash.c:                     enable_kernel_vsx();
> >
> >
> > That appears to all be controlled by CONFIG_CRYPTO_DEV_VMX_ENCRYPT, which
> > depends on CONFIG_CRYPTO_DEV_VMX, which depends on PPC64.
> >
> > So that looks like it will break terribly if VSX is turned off.
> >
> > We do have an automated test build with VSX turned off, but it doesn't have
> > CONFIG_CRYPTO_DEV_VMX enabled :/
> >
> >
> > Having said all that, why are you building a ppc64 kernel with VSX turned off?
> 
> I'm pretty sure my problem is that I'm building a 32bit powerpc with 
> CONFIG_CRYPTO_DEV_VMX_ENCRYPT=y, though it is hard to tell for sure with 
> the interleaved build output from 4 parallel builds (powerpc-smp 
> powerpc64-smp powerpc-e500mc powerpc64-emb). 

OK. It shouldn't be possible to have CONFIG_CRYPTO_DEV_VMX_ENCRYPT=y for a
32-bit kernel.

I didn't know you guys were building a powerpc64-emb kernel, which by the looks
is ~= CONFIG_PPC_BOOK3E_64.

I'm fairly certain that will be the problem, as it's a 64-bit kernel, but does
not have VSX.

> Your proposed patch ("[PATCH v2] crypto: vmx - VMX crypto should depend on
> CONFIG_VSX") fixes my problems (and makes more sense then my patch), so I
> suddenly don't care as much.

OK great. Sorry for the screw up, I'll try and keep a better eye on what's
going in via the crypto tree in future.

cheers
