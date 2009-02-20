Return-Path: <daniel.ng1234@gmail.com>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.177])
	by ozlabs.org (Postfix) with ESMTP id F0C2DDDD01
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Feb 2009 16:01:01 +1100 (EST)
Received: by wa-out-1112.google.com with SMTP id j5so409480wah.9
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Feb 2009 21:01:00 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20090219184410.GB4180@ld0162-tx32.am.freescale.net>
References: <mailman.5.1233190802.9523.linuxppc-dev@ozlabs.org>
	<49810367.5000904@consentry.com>
	<547eba1b0902182247g66c8b83se0855ff048413c01@mail.gmail.com>
	<20090219184410.GB4180@ld0162-tx32.am.freescale.net>
Date: Fri, 20 Feb 2009 16:01:00 +1100
Message-ID: <547eba1b0902192101n323f51ceuf39b9d954b696225@mail.gmail.com>
Subject: Re: How to bring up fs_enet on 2.6.27?
From: Daniel Ng <daniel.ng1234@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Mike Ditto <mditto@consentry.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Feb 20, 2009 at 5:44 AM, Scott Wood <scottwood@freescale.com> wrote:
> See this thread:
> http://ozlabs.org/pipermail/linuxppc-dev/2009-February/068467.html
>

Great, that's helped. Thanks Scott.

Now, I'm seeing these boot messages:

f0010d40:00 not found
eth0: Could not attach to PHY
IP-Config: Failed to open eth0
IP-Config: Device `eth0' not found.

Previous mailing list discussions suggest that I use the correct PHY,
which I am sure about because my 8272-based board only has the one PHY
ie. PHY0 with reg = <0x0>.

Note the relevant parts of my Device Tree below. Currently, our PHY
attributes eg. 'auto-negotiate' are not changeable, so we aren't
actually using MDC+MDIO even the MDC+MDIO lines exist. Also, the PHY
interrupt line is not wired up. Hence the PHY0 interrupts field is <0
8> (or should it be removed altogether?).

I am usig FCC2.

What might I need to change to get the ethernet driver working?


      ethernet@11320 {
        device_type = "network";
        compatible = "fsl,mpc8272-fcc-enet",
                     "fsl,cpm2-fcc-enet";
        // FCC2-
        reg = <0x11320 0x20 0x8500 0x100 0x113b0 0x1>;
        local-mac-address = [ 00 00 00 00 00 00 ];
        interrupts = <33 8>;
        interrupt-parent = <&PIC>;
        phy-handle = <&PHY0>;
        linux,network-index = <0>;
        fsl,cpm-command = <0x16200300>;
      };

      mdio@10d40 {
        device_type = "mdio";
        compatible = "fsl,mpc8272ads-mdio-bitbang",
                     "fsl,mpc8272-mdio-bitbang",
                     "fsl,cpm2-mdio-bitbang";
        reg = <0x10d40 0x14>;
        #address-cells = <1>;
        #size-cells = <0>;
        fsl,mdio-pin = <5>;
        fsl,mdc-pin = <19>;

        PHY0: ethernet-phy@0 {
          interrupt-parenn = <&PIC>;
          interrupts = <0 8>;
          reg = <0x0>;
          device_type = "ethernet-phy";
        };
.
.
.
                PIC: interrupt-controller@10c00 {
                        #interrupt-cells = <2>;
                        interrupt-controller;
                        reg = <0x10c00 0x80>;
                        compatible = "fsl,mpc8272-pic", "fsl,cpm2-pic";
                };

Cheers,
Daniel
