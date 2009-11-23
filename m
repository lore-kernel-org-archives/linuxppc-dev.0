Return-Path: <glikely@secretlab.ca>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.210.179]) by ozlabs.org (Postfix) with ESMTP id 917CFB7BBA
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 24 Nov 2009 07:36:25 +1100 (EST)
Received: by yxe9 with SMTP id 9so5761543yxe.26
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 23 Nov 2009 12:36:23 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <4B0AE865.4030502@yahoo.es>
References: <1258927311-4340-1-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-2-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-3-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-4-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-5-git-send-email-albert_herranz@yahoo.es>
	<fa686aa40911221518s5d82d5b4i8402a297d52a46d1@mail.gmail.com>
	<4B0AE865.4030502@yahoo.es>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 23 Nov 2009 13:36:03 -0700
Message-ID: <fa686aa40911231236i2d49d21me1853d681077a9d1@mail.gmail.com>
Subject: Re: [RFC PATCH 04/19] powerpc: wii: device tree
To: Albert Herranz <albert_herranz@yahoo.es>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Nov 23, 2009 at 12:54 PM, Albert Herranz
<albert_herranz@yahoo.es> wrote:
> Grant Likely wrote:
>> On Sun, Nov 22, 2009 at 3:01 PM, Albert Herranz <albert_herranz@yahoo.es=
> wrote:
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 i2c-video {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 #address-cells =3D <1>;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 #size-cells =3D <0>;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "virtual,i=
2c-gpio";
>>
>> There isn't a documented binding for this. =A0Is there a driver for it?
>>
>
> I have a driver for it. But it isn't yet published.
>
> This is the documentation I wrote so far for the bindings.
> Is there a standard for this?

This looks pretty good to me.  The documentation format isn't strict,
just follow the pattern seen in other bindings.  Make sure you post
new bindings to devicetree-discuss@lists.ozlabs.org for review.  A
couple of comments below.

> Documentation/powerpc/dts-bindings/gpio/i2c.txt
>
> GPIO-based I2C
>
> Required properties:
> - compatible : should be "virtual,i2c-gpio".
> - gpios : should specify GPIOs used for SDA and SCL lines, in that order.
> - sda-is-open-drain : should be non-zero if SDA gpio is open-drain.
> - sda-enforce-dir : should be non-zero if SDA gpio must be configured for
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0input before reading and for outpu=
t before writing.
> - scl-is-open-drain : should be non-zero if SCL gpio is open-drain.
> - scl-is-output-only : should be non-zero if SCL is an output gpio only.

Instead of looking for a value in these properties, just make them
empty properties and change behaviour based on whether or not the
property is present.

Why is the scl-is-output-only property needed?

> - udelay : signal toggle delay. SCL frequency is (500 / udelay) kHz

You should follow the lead of
Documentation/powerpc/dts-bindings/fsl/i2c.txt here and specify a
clock-frequency property.

> - timeout : clock stretching timeout in milliseconds.

I don't understand what this property means.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
