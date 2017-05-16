Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wS83z6Nn0zDqNs
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 May 2017 06:21:35 +1000 (AEST)
Date: Tue, 16 May 2017 22:20:15 +0200
Message-ID: <20170516222015.Horde.fwWhnIwI59SuB64Du97wdg2@messagerie.c-s.fr>
From: LEROY Christophe <christophe.leroy@c-s.fr>
To: Balbir Singh <bsingharora@gmail.com>
Cc: naveen.n.rao@linux.vnet.ibm.com, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC 0/2] Consolidate patch_instruction
In-Reply-To: <20170516034913.21163-1-bsingharora@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Balbir Singh <bsingharora@gmail.com> a =C3=A9crit=C2=A0:

> patch_instruction is enhanced in this RFC to support
> patching via a different virtual address (text_poke_area).
> The mapping of text_poke_area->addr is RW and not RWX.
> This way the mapping allows write for patching and then we tear
> down the mapping. The downside is that we introduce a spinlock
> which serializes our patching to one patch at a time.

Very nice patch, would fit great with my patch for impmementing=20=20
CONFIG_DEBUG_RODATA=20(https://patchwork.ozlabs.org/patch/754289 ).
Would avoid having to set the text area back to RW for patching

Christophe

>
> In this patchset we also consolidate instruction changes
> in kprobes to use patch_instruction().
>
> Balbir Singh (2):
>   powerpc/lib/code-patching: Enhance code patching
>   powerpc/kprobes: Move kprobes over to patch_instruction
>
>  arch/powerpc/kernel/kprobes.c    |  4 +-
>  arch/powerpc/lib/code-patching.c | 88=20=20
>=20++++++++++++++++++++++++++++++++++++++--
>  2 files changed, 86 insertions(+), 6 deletions(-)
>
> --
> 2.9.3
