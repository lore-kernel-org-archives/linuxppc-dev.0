Return-Path: <tj@kernel.org>
Received: from hera.kernel.org (hera.kernel.org [140.211.167.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id F2919B6EF7
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  1 Dec 2009 18:25:14 +1100 (EST)
Message-ID: <4B14C4DC.6060107@kernel.org>
Date: Tue, 01 Dec 2009 16:25:16 +0900
From: Tejun Heo <tj@kernel.org>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 4/5] libata/sff: Use ops->bmdma_stop instead of
	ata_bmdma_stop()
References: <20091201070833.CC084B7BD9@ozlabs.org>
In-Reply-To: <20091201070833.CC084B7BD9@ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-ide@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, jeff@garzik.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/01/2009 04:08 PM, Benjamin Herrenschmidt wrote:
> In libata-sff, ata_sff_post_internal_cmd() directly calls ata_bmdma_stop()
> instead of ap->ops->bmdma_stop(). This can be a problem for controllers
> that use their own bmdma_stop for which the generic sff one isn't suitable
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Oh... that's a scary bug lurking around.  Thanks for catching it.

Acked-by: Tejun Heo <tj@kernel.org>

-- 
tejun
