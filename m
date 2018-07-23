Return-Path: <BATV+57f4d657a4d3ec61a87c+5447+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41YvsF29dHzDqRM
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Jul 2018 18:33:37 +1000 (AEST)
Date: Mon, 23 Jul 2018 01:18:11 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: PowerPC <linuxppc-dev@lists.ozlabs.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 linux-scsi <linux-scsi@vger.kernel.org>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>
Subject: Re: [PATCH] scsi: prevent ISA driver from building on PPC32
Message-ID: <20180723081811.GA27025@infradead.org>
References: <5928f120-5a23-eff9-6c1d-41344d588b11@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5928f120-5a23-eff9-6c1d-41344d588b11@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Jul 21, 2018 at 12:58:21PM -0700, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Prevent drivers from building on PPC32 if they use isa_bus_to_virt(),
> isa_virt_to_bus(), or isa_page_to_bus(), which are not available and
> thus cause build errors.

Please don't introduce weird arch dependencies, and add a
CONFIG_ISA_VIRT_TO_BUS instead.
