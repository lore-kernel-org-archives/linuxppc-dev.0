Return-Path: <SRS0=eeko=PU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 190EFC43387
	for <linuxppc-dev@archiver.kernel.org>; Sat, 12 Jan 2019 07:36:36 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A63A72086C
	for <linuxppc-dev@archiver.kernel.org>; Sat, 12 Jan 2019 07:36:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A63A72086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43cBPW5JlWzDr7B
	for <linuxppc-dev@archiver.kernel.org>; Sat, 12 Jan 2019 18:36:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=permerror (mailfrom)
 smtp.mailfrom=kernel.crashing.org (client-ip=63.228.1.57;
 helo=gate.crashing.org; envelope-from=segher@kernel.crashing.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=kernel.crashing.org
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43cBMn67YXzDr49
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Jan 2019 18:35:01 +1100 (AEDT)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x0C7YkSM025561;
 Sat, 12 Jan 2019 01:34:47 -0600
Received: (from segher@localhost)
 by gate.crashing.org (8.14.1/8.14.1/Submit) id x0C7Ygbh025551;
 Sat, 12 Jan 2019 01:34:42 -0600
X-Authentication-Warning: gate.crashing.org: segher set sender to
 segher@kernel.crashing.org using -f
Date: Sat, 12 Jan 2019 01:34:42 -0600
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] powerpc/powernv/npu: Allocate enough memory in
 pnv_try_setup_npu_table_group()
Message-ID: <20190112073441.GJ14180@gate.crashing.org>
References: <20190109102328.GB5476@kadam> <20190112003035.GA10427@350D>
 <20190112054426.GF1743@kadam>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190112054426.GF1743@kadam>
User-Agent: Mutt/1.4.2.3i
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alistair Popple <alistair@popple.id.au>,
 Mark Hairgrove <mhairgrove@nvidia.com>, kernel-janitors@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sat, Jan 12, 2019 at 08:44:26AM +0300, Dan Carpenter wrote:
> On Sat, Jan 12, 2019 at 11:30:35AM +1100, Balbir Singh wrote:
> > On Wed, Jan 09, 2019 at 01:23:29PM +0300, Dan Carpenter wrote:
> > > There is a typo so we accidentally allocate enough memory for a pointer
> > > when we wanted to allocate enough for a struct.
> > > 
> > > Fixes: 0bd971676e68 ("powerpc/powernv/npu: Add compound IOMMU groups")
> > > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > > ---
> > >  arch/powerpc/platforms/powernv/npu-dma.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/arch/powerpc/platforms/powernv/npu-dma.c b/arch/powerpc/platforms/powernv/npu-dma.c
> > > index d7f742ed48ba..3f58c7dbd581 100644
> > > --- a/arch/powerpc/platforms/powernv/npu-dma.c
> > > +++ b/arch/powerpc/platforms/powernv/npu-dma.c
> > > @@ -564,7 +564,7 @@ struct iommu_table_group *pnv_try_setup_npu_table_group(struct pnv_ioda_pe *pe)
> > >  		}
> > >  	} else {
> > >  		/* Create a group for 1 GPU and attached NPUs for POWER8 */
> > > -		pe->npucomp = kzalloc(sizeof(pe->npucomp), GFP_KERNEL);
> > > +		pe->npucomp = kzalloc(sizeof(*pe->npucomp), GFP_KERNEL);
> > 
> > To avoid these in the future, I wonder if instead of sizeof(pe->npucomp), we insist on
> > sizeof structure
> > 
> > pe->npucomp = kzalloc(sizeof(struct npucomp), GFP_KERNEL);
> > 
> 
> The latest kernel fashion is sizeof(*ptr).  It can go wrong either way.
> I don't have strong feelings about it.  These sorts of bugs don't last
> long because they're caught in testing or with static analysis.

And it is easy to see someone forgot the * in "sizeof *ptr", and with
experience it will just automatically look wrong if it is forgotten; but
it isn't obvious at all if the wrong struct is used, which cannot happen
with the *ptr form, but happens frequently with the "sizeof(struct x)"
form.


Segher
