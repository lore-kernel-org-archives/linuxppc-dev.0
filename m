Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yjrtj5c7vzDrbn
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Nov 2017 20:46:37 +1100 (AEDT)
In-Reply-To: <20171121142820.C744F6BB8F@po15668-vm-win7.idsi0.si.c-s.fr>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Scott Wood <oss@buserror.net>,
 Meelis Roos <mroos@linux.ee>, Balbir Singh <bsingharora@gmail.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [v2] powerpc: fix boot on BOOK3S_32 with CONFIG_STRICT_KERNEL_RWX
Message-Id: <3yjrtj40HRz9rxl@ozlabs.org>
Date: Fri, 24 Nov 2017 20:46:37 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-11-21 at 14:28:20 UTC, Christophe Leroy wrote:
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
> Reported-by: Meelis Roos <mroos@linux.ee>
> Cc: Balbir Singh <bsingharora@gmail.com>
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/252eb55816a6f69ef9464cad303cdb

cheers
