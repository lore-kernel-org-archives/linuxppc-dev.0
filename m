Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wcYK24N4RzDq5x
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 May 2017 22:47:02 +1000 (AEST)
Subject: Re: [PATCH 1/7] powerpc/mm: rename map_page() to map_kernel_page() on
 PPC32
To: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Scott Wood <oss@buserror.net>,
 Balbir Singh <bsingharora@gmail.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <cover.1496070452.git.christophe.leroy@c-s.fr>
 <83aadb3163da87ec017ca4a61afcc29520a27eff.1496070452.git.christophe.leroy@c-s.fr>
 <8760gi62jw.fsf@concordia.ellerman.id.au>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <4ef6cdbc-9a35-537d-d0f4-2d7cbb67ed59@c-s.fr>
Date: Tue, 30 May 2017 14:46:45 +0200
MIME-Version: 1.0
In-Reply-To: <8760gi62jw.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 30/05/2017 à 12:50, Michael Ellerman a écrit :
> Christophe Leroy <christophe.leroy@c-s.fr> writes:
> 
> ...
> 
> Please tell me why.

Because of patch https://patchwork.ozlabs.org/patch/766777/ which 
modifies patch_instruction() to use an alternative mapping.
Compilation fails on PPC32 because map_kernel_page() only exists on 
PPC64. However we have map_page() which does the same on PPC32, hence 
the renaming.

> 
> You also moved the declaration from mmu_decl.h to book3s/32/pgtable.h,
> but didn't update any includes, presumably we're confident everything
> gets pgtable.h somehow?

Yes I did that so that lib/code_patching.c sees it.
All users of map_page() already include pgtable in a way or another.

Christophe
