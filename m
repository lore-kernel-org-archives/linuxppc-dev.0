Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yhgr00NZTzDr1w
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Nov 2017 22:55:12 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Scott Wood <oss@buserror.net>,
 Meelis Roos <mroos@linux.ee>, Balbir Singh <bsingharora@gmail.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2] powerpc: fix boot on BOOK3S_32 with
 CONFIG_STRICT_KERNEL_RWX
In-Reply-To: <20171121142820.C744F6BB8F@po15668-vm-win7.idsi0.si.c-s.fr>
References: <20171121142820.C744F6BB8F@po15668-vm-win7.idsi0.si.c-s.fr>
Date: Wed, 22 Nov 2017 22:55:11 +1100
Message-ID: <87efoq34v4.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Christophe Leroy <christophe.leroy@c-s.fr> writes:

> On powerpc32, patch_instruction() is called by apply_feature_fixups()
> which is called from early_init()
>
> There is the following note in front of early_init():
>  * Note that the kernel may be running at an address which is different
>  * from the address that it was linked at, so we must use RELOC/PTRRELOC
>  * to access static data (including strings).  -- paulus
>
> Therefore, slab_is_available() cannot be called yet, and
> text_poke_area must be addressed with PTRRELOC()
>
> Fixes: 37bc3e5fd764f ("powerpc/lib/code-patching: Use alternate map
> for patch_instruction()")

I changed this to:

  Fixes: 95902e6c8864 ("powerpc/mm: Implement STRICT_KERNEL_RWX on PPC32")
  Cc: stable@vger.kernel.org # v4.14+

Because although the code was added in 37bc3e5fd764f, at that point it
couldn't be enabled on 32-bit, so there was no bug.

I'm not saying as the author of 95902e6c8864 that the bug is your fault,
but that is the first commit where the bug actually existed for someone
to hit.

cheers
