Return-Path: <jeremy@goop.org>
Received: from claw.goop.org (claw.goop.org [74.207.240.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.goop.org", Issuer "Goop.org CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 5C11DDDDFA
	for <linuxppc-dev@ozlabs.org>; Sat, 30 May 2009 07:09:25 +1000 (EST)
Message-ID: <4A204EFC.501@goop.org>
Date: Fri, 29 May 2009 14:09:16 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
MIME-Version: 1.0
To: Ian Campbell <ian.campbell@citrix.com>
Subject: Re: [PATCH 6/9] swiotlb: use dma_to_phys and phys_to_dma
References: <1243586643-5554-1-git-send-email-ian.campbell@citrix.com>
	<1243586643-5554-7-git-send-email-ian.campbell@citrix.com>
In-Reply-To: <1243586643-5554-7-git-send-email-ian.campbell@citrix.com>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Cc: x86@kernel.org, Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org,
	Olaf Kirch <okir@suse.de>, Greg KH <gregkh@suse.de>,
	linux-kernel@vger.kernel.org,
	FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Ian Campbell wrote:
> static dma_addr_t swiotlb_virt_to_bus(struct device *hwdev,
>  				      volatile void *address)
>  {
> -	return swiotlb_phys_to_bus(hwdev, virt_to_phys(address));
> +	return phys_to_dma(hwdev, virt_to_phys(address));
>  }
>  
>  void * __weak swiotlb_bus_to_virt(struct device *hwdev, dma_addr_t address)
>   

Does this need to be weak too?

    J
