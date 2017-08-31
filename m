Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xjdlf54MYzDqRM
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Aug 2017 20:24:30 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 John Allen <jallen@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/pseries: Don't attempt to acquire drc during
 memory hot add for assigned lmbs
In-Reply-To: <cad79893-3d1a-f2ea-892f-6481a22f261a@linux.vnet.ibm.com>
References: <fc2ad536-a772-f006-43c4-1ddf6e296ebb@linux.vnet.ibm.com>
 <87bmmx3hr8.fsf@concordia.ellerman.id.au>
 <cad79893-3d1a-f2ea-892f-6481a22f261a@linux.vnet.ibm.com>
Date: Thu, 31 Aug 2017 20:24:29 +1000
Message-ID: <87d17ct4pu.fsf@concordia.ellerman.id.au>
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

Nathan Fontenot <nfont@linux.vnet.ibm.com> writes:
...
>
> Hopefully that helps clarify things.

Yep thanks. In short, read the code better Michael :)

I folded in this hunk, which will keep the compiler happy and is also
correct I believe. Basically in the success case (lmbs_added == lmbs_to_add)
we explicitly set rc to 0.

@@ -870,6 +873,7 @@ static int dlpar_memory_add_by_count(u32 lmbs_to_add, struct property *prop)
                                lmbs[i].base_addr, lmbs[i].drc_index);
                        lmbs[i].reserved = 0;
                }
+               rc = 0;
        }
 
        return rc;

cheers
