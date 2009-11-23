Return-Path: <albert_herranz@yahoo.es>
Received: from smtp106.mail.ukl.yahoo.com (smtp106.mail.ukl.yahoo.com
	[77.238.184.38]) by ozlabs.org (Postfix) with SMTP id 55A0BB7B3E
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 24 Nov 2009 08:55:58 +1100 (EST)
Message-ID: <4B0B04ED.9080307@yahoo.es>
Date: Mon, 23 Nov 2009 22:55:57 +0100
From: Albert Herranz <albert_herranz@yahoo.es>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [RFC PATCH 04/19] powerpc: wii: device tree
References: <1258927311-4340-1-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-2-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-3-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-4-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-5-git-send-email-albert_herranz@yahoo.es>
	<fa686aa40911221518s5d82d5b4i8402a297d52a46d1@mail.gmail.com>
	<4B0AE865.4030502@yahoo.es>
	<fa686aa40911231236i2d49d21me1853d681077a9d1@mail.gmail.com>
In-Reply-To: <fa686aa40911231236i2d49d21me1853d681077a9d1@mail.gmail.com>
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

Grant Likely wrote:
> This looks pretty good to me.  The documentation format isn't strict,
> just follow the pattern seen in other bindings.  Make sure you post
> new bindings to devicetree-discuss@lists.ozlabs.org for review.  A
> couple of comments below.
> 

Ok. I know it now for the next time :)

>> Documentation/powerpc/dts-bindings/gpio/i2c.txt
>>
>> GPIO-based I2C
>>
>> Required properties:
>> - compatible : should be "virtual,i2c-gpio".
>> - gpios : should specify GPIOs used for SDA and SCL lines, in that order.
>> - sda-is-open-drain : should be non-zero if SDA gpio is open-drain.
>> - sda-enforce-dir : should be non-zero if SDA gpio must be configured for
>>                    input before reading and for output before writing.
>> - scl-is-open-drain : should be non-zero if SCL gpio is open-drain.
>> - scl-is-output-only : should be non-zero if SCL is an output gpio only.
> 
> Instead of looking for a value in these properties, just make them
> empty properties and change behaviour based on whether or not the
> property is present.
> 

It seems reasonable. Thanks.

> Why is the scl-is-output-only property needed?
> 

It is needed to specify that the I2C master can't honour clock stretching done by I2C slave devices, as it cannot read back SCL.

>> - udelay : signal toggle delay. SCL frequency is (500 / udelay) kHz
> 
> You should follow the lead of
> Documentation/powerpc/dts-bindings/fsl/i2c.txt here and specify a
> clock-frequency property.
> 

Ok.

>> - timeout : clock stretching timeout in milliseconds.
> 
> I don't understand what this property means.
> 

It is the maximum time that the I2C master should wait for SCL to go high when a I2C slave is "clock-stretching".

Cheers,
Albert
