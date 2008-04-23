Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id F0D90DDEDF
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Apr 2008 08:09:27 +1000 (EST)
In-Reply-To: <480F8754.7000200@tiscali.nl>
References: <480F6905.3070808@tiscali.nl> <480F8754.7000200@tiscali.nl>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <df21920e067e73985f73047e2d8bcbda@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 2/2] mpic_u3msi: mpic_u3msi: failed allocation unnoticed
Date: Thu, 24 Apr 2008 00:09:21 +0200
To: Roel Kluin <12o3l@tiscali.nl>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org,
	lkml <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> bitmap_find_free_region(), called by mpic_msi_alloc_hwirqs() may
> return -ENOMEM, but hwirq of type irq_hw_number_t which is unsigned.

>  	list_for_each_entry(entry, &pdev->msi_list, list) {
>  		hwirq = mpic_msi_alloc_hwirqs(msi_mpic, 1);
> -		if (hwirq < 0) {
> +		if (hwirq == -ENOMEM) {
>  			pr_debug("u3msi: failed allocating hwirq\n");
>  			return hwirq;
>  		}

Please test for _all_ error values, instead.


Segher
