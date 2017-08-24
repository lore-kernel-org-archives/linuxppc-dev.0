Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xdLGm3c0hzDrJx
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Aug 2017 20:33:04 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: John Allen <jallen@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc/pseries: Don't attempt to acquire drc during
 memory hot add for assigned lmbs
In-Reply-To: <fc2ad536-a772-f006-43c4-1ddf6e296ebb@linux.vnet.ibm.com>
References: <fc2ad536-a772-f006-43c4-1ddf6e296ebb@linux.vnet.ibm.com>
Date: Thu, 24 Aug 2017 20:33:02 +1000
Message-ID: <874lsxw90h.fsf@concordia.ellerman.id.au>
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

John Allen <jallen@linux.vnet.ibm.com> writes:

> Check if an LMB is assigned before attempting to call dlpar_acquire_drc in
> order to avoid any unnecessary rtas calls. This substantially reduces the
> running time of memory hot add on lpars with large amounts of memory.
>
> Signed-off-by: John Allen <jallen@linux.vnet.ibm.com>

I'll add:

  Fixes: c21f515c7436 ("powerpc/pseries: Make the acquire/release of the drc for memory a seperate step")

?

How bad is the slow down, do we need to backport to stable/distros?

cheers
