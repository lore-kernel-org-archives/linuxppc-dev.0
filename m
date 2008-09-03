Return-Path: <scottwood@freescale.com>
Date: Wed, 3 Sep 2008 12:12:25 -0500
From: Scott Wood <scottwood@freescale.com>
To: Gary Thomas <gary@mlbassoc.com>
Subject: Re: More DTS questions
Message-ID: <20080903171225.GB10979@loki.buserror.net>
References: <48BE92C0.2020205@mlbassoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <48BE92C0.2020205@mlbassoc.com>
Cc: Linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Sep 03, 2008 at 07:36:00AM -0600, Gary Thomas wrote:
>         pci@f0000d00 {
>                 #interrupt-cells = <1>;
>                 #size-cells = <2>;
>                 #address-cells = <3>;
>                 device_type = "pci";
>                 compatible = "fsl,mpc5200-pci";
>                 reg = <0xf0000d00 0x100>;
>                 interrupt-map-mask = <0xf800 0 0 7>;
>                 interrupt-map = <0xc000 0 0 1 &mpc5200_pic 0 0 3
>                                  0xc000 0 0 2 &mpc5200_pic 0 0 3
>                                  0xc000 0 0 3 &mpc5200_pic 0 0 3
>                                  0xc000 0 0 4 &mpc5200_pic 0 0 3>;
>                 clock-frequency = <0>; // From boot loader
>                 interrupts = <2 8 0 2 9 0 2 10 0>;
>                 interrupt-parent = <&mpc5200_pic>;
>                 bus-range = <0 0>;
>                 ranges = <0x42000000 0 0x80000000 0x80000000 0 0x10000000
>                           0x02000000 0 0x90000000 0x90000000 0 0x10000000
>                           0x01000000 0 0x00000000 0xa0000000 0 0x01000000>;
>         };
>
> The things that truly aren't clear are the various lists.
> For example, how does "interrupt-map" and "interrupts" describe
> how the interrupts are handled? 

It is described in this document:
http://www.power.org/resources/downloads/Power_ePAPR_APPROVED_v1.0.pdf

> I don't see any reference in the code to these names (how does a driver
> get access to such properties?)

Look in arch/powerpc/kernel/prom_parse.c.

You'll want to change &mpc5200_pic in your interrupt-map to point to your
FPGA interrupt controller, and change the interrupt specifiers accordingly.

-Scott
