Return-Path: <pladow@gmail.com>
Received: from mail-ie0-x22d.google.com (mail-ie0-x22d.google.com
 [IPv6:2607:f8b0:4001:c03::22d])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8AA662C04DE
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Jun 2013 10:56:14 +1000 (EST)
Received: by mail-ie0-f173.google.com with SMTP id k13so23459781iea.4
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 23 Jun 2013 17:56:09 -0700 (PDT)
References: <CAN8Q1EdnN9+kKGy+voF3=EyPfbHv04Emfz=uA6XKMJEAkvLpAA@mail.gmail.com>
 <CAN8Q1Ed9Lpg1Sog5tQODe+jqCRXBBH3d_UeR5usdc23CD7vwjg@mail.gmail.com>
 <1371945647.3944.106.camel@pasglop>
Mime-Version: 1.0 (1.0)
In-Reply-To: <1371945647.3944.106.camel@pasglop>
Content-Type: text/plain;
	charset=us-ascii
Message-Id: <F3E9F49F-9C68-4BCB-B2A0-507AB1B2F10F@gmail.com>
From: Peter LaDow <pladow@gmail.com>
Subject: Re: Inbound PCI and Memory Corruption
Date: Sun, 23 Jun 2013 17:56:05 -0700
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Peter LaDow <petela@gocougs.wsu.edu>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Jun 22, 2013, at 5:00 PM, Benjamin Herrenschmidt <benh@kernel.crashing.or=
g> wrote:

> On Fri, 2013-06-21 at 10:14 -0700, Peter LaDow wrote:
>>=20
> Afaik e300 is slightly out of order, maybe it's missing a memory barrier
> somewhere.... One thing to try is to add some to the dma_map/unmap ops.
>=20
> Also audit the driver to ensure that it properly uses barriers when
> populating descriptors (and maybe compare to a more recent version of
> the driver upstream).
Thanks for the tips.

I've been working with the folk at Intel on the e1000-dev list, and they did=
 add memory barriers. And I've tried the latest e1000 drivers (direct from t=
he e1000 tree) with no luck.

I've done PCI traces, and there is no DMA after the disable is written to th=
e e1000 part. All I can think is that there may be posted writes, the kernel=
 goes on to cleanup the DMA buffers. But there are write memory barriers, so=
 I don't see how this is possible.

Are the memory barriers meaningful in single processor builds?

Thanks,
Pete=
