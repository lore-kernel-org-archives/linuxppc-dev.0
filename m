Return-Path: <khali@linux-fr.org>
Date: Thu, 7 Aug 2008 10:21:26 +0200
From: Jean Delvare <khali@linux-fr.org>
To: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: [PATCH] i2c-mpc: suppress I2C device probing
Message-ID: <20080807102126.5980c761@hyperion.delvare>
In-Reply-To: <fa686aa40807171102k6f638d9dn6dca86706673fde1@mail.gmail.com>
References: <487F20EC.9040503@grandegger.com>
	<fa686aa40807171102k6f638d9dn6dca86706673fde1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Grant, Wolgang,

On Thu, 17 Jul 2008 12:02:50 -0600, Grant Likely wrote:
> On Thu, Jul 17, 2008 at 4:37 AM, Wolfgang Grandegger <wg@grandegger.com> wrote:
> > This patch suppresses I2C device probing by clearing the class field
> > of the "struct i2c_adapter" for the MPC I2C bus adapters. Some board
> > configurations which rely on probing must be fixed up by adding a
> > proper I2C device node to the DTS file, like the TQM85xx modules.
> >
> > Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
> Acked-by: Grant Likely <grant.likely@secretlab.ca>
> 
> > ---
> > drivers/i2c/busses/i2c-mpc.c |    1 -
> > 1 file changed, 1 deletion(-)
> >
> > Index: powerpc/drivers/i2c/busses/i2c-mpc.c
> > ===================================================================
> > --- powerpc.orig/drivers/i2c/busses/i2c-mpc.c
> > +++ powerpc/drivers/i2c/busses/i2c-mpc.c
> > @@ -312,7 +312,6 @@ static struct i2c_adapter mpc_ops = {
> >        .name = "MPC adapter",
> >        .id = I2C_HW_MPC107,
> >        .algo = &mpc_algo,
> > -       .class = I2C_CLASS_HWMON | I2C_CLASS_SPD,
> >        .timeout = 1,
> > };

Unless you intend to push this patch upstream yourself (through the ppc
tree), you should send it to Ben Dooks (who is in charge of this part
of the i2c subsystem) with Cc to the i2c list.

-- 
Jean Delvare
