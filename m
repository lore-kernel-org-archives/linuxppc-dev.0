Return-Path: <matthias.transier@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.207])
	by ozlabs.org (Postfix) with ESMTP id F3E066895F
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  5 Jan 2006 04:59:40 +1100 (EST)
Received: by wproxy.gmail.com with SMTP id i24so1636522wra
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 04 Jan 2006 09:59:39 -0800 (PST)
Message-ID: <b789c2e60601040959n4f6e730dw@mail.gmail.com>
Date: Wed, 4 Jan 2006 18:59:35 +0100
From: Matthias Transier <matthias.transier@gmail.com>
To: Wolfgang Denk <wd@denx.de>
In-Reply-To: <b789c2e60601040819j65eea749p@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <b789c2e60601040333o42d64c52n@mail.gmail.com>
	<20060104154812.24858352B1E@atlas.denx.de>
	<b789c2e60601040819j65eea749p@mail.gmail.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Segmentation fault with X.org and Coral-P drivers
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Wolfgang,

it finally works :-). I had to make a small modification to the x.org
source code. The file xc/programs/Xserver/hw/xfree86/i2c/xf86i2c.c
contains the initialization of the i2c bus. In function
xf86I2CBusInit, I added the two lines near the beginning:

    if (b->I2CStart =3D=3D NULL)
            b->I2CStart =3D I2CStart;

which sets the start function to a default function. The problem was
that mb86290_i2c.c does not provide a start function, whereas
xf86I2CBusInit expects one under some circumstances.

Best regards,
Matthias
