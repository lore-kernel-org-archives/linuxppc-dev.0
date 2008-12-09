Return-Path: <dan.j.williams@gmail.com>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.170])
	by ozlabs.org (Postfix) with ESMTP id 4AF63DDEE8
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Dec 2008 11:31:14 +1100 (EST)
Received: by wf-out-1314.google.com with SMTP id 24so1779167wfg.15
	for <linuxppc-dev@ozlabs.org>; Mon, 08 Dec 2008 16:31:13 -0800 (PST)
Message-ID: <e9c3a7c20812081631i1e0efff2j953b2e81f6dc6e0e@mail.gmail.com>
Date: Mon, 8 Dec 2008 17:31:13 -0700
From: "Dan Williams" <dan.j.williams@intel.com>
Sender: dan.j.williams@gmail.com
To: "Yuri Tikhonov" <yur@emcraft.com>
Subject: Re: [PATCH 01/11] async_tx: don't use src_list argument of
	async_xor() for dma addresses
In-Reply-To: <200812090055.26721.yur@emcraft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <200812090055.26721.yur@emcraft.com>
Cc: linux-raid@vger.kernel.org, linuxppc-dev@ozlabs.org, wd@denx.de,
	dzu@denx.de, yanok@emcraft.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Dec 8, 2008 at 2:55 PM, Yuri Tikhonov <yur@emcraft.com> wrote:
> Using src_list argument of async_xor() as a storage for dma addresses
> implies sizeof(dma_addr_t) <= sizeof(struct page *) restriction which is
> not always true (e.g. ppc440spe).
>

ppc440spe runs with CONFIG_PHYS_64BIT?

If we do this then we need to also change md to limit the number of
allowed disks based on the kernel stack size.  Because with 256 disks
a 4K stack can be consumed by one call to async_pq ((256 sources in
raid5.c + 256 sources async_pq.c) * 8 bytes per source on 64-bit).

Regards,
Dan
