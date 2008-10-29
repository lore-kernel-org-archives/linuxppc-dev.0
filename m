Return-Path: <henk.stegeman@gmail.com>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.155])
	by ozlabs.org (Postfix) with ESMTP id 043D5DDDE6
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Oct 2008 00:43:34 +1100 (EST)
Received: by fg-out-1718.google.com with SMTP id d23so39633fga.39
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Oct 2008 06:43:32 -0700 (PDT)
Message-ID: <ae4f76fd0810290643o27c357d7k2ccde459d9e52a7b@mail.gmail.com>
Date: Wed, 29 Oct 2008 14:43:32 +0100
From: "Henk Stegeman" <henk.stegeman@gmail.com>
To: linuxppc-dev@ozlabs.org
Subject: Chipselect in SPI binding with mpc5200-psc-spi
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_3744_27396951.1225287812684"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

------=_Part_3744_27396951.1225287812684
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

..
..
In my dts

I have my chipselect defined as follows:

        gpt4: timer@640 {    // General Purpose Timer GPT4 in GPIO mode for
SMC4000IO chip select.
            compatible = "fsl,mpc5200b-gpt-gpio","fsl,mpc5200-gpt-gpio";
            cell-index = <4>;
            reg = <0x640 0x10>;
            interrupts = <1 13 0>;
            interrupt-parent = <&mpc5200_pic>;
            gpio-controller;
            #gpio-cells = <2>;
        };

I found the gpio in
# cat /sys/class/gpio/gpiochip215/label
/soc5200@f0000000/timer@640

The spi controller is defined like this:

        spi@2400 {
            device_type = "spi";
            #address-cells = <1>;
            #size-cells = <0>;
            compatible = "fsl,mpc5200-psc-spi","fsl,mpc5200b-psc-spi";
            cell-index = <2>;
            reg = <2400 100>;
            interrupts = <2 3 0>;
            interrupt-parent = <&mpc5200_pic>;
            gpios = <&gpt4 0 0>;

            io-controller@0 {
                compatible = "microkey,smc4000io";
                spi-max-frequency = <1000000>;
                reg = <0>;
            };
        };

At bootup linux (2.6.27) reports:

mpc52xx-psc-spi f0000960.spi: probe called without platform data, no
(de)activate_cs function will be called.

Is my assumption wrong that the gpios property is the way to map chipselects
to the spi driver?

Thanks in advance.
Henk.

------=_Part_3744_27396951.1225287812684
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

..<br>..<br>In my dts<br><br>I have my chipselect defined as follows:<br><br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; gpt4: timer@640 {&nbsp;&nbsp;&nbsp; // General Purpose Timer GPT4 in GPIO mode for SMC4000IO chip select.<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; compatible = &quot;fsl,mpc5200b-gpt-gpio&quot;,&quot;fsl,mpc5200-gpt-gpio&quot;;<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; cell-index = &lt;4&gt;;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; reg = &lt;0x640 0x10&gt;;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; interrupts = &lt;1 13 0&gt;;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; interrupt-parent = &lt;&amp;mpc5200_pic&gt;;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; gpio-controller;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; #gpio-cells = &lt;2&gt;;<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; };<br><br>I found the gpio in<br>
# cat /sys/class/gpio/gpiochip215/label<br>
/soc5200@f0000000/timer@640<br>
<br>The spi controller is defined like this:<br><br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; spi@2400 {<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; device_type = &quot;spi&quot;;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; #address-cells = &lt;1&gt;;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; #size-cells = &lt;0&gt;;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; compatible = &quot;fsl,mpc5200-psc-spi&quot;,&quot;fsl,mpc5200b-psc-spi&quot;;<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; cell-index = &lt;2&gt;;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; reg = &lt;2400 100&gt;;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; interrupts = &lt;2 3 0&gt;;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; interrupt-parent = &lt;&amp;mpc5200_pic&gt;;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; gpios = &lt;&amp;gpt4 0 0&gt;;<br>
<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; io-controller@0 {<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; compatible = &quot;microkey,smc4000io&quot;;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; spi-max-frequency = &lt;1000000&gt;;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; reg = &lt;0&gt;;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; };<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; };<br>
<br>At bootup linux (2.6.27) reports:<br><br>mpc52xx-psc-spi f0000960.spi: probe called without platform data, no (de)activate_cs function will be called.<br><br>Is my assumption wrong that the gpios property is the way to map chipselects to the spi driver?<br>
<br>Thanks in advance.<br>Henk.<br><br><br>

------=_Part_3744_27396951.1225287812684--
