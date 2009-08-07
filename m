Return-Path: <glikely@secretlab.ca>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 78C83B7080
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  8 Aug 2009 02:24:27 +1000 (EST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <9e4733910908070903p539b8987p8351df5b3d328fdd@mail.gmail.com>
References: <9e4733910908070903p539b8987p8351df5b3d328fdd@mail.gmail.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Fri, 7 Aug 2009 10:15:47 -0600
Message-ID: <fa686aa40908070915x7e04cbb8ofccd106230d5f76c@mail.gmail.com>
Subject: Re: PSC clock divider
To: Jon Smirl <jonsmirl@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Aug 7, 2009 at 10:03 AM, Jon Smirl<jonsmirl@gmail.com> wrote:
> mpc52xx_set_psc_clkdiv() has problems. It take the clk divider as a
> parameter. But this divisor is not always gettting calculated
> correctly. My code in i2s was doing it wrong.
>
> Take this snippet from the SPI driver, it just assumes a fsystem of
> 512Mhz. fsystem is 533Mhz on my boards.
>
> =A0 =A0 =A0 =A0/* default sysclk is 512MHz */
> =A0 =A0 =A0 =A0mclken_div =3D (mps->sysclk ? mps->sysclk : 512000000) / M=
CLK;
> =A0 =A0 =A0 =A0mpc52xx_set_psc_clkdiv(psc_id, mclken_div);
>
> Is it also not accounting for the hardware adding one to the divisor.
>
> I've change i2s to this:
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!fsystem) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0np =3D of_=
find_matching_node(NULL, mpc52xx_cdm_ids);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mpc52xx_cd=
m =3D of_iomap(np, 0);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0fsystem =
=3D mpc5xxx_get_bus_frequency(np);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0of_node_pu=
t(np);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0val =3D in=
_be32(&mpc52xx_cdm->rstcfg);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (val & =
(1 << 5))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0fsystem *=3D 8;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0fsystem *=3D 4;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0iounmap(mp=
c52xx_cdm);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0clkdiv =3D fsystem / freq;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D fsystem % freq;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (err > freq / 2)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0clkdiv++;
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_dbg(psc_dma->dev, "psc=
_i2s_set_sysclk(clkdiv %d freq error=3D%dHz)\n",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0clkdiv, (fsystem / clkdiv - freq));
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* PSC is 1-6 */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Hardware adds 1 to divi=
sor */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return mpc52xx_set_psc_clk=
div(psc_dma->id + 1, clkdiv - 1);
>
>
> Should I modify mpc52xx_set_psc_clkdiv() to take in a frequency and
> them move this code into mpc52xx_common.c? That allows the sysclk
> parameter to be eliminated for SPI.

Yes, please do.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
