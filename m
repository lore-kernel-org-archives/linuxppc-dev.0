Return-Path: <anton@samba.org>
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3shlSd3KcmzDrPh
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 25 Sep 2016 21:37:21 +1000 (AEST)
Date: Sun, 25 Sep 2016 21:36:59 +1000
From: Anton Blanchard <anton@samba.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 agraf@suse.de, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc: Align hot loops of memset() and
 backwards_memcpy()
Message-ID: <20160925213659.18971b96@kryten>
In-Reply-To: <20160805210052.0f9a8c43@roar.ozlabs.ibm.com>
References: <1470293602-11121-1-git-send-email-anton@ozlabs.org>
 <20160805210052.0f9a8c43@roar.ozlabs.ibm.com>
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

Hi Nick,

> Hmm. If we execute this loop once, we'll only fetch additional nops.
> Twice, and we make up for them by not fetching unused instructions.
> More than twice and we may start winning.
> 
> For large sizes it probably helps, but I'd like to see what sizes
> memset sees.

I noticed this in an nginx web serving test. There are some 1 and 2
iteration calls, but quite a few larger ones - get_empty_filp() goes for
4 iterations and sk_prot_alloc() for 26 iterations.

Anton
