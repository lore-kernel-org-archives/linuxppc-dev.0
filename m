Return-Path: <wd@denx.de>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 796CFB708B
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 17 Jul 2009 22:32:48 +1000 (EST)
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 06723DDD0B
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Jul 2009 22:32:48 +1000 (EST)
To: Wolfram Sang <w.sang@pengutronix.de>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: [PATCH 1/2 v4] fs_enet/mii-fec.c: fix MII speed calculation
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: <20090717093307.GB3150@pengutronix.de>
References: <1247671133-12148-1-git-send-email-wd@denx.de>
	<1247780546-4426-1-git-send-email-wd@denx.de>
	<20090717093307.GB3150@pengutronix.de>
Date: Fri, 17 Jul 2009 14:32:45 +0200
Message-Id: <20090717123245.4595F832E416@gemini.denx.de>
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Dear Wolfram Sang,

In message <20090717093307.GB3150@pengutronix.de> you wrote:
> 
...
> > @@ -188,6 +209,12 @@ static struct of_device_id fs_enet_mdio_fec_match[] = {
> >  	{
> >  		.compatible = "fsl,pq1-fec-mdio",
> >  	},
> > +#if defined(CONFIG_PPC_MPC512x)
> > +	{
> > +		.compatible = "fsl,mpc5121-fec-mdio",
> > +		.data = mpc5xxx_get_bus_frequency,
> > +	},
> > +#endif
>
> Grepping through 'drivers/*' I see that #ifdefing compatible-entries is highly
> uncommon (just 3 hits). I think a guideline would be useful. Most people like
> to avoid #ifdefs at any cost, while I personally think it doesn't spoil
> readability too much here. Other opinions?

An older version of the patch tried to "hide" the ifdef in a 512x
specific header, so at least common code would remain clean, but I
agree with Grant that this current version looks cleaner globally.

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
"You can have my Unix system when you  pry  it  from  my  cold,  dead
fingers."                                                - Cal Keegan
