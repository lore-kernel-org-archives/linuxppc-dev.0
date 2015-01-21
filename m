Return-Path: <anton@samba.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9F5711A0DF0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jan 2015 23:06:40 +1100 (AEDT)
Date: Wed, 21 Jan 2015 23:06:39 +1100
From: Anton Blanchard <anton@samba.org>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/2] powerpc: Add 64bit optimised memcmp
Message-ID: <20150121230639.081d6dcd@kryten>
In-Reply-To: <3008920.kfIvkVJRyU@wuerfel>
References: <1421803659-10678-1-git-send-email-anton@samba.org>
 <3008920.kfIvkVJRyU@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Arnd,

> Would it help to also add a way for an architecture to override
> memcmp_pages() with its own implementation? That way you could
> skip the unaligned part, hardcode the loop counter and avoid the
> preempt_disable() in kmap_atomic().

Good idea. We could also have a generic implementation that did long
comparisons, so everyone would get a decent speed up.

Anton
