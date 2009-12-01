Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8DAF9B7BC0
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  1 Dec 2009 18:29:59 +1100 (EST)
Subject: Re: [PATCH 4/5] libata/sff: Use ops->bmdma_stop instead of
	ata_bmdma_stop()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Tejun Heo <tj@kernel.org>
In-Reply-To: <4B14C4DC.6060107@kernel.org>
References: <20091201070833.CC084B7BD9@ozlabs.org>
	<4B14C4DC.6060107@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 01 Dec 2009 18:29:05 +1100
Message-ID: <1259652545.2076.321.camel@pasglop>
Mime-Version: 1.0
Cc: linux-ide@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, jeff@garzik.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2009-12-01 at 16:25 +0900, Tejun Heo wrote:
> On 12/01/2009 04:08 PM, Benjamin Herrenschmidt wrote:
> > In libata-sff, ata_sff_post_internal_cmd() directly calls ata_bmdma_stop()
> > instead of ap->ops->bmdma_stop(). This can be a problem for controllers
> > that use their own bmdma_stop for which the generic sff one isn't suitable
> > 
> > Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> 
> Oh... that's a scary bug lurking around.  Thanks for catching it.
> 
> Acked-by: Tejun Heo <tj@kernel.org>

Feel free to pick that one up earlier if you want (ie for 2.6.32), as
long as we manage to get it in in 2.6.33 -before- I push powerpc-next to
Linus, I'm happy :-) (or we can have it in both trees).

Cheers,
Ben.
