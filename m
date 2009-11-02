Return-Path: <glikely@secretlab.ca>
Received: from mail-yw0-f199.google.com (mail-yw0-f199.google.com
	[209.85.211.199]) by ozlabs.org (Postfix) with ESMTP id 1DA551007D2
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Nov 2009 03:08:54 +1100 (EST)
Received: by ywh37 with SMTP id 37so5276021ywh.17
	for <linuxppc-dev@ozlabs.org>; Mon, 02 Nov 2009 08:08:52 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <20091102131427.GB4696@pengutronix.de>
References: <1256931852-13255-1-git-send-email-w.sang@pengutronix.de>
	<fa686aa40910311803m43504167s1ad802aecd2b4344@mail.gmail.com>
	<20091102131427.GB4696@pengutronix.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 2 Nov 2009 09:08:31 -0700
Message-ID: <fa686aa40911020808n73a898ack5fb66933188555da@mail.gmail.com>
Subject: Re: [PATCH] mpc52xx-psc-spi: refactor probe and remove to make use of
	of_register_spi_devices()
To: Wolfram Sang <w.sang@pengutronix.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: =?ISO-8859-1?B?S+FyaSBEYXbt8HNzb24=?= <kari.davidsson@marel.com>,
	spi-devel-general@lists.sourceforge.net, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Nov 2, 2009 at 6:14 AM, Wolfram Sang <w.sang@pengutronix.de> wrote:
>> Also, I'm resistant to changing the probe layout on this driver at
>> this time. =A0With the work being done to generalize the OF support
>> code, there is a strong possibility that of_platform will be
>> deprecated in favor of going back to using the platform bus directly
>> (just like how OF support works for i2c, spi, etc). =A0I'd rather not
>> refactor the driver until I'm certain of the direction that things are
>> going to go.
>
> And this was possibly the best answer I could get \o/ Sounds really promi=
sing,
> is there somewhere a discussion about how OF-generalization could happen?

It has been discussed on-and-off on the mailing list and on IRC.
There are 2 major problems that need to be solved before it can be
done:
1. Figure out how to do OF-style driver probing with the platform bus.
 I could use the same heuristic as used by i2c & spi, but that
approach isn't very scalable, and doesn't handle backwards
compatibility very well.
2. Figure out the best way to extract platform data from the device
tree without having a huge impact on the device drivers.  The adapter
code still driver specific, so it needs to be part of the device
driver itself, but I want to establish a pattern which does not
require major surgery to platform drivers in order to add OF support.

>> - =A0 =A0 return mpc52xx_psc_spi_do_probe(&op->dev, (u32)regaddr64, (u32=
)size64,
>> + =A0 =A0 rc =3D mpc52xx_psc_spi_do_probe(&op->dev, (u32)regaddr64, (u32=
)size64,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 irq_of_parse_and_map(op->node, 0), id);
>> + =A0 =A0 if (!rc)
>
> A matter of taste, maybe: I'd prefer
>
> =A0 =A0 =A0 =A0if (rc =3D=3D 0)
>
> as (!ptr) is often used for catching errors with pointers, but here it is=
 the
> 'all went OK'-path.

Okay, I'll change this.  Thanks for the feedback.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
