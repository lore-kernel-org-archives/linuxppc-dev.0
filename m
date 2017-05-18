Return-Path: <bp@alien8.de>
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
 by lists.ozlabs.org (Postfix) with ESMTP id 3wT3jn0WTlzDqY7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 May 2017 18:09:00 +1000 (AEST)
Date: Thu, 18 May 2017 10:08:40 +0200
From: Borislav Petkov <bp@alien8.de>
To: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
 "mchehab@kernel.org" <mchehab@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] EDAC: mv64x60: replace in_le32/out_le32 with
 ioread32/iowrite32
Message-ID: <20170518080840.fnoiauo5aq4qqgv2@pd.tnic>
References: <20170512042002.18524-1-chris.packham@alliedtelesis.co.nz>
 <20170512042002.18524-4-chris.packham@alliedtelesis.co.nz>
 <20170517181021.yfctrok7f25d5bu5@pd.tnic>
 <7c7bfec63342409ebd58913836a0739a@svr-chch-ex1.atlnz.lc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <7c7bfec63342409ebd58913836a0739a@svr-chch-ex1.atlnz.lc>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, May 17, 2017 at 09:16:47PM +0000, Chris Packham wrote:
> MV64x60 is pretty old. I considered gutting mv64x60_edac.c to make a 
> separate driver but that would just be more code to maintain.

Well, one thing we did with layerscape and mpc85xx EDAC modules is share
the FSL memory controller IP through fsl_ddr_edac.c which both modules
link.

I dunno, perhaps you could do something similar by extracting the common
parts and this way avoid any breakage of the PPC side of things - since
apparently finding such hw is not easy - and then link those into your
driver. And your driver could just be a wrapper containing the EDAC glue
to make it a separate ARM armada_edac.c or so.

Anyway, just an idea.

Thanks.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
