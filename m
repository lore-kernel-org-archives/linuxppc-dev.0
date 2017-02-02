Return-Path: <bp@alien8.de>
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:120:8448::d00d])
 by lists.ozlabs.org (Postfix) with ESMTP id 3vDn851R63zDqBV
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Feb 2017 04:30:29 +1100 (AEDT)
Date: Thu, 2 Feb 2017 18:30:05 +0100
From: Borislav Petkov <bp@alien8.de>
To: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
 "morbidrsa@gmail.com" <morbidrsa@gmail.com>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] EDAC: mpc85xx: Add T2080 l2-cache support
Message-ID: <20170202173005.gqesvy5owtsbrviu@pd.tnic>
References: <20170201231624.28843-1-chris.packham@alliedtelesis.co.nz>
 <20170201232735.byk7bnpeoqtcc7mh@pd.tnic>
 <01fe1af463c640a8bd48e45c2752b52c@svr-chch-ex1.atlnz.lc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <01fe1af463c640a8bd48e45c2752b52c@svr-chch-ex1.atlnz.lc>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Feb 01, 2017 at 11:46:23PM +0000, Chris Packham wrote:
> >> diff --git a/drivers/edac/mpc85xx_edac.c b/drivers/edac/mpc85xx_edac.c
> >> index 8f66cbed70b7..67f7bc3fe5b3 100644
> >> --- a/drivers/edac/mpc85xx_edac.c
> >> +++ b/drivers/edac/mpc85xx_edac.c
> >> @@ -629,6 +629,7 @@ static const struct of_device_id mpc85xx_l2_err_of_match[] = {
> >>  	{ .compatible = "fsl,p1020-l2-cache-controller", },
> >>  	{ .compatible = "fsl,p1021-l2-cache-controller", },
> >>  	{ .compatible = "fsl,p2020-l2-cache-controller", },
> >> +	{ .compatible = "fsl,t2080-l2-cache-controller", },
> >
> > WARNING: DT compatible string "fsl,t2080-l2-cache-controller" appears un-documented -- check ./Documentation/devicetree/bindings/
> > #58: FILE: drivers/edac/mpc85xx_edac.c:632:
> > +       { .compatible = "fsl,t2080-l2-cache-controller", },
> >
> > What is checkpatch.pl trying to tell me here?
> >
> 
> checpkatch.pl is confused by 
> Documentation/devicetree/bindings/powerpc/fsl/l2cache.txt which says
> 
> - compatible    : Should include "fsl,chip-l2-cache-controller" and "cache"
>                    where chip is the processor (bsc9132, npc8572 etc.)
> 
> So none of the fsl cache controllers pass the checkpatch.pl test.

Hmm, so others do list those names explicitly. For example:

Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt

And the patch that added that check to cp:

bff5da433525 ("checkpatch: add DT compatible string documentation checks")

is basically to enforce explicit compatible names.

So I'd like to have an ACK from a PPC maintainer here first before I
apply this.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
