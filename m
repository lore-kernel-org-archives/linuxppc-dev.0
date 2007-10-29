Return-Path: <dale@farnsworth.org>
From: "Dale Farnsworth" <dale@farnsworth.org>
Date: Mon, 29 Oct 2007 16:03:53 -0700
To: Yoder Stuart-B08248 <stuart.yoder@freescale.com>
Subject: Re: RFC:  replace device_type with new "class" property?
Message-ID: <20071029230353.GA11750@xyzzy.farnsworth.org>
References: <9696D7A991D0824DBA8DFAC74A9C5FA30359F9BB@az33exm25.fsl.freescale.net>
	<47262E36.4030503@genesi-usa.com>
	<9696D7A991D0824DBA8DFAC74A9C5FA30359FB6A@az33exm25.fsl.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9696D7A991D0824DBA8DFAC74A9C5FA30359FB6A@az33exm25.fsl.freescale.net>
Cc: Linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Oct 29, 2007 at 12:34:40PM -0700, Yoder Stuart-B08248 wrote:
> #4 use "compatible"
> 
>   ucc@2200 {
>         compatible = "fsl,ucc_geth","[official spec],network";
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
>   };
> 
>   > I don't like this...we are overloading "compatible" with
>   > stuff that is not specifying a programming interface.  compatible
>   > is supposed to be specifying a programming interface which
>   > the device complies to.

If your proposed class property doesn't specify a programming interface,
then I agree that we shouldn't put that info in compatible.  My point
was that compatible is the one and only property that a driver should
look at to find a node with a suitable programming interface.

But, that begs the question: How will the code use your class property?
Another post implied that it's for human-readable purposes.  If that's
all, I'd leave it out, or use a comment instead.

-Dale
