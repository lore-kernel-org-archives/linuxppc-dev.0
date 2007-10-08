Return-Path: <glikely@secretlab.ca>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.190])
	by ozlabs.org (Postfix) with ESMTP id 3E003DDF1D
	for <linuxppc-dev@ozlabs.org>; Mon,  8 Oct 2007 16:27:06 +1000 (EST)
Received: by rv-out-0910.google.com with SMTP id c27so626365rvf
	for <linuxppc-dev@ozlabs.org>; Sun, 07 Oct 2007 23:27:05 -0700 (PDT)
Message-ID: <fa686aa40710072327j304b7a62q602ed2553787abd4@mail.gmail.com>
Date: Mon, 8 Oct 2007 00:27:04 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Marian Balakowicz" <m8@semihalf.com>
Subject: Re: [PATCH 01/15] [POWERPC] TQM5200 DTS
In-Reply-To: <4708BFDD.9020900@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <47075FA7.3030108@semihalf.com> <4708BFDD.9020900@semihalf.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 10/7/07, Marian Balakowicz <m8@semihalf.com> wrote:
> +
> +               pci@0d00 {
> +                       #interrupt-cells = <1>;
> +                       #size-cells = <2>;
> +                       #address-cells = <3>;
> +                       device_type = "pci";
> +                       compatible = "mpc5200-pci";
> +                       reg = <d00 100>;
> +                       interrupt-map-mask = <f800 0 0 7>;
> +                       interrupt-map = <c000 0 0 1 &mpc5200_pic 0 0 3
> +                                        c000 0 0 2 &mpc5200_pic 0 0 3
> +                                        c000 0 0 3 &mpc5200_pic 0 0 3
> +                                        c000 0 0 4 &mpc5200_pic 0 0 3>;
> +                       clock-frequency = <0>; // From boot loader
> +                       interrupts = <2 8 0 2 9 0 2 a 0>;
> +                       interrupt-parent = <&mpc5200_pic>;
> +                       bus-range = <0 0>;
> +                       ranges = <42000000 0 80000000 80000000 0 10000000
> +                                 02000000 0 90000000 90000000 0 10000000
> +                                 01000000 0 00000000 a0000000 0 01000000>;
> +               };

Also, the PCI node should no longer be a child of the 'soc' node.  See
the latest lite5200.dts file in Paul Mackerras' powerpc tree for an
example.



-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
