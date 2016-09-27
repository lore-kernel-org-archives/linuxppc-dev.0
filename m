Return-Path: <npiggin@gmail.com>
Received: from mail-pa0-x232.google.com (mail-pa0-x232.google.com
 [IPv6:2607:f8b0:400e:c03::232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sk9GQ5WBMzDrWK
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Sep 2016 05:03:26 +1000 (AEST)
Received: by mail-pa0-x232.google.com with SMTP id oz2so8277849pac.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Sep 2016 12:03:26 -0700 (PDT)
Date: Wed, 28 Sep 2016 05:03:16 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Anton Blanchard <anton@samba.org>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 agraf@suse.de, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc: Align hot loops of memset() and
 backwards_memcpy()
Message-ID: <20160928050316.0290e4c5@roar.ozlabs.ibm.com>
In-Reply-To: <20160925213659.18971b96@kryten>
References: <1470293602-11121-1-git-send-email-anton@ozlabs.org>
 <20160805210052.0f9a8c43@roar.ozlabs.ibm.com>
 <20160925213659.18971b96@kryten>
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

On Sun, 25 Sep 2016 21:36:59 +1000
Anton Blanchard <anton@samba.org> wrote:

> Hi Nick,
> 
> > Hmm. If we execute this loop once, we'll only fetch additional nops.
> > Twice, and we make up for them by not fetching unused instructions.
> > More than twice and we may start winning.
> > 
> > For large sizes it probably helps, but I'd like to see what sizes
> > memset sees.  
> 
> I noticed this in an nginx web serving test. There are some 1 and 2
> iteration calls, but quite a few larger ones - get_empty_filp() goes for
> 4 iterations and sk_prot_alloc() for 26 iterations.

Hi Anton,

I didn't have anything against the patch as such, I just wondered if
it's likely to be an overall win.

Thanks,
Nick
