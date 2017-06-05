Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wh9pl5bgzzDqLH
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Jun 2017 20:21:51 +1000 (AEST)
In-Reply-To: <20170523234559.28080-1-matthew.brown.dev@gmail.com>
To: Matt Brown <matthew.brown.dev@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: anton@samba.org
Subject: Re: powerpc/lib: Split xor_vmx file to guarantee instruction ordering
Message-Id: <3wh9pl4vtXz9sN5@ozlabs.org>
Date: Mon,  5 Jun 2017 20:21:51 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-05-23 at 23:45:59 UTC, Matt Brown wrote:
> The xor_vmx.c file is used for the RAID5 xor operations. In these functions
> altivec is enabled to run the operation and then disabled. However due to
> compiler instruction reordering, altivec instructions are being run before
> enable_altivec() and after disable_altivec().
> 
> This patch splits the non-altivec code into xor_vmx_glue.c which calls the
> altivec functions in xor_vmx.c. By compiling xor_vmx_glue.c without
> -maltivec we can guarantee that altivec instruction will not be reordered
> outside of the enable/disable block.
> 
> Signed-off-by: Matt Brown <matthew.brown.dev@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/f718d426d7e42eec6e5d2932f52a51

cheers
