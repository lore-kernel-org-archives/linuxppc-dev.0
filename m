Return-Path: <glikely@secretlab.ca>
Sender: Grant Likely <glikely@secretlab.ca>
Date: Fri, 3 Jun 2011 14:51:38 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: Josh Triplett <josh@joshtriplett.org>
Subject: Re: Hooking up SM501 on TQM5200 (MPC5200) board via device tree?
Message-ID: <20110603205138.GI17972@ponder.secretlab.ca>
References: <20110601050659.GA7789@leaf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110601050659.GA7789@leaf>
Cc: devicetree-discuss@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, Jamey Sharp <jamey@minilop.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, May 31, 2011 at 10:07:01PM -0700, Josh Triplett wrote:
> We have a TQM5200 board, which has GPIO lines hooked up to an SM501.
> I've managed to come up with the following patch to the tqm5200 device
> tree, which manages to convince the sm501 driver to attach an sm501-fb:
> 
> --- a/arch/powerpc/boot/dts/tqm5200.dts  2009-11-23 03:13:27.000000000 -0800
> +++ b/arch/powerpc/boot/dts/tqm5200.dts  2011-05-31 22:00:28.000580627 -0700
> @@ -177,7 +177,8 @@
>                 compatible = "fsl,mpc5200-lpb","simple-bus";
>                 #address-cells = <2>;
>                 #size-cells = <1>;
> -               ranges = <0 0 0xfc000000 0x02000000>;
> +               ranges = <0 0 0xfc000000 0x02000000
> +                         1 0 0xe0000000 0x04000000>;
>  
>                 flash@0,0 {
>                         compatible = "cfi-flash";
> @@ -187,6 +188,13 @@
>                         #size-cells = <1>;
>                         #address-cells = <1>;
>                 };
> +
> +               display@1,0 {
> +                       compatible = "smi,sm501";
> +                       reg = <1 0x00000000 0x00800000
> +                              1 0x03e00000 0x00200000>;
> +                       interrupts = <1 1 3>;
> +               };
>         };
>  
>         pci@f0000d00 {
> 
> 
> However, this doesn't hook up the sm501-gpio bits.  Reading the sm501
> driver carefully, it looks like it only hooks up sm501-gpio if it has
> platform_data available which sets some flags and other information.
> So, if I understand correctly, hooking up sm501-gpio would require
> adding functionality the driver to get the GPIO information from the
> device tree in preference to the platform_data, if available, and fall
> back to the platform_data for existing users?
> 
> What should the necessary device tree properties look like to replace
> sm501_initdata?
> 
> - Josh Triplett

You need to look at Documentation/devicetree/bindings/gpio/gpio.txt.

Also, you need to add bits to the sm501-gpio driver to register a
dynamically allocated range of gpio pins and to populate the
gpiochip->of_node pointer.  If that points at a device tree node, then
the core code will take care of setting up translation for you.

g.
