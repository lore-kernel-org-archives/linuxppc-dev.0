Return-Path: <becky.bruce@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6F792DDF15
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Aug 2008 08:26:52 +1000 (EST)
Message-Id: <0120619E-B530-4605-B550-15085F7009E2@freescale.com>
From: Becky Bruce <becky.bruce@freescale.com>
To: "Morrison, Tom" <tmorrison@empirix.com>
In-Reply-To: <BD261180E6D35F4D9D32F3E44FD3D9010DF4EB31@EMPBEDEX.empirix.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: Does Dev Tree WORK with soc@y_xxxx_0000 <#address/size> = <2/1>
Date: Mon, 11 Aug 2008 17:26:26 -0500
References: <mailman.1745.1218472641.19168.linuxppc-dev@ozlabs.org>
	<BD261180E6D35F4D9D32F3E44FD3D9010DF4EB31@EMPBEDEX.empirix.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Aug 11, 2008, at 4:37 PM, Morrison, Tom wrote:

> I am sorry, but I've butted my head against a tree for over a
> week and some things just aren't making sense...especially how
> the prom parse code is working to exact / resolve physical
> addresses to then ioremap...
>
> a) Setup, I have a working MPC8548E board using 2.6.23.8 (ARCH=ppc)
>   with PHYS/PTE_64BIT enabled (with the proper patches)).

So, how much RAM are you trying to use?  If it's 4GB+, there are still
patches you need that haven't been released yet but should be out in
the next week or so (I'm in the middle of pulling everything up to
top-of-tree and re-testing).

>
>
> b) Goal: we want to move our board to a generic 2.6.23 version that
>   Freescale has produced to support the MPC8572DS (and eventually
>   use that kernel to build our BSP for our next board).
>
> c) I have successfully gotten to work a pure '32-bit' dev tree
>   (PHYS/PTE_64BIT not defined - and the CCSRBAR @ 0xE000_0000)
>    The #address/#size <1/1> is '1' (as well as the #size is '1')
>
> d) I have modified this dev tree to support the 36bit mode addressing
>   (with the CCSRBAR and PCIExpress defined to in the last 4Gig  
> (instead
>    of the default first 4Gig - e.g.: 0xC_E000_0000)...
>
> e) I then set the soc to have #address-cells to '2' (#size-cells is  
> '1')
>   (and added the additional values accordingly to the ranges...	

I'm not sure you've done the right thing here.  In many cases, you don't
actually need to modify the size/addr cells in the soc node - those just
impact the children of that node, which are relative to the parent.

You do need to change your high-level platform node at the very top of
the .dts to have the right width - here's a patch snippet from a dts I  
had
with 2/1 formatting (this is a very old .dts, so it uses the old-style
number formatting before we started using '0x'):

+       model = "MPC8641HPCN";
+       compatible = "mpc86xx";
+       #address-cells = <2>;
+       #size-cells = <1>;

and then the soc node itself was: (I located things at 0xf_xxx0_0000)

+       soc8641@ff8000000 {
+               #address-cells = <1>;
+               #size-cells = <1>;
+               device_type = "soc";
+               ranges = <00000000 0f f8000000 00100000>;
+               reg = <f f8000000 00001000>;    // CCSRBAR

The reg and ranges now reflect the wider parent bus address.

>
>
> f) The prom_parse code has a problem with translating these addresses

>
>
> The main question is: has anyone ever tested this with soc #address/ 
> size
> being <2/1> in this fashion?

I did that a while ago with 8641D and it worked fine at that point;
since then I've converted to a 2/2 format (which also works fine).

That, of course, assumes you've modified your bootloader to put the
devices in the right spot.  Without that, all bets are off.

Hope that helps.... if you're still confused, post some snippets of  
your dts and I'll take a look.

Cheers,
B
