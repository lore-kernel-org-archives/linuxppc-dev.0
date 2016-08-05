Return-Path: <anton@samba.org>
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s5QGV3ZyCzDqCb
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Aug 2016 21:54:58 +1000 (AEST)
Date: Fri, 5 Aug 2016 21:54:37 +1000
From: Anton Blanchard <anton@samba.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 agraf@suse.de, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc: Align hot loops of memset() and
 backwards_memcpy()
Message-ID: <20160805215437.54af6f57@kryten>
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

I found this in a trace of nginx web serving. Looking back at it,
get_empty_filp() zeros a struct file, and we go through the loop 4
times. We might want to look more generally at what lengths memset() is
called with though.

Anton
