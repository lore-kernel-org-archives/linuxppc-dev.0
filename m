Return-Path: <scottwood@freescale.com>
Message-ID: <47263800.8020401@freescale.com>
Date: Mon, 29 Oct 2007 14:44:00 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Yoder Stuart-B08248 <stuart.yoder@freescale.com>
Subject: Re: RFC:  replace device_type with new "class" property?
References: <9696D7A991D0824DBA8DFAC74A9C5FA30359F9BB@az33exm25.fsl.freescale.net>	<4725FA58.4030505@genesi-usa.com><20071029172724.11354.qmail@farnsworth.org>	<47262E36.4030503@genesi-usa.com>
	<9696D7A991D0824DBA8DFAC74A9C5FA30359FB6A@az33exm25.fsl.freescale.net>
In-Reply-To: <9696D7A991D0824DBA8DFAC74A9C5FA30359FB6A@az33exm25.fsl.freescale.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: Linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Yoder Stuart-B08248 wrote:
> Here's an example of what I'm trying to get at-- take 
> a node from a FSL device tree.  The ideas I've heard
> for expressing the class are like this--
> 
> #1  don't express any class at all:
> 
>   ucc@2200 {
>         compatible = "fsl,ucc_geth";
>         model = "UCC";
>         device-id = <3>;
>         reg = <2200 200>;
>         interrupts = <22>;
>         interrupt-parent = < &qeic >;
>         mac-address = [ 00 00 00 00 00 00 ];
>         local-mac-address = [ 00 00 00 00 00 00 ];
>         rx-clock = <19>;
>         tx-clock = <1a>;
>         phy-handle = < &phy3 >;
>         pio-handle = < &pio3 >;

Of course, this should properly be something like

ethernet@2200 {
	compatible = "fsl,mpc8360-qe-enet", "fsl,qe-enet";
	local-mac-address = [ 00 00 00 00 00 00 ];
	...
};

With no "mac-address", and a more useful "model" if any at all.

-Scott
