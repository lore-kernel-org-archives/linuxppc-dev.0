Return-Path: <glikely@secretlab.ca>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.229])
	by ozlabs.org (Postfix) with ESMTP id 47EE6DDDE0
	for <linuxppc-dev@ozlabs.org>; Sat, 25 Oct 2008 08:29:02 +1100 (EST)
Received: by rv-out-0506.google.com with SMTP id f6so989987rvb.9
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Oct 2008 14:29:00 -0700 (PDT)
Message-ID: <fa686aa40810241429r1dccb408ua9c1a692b8060f55@mail.gmail.com>
Date: Fri, 24 Oct 2008 15:29:00 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH] Added gpios property for SPI slaves
In-Reply-To: <20081024211056.GA7309@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1224878939.4039.22.camel@galileo.recco.de>
	<20081024211056.GA7309@oksana.dev.rtsoft.ru>
Cc: Stefan Roese <sr@denx.de>, linuxppc-dev@ozlabs.org,
	Wolfgang Ocker <weo@reccoware.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Oct 24, 2008 at 3:10 PM, Anton Vorontsov
<avorontsov@ru.mvista.com> wrote:
> On Fri, Oct 24, 2008 at 10:08:59PM +0200, Wolfgang Ocker wrote:
>> SPI slave devices require the specification of a chip select address.
>> This patch allows that specification using the gpios property. The reg
>> property remains supported.
>>
>> Signed-off-by: Wolfgang Ocker <weo@reccoware.de>
>> ---
>>
>> --- linux-2.6.27.3/drivers/of/of_spi.c.of_spi_gpio    2008-10-22 23:38:01.000000000 +0200
>> +++ linux-2.6.27.3/drivers/of/of_spi.c.of_spi_cshigh  2008-10-24 21:36:39.000000000 +0200
> [...]
>> --- linux-2.6.27.3/Documentation/powerpc/booting-without-of.txt.of_spi_gpio   2008-10-22 23:38:01.000000000 +0200
>> +++ linux-2.6.27.3/Documentation/powerpc/booting-without-of.txt.of_spi_cshigh 2008-10-24 21:57:16.000000000 +0200
>> @@ -1936,7 +1938,7 @@ platforms are moved over to use the flat
>>                       codec@1 {
>>                               compatible = "ti,tlv320aic26";
>>                               spi-max-frequency = <100000>;
>> -                             reg = <1>;
>> +                             gpios = <&GPIO1 3>;
>>                       };
>>               };
>
> Close, but no cigar. Sorry. ;-) The bindings are fine as is, you don't
> need to change them.
>
> The scheme should look like this:
>
> spi-controller {
>        #address-cells = <1>;
>        #size-cells = <0>;
>
>        /* two GPIOs, representing two chip selects: 0 and 1 */
>        gpios = <&pio 5 0 &pio 16 0>;
>
>        mmc-slot@0 {
>                reg = <0>;
>        };
>
>        touchscreen@1 {
>                reg = <1>;
>        };
> }
>
> Notice that "gpios" is spi-controller's property, not spi devices'.
> It is truly as hardware works, SPI controllers consists of two units:
> I/O, and chip-select machine. Most spi controllers don't have
> dedicated chip-select machines, so they use GPIOs.

FWIW, I 100% agree.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
