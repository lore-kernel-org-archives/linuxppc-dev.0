Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r1Fv92VrNzDq5f
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 May 2016 12:23:33 +1000 (AEST)
Message-ID: <1462501412.8044.0.camel@ellerman.id.au>
Subject: Re: [PATCH] cxl: Add kernel API to allow a context to operate with
 relocate disabled
From: Michael Ellerman <mpe@ellerman.id.au>
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>, Ian Munsie
 <imunsie@au1.ibm.com>, mikey <mikey@neuling.org>,
 linuxppc-dev@lists.ozlabs.org,  Frederic Barrat <frederic.barrat@fr.ibm.com>
Date: Fri, 06 May 2016 12:23:32 +1000
In-Reply-To: <572A1E30.2020306@linux.vnet.ibm.com>
References: <1462344882-1638-1-git-send-email-imunsie@au.ibm.com>
 <572A1E30.2020306@linux.vnet.ibm.com>
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

On Wed, 2016-05-04 at 18:07 +0200, Frederic Barrat wrote:

> Hi Ian,
> 
> The principle is fine, but the cxl_start_context2 API bothers me a bit. 
> Would something similar to this make sense, I think it would keep the 
> API cleaner:
> 
> /* new kernel-only API */
> void cxl_set_translation_mode(struct cxl_context *ctx, bool real_mode)
> 
> For mlx5, the call sequence would be:
> 	ctx = cxl_dev_context_init()
> 	cxl_set_translation_mode(ctx, true)
> 	cxl_start_context(ctx)

I'd prefer that if it works.

The new "2" API and the bool being passed everywhere is a bit smelly.

cheers
