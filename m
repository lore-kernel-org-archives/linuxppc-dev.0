Return-Path: <grant.likely@secretlab.ca>
Received: from mail-ea0-x235.google.com (mail-ea0-x235.google.com
 [IPv6:2a00:1450:4013:c01::235])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9E8D52C029B
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Jun 2013 09:03:17 +1000 (EST)
Received: by mail-ea0-f181.google.com with SMTP id a11so1809223eae.26
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Jun 2013 16:03:11 -0700 (PDT)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 1/3] irq: Set multiple MSI descriptor data for multiple
 IRQs
To: Mike Qiu <qiudayu@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <1358235536-32741-2-git-send-email-qiudayu@linux.vnet.ibm.com>
References: <1358235536-32741-1-git-send-email-qiudayu@linux.vnet.ibm.com>
 <1358235536-32741-2-git-send-email-qiudayu@linux.vnet.ibm.com>
Date: Thu, 06 Jun 2013 00:03:08 +0100
Message-Id: <20130605230308.8CC093E10E4@localhost>
Cc: tglx@linutronix.de, Mike Qiu <qiudayu@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 15 Jan 2013 15:38:54 +0800, Mike Qiu <qiudayu@linux.vnet.ibm.com> wrote:
> Multiple MSI only requires the IRQ in msi_desc entry to be set as
> the value of irq_base.
> 
> This patch implements the above mentioned technique.
> 
> Signed-off-by: Mike Qiu <qiudayu@linux.vnet.ibm.com>

Hi Mike,

question below...

> ---
> +int irq_set_multiple_msi_desc(unsigned int irq_base, unsigned int nvec,
> +				struct msi_desc *entry)
> +{
> +	unsigned long flags, i;
> +	struct irq_desc *desc;
> +
> +	for (i = 0; i < nvec; i++) {
> +		desc = irq_get_desc_lock(irq_base + i, &flags,
> +					IRQ_GET_DESC_CHECK_GLOBAL);
> +		if (!desc)
> +			return -EINVAL;
> +		desc->irq_data.msi_desc = entry;
> +		if (i == 0 && entry)
> +			entry->irq = irq_base;

It's not clear to me why this code only sets the irq value for the first
desc. Why don't the other descs in the array want (irq_base + i) here? A
comment describing what is going on would be appropriate and helpful.

g.
