Return-Path: <linuxppc-dev+bounces-26068-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B02DFC5DF9C
	for <linuxppc-dev@archiver.kernel.org>; Mon, 24 Aug 2026 18:50:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hTKj64hcRz2y06;
	Tue, 25 Aug 2026 04:50:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787597402;
	cv=none; b=OapUrHKdRN7jZlD8UUyrMXhGiRKNMBsyZRLhjpOfrSwu6EjGhV0VH3UjYTXO7eCW+SHSG1eRwlVxR2U06xTVwvLhHgD0nlYdXnFEz/FVkf7Lgn4LET6dSHnYjDrll33zQpviHApTvq/dN6iIE/jMpK+bKthiwHIyvd4BG3GO91FCcg1h59IHux7uMNacumxpVJqSMXWAyMyRgn8x+x2hIUvXEWWXs1wCh7yLul0wiQ8i24wIyem2CB9jjkdG214KujbJxVpCXSh/sOhIpx+m3yV+5lLH5kwwcMSwuw/kcWqvz4ja7tR9J1dnXfKfawrOKIXgh/x5D1r28T5qIfMS3A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787597402; c=relaxed/relaxed;
	bh=wv3hSyc7KpV2vcpK4ExKVfFvsrqD+y8hugaEQYXGNOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k+bH32w0O8CGL+HSr6JmFyD0jbslONUWvZPH5/1T6/MYCR/I/SQx/QIQVKosOxmmNs2cH9Xe9n6TaLlJLLCBMzul+O6aql1QNP64r6LAhbumgSj8qGklTtfeIWUMkCe8mZleYZgYIIXgPdxsqIhSmoLJoerTzwbIUJEjTjCAm5qrHwmJePbSAsa3QTptcp7c2vLz+tIUJc7qFWxjRDFYX8LqxWjMThGXD4g2Lti6OPL14BfTImnFlz9rQSPo1gygjjwDeCwH2pynMGuwtapAgLGRl0CXDHb+SdDYbfTvl9RB0pKAodNMDfx+i2tWFH0Y7EeqUWWWC5FeymQwyFg+9Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=FLSzt3qU; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=gautam@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=FLSzt3qU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=gautam@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hTKj535VZz2xZh
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Aug 2026 04:50:00 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67OG1aJR500916;
	Mon, 24 Aug 2026 18:49:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=wv3hSyc7KpV2vcpK4ExKVfFvsrqD+y
	8hugaEQYXGNOo=; b=FLSzt3qUNzOpXHeoMpAVTPku8qkNhLTiieCR4CXFb/wcF5
	tuuL6PPp+1cE5VVFK56uVB5TDpbUGXf8rfiWhH2dKx4iNzAI+nMFczEQlDuUPujq
	X0hBU4pORfHlBJLIKJz8i1eU5DIU+avoTGUheujPXPQNoe+jghO04Y3HJZWemxiE
	K2CLZmUYWvQXV6DhNJyd5fxNEyxPzFV4dX6iDKJ8VhrgvJtK0CatAthxncaiQCYf
	CWhCWN57Kef7ltvJZuJV2LGsZmWl6yyERlICDrwRHKnE4GTX6KLdJ46TJxI8UuMo
	f+dUW+GW96ltCkY8hOf32/s7qAWt3zc6W0eGMMnQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73eqkg3p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Aug 2026 18:49:25 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67OIfJ1a023207;
	Mon, 24 Aug 2026 18:49:24 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7pfw0116-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Aug 2026 18:49:24 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67OInKoM41025926
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Aug 2026 18:49:20 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 00F7F20043;
	Mon, 24 Aug 2026 18:49:20 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E194520040;
	Mon, 24 Aug 2026 18:49:16 +0000 (GMT)
Received: from Gautams-MacBook-Pro.local (unknown [9.124.214.83])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 24 Aug 2026 18:49:16 +0000 (GMT)
Date: Tue, 25 Aug 2026 00:19:13 +0530
From: Gautam Menghani <gautam@linux.ibm.com>
To: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Cc: maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org,
        tpearson@raptorengineering.com, mpe@ellerman.id.au, npiggin@gmail.com,
        chleroy@kernel.org, namcao@linutronix.de, tglx@kernel.org,
        yury.norov@gmail.com, tiwai@suse.de, wangruikang@iscas.ac.cn,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc: pci-ioda: Fix the stale irq chip reference
Message-ID: <aoySKRSGKMXho8Ij@Gautams-MacBook-Pro.local>
References: <178716225364.1437.6201568081502251835.stgit@linux.ibm.com>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178716225364.1437.6201568081502251835.stgit@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: 8hn9C5WobgogztKIAdQUBo3K_wnph8G2
X-Proofpoint-ORIG-GUID: Nd3qSs4oO3usFBvAXrRidJfzCZV8ya7n
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDE1NiBTYWx0ZWRfX719ziVHf6r3h
 ebbbKU/RNqINJ0KtDzKP7wXd2B+/3WSYC7LXdzdismqcxyA4Jr8zBxC1xgsiOWotgNnX+mVo+A+
 M8vhcII3F6yQt9Df86/2ZBkqk+aQE573qVS7bYwWw7A9b1BuAuXwZozWZAbuL1TBK1OXR4Y47iK
 U3liPUOweTTZ49dyPtzhBuyw1Y69Y8luPWnkTS/O7digKDG3zXeVscYi+/evi6mUlc45Ic1KBFN
 69FqqXkhMZG8Z9TOXrFVM+Uv6xMrvW9JgcvB6w3I97b/t1eDaOp/vmbupuGiheT2OQKyvHTmgb6
 GDQnNL91Meb55cmejD/IPRK064mIEd1K73bWiD1SMb0NUYyaKcwn6YEoKv028RpfI4wsm1/W+kp
 BTuhlQjUaiE5FDU2Rx/TwTw/yuuux4VAe3bfwRyRmrsVeXUyU1GLNGsWx3dhcHZbmBRSkygwWBy
 NrC+JO3eQwevWAvML4A==
X-Authority-Analysis: v=2.4 cv=QsRuG1yd c=1 sm=1 tr=0 ts=6a8c9236 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=aqPL-WvAAm6ynEwNJewA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDE1NiBTYWx0ZWRfX/9lYbB7cHCHS
 +jyJmbJNCDglXeiAJn/5/rtYayQSoCJ0SFbJiKTxaTVURFxvQixe5WPhhsbVeBIzKhnDNuyAc95
 kLYm1z2eaJdHjhAfTHtm7Yvsc76MNQw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_05,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 lowpriorityscore=0 clxscore=1011 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240156

On Wed, Aug 19, 2026 at 05:58:22PM +0000, Shivaprasad G Bhat wrote:
> The commit f0ac60e6e311 ("powerpc/powernv/pci: Switch to use
> msi_create_parent_irq_domain()") removed the legacy MSI irq chip
> pnv_pci_msi_irq_chip but left behind the static definition of it and
> its reference in is_pnv_opal_msi().
> 
> The KVM IRQ bypass for vfio devices is broken because the
> comparision in is_pnv_opal_msi() fails on the comparision with
> stale unused variable showing the below errors in dmesg.
> 
>  kvmppc_set_passthru_irq_hv: Could not assign IRQ map for (X,Y)
>  kvmppc_set_passthru_irq (irq X, gsi Y) fails: -2
>  vfio-pci A:B:C.D irq bypass producer (eventfd Z) registration fails: -2
> 
> The patch removes the stale variable definition and fixes the
> is_pnv_opal_msi() by comparing against the chip name prefix.
> 
> Fixes: f0ac60e6e311 ("powerpc/powernv/pci: Switch to use msi_create_parent_irq_domain()")
> Cc: stable@kernel.org
> Signed-off-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
> ---
>  arch/powerpc/platforms/powernv/pci-ioda.c |    6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
> index 32ecbc46e74b..728a5610d167 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -1623,15 +1623,13 @@ int64_t pnv_opal_pci_msi_eoi(struct irq_data *d)
>  	return opal_pci_msi_eoi(phb->opal_id, d->parent_data->hwirq);
>  }
>  
> -static struct irq_chip pnv_pci_msi_irq_chip;
> -
>  /*
>   * Returns true iff chip is something that we could call
>   * pnv_opal_pci_msi_eoi for.
>   */
>  bool is_pnv_opal_msi(struct irq_chip *chip)
>  {
> -	return chip == &pnv_pci_msi_irq_chip;
> +	return chip && chip->name && str_has_prefix(chip->name, "PNV-");
>  }
>  EXPORT_SYMBOL_GPL(is_pnv_opal_msi);
>  
> @@ -1728,7 +1726,7 @@ static const struct msi_parent_ops pnv_msi_parent_ops = {
>  	.chip_flags		= MSI_CHIP_FLAG_SET_EOI,
>  	.bus_select_token	= DOMAIN_BUS_NEXUS,
>  	.bus_select_mask	= MATCH_PCI_MSI,
> -	.prefix			= "PNV-",
> +	.prefix			= "PNV-", /* Note: is_pnv_opal_msi() uses this */
>  	.init_dev_msi_info	= pnv_init_dev_msi_info,
>  };
>  

I boot tested this patch on KVM on PowerNV (P9) and KVM on LPAR (P10),
with the USB controller passed through to the guest.
The warnings are not observed.

Tested-by: Gautam Menghani <gautam@linux.ibm.com>



