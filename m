Return-Path: <gsi@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net
 [IPv6:2001:a60:0:28:0:1:25:1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 9483E2C007E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Aug 2013 17:57:13 +1000 (EST)
Date: Mon, 12 Aug 2013 09:57:06 +0200
From: Gerhard Sittig <gsi@denx.de>
To: Anatolij Gustschin <agust@denx.de>
Subject: Re: [PATCH v4 09/31] powerpc/fsl-pci: improve clock API use
Message-ID: <20130812075706.GC2580@book.gsilab.sittig.org>
References: <1374495298-22019-1-git-send-email-gsi@denx.de>
 <1375821851-31609-1-git-send-email-gsi@denx.de>
 <1375821851-31609-10-git-send-email-gsi@denx.de>
 <20130808221231.6d3046c5@crub>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130808221231.6d3046c5@crub>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Aug 08, 2013 at 22:12 +0200, Anatolij Gustschin wrote:
> 
> On Tue,  6 Aug 2013 22:43:49 +0200
> Gerhard Sittig <gsi@denx.de> wrote:
> ...
> > diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
> > index 46ac1dd..549ff08 100644
> > --- a/arch/powerpc/sysdev/fsl_pci.c
> > +++ b/arch/powerpc/sysdev/fsl_pci.c
> ...
> > +	clk = devm_clk_get(&pdev->dev, "per");
> > +	if (!IS_ERR(clk)) {
> > +		ret = clk_prepare_enable(clk);
> > +		if (ret) {
> > +			dev_err(dev, "Could not enable peripheral clock\n");
> 
> above line will break building. s/dev,/&pdev->dev,/

Thank you for testing and for the feedback.

I've queued this fix for v5.  The bug could hide because the file
gets compiled on MPC512x, but this specific routine sits behind
even more compile time switches (85xx and 86xx related).


virtually yours
Gerhard Sittig
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr. 5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office@denx.de
