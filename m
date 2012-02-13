Return-Path: <ppc@mindchasers.com>
Received: from vms173003pub.verizon.net (vms173003pub.verizon.net
 [206.46.173.3]) by ozlabs.org (Postfix) with ESMTP id A7A82B6F9D
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Feb 2012 12:40:23 +1100 (EST)
Received: from [192.168.1.3] ([unknown] [108.25.174.63])
 by vms173003.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LZB00BUW5YWAPK1@vms173003.mailsrvcs.net> for
 linuxppc-dev@lists.ozlabs.org; Sun, 12 Feb 2012 19:40:09 -0600 (CST)
Message-id: <4F3869F8.6080802@mindchasers.com>
Date: Sun, 12 Feb 2012 20:40:08 -0500
From: Bob Cochran <ppc@mindchasers.com>
MIME-version: 1.0
To: b29983@freescale.com, linuxppc-dev@lists.ozlabs.org,
 Tang Yuantian <Yuantian.Tang@freescale.com>, Jin Qing <b24347@freescale.com>
Subject: Re: [PATCH 1/2 V3] powerpc/85xx: Add P1024rdb dts support
References: <1328860851-392-1-git-send-email-b29983@freescale.com>
In-reply-to: <1328860851-392-1-git-send-email-b29983@freescale.com>
Content-type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/10/2012 03:00 AM, b29983@freescale.com wrote:
> From: Tang Yuantian<Yuantian.Tang@freescale.com>
>
> Signed-off-by: Jin Qing<b24347@freescale.com>
> Signed-off-by: Li Yang<leoli@freescale.com>
> Signed-off-by: Tang Yuantian<Yuantian.Tang@freescale.com>
> ---
> v3:



I'm curious how fsl_pq_mdio_probe returns successfully when probing the 
phys on the first pass (mdio@24000).  I don't have a P1024 to test with, 
but I believe it has the same ETSEC configuration as the P1010 that I 
work with.

Inside the fsl_pq_mdio_probe routine (fsl_pq_mdio.c), a successful 
search of a tbi child node is required with a tbi->type of "tby-phy". 
If it doesn't find this node, the probe routine will return an error of 
EBUSY.  The logic from the routine is provided below:


for_each_child_of_node(np, tbi) {
                 if (!strncmp(tbi->type, "tbi-phy", 8))
                         break;
         }

         if (tbi) {
                 const u32 *prop = of_get_property(tbi, "reg", NULL);

                 if (prop)
                         tbiaddr = *prop;
         }

         if (tbiaddr == -1) {
                 err = -EBUSY;
                 goto err_free_irqs;
         } else {
                 out_be32(tbipa, tbiaddr);
         }


If I look at the p1010rdb.dtsi file, I see that a tbi-phy child node was 
added inside mdio@24000; however, I don't see this inside your 
p1024rdb.dtsi.

On top of this, the current p1010rdb mdio@24000 node in p1024rdb.dtsi 
doesn't yield a successful probe (as I reported on this mail list on 
2/7/12).

So, it seems to me that a tbi child node needs to be added to your 
mdio@24000 node similar to what was done with the p1010rdb,

but it also requires some additional tweaking or perhaps a fix inside 
the fsl_pq_mdio_probe routine or of library (It's not clear to me how to 
best produce a successful probe given the circumstances).



> +
> +	mdio@24000 {
> +		phy0: ethernet-phy@0 {
> +			interrupts =<3 1 0 0>;
> +			reg =<0x0>;
> +		};
> +		phy1: ethernet-phy@1 {
> +			interrupts =<2 1 0 0>;
> +			reg =<0x1>;
> +		};
> +		phy2: ethernet-phy@2 {
> +			interrupts =<1 1 0 0>;
> +			reg =<0x2>;
> +		};
> +	};
> +
> +	mdio@25000 {
> +		tbi0: tbi-phy@11 {
> +			reg =<0x11>;
> +			device_type = "tbi-phy";
> +		};
> +	};
> +
> +	mdio@26000 {
> +		tbi1: tbi-phy@11 {
> +			reg =<0x11>;
> +			device_type = "tbi-phy";
> +		};
> +	};
> +
> +	ethernet@b0000 {
> +		phy-handle =<&phy2>;
> +		phy-connection-type = "rgmii-id";
> +	};
> +
