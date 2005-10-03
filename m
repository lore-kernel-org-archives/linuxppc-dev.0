Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 5233868423
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  4 Oct 2005 02:16:08 +1000 (EST)
Date: Mon, 3 Oct 2005 09:15:59 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: "Ruslan V. Sushko" <rsushko@ru.mvista.com>
Message-ID: <20051003161559.GA21682@gate.ebshome.net>
References: <1128328568.21396.7.camel@mephisto.spb.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1128328568.21396.7.camel@mephisto.spb.rtsoft.ru>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH 2/3][PPC32] PCI-X support for Yucca
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon, Oct 03, 2005 at 12:36:08PM +0400, Ruslan V. Sushko wrote:
> This patch adds PCIX support for Yucca PPC440SPe board. The patch is
> implemented for Roland Dreier git tree for Yucca PPC440SPe board.
> 
> Signed-off-by: Ruslan V. Sushko <rsushko@ru.mvista.com>

[snip]

> +                mtdcr(DCRN_UIC_PR(UIC1), 
> +                mfdcr(DCRN_UIC_PR(UIC1)) & ~0x00004000); /* Set PCI interrupt
> +                                                            (EXT IRQ12) plarity
> +                                                            to Negative */

Don't mess with UIC registers directly. Take a look how this type of 
setup is done in other 4xx ports (e.g. Ebony) and use the same 
approach (hint: ppc4xx_uic_ext_irq_cfg).

-- 
Eugene
