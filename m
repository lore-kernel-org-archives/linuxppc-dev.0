Return-Path: <lethal@linux-sh.org>
Received: from linux-sh.org (linux-sh.org [111.68.239.195])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id AB3A32C031F
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Mar 2013 13:41:46 +1100 (EST)
Date: Tue, 5 Mar 2013 11:41:12 +0900
From: Paul Mundt <lethal@linux-sh.org>
To: Mike Qiu <qiudayu@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/3] irq: Add hw continuous IRQs map to virtual
 continuous IRQs support
Message-ID: <20130305024110.GB14275@linux-sh.org>
References: <1358235536-32741-1-git-send-email-qiudayu@linux.vnet.ibm.com>
 <1358235536-32741-3-git-send-email-qiudayu@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1358235536-32741-3-git-send-email-qiudayu@linux.vnet.ibm.com>
Cc: tglx@linutronix.de, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jan 15, 2013 at 03:38:55PM +0800, Mike Qiu wrote:
> Adding a function irq_create_mapping_many() which can associate
> multiple MSIs to a continous irq mapping.
> 
> This is needed to enable multiple MSI support for pSeries.
> 
> +int irq_create_mapping_many(struct irq_domain *domain,
> +		irq_hw_number_t hwirq_base, int count)
> +{

Other than the other review comments already made, I think you can
simplify this considerably by simply doing what irq_create_strict_mappings() does,
and relaxing the irq_base requirements.

In any event, as you are creating a new interface, I don't think you want
to carry around half of the legacy crap that irq_create_mapping() has to
deal with. We made the decision to avoid this with irq_create_strict_mappings()
intentionally, too.
