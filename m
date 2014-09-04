Return-Path: <daniel@ffwll.ch>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4875E1A00FE
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Sep 2014 19:34:40 +1000 (EST)
Received: from mail-we0-x22e.google.com (mail-we0-x22e.google.com
 [IPv6:2a00:1450:400c:c03::22e])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 8FE941400E9
 for <linuxppc-dev@ozlabs.org>; Thu,  4 Sep 2014 19:34:38 +1000 (EST)
Received: by mail-we0-f174.google.com with SMTP id u57so9880904wes.5
 for <linuxppc-dev@ozlabs.org>; Thu, 04 Sep 2014 02:34:34 -0700 (PDT)
Sender: Daniel Vetter <daniel.vetter@ffwll.ch>
Date: Thu, 4 Sep 2014 11:34:54 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Thomas Hellstrom <thellstrom@vmware.com>
Subject: Re: TTM placement & caching issue/questions
Message-ID: <20140904093454.GG15520@phenom.ffwll.local>
References: <1409789547.30640.136.camel@pasglop> <54081844.7000604@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <54081844.7000604@vmware.com>
Cc: dri-devel@lists.freedesktop.org, Michel Danzer <daenzer@vmware.com>,
 linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Sep 04, 2014 at 09:44:04AM +0200, Thomas Hellstrom wrote:
> Last time I tested, (and it seems like Michel is on the same track),
> writing with the CPU to write-combined memory was substantially faster
> than writing to cached memory, with the additional side-effect that CPU
> caches are left unpolluted.
> 
> Moreover (although only tested on Intel's embedded chipsets), texturing
> from cpu-cache-coherent PCI memory was a real GPU performance hog
> compared to texturing from non-snooped memory. Hence, whenever a buffer
> could be classified as GPU-read-only (or almost at least), it should be
> placed in write-combined memory.

Just a quick comment since this explicitly referes to intel chips: On
desktop/laptop chips with the big shared l3/l4 caches it's the other way
round. Cached uploads are substantially faster than wc and not using
coherent access is a severe perf hit for texturing. I guess the hw guys
worked really hard to hide the snooping costs so that the gpu can benefit
from the massive bandwidth these caches can provide.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
