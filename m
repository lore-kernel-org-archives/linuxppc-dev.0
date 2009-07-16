Return-Path: <glikely@secretlab.ca>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 24422B709C
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 17 Jul 2009 08:44:45 +1000 (EST)
Received: from mail-gx0-f216.google.com (mail-gx0-f216.google.com
	[209.85.217.216]) by ozlabs.org (Postfix) with ESMTP id 77983DDD0C
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Jul 2009 08:44:43 +1000 (EST)
Received: by gxk12 with SMTP id 12so822429gxk.9
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Jul 2009 15:44:41 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1247780546-4426-1-git-send-email-wd@denx.de>
References: <1247671133-12148-1-git-send-email-wd@denx.de>
	<1247780546-4426-1-git-send-email-wd@denx.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 16 Jul 2009 16:44:21 -0600
Message-ID: <fa686aa40907161544je92317dy7abea6819746847@mail.gmail.com>
Subject: Re: [PATCH 1/2 v4] fs_enet/mii-fec.c: fix MII speed calculation
To: Wolfgang Denk <wd@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jul 16, 2009 at 3:42 PM, Wolfgang Denk<wd@denx.de> wrote:
> The MII speed calculation was based on the CPU clock (ppc_proc_freq),
> but for MPC512x we must use the bus clock instead.
>
> This patch makes it use the correct clock and makes sure we don't
> clobber reserved bits in the MII_SPEED register.
>
> Signed-off-by: Wolfgang Denk <wd@denx.de>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: Kumar Gala <galak@kernel.crashing.org>
> Cc: <netdev@vger.kernel.org>

Looks good to me.  Thanks for the work!

I assume this is tested.  I have not tested this on my board, and I've
got one question below, but otherwise I think I can say....
Acked-by: Grant Likely <grant.likely@secretlab.ca>

> - =A0 =A0 =A0 fec->mii_speed =3D ((ppc_proc_freq + 4999999) / 5000000) <<=
 1;
> + =A0 =A0 =A0 if (get_bus_freq) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clock =3D get_bus_freq(ofdev->node);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!clock) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&ofdev->dev, "could=
 not determine IPS/IPB clock\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out_unmap_regs;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 } else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clock =3D ppc_proc_freq;
> +
> + =A0 =A0 =A0 /* scale for a MII clock <=3D 2.5 MHz */
> + =A0 =A0 =A0 speed =3D (clock + 2499999) / 2500000;

The calculation has changed here for non mpc5121 users.  Shouldn't the
"clock =3D ppc_proc_freq;" line above be "clock =3D ppc_proc_freq / 2;"?
Or was this also a bug in the original driver?

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
