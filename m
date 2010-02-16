Return-Path: <glikely@secretlab.ca>
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1265813711-16794-2-git-send-email-wg@grandegger.com>
References: <1265813711-16794-1-git-send-email-wg@grandegger.com>
	<1265813711-16794-2-git-send-email-wg@grandegger.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 16 Feb 2010 11:40:35 -0700
Message-ID: <fa686aa41002161040kada217ds1f63d363157e08ab@mail.gmail.com>
Subject: Re: [PATCH v7 1/4] i2c-mpc: use __devinit[data] for initialization
	functions and data
To: Wolfgang Grandegger <wg@grandegger.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Ben Dooks <ben-linux@fluff.org>, Devicetree-discuss@lists.ozlabs.org,
	Linuxppc-dev@lists.ozlabs.org, Linux-i2c@vger.kernel.org,
	Wolfgang Grandegger <wg@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Feb 10, 2010 at 7:55 AM, Wolfgang Grandegger <wg@grandegger.com> wr=
ote:
> From: Wolfgang Grandegger <wg@denx.de>
>
> "__devinit[data]" has not yet been used for all initialization functions
> and data. To avoid truncating lines, the struct "mpc_i2c_match_data" has
> been renamed to "mpc_i2c_data", which is even the better name.
>
> Signed-off-by: Wolfgang Grandegger <wg@denx.de>
> Tested-by: Wolfram Sang <w.sang@pengutronix.de>

Between patch 1 & 2 is not bisectable.  Functions still called
*_setclock in this patch, but referenced as *_setup in the structure.
Please respin.

Also ...

> +static struct mpc_i2c_data mpc_i2c_data_52xx __devinitdata =3D {
> + =A0 =A0 =A0 .setup =3D mpc_i2c_setup_52xx,
> +};
> +
> +static struct mpc_i2c_data mpc_i2c_data_8313 __devinitdata =3D {
> + =A0 =A0 =A0 .setup =3D mpc_i2c_setup_8xxx,
> +};
> +
> +static struct mpc_i2c_data mpc_i2c_data_8543 __devinitdata =3D {
> + =A0 =A0 =A0 .setup =3D mpc_i2c_setup_8xxx,
> + =A0 =A0 =A0 .prescaler =3D 2,
> +};
> +
> +static struct mpc_i2c_data mpc_i2c_data_8544 __devinitdata =3D {
> + =A0 =A0 =A0 .setup =3D mpc_i2c_setup_8xxx,
> + =A0 =A0 =A0 .prescaler =3D 3,
> +};
> +
> =A0static const struct of_device_id mpc_i2c_of_match[] =3D {
> - =A0 =A0 =A0 {.compatible =3D "mpc5200-i2c",
> - =A0 =A0 =A0 =A0.data =3D &(struct mpc_i2c_match_data) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .setclock =3D mpc_i2c_setcl=
ock_52xx,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 },
> - =A0 =A0 =A0 },
> - =A0 =A0 =A0 {.compatible =3D "fsl,mpc5200b-i2c",
> - =A0 =A0 =A0 =A0.data =3D &(struct mpc_i2c_match_data) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .setclock =3D mpc_i2c_setcl=
ock_52xx,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 },
> - =A0 =A0 =A0 },
> - =A0 =A0 =A0 {.compatible =3D "fsl,mpc5200-i2c",
> - =A0 =A0 =A0 =A0.data =3D &(struct mpc_i2c_match_data) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .setclock =3D mpc_i2c_setcl=
ock_52xx,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 },
> - =A0 =A0 =A0 },
> - =A0 =A0 =A0 {.compatible =3D "fsl,mpc8313-i2c",
> - =A0 =A0 =A0 =A0.data =3D &(struct mpc_i2c_match_data) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .setclock =3D mpc_i2c_setcl=
ock_8xxx,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 },
> - =A0 =A0 =A0 },
> - =A0 =A0 =A0 {.compatible =3D "fsl,mpc8543-i2c",
> - =A0 =A0 =A0 =A0.data =3D &(struct mpc_i2c_match_data) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .setclock =3D mpc_i2c_setcl=
ock_8xxx,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .prescaler =3D 2,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 },
> - =A0 =A0 =A0 },
> - =A0 =A0 =A0 {.compatible =3D "fsl,mpc8544-i2c",
> - =A0 =A0 =A0 =A0.data =3D &(struct mpc_i2c_match_data) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .setclock =3D mpc_i2c_setcl=
ock_8xxx,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .prescaler =3D 3,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 },
> + =A0 =A0 =A0 {.compatible =3D "mpc5200-i2c", .data =3D &mpc_i2c_data_52x=
x, },
> + =A0 =A0 =A0 {.compatible =3D "fsl,mpc5200b-i2c", .data =3D &mpc_i2c_dat=
a_52xx, },
> + =A0 =A0 =A0 {.compatible =3D "fsl,mpc5200-i2c", .data =3D &mpc_i2c_data=
_52xx, },
> + =A0 =A0 =A0 {.compatible =3D "fsl,mpc8313-i2c", .data =3D &mpc_i2c_data=
_8313, },
> + =A0 =A0 =A0 {.compatible =3D "fsl,mpc8543-i2c", .data =3D &mpc_i2c_data=
_8543, },
> + =A0 =A0 =A0 {.compatible =3D "fsl,mpc8544-i2c", .data =3D &mpc_i2c_data=
_8544, },

... what was wrong with the old format of declaring the .data
structures inline with the match table?

g.
