Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [195.58.98.146])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id E0792B7058
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Apr 2012 02:57:47 +1000 (EST)
In-Reply-To: <4F85AFB0.9020909@mlbassoc.com>
References: <4F85ADE7.5020800@mlbassoc.com> <4F85AFB0.9020909@mlbassoc.com>
Subject: Re: Network problem with 3.3
To: Gary Thomas <gary@mlbassoc.com>
Message-ID: <OFBD338563.A7871AC2-ONC12579DD.005CD50B-C12579DD.005D2BA2@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Wed, 11 Apr 2012 18:57:40 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>
> On 2012-04-11 10:14, Gary Thomas wrote:
> >
> > n.b. sorry if you receive this twice - ThunderBird seems very crashy lately!
> >
> > I'm trying to update my MPC8379 board from 3.0 to 3.3. I have
> > this setup in my device tree:
> >
> > mdio@24520 {
> > #address-cells = <1>;
> > #size-cells = <0>;
> > compatible = "fsl,gianfar-mdio";
> > reg = <0x24520 0x20>;
> >
> > phy0: ethernet-phy@0 {
> > interrupt-parent = <&ipic>;
> > interrupts = <17 0x8>;
> > reg = <0x01>;
> > device_type = "ethernet-phy";
> > };
> > phy1: ethernet-phy@1 {
> > interrupt-parent = <&ipic>;
> > interrupts = <18 0x8>;
> > reg = <0x00>;
> > device_type = "ethernet-phy";
> > };
> > };
> >
> > enet0: ethernet@24000 {
> > cell-index = <0>;
> > device_type = "network";
> > model = "TSEC";
> > compatible = "gianfar";
> > reg = <0x24000 0x1000>;
> > local-mac-address = [ 00 08 e5 11 32 33 ];
> > interrupts = <32 0x8 33 0x8 34 0x8>;
> > interrupt-parent = <&ipic>;
> > phy-handle = <&phy0>;
> > linux,network-index = <0>;
> > };
> >
> > enet1: ethernet@25000 {
> > cell-index = <1>;
> > device_type = "network";
> > model = "TSEC";
> > compatible = "gianfar";
> > reg = <0x25000 0x1000>;
> > local-mac-address = [ 00 08 e5 11 32 34 ];
> > interrupts = <35 0x8 36 0x8 37 0x8>;
> > interrupt-parent = <&ipic>;
> > phy-handle = <&phy1>;
> > linux,network-index = <1>;
> > };
> >
> > On 3.0, this works just fine. When I boot the same setup on 3.3,
> > I get this error:
> > fsl-pq_mdio: probe of ff024520.mdio failed with error -16
> >
> > Is there something I need to change in my DTS file to make this work?
> > Something else I might be missing?
>
> I think I found it - I need to add a TBI node to my PHY setup.
> It's working now.

Do you have a TBI PHY? There is a bug in 3.3 where every non-TBI PHY would fail, see
  http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=464b57da56910c8737ede75ad820b9a7afc46b3e
for a fix.

 Jocke
