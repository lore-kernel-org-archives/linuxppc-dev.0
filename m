Return-Path: <glikely@secretlab.ca>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.225])
	by ozlabs.org (Postfix) with ESMTP id 7BFF9DDDE6
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Oct 2008 01:45:31 +1100 (EST)
Received: by rv-out-0506.google.com with SMTP id f6so24800rvb.9
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Oct 2008 07:45:30 -0700 (PDT)
Message-ID: <fa686aa40810290745k5c34c5e1m835351837e39248e@mail.gmail.com>
Date: Wed, 29 Oct 2008 08:45:30 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
To: "Henk Stegeman" <henk.stegeman@gmail.com>
Subject: Re: Chipselect in SPI binding with mpc5200-psc-spi
In-Reply-To: <ae4f76fd0810290643o27c357d7k2ccde459d9e52a7b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <ae4f76fd0810290643o27c357d7k2ccde459d9e52a7b@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Oct 29, 2008 at 7:43 AM, Henk Stegeman <henk.stegeman@gmail.com> wrote:
> ..
> ..
> In my dts
>
> I have my chipselect defined as follows:
>
>         gpt4: timer@640 {    // General Purpose Timer GPT4 in GPIO mode for
> SMC4000IO chip select.
>             compatible = "fsl,mpc5200b-gpt-gpio","fsl,mpc5200-gpt-gpio";
>             cell-index = <4>;
>             reg = <0x640 0x10>;
>             interrupts = <1 13 0>;
>             interrupt-parent = <&mpc5200_pic>;
>             gpio-controller;
>             #gpio-cells = <2>;
>         };
>
> I found the gpio in
> # cat /sys/class/gpio/gpiochip215/label
> /soc5200@f0000000/timer@640
>
> The spi controller is defined like this:
>
>         spi@2400 {
>             device_type = "spi";
>             #address-cells = <1>;
>             #size-cells = <0>;
>             compatible = "fsl,mpc5200-psc-spi","fsl,mpc5200b-psc-spi";
>             cell-index = <2>;
>             reg = <2400 100>;
>             interrupts = <2 3 0>;
>             interrupt-parent = <&mpc5200_pic>;
>             gpios = <&gpt4 0 0>;
>
>             io-controller@0 {
>                 compatible = "microkey,smc4000io";
>                 spi-max-frequency = <1000000>;
>                 reg = <0>;
>             };
>         };
>
> At bootup linux (2.6.27) reports:
>
> mpc52xx-psc-spi f0000960.spi: probe called without platform data, no
> (de)activate_cs function will be called.
>
> Is my assumption wrong that the gpios property is the way to map chipselects
> to the spi driver?

Yes, that is the way you should work specify the chip selects, but the
driver hasn't been updated to support it yet.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
