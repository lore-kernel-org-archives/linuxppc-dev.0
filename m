Return-Path: <glikely@secretlab.ca>
Message-ID: <fa686aa40710222024m41045bfbx34e19d83a8f0bfcd@mail.gmail.com>
Date: Mon, 22 Oct 2007 21:24:52 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Device trees and audio codecs
In-Reply-To: <9e4733910710211729k2f2a065cm56670d1b0f90a1af@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <9e4733910710200833x5d1c55b5l2cd400f77c13ec87@mail.gmail.com>
	<a76a128145ec8a8f779727a7e11925ac@kernel.crashing.org>
	<9e4733910710211433r7e0cf4b4sf6aed12c57dda375@mail.gmail.com>
	<5cac8057884ac400b0596988414c7ed7@kernel.crashing.org>
	<9e4733910710211729k2f2a065cm56670d1b0f90a1af@mail.gmail.com>
Cc: PowerPC dev list <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 10/21/07, Jon Smirl <jonsmirl@gmail.com> wrote:
> I have received conflicting opinions as to whether a codec hooked to
> an ac97 bus should get a chip specific codec entry in the device tree.
> Without the codec specific entry only generic ac97 features can be
> used. The Efika has a STA9766. Looking at the data sheet for the chip
> I see that it implements some proprietary functions in addition to the
> standard ones.

You definitely want the codec node on the control bus.  This is
analogous to how Ethernet PHYs are handled.  The PHY nodes are
children of an MDIO node (because that's the control path).  The
ethernet MAC node contains a phandle to the PHY.

In I2S/I2C terms, the CODEC ~= MAC, I2C ~= MDIO and I2S ~= MAC.

In AC97 terms this analogy doesn't work because AC97 doesn't separate
the control and data interfaces.  An AC97 codec is simply a child of
an AC97 controller.

For the MPC5200; the device tree should reflect the required mode.  If
the PSC needs to be in AC97 mode, then the device tree should say
compatible = "fsl,mpc5200b-psc-ac97".  If the PSC needs to be in I2C
mode, then it should be compatible = "fsl,mpc5200b-psc-i2s".  For the
5200 PSCs, the device node not only reflects the hardware (a PSC
core), but also reflects the schematic design (it is wired either as
an I2S bus or an AC97 bus).

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
