Return-Path: <Poonam.Aggrwal@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 10EF4DDE03
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Dec 2007 16:58:39 +1100 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	lBH5shH6010639
	for <linuxppc-dev@ozlabs.org>; Sun, 16 Dec 2007 22:58:35 -0700 (MST)
Received: from zin33exm24.fsl.freescale.net (zin33exm24.ap.freescale.net
	[10.232.192.24])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id lBH5sfmq006378
	for <linuxppc-dev@ozlabs.org>; Sun, 16 Dec 2007 23:54:42 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH 2/3] arch/ : Platform changes for UCC TDM driver for
	MPC8323ERDB.Also includes related QE changes.
Date: Mon, 17 Dec 2007 11:24:40 +0530
Message-ID: <FBA61160C48B8D438F3323FEFB4EF2C2610FFB@zin33exm24.fsl.freescale.net>
In-Reply-To: <20071211111855.dc5276a2.sfr@canb.auug.org.au>
References: <Pine.LNX.4.64.0712101734490.29623@linux121>
	<20071211111855.dc5276a2.sfr@canb.auug.org.au>
From: "Aggrwal Poonam" <Poonam.Aggrwal@freescale.com>
To: "Stephen Rothwell" <sfr@canb.auug.org.au>
Cc: Barkowski Michael <Michael.Barkowski@freescale.com>, netdev@vger.kernel.org,
	Gala Kumar <kumar.gala@freescale.com>,
	linux-kernel@vger.kernel.org, rubini@vision.unipv.it,
	linuxppc-dev@ozlabs.org, Kalra Ashish <ashish.kalra@freescale.com>,
	Cutler Richard <Rich.Cutler@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Thanks Stephen for your comments.
I have gone through them.
Shall incorporate them and repost the patch.

Sorry for late reply as I was on leave for the last week.=20


With Regards
Poonam=20
=20
=20

-----Original Message-----
From: Stephen Rothwell [mailto:sfr@canb.auug.org.au]=20
Sent: Tuesday, December 11, 2007 5:49 AM
To: Aggrwal Poonam
Cc: rubini@vision.unipv.it; linux-kernel@vger.kernel.org;
netdev@vger.kernel.org; Gala Kumar; linuxppc-dev@ozlabs.org; Barkowski
Michael; Cutler Richard; Kalra Ashish
Subject: Re: [PATCH 2/3] arch/ : Platform changes for UCC TDM driver for
MPC8323ERDB.Also includes related QE changes.

On Mon, 10 Dec 2007 17:39:22 +0530 (IST) Poonam_Aggrwal-b10812
<b10812@freescale.com> wrote:
>
> +++ b/arch/powerpc/sysdev/qe_lib/qe.c
> @@ -149,22 +149,116 @@ EXPORT_SYMBOL(qe_issue_cmd);
>   */
>  static unsigned int brg_clk =3D 0;
> =20
> -unsigned int get_brg_clk(void)
> +u32 get_brg_clk(enum qe_clock brgclk, enum qe_clock *brg_source)
>  {
> -	struct device_node *qe;
> -	if (brg_clk)
> -		return brg_clk;
> +	struct device_node *qe, *brg, *clocks;
> +	enum qe_clock brg_src;
> +	u32 brg_input_freq =3D 0;
> +	u32 brg_num;
> +	const unsigned int *prop;
> =20
> -	qe =3D of_find_node_by_type(NULL, "qe");
> -	if (qe) {
> +	*brg_source =3D 0;
> +
> +	brg_num =3D brgclk - QE_BRG1;
> +	brg =3D of_find_compatible_node(NULL, NULL, "fsl,cpm-brg");
> +	if (brg) {
>  		unsigned int size;
> -		const u32 *prop =3D of_get_property(qe, "brg-frequency",
&size);
> -		brg_clk =3D *prop;
> -		of_node_put(qe);
> -	};
> +		prop =3D of_get_property(brg,
> +					"fsl,brg-sources", &size);
> +
> +		brg_src =3D *(prop + brg_num);

You should probably sanity check that prop is not NULL and points to
something large enough.

You don't use brg after here, so the "of_node_put(brg)" could go here to
save putting it in multiple places later.  Also, currently there are
paths through the following code that do not do the of_node_put(brg).

> +		if (brg_src =3D=3D 0) {
> +			*brg_source =3D 0;
> +			if (brg_clk > 0) {
> +				of_node_put(brg);
> +				return brg_clk;
> +			}
> +			qe =3D of_find_node_by_type(NULL, "qe");
> +			if (qe) {
> +				unsigned int size;
> +				prop =3D of_get_property
> +						(qe, "brg-frequency",
&size);
> +				of_node_put(qe);
> +				of_node_put(brg);
> +				return *prop;

NULL check here (yes, I know that the old code didn't check).

> +			}
> +		} else {
> +			*brg_source =3D brg_src + QE_CLK1 - 1;
> +			clocks =3D of_find_compatible_node(NULL, NULL,
> +
"fsl,cpm-clocks");
> +			prop =3D of_get_property(clocks,
> +						"#clock-cells", &size);
> +			/*
> +			 * clock-cells =3D 1 only supported right now.
> +			 */
> +			if (*prop !=3D 1)

Again check for NULL (and possibly size).

> +				return 0;
> +			prop =3D of_get_property(clocks,
> +						"clock-frequency",
&size);
> +
> +			brg_input_freq =3D *(prop+(brg_src - 1));

And again.

> +			of_node_put(clocks);
> +			of_node_put(brg);
> +			return brg_input_freq;
> +		}
> +	}
>  	return brg_clk;
>  }
--
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
