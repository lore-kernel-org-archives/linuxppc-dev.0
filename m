Return-Path: <mroos@linux.ee>
Received: from smtp2.it.da.ut.ee (smtp2.it.da.ut.ee
 [IPv6:2001:bb8:2002:500:20f:1fff:fe04:1bbb])
 by lists.ozlabs.org (Postfix) with ESMTP id 3yhCH53SF5zDqyR
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Nov 2017 04:28:28 +1100 (AEDT)
Date: Tue, 21 Nov 2017 19:28:24 +0200 (EET)
From: Meelis Roos <mroos@linux.ee>
Sender: mroos@math.ut.ee
To: Christophe Leroy <christophe.leroy@c-s.fr>
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>, Balbir Singh <bsingharora@gmail.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2] powerpc: fix boot on BOOK3S_32 with
 CONFIG_STRICT_KERNEL_RWX
In-Reply-To: <20171121142820.C744F6BB8F@po15668-vm-win7.idsi0.si.c-s.fr>
Message-ID: <alpine.LRH.2.21.1711211821320.8798@math.ut.ee>
References: <20171121142820.C744F6BB8F@po15668-vm-win7.idsi0.si.c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


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
> ---
>  v2: Added missing asm/setup.h

It works - thank you! Tested on top of 4.14.0.

For wider powerpc audience: this warning-like INFO bit is present 
independently of theis patch. Is it dangerous for some configuration?

INFO: Uncompressed kernel (size 0x5d6c54) overlaps the address of the wrapper(0x400000)
INFO: Fixing the link_address of wrapper to (0x600000)


-- 
Meelis Roos (mroos@linux.ee)
