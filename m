Return-Path: <glikely@secretlab.ca>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.176])
	by ozlabs.org (Postfix) with ESMTP id F15E4DDE2E
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Oct 2007 00:59:16 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so2983327wag
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Oct 2007 07:59:14 -0700 (PDT)
Message-ID: <fa686aa40710170759n5e92bac0x82e7cf72f03e932c@mail.gmail.com>
Date: Wed, 17 Oct 2007 08:59:14 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Marian Balakowicz" <m8@semihalf.com>
Subject: Re: [PATCH 04/15] [POWERPC] CM5200 DTS
In-Reply-To: <4715FE6C.2070201@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <47075FA7.3030108@semihalf.com> <4708C112.9020506@semihalf.com>
	<20071008015021.GA12499@localhost.localdomain>
	<4715FE6C.2070201@semihalf.com>
Cc: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 10/17/07, Marian Balakowicz <m8@semihalf.com> wrote:
> David Gibson wrote:
> > [snip]
> >> +            flash@c000000 {
> >> +                    device_type = "rom";
> >> +                    compatible = "direct-mapped";
> >> +                    reg = <0c000000 02000000>;
> >> +                    probe-type = "CFI";
> >> +                    bank-width = <2>;
> >> +                    partitions = <00000000 00060000
> >> +                            00060000 00020000
> >> +                            00080000 00020000
> >> +                            000a0000 00020000
> >> +                            000c0000 00200000
> >> +                            002c0000 01b40000
> >> +                            01e00000 00200000>;
> >> +                    partition-names = "uboot\0env\0redund_env\0dtb\0kernel\0rootfs\0config";
> >> +            };
> >
> > First, this is the old flash binding, please use the new one.
>
> Ok.
>
> > Second, is the flash really part of the SoC?
>
> Not directly, it is attached to LocalPlus Bus Controller, which is
> part of the SoC. And the soc@ is currently the only recognized of bus
> for mpc5200, so if we want to move it to some other place new bindings
> will need to be defined for lpc (LocalPlus Controller) bus. But I am
> not quite sure where this should be attached. Bus is under LPC which
> is a part of the SoC, but on the other hand Soc address range covers
> only device control registers not the address space LPC may handle
> (that may be varied). Any ideas?

My vote is for an lpc node off the root of the tree for devices like
this to hang off.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
