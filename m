Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 921F31A0151
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Aug 2015 15:33:16 +1000 (AEST)
Message-ID: <1439962396.24918.8.camel@ellerman.id.au>
Subject: Re: [PATCH 2/2] cxl: add set/get private data to context struct
From: Michael Ellerman <mpe@ellerman.id.au>
To: Ian Munsie <imunsie@au1.ibm.com>
Cc: Matt Ochs <mrochs@us.ibm.com>, linuxppc-dev <linuxppc-dev@ozlabs.org>,
 mikey <mikey@neuling.org>, linux-kernel <linux-kernel@vger.kernel.org>
Date: Wed, 19 Aug 2015 15:33:16 +1000
In-Reply-To: <1439960447-sup-3936@delenn.ozlabs.ibm.com>
References: <1439957971-30483-1-git-send-email-imunsie@au.ibm.com>
 <1439957971-30483-2-git-send-email-imunsie@au.ibm.com>
 <1439959770.24918.5.camel@ellerman.id.au>
 <1439960447-sup-3936@delenn.ozlabs.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-08-19 at 15:12 +1000, Ian Munsie wrote:
> Excerpts from Michael Ellerman's message of 2015-08-19 14:49:30 +1000:
> > Do we really need the accessors? They don't buy anything I can see over just
> > using ctx->priv directly.
> 
> The reasoning there is because we don't currently expose the contents of
> stuct cxl_context to afu drivers, rather they just treat it as an opaque
> type.
> 
> We could potentially change this to expose the details, but there's a
> lot of junk in there that's just internal details of the cxl driver that
> isn't of interest to an afu driver that I'd rather not expose.
> 
> We also already have another accessor function (cxl_process_element) in
> the api, so it's not out of place.
> 
> FWIW I'm not opposed to changing how this api works if it ultimately
> makes things better, but I want to wait until the cxlflash superpipe
> support is merged so any patches that change the api can change it at
> the same time.

OK. I saw struct cxl_context in cxl.h and figured it was public, but it's in
drivers/misc/cxl/cxl.h, so yes other drivers have no business poking in there,
even though they *could*.

So that's fine.

cheers
