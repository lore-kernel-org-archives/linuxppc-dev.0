Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.242])
	by ozlabs.org (Postfix) with ESMTP id F3367DDE32
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jan 2008 06:26:14 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so1531908anc.78
	for <linuxppc-dev@ozlabs.org>; Mon, 07 Jan 2008 11:26:13 -0800 (PST)
Message-ID: <fa686aa40801071126o1dd9798eub6006e1f0f33797f@mail.gmail.com>
Date: Mon, 7 Jan 2008 12:26:13 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Jon Loeliger" <jdl@jdl.com>
Subject: Re: [RFC PATCH 1/3] Add StorCenter DTS first draft.
In-Reply-To: <E1JBwBQ-0006Iy-54@jdl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <E1JBwBQ-0006Iy-54@jdl.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 1/7/08, Jon Loeliger <jdl@jdl.com> wrote:
> Based on the Kurobox DTS files.
>
> Signed-off-by: Andy Wilcox <andy@protium.com>
> Signed-off-by: Jon Loeliger <jdl@jdl.com>
> ---
>
> Ignore the flash bits.  They are from the previous
> World View and need to be updated still.
>
>  arch/powerpc/boot/dts/storcenter.dts |  159 ++++++++++++++++++++++++++++++++++
>  1 files changed, 159 insertions(+), 0 deletions(-)
>  create mode 100644 arch/powerpc/boot/dts/storcenter.dts
>
> diff --git a/arch/powerpc/boot/dts/storcenter.dts b/arch/powerpc/boot/dts/storcenter.dts
> new file mode 100644
> index 0000000..68887ac
> --- /dev/null
> +++ b/arch/powerpc/boot/dts/storcenter.dts
> @@ -0,0 +1,159 @@
> +       soc@80000000 {
> +               #address-cells = <1>;
> +               #size-cells = <1>;
> +               device_type = "soc";
> +               compatible = "fsl,mpc8241", "mpc10x";
> +               store-gathering = <0>; /* 0 == off, !0 == on */
> +
> +               reg = <80000000 00100000>;              /* Temporary, right? */
> +
> +               ranges = <80000000 80000000 70000000    /* pci mem space */
> +                         fdf00000 fdf00000 00100000    /* EUMB */
> +                         fe000000 fe000000 00c00000    /* pci i/o space */
> +                         fec00000 fec00000 00300000    /* pci cfg regs */
> +                         fef00000 fef00000 00100000>;  /* pci iack */

This doesn't look nice.  On the other ppc boards, Kumar moved the pci
bus node out of the soc node so the the internal register range is
separate from the soc.

I think it should look like this:

{
    soc@fdf00000 {
        compatible = "fsl,mpc8241-immr";
        ranges = <0 fe000000 00100000>;
        serial@4500 {
            blah....
        };
        blah....
    };
    pci@800000000 {
        ranges = blah....
    };
};

> +
> +               i2c@fdf03000 {
> +               serial0: serial@fdf04500 {
> +                       cell-index = <0>;
> +                       device_type = "serial";
> +                       compatible = "ns16550";
> +                       reg = <fdf04500 8>;
> +                       clock-frequency = <d# 97553800>; /* Hz */

That's kind of an odd number for clock frequency.  Usually clock
frequencies are *big* and *round*.  :-)

> +                       current-speed = <d# 115200>;
> +                       interrupts = <9 2>;
> +                       interrupt-parent = <&mpic>;
> +               };
> +

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
