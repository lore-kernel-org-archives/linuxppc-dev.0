Return-Path: <tnt@246tNt.com>
Message-ID: <41B7156C.2000702@246tNt.com>
Date: Wed, 08 Dec 2004 15:53:32 +0100
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: Dan Malek <dan@embeddededge.com>
References: <48C50EC3-480D-11D9-8A5A-000393DBC2E8@freescale.com>
	<CC280DE6-485F-11D9-AEAC-003065F9B7DC@embeddededge.com>
In-Reply-To: <CC280DE6-485F-11D9-AEAC-003065F9B7DC@embeddededge.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	linux-arm-kernel@lists.arm.linux.org.uk,
	Linux Kernel Development <linux-kernel@vger.kernel.org>,
	Embedded PPC Linux list <linuxppc-embedded@ozlabs.org>
Subject: Re: Second Attempt: Driver model usage on embedded processors
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Dan Malek wrote:

> Why don't you just use the feature_call() model like we currently
> use for PowerPC on the PMac?  Isolate those places in the driver
> that need that information and call the function with a 
> selector/information
> request (and varargs) to get it. 


> For example,
> a driver could:
>
> feature_call(SOC_FTR, Fast_Ethernet1, INIT_IO_PINS);
>
> to configure the IO pins associated with the device, then it could:
>
> feature_call(SOC_FTR, Fast_Ethernet1, GET_CLKS, &txclk, &rxclk);
>
> to get the routing for the transmit and receive clocks, and finally:
>
> feature_call(SOC_FTR, Fast_Ethernet1, GET_PHY_IRQ, &phy_irq);
>
> to get the external interrupt number associated with the PHY.
>

FWIW, I really like this model.

Just as another example, for the I2C driver i2c-mpc, almost the only
variation between model is the clock selection and that forced to put
some processor specific stuff into the driver. With that model, you could
easly avoid theses platform/cpu specific stuff and isolate them.

USB with some really alike bus glues comes to mind too ...

Being able to do "action" in plus of just passing parameters is really nice
IMHO.


    Sylvain
