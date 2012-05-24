Return-Path: <B04825@freescale.com>
Message-ID: <4FBE7DD8.509@freescale.com>
Date: Thu, 24 May 2012 13:28:40 -0500
From: Timur Tabi <b04825@freescale.com>
MIME-Version: 1.0
To: David Daney <ddaney.cavm@gmail.com>
Subject: Re: [PATCH v6 0/3] netdev/of/phy: MDIO bus multiplexer support.
References: <1336007799-31016-1-git-send-email-ddaney.cavm@gmail.com>
 <CAOZdJXWVCu+aNxcQRkcSSDsWWxnn8B9X5Y6=8oVgFwJ9SZTTGQ@mail.gmail.com>
 <4FB6C728.3090507@gmail.com> <4FB6C886.3050105@freescale.com>
 <4FB6CBF1.40300@gmail.com>
In-Reply-To: <4FB6CBF1.40300@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "devicetree-discuss@lists.ozlabs.org"
 <devicetree-discuss@lists.ozlabs.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

David Daney wrote:
> Yes.  You may note in the DTS file I attached in the parent (sorry for 
> the fubar mime types), that there are two, almost identical, MDIO 
> masters.  smi0 has two directly attached PHYs.  smi1 goes to the mux, 
> and each child of the mux has four attached PHYs.

I'm till have trouble understanding all this.  I'm just hacking things up
in order to help me understand it, but it's a slow and painful process.

This call in mdio_mux_init() is failing:

	parent_bus = of_mdio_find_bus(parent_bus_node);

It returns NULL.  Here is my MDIO node:

		fman0: fman@400000 {
			enet0: ethernet@e0000 {
				tbi-handle = <&tbi0>;
				phy-handle = <&phy0>;
				phy-connection-type = "sgmii";
			};

			mdio0: mdio@e1120 {
				gpios = <&gpio0 0 0
					 &gpio0 1 0>;

				tbi0: tbi-phy@8 {
					reg = <0x8>;
					device_type = "tbi-phy";
				};

				phy0: ethernet-phy@1c {
					reg = <0x1c>;
				};
			};
		};

What am I missing?  What do I need to do in order to get
of_mdio_find_bus() to return a real value?

-- 
Timur Tabi
Linux kernel developer at Freescale
