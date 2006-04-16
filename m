Return-Path: <andrewd.lists@gmail.com>
Received: from nz-out-0102.google.com (nz-out-0102.google.com [64.233.162.193])
	by ozlabs.org (Postfix) with ESMTP id 5909F67A33
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 16 Apr 2006 21:50:23 +1000 (EST)
Received: by nz-out-0102.google.com with SMTP id 12so335897nzp
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 16 Apr 2006 04:50:22 -0700 (PDT)
Message-ID: <54823def0604160443tcce818dk8cca5c20593c46a7@mail.gmail.com>
Date: Sun, 16 Apr 2006 21:43:17 +1000
From: "Andrew Dennison" <andrewd.lists@gmail.com>
To: "Sylvain Munaut" <tnt@246tnt.com>, linuxppc-embedded@ozlabs.org,
	massimo.vanetti@fastwebnet.it
Subject: Re: freescale lite 5200 board and kernel 2.6
In-Reply-To: <20060413102330.GA10025@raptus.dandreoli.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20060405210654.GA16848@raptus.dandreoli.com>
	<20060405212741.GC61331@server.idefix.loc>
	<20060406221056.GA15540@raptus.dandreoli.com>
	<20060408082100.GA54030@server.idefix.loc>
	<20060410215428.GA22290@raptus.dandreoli.com>
	<443D7F78.30402@246tNt.com>
	<20060413102330.GA10025@raptus.dandreoli.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 4/13/06, Domenico Andreoli <cavokz@gmail.com> wrote:
> no, it does not, it uses GENERIC. when PHY is detected as LXT971,
> network works.
>
> actually this is unrelated with previous runs of kernel 2.4 (as i
> stated in some previous post). sometimes PHY is detected correctly,
> sometimes is not.
>

Is the PHY address something other than 0?

If there is no pullup on MDIO (?) and the PHY address isn't 0
sometimes a PHY will be detected on the wrong address. Well that's the
problem I had with a 5200 on a custom board. I worked around something
like this with the following (edited) patch / hack. The correct answer
was to add a pullup on the board, but this is fairly safe as it won't
misdetect any of the phys supported in fec.c.

--- arch/ppc/5xxx_io/fec.c      15 Feb 2005 00:19:13 -0000      1.10
+++ arch/ppc/5xxx_io/fec.c      22 Apr 2005 05:28:12 -0000
@@ -732,7 +825,7 @@ mii_discover_phy(uint mii_reg, struct ne
        printk("mii_discover_phy\n");
 #endif

-       if ((phytype =3D (mii_reg & 0xffff)) !=3D 0xffff) {
+       if ((phytype =3D (mii_reg & 0x3ff)) !=3D 0x3ff) { /* hack - was 0xf=
fff */
                /* Got first part of ID, now get remainder.
                */
                priv->phy_id =3D phytype << 16;
