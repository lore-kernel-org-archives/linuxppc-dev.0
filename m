Return-Path: <SRS0=3K4h=OM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3054BC04EB9
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Dec 2018 16:22:30 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FDF920661
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Dec 2018 16:22:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FDF920661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 437qyp53JbzDqMG
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Dec 2018 03:22:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=ravnborg.org
 (client-ip=109.247.116.15; helo=asavdk4.altibox.net;
 envelope-from=sam@ravnborg.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ravnborg.org
X-Greylist: delayed 563 seconds by postgrey-1.36 at bilbo;
 Tue, 04 Dec 2018 03:20:33 AEDT
Received: from asavdk4.altibox.net (asavdk4.altibox.net [109.247.116.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 437qwd5XMpzDqGc
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Dec 2018 03:20:33 +1100 (AEDT)
Received: from ravnborg.org (unknown [158.248.194.18])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by asavdk4.altibox.net (Postfix) with ESMTPS id 5A86C804EA;
 Mon,  3 Dec 2018 17:10:54 +0100 (CET)
Date: Mon, 3 Dec 2018 17:10:52 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH v2 3/6] sh: prefer memblock APIs returning virtual address
Message-ID: <20181203161052.GA4244@ravnborg.org>
References: <1543852035-26634-1-git-send-email-rppt@linux.ibm.com>
 <1543852035-26634-4-git-send-email-rppt@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1543852035-26634-4-git-send-email-rppt@linux.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=UpRNyd4B c=1 sm=1 tr=0
 a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
 a=kj9zAlcOel0A:10 a=VnNF1IyMAAAA:8 a=FTNaidAvUsMVHdn4hVIA:9
 a=9GetFJ8xNGreKwwT:21 a=sKQTW2iCjVXyVLe6:21 a=CjuIK1q_8ugA:10
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Michal Hocko <mhocko@suse.com>, linux-sh@vger.kernel.org,
 linux-mm@kvack.org, Rich Felker <dalias@libc.org>,
 Paul Mackerras <paulus@samba.org>, sparclinux@vger.kernel.org,
 Vincent Chen <deanbo422@gmail.com>, Jonas Bonn <jonas@southpole.se>,
 linux-c6x-dev@linux-c6x.org, Yoshinori Sato <ysato@users.sourceforge.jp>,
 Russell King <linux@armlinux.org.uk>, Mark Salter <msalter@redhat.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
 openrisc@lists.librecores.org, Greentime Hu <green.hu@gmail.com>,
 Stafford Horne <shorne@gmail.com>, Guan Xuetao <gxt@pku.edu.cn>,
 linux-arm-kernel@lists.infradead.org, Michal Simek <monstr@monstr.eu>,
 linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Mike.

On Mon, Dec 03, 2018 at 05:47:12PM +0200, Mike Rapoport wrote:
> Rather than use the memblock_alloc_base that returns a physical address and
> then convert this address to the virtual one, use appropriate memblock
> function that returns a virtual address.
> 
> There is a small functional change in the allocation of then NODE_DATA().
> Instead of panicing if the local allocation failed, the non-local
> allocation attempt will be made.
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>  arch/sh/mm/init.c | 18 +++++-------------
>  arch/sh/mm/numa.c |  5 ++---
>  2 files changed, 7 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/sh/mm/init.c b/arch/sh/mm/init.c
> index c8c13c77..3576b5f 100644
> --- a/arch/sh/mm/init.c
> +++ b/arch/sh/mm/init.c
> @@ -192,24 +192,16 @@ void __init page_table_range_init(unsigned long start, unsigned long end,
>  void __init allocate_pgdat(unsigned int nid)
>  {
>  	unsigned long start_pfn, end_pfn;
> -#ifdef CONFIG_NEED_MULTIPLE_NODES
> -	unsigned long phys;
> -#endif
>  
>  	get_pfn_range_for_nid(nid, &start_pfn, &end_pfn);
>  
>  #ifdef CONFIG_NEED_MULTIPLE_NODES
> -	phys = __memblock_alloc_base(sizeof(struct pglist_data),
> -				SMP_CACHE_BYTES, end_pfn << PAGE_SHIFT);
> -	/* Retry with all of system memory */
> -	if (!phys)
> -		phys = __memblock_alloc_base(sizeof(struct pglist_data),
> -					SMP_CACHE_BYTES, memblock_end_of_DRAM());
> -	if (!phys)
> +	NODE_DATA(nid) = memblock_alloc_try_nid_nopanic(
> +				sizeof(struct pglist_data),
> +				SMP_CACHE_BYTES, MEMBLOCK_LOW_LIMIT,
> +				MEMBLOCK_ALLOC_ACCESSIBLE, nid);
> +	if (!NODE_DATA(nid))
>  		panic("Can't allocate pgdat for node %d\n", nid);
> -
> -	NODE_DATA(nid) = __va(phys);
> -	memset(NODE_DATA(nid), 0, sizeof(struct pglist_data));
The new code will always assign NODE_DATA(nid), where the old
code only assigned NODE_DATA(nid) in the good case.
I dunno if this is an issue, just noticed the difference and
wanted to point it out.

	Sam
