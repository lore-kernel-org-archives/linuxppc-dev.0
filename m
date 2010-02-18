Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 86843B7CF4
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Feb 2010 19:10:49 +1100 (EST)
In-Reply-To: <1266433154.2322.0@antares>
References: <1266433154.2322.0@antares>
Subject: Re: [Patch v2 1/2] 5200/mpc: improve i2c bus error recovery
To: =?ISO-8859-15?Q?Albrecht_Dre=DF?= <albrecht.dress@arcor.de>
Message-ID: <OF3D88A7A0.9A4F1639-ONC12576CE.002C0FB9-C12576CE.002CCBBB@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Thu, 18 Feb 2010 09:09:17 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-15
Cc: Linux PPC Development <linuxppc-dev@ozlabs.org>,
	Devicetree Discussions <devicetree-discuss@lists.ozlabs.org>,
	"Ben Dooks \(embedded platforms\)" <ben-linux@fluff.org>,
	"Ira W. Snyder" <iws@ovro.caltech.edu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>
> This patch improves the recovery of the MPC's I2C bus from errors lik=
e bus
> hangs resulting in timeouts:
> 1. make the bus timeout configurable, as it depends on the bus clock =
and
>     the attached slave chip(s); default is still 1 second;
> 2. detect any of the cases indicated by the CF, BB and RXAK MSR flags=
 if a
>     timeout occurs, and add a missing (required) MAL reset;
> 3. use a more reliable method to fixup the bus if a hang has been det=
ected.
>     The sequence is sent 9 times which seems to be necessary if a sla=
ve
>     "misses" more than one clock cycle.  For 400 kHz bus speed, the f=
ixup is
>     also ~70us (81us vs. 150us) faster.
>
> Tested on a custom Lite5200b derived board, with a Dallas RTC, AD sen=
sors
> and NXP IO expander chips attached to the i2c.
>
> Changes vs. v1:
> - use improved bus fixup sequence for all chips (not only the 5200)
> - calculate real clock from defaults if no clock is given in the devi=
ce tree
> - better description (I hope) of the changes.
>
> I didn't split the changes in this file into three parts as recommend=
ed by
> Grant, as they actually belong together (i.e. they address one single=

> problem, just in three places of one single source file).
>
> Signed-off-by: Albrecht Dre=DF <albrecht.dress@arcor.de>
>
> ---
>
> Note about the reset sequence: I verified the waveforms for 18.4kHz, =
85.9kHz
> and 375kHz (drop me a note if you want to see scope screen shots).  N=
ot
> verified on other mpc chips yet.
> @Ira: thanks in advance for giving it a try on your box!

Does this reset sequence also send a START condition for every clock?
The ideal I2C reset sequence should look like this:

	for(j =3D 0; j < 9; j++) {
		if(I2C_READ)
			send_start();
		I2C_SCL(0);
		I2C_DELAY;
		I2C_TRISTATE;
		I2C_SDA(1);
		I2C_DELAY;
		I2C_SCL(1);
		I2C_DELAY;
		I2C_DELAY;
	}
	send_stop();

static void send_start(void)
{
	I2C_DELAY;
	I2C_TRISTATE;
	I2C_SDA(1);
	I2C_DELAY;
	I2C_SCL(1);
	I2C_DELAY;
	I2C_SDA(0);
	I2C_ACTIVE;
	I2C_DELAY;
}

static void send_stop(void)
{
	I2C_SCL(0);
	I2C_DELAY;
	I2C_SDA(0);
	I2C_ACTIVE;
	I2C_DELAY;
	I2C_SCL(1);
	I2C_DELAY;
	I2C_TRISTATE;
	I2C_SDA(1);
	I2C_DELAY;
}

 Jocke=
