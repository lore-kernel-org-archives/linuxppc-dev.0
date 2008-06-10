Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.245])
	by ozlabs.org (Postfix) with ESMTP id 4C315DDF40
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jun 2008 23:26:09 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c34so536708anc.78
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jun 2008 06:26:07 -0700 (PDT)
Message-ID: <fa686aa40806100626t14ee44fnc1108426b73fc7fd@mail.gmail.com>
Date: Tue, 10 Jun 2008 07:26:07 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Juergen Beisert" <jbe@pengutronix.de>
Subject: Re: Comments on device tree for pcm030
In-Reply-To: <200806101105.15080.jbe@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <9e4733910806081208r1a8d0987j6eab0d73bc446640@mail.gmail.com>
	<9e4733910806091430j56aeb06bpa090b0c8242e2041@mail.gmail.com>
	<200806101020.38788.jbe@pengutronix.de>
	<200806101105.15080.jbe@pengutronix.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jun 10, 2008 at 3:05 AM, Juergen Beisert <jbe@pengutronix.de> wrote:
> Maybe everything in this small piece of my dts is wrong. But I don't know how
> the correct way is. All I want is to define a 32MiB flash at the end if the
> address space of my MPC5200B based system.
>
>        [...]
>        lpb@fe000000 {
>                model = "fsl,lpb";
>                compatible = "fsl,lpb";
>                ranges = <0x0 0xfe000000 0x02000000>;

- You need #address-cells and #size-cells in bus nodes.
#address-cells should be <2> in fsl,lpb nodes.  Your ranges property
is broken due to the missing #address/size-cells.

>                flash@0 {
>                        compatible = "cfi-flash";
>                        reg = <0x00000000 0x02000000>;

- since address cells will be '2', you need 2 cells to describe the
base address here; first cell is the chip select, second cell is the
address offset off that base address.

>                        bank-width = <4>;
>                };
>        };
>
> The dtc gives me the follwing output:
>
> Warning (reg_format): "reg" property in /lpb@fe000000/flash@0 has invalid length (8 bytes) (#address-cells == 2, #size-cells == 1)
> Warning (ranges_format): "ranges" property in /lpb@fe000000 has invalid length (12 bytes) (parent #address-cells == 1, child #address-cells == 2, #size-cells == 1)
> Warning (avoid_default_addr_size): Relying on default #address-cells value for /lpb@fe000000/flash@0
> Warning (avoid_default_addr_size): Relying on default #size-cells value for /lpb@fe000000/flash@0
>
> What does it mean?
>
> At runtime I get:
>
> [...]
> of-flash fe000000.flash: of_flash device: fe000000-ffffffff
> CFI: Found no fe000000.flash device at location zero
> of-flash fe000000.flash: do_map_probe() failed
> [...]
>
> What's going wrong? Any hint?
>
> Regards,
> Juergen
>
> --
> Dipl.-Ing. Juergen Beisert | http://www.pengutronix.de
>  Pengutronix - Linux Solutions for Science and Industry
>     Handelsregister: Amtsgericht Hildesheim, HRA 2686
>          Vertretung Sued/Muenchen, Germany
>   Phone: +49-8766-939 228 |  Fax: +49-5121-206917-9
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>



-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
