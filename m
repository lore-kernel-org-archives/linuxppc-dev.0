Return-Path: <alistair@popple.id.au>
Received: from ipmail06.adl2.internode.on.net (ipmail06.adl2.internode.on.net
 [IPv6:2001:44b8:8060:ff02:300:1:2:6])
 by ozlabs.org (Postfix) with ESMTP id 625712C014B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Feb 2014 10:52:13 +1100 (EST)
From: Alistair Popple <alistair@popple.id.au>
To: Josh Boyer <jwboyer@gmail.com>
Subject: Re: [PATCH] ppc476: Enable a linker work around for IBM errata #46
Date: Tue, 25 Feb 2014 10:52:07 +1100
Message-ID: <25816197.m2jECl2CbU@mexican>
In-Reply-To: <CA+5PVA4Hx4iKkL+vLJjOTwMaKOL-dJPJpSHLjR+nU6MTTGvFcA@mail.gmail.com>
References: <1393225256-21122-1-git-send-email-alistair@popple.id.au>
 <CA+5PVA4Hx4iKkL+vLJjOTwMaKOL-dJPJpSHLjR+nU6MTTGvFcA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 24 Feb 2014 08:35:06 Josh Boyer wrote:
> On Mon, Feb 24, 2014 at 2:00 AM, Alistair Popple <alistair@popple.id.au> 
wrote:
> > This patch adds an option to enable a work around for an icache bug on
> > 476 that can cause execution of stale instructions when falling
> > through pages (IBM errata #46). It requires a recent version of
> > binutils which supports the --ppc476-workaround option.
> > 
> > The work around enables the appropriate linker options and ensures
> > that all module output sections are aligned to 4K page boundaries. The
> > work around is only required when building modules.
> 
> What happens if you're using 64K pages?  Is the alignment 4K always,
> or does it need to be aligned to PAGE_SIZE?

The work around inserts an extra instruction on 4K page boundaries. As a 64K 
(or a 16K) page boundary is also a 4K page boundary the work around should 
cover those page sizes as well.

- Alistair

> josh
