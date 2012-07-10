Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 4908A2C0527
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jul 2012 22:24:19 +1000 (EST)
Subject: Re: [PATCH 1/2] powerpc/mpc8572ds: Fix eTSEC is not available on
 core1 of AMP boot issue
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1341900506-23401-1-git-send-email-B38951@freescale.com>
Date: Tue, 10 Jul 2012 07:24:12 -0500
Message-Id: <9D9B5A65-CABB-4EB8-9901-206970467A9F@kernel.crashing.org>
References: <1341900506-23401-1-git-send-email-B38951@freescale.com>
To: Jia Hongtao <B38951@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jul 10, 2012, at 1:08 AM, Jia Hongtao wrote:

> The issue log on core1 is:
> root@mpc8572ds:~# ifconfig eth0 10.192.208.244
> net eth0: could not attach to PHY
> SIOCSIFFLAGS: No such device
> 
> To attach PHY node mdio@24520 should not be disabled in dts of core1.
> Because all PHYs are controlled through this node as follows:
> 
> mdio@24520 {
> 	phy0: ethernet-phy@0 {
> 		interrupts = <10 1 0 0>;
> 		reg = <0x0>;
> 	};
> 	phy1: ethernet-phy@1 {
> 		interrupts = <10 1 0 0>;
> 		reg = <0x1>;
> 	};
> 	phy2: ethernet-phy@2 {
> 		interrupts = <10 1 0 0>;
> 		reg = <0x2>;
> 	};
> 	phy3: ethernet-phy@3 {
> 		interrupts = <10 1 0 0>;
> 		reg = <0x3>;
> 	};
> 
> 	tbi0: tbi-phy@11 {
> 		reg = <0x11>;
> 		device_type = "tbi-phy";
> 	};
> };
> 
> Signed-off-by: Li Yang <leoli@freescale.com>
> Signed-off-by: Jia Hongtao <B38951@freescale.com>
> ---
> arch/powerpc/boot/dts/mpc8572ds_camp_core1.dts |    3 ---
> 1 files changed, 0 insertions(+), 3 deletions(-)

applied to next

- k
