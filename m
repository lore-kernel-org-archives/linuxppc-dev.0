Return-Path: <yur@emcraft.com>
Received: from ocean.emcraft.com (ocean.emcraft.com [213.221.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B59A5DDE41
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Dec 2008 11:41:43 +1100 (EST)
Date: Tue, 9 Dec 2008 03:41:36 +0300
From: Yuri Tikhonov <yur@emcraft.com>
Message-ID: <1195158776.20081209034136@emcraft.com>
To: "Dan Williams" <dan.j.williams@intel.com>
Subject: Re[2]: [PATCH 01/11] async_tx: don't use src_list argument of
	async_xor() for dma addresses
In-Reply-To: <e9c3a7c20812081631i1e0efff2j953b2e81f6dc6e0e@mail.gmail.com>
References: <200812090055.26721.yur@emcraft.com>
	<e9c3a7c20812081631i1e0efff2j953b2e81f6dc6e0e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
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

On Tuesday, December 9, 2008 you wrote:

> On Mon, Dec 8, 2008 at 2:55 PM, Yuri Tikhonov <yur@emcraft.com> wrote:
>> Using src_list argument of async_xor() as a storage for dma addresses
>> implies sizeof(dma_addr_t) <=3D sizeof(struct page *) restriction which =
is
>> not always true (e.g. ppc440spe).
>>

> ppc440spe runs with CONFIG_PHYS_64BIT?

 Yep. It uses 36-bit addressing, so this CONFIG is turned on.

> If we do this then we need to also change md to limit the number of
> allowed disks based on the kernel stack size.  Because with 256 disks
> a 4K stack can be consumed by one call to async_pq ((256 sources in
> raid5.c + 256 sources async_pq.c) * 8 bytes per source on 64-bit).

 On ppc440spe we have 8KB stack, so the things are not worse than on=20
32-bit archs with 4KB stack. Thus, I guess no changes to md are=20
required because of this patch. Right?

 Regards, Yuri

 --
 Yuri Tikhonov, Senior Software Engineer
 Emcraft Systems, www.emcraft.com
