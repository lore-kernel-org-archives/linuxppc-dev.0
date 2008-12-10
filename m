Return-Path: <dan.j.williams@gmail.com>
Received: from rn-out-0910.google.com (rn-out-0910.google.com [64.233.170.186])
	by ozlabs.org (Postfix) with ESMTP id 02F49DDF1C
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Dec 2008 12:08:31 +1100 (EST)
Received: by rn-out-0910.google.com with SMTP id j40so260698rnf.16
	for <linuxppc-dev@ozlabs.org>; Tue, 09 Dec 2008 17:08:30 -0800 (PST)
Message-ID: <e9c3a7c20812091708n5e5daf2ane9c7fb927782c771@mail.gmail.com>
Date: Tue, 9 Dec 2008 18:08:29 -0700
From: "Dan Williams" <dan.j.williams@intel.com>
Sender: dan.j.williams@gmail.com
To: "Yuri Tikhonov" <yur@emcraft.com>
Subject: Re: Re[2]: [PATCH 01/11] async_tx: don't use src_list argument of
	async_xor() for dma addresses
In-Reply-To: <1195158776.20081209034136@emcraft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <200812090055.26721.yur@emcraft.com>
	<e9c3a7c20812081631i1e0efff2j953b2e81f6dc6e0e@mail.gmail.com>
	<1195158776.20081209034136@emcraft.com>
Cc: wd@denx.de, dzu@denx.de, Neil Brown <neilb@suse.de>,
	linux-raid@vger.kernel.org, linuxppc-dev@ozlabs.org, yanok@emcraft.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Dec 8, 2008 at 5:41 PM, Yuri Tikhonov <yur@emcraft.com> wrote:
> On Tuesday, December 9, 2008 you wrote:
>
>> On Mon, Dec 8, 2008 at 2:55 PM, Yuri Tikhonov <yur@emcraft.com> wrote:
>>> Using src_list argument of async_xor() as a storage for dma addresses
>>> implies sizeof(dma_addr_t) <= sizeof(struct page *) restriction which is
>>> not always true (e.g. ppc440spe).
>>>
>
>> ppc440spe runs with CONFIG_PHYS_64BIT?
>
>  Yep. It uses 36-bit addressing, so this CONFIG is turned on.
>
>> If we do this then we need to also change md to limit the number of
>> allowed disks based on the kernel stack size.  Because with 256 disks
>> a 4K stack can be consumed by one call to async_pq ((256 sources in
>> raid5.c + 256 sources async_pq.c) * 8 bytes per source on 64-bit).
>
>  On ppc440spe we have 8KB stack, so the things are not worse than on
> 32-bit archs with 4KB stack. Thus, I guess no changes to md are
> required because of this patch. Right?

8K stacks do make this less of an issue *provided* handle_stripe()
remains only called from raid5d.  We used to share some stripe
handling work with the requester's process context where the stack is
much more crowded.  So, we would now be more strongly tied to the
raid5d-only approach... maybe that is not enough to deny this change.
Neil what do you think of the async_{xor,pq,etc} apis allocating
'src_cnt' sized arrays on the stack?

Thanks,
Dan
