Return-Path: <andi@firstfloor.org>
Received: from one.firstfloor.org (one.firstfloor.org [213.235.205.2])
	by ozlabs.org (Postfix) with ESMTP id 522DDDE61B
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Mar 2008 09:31:17 +1100 (EST)
Date: Wed, 26 Mar 2008 22:49:39 +0100
From: Andi Kleen <andi@firstfloor.org>
To: Jon Tollefson <kniht@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/4] allow arch specific function for allocating gigantic
	pages
Message-ID: <20080326214939.GB29105@one.firstfloor.org>
References: <47EABE2D.7080400@linux.vnet.ibm.com>
	<47EABF09.6090302@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <47EABF09.6090302@linux.vnet.ibm.com>
Cc: npiggin@suse.de, Adam Litke <agl@linux.vnet.ibm.com>,
	linuxppc-dev <linuxppc-dev@ozlabs.org>, linux-kernel@vger.kernel.org,
	Linux Memory Management List <linux-mm@kvack.org>,
	Andi Kleen <andi@firstfloor.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Haven't reviewed it in detail, just noticed something.

> @@ -614,6 +610,7 @@ static int __init hugetlb_init(void)
>  {
>  	if (HPAGE_SHIFT == 0)
>  		return 0;
> +	INIT_LIST_HEAD(&huge_boot_pages);
>  	return hugetlb_init_hstate(&global_hstate);

I don't think adding the INIT_LIST_HEAD here is correct. There can
be huge pages added by the __setup handlers before hugetlb_init

-Andi
