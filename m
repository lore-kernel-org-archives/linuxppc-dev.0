Return-Path: <danielwa@cisco.com>
Received: from alln-iport-6.cisco.com (alln-iport-6.cisco.com [173.37.142.93])
 (using TLSv1.2 with cipher DHE-RSA-SEED-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rlrr868pWzDr2b
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jul 2016 07:49:44 +1000 (AEST)
Subject: Re: t1040 IFC flash driver Extended Chip Select
To: Scott Wood <scott.wood@nxp.com>, Raghav Dogra <raghav.dogra@nxp.com>,
 Brian Norris <computersforpeace@gmail.com>,
 Jaiprakash Singh <b44839@freescale.com>, Scott Wood
 <scottwood@freescale.com>, Lijun Pan <Lijun.Pan@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "xe-kernel@external.cisco.com" <xe-kernel@external.cisco.com>
References: <577D68B8.8020305@cisco.com>
 <DB5PR0401MB1928C329F9B0FF9AAF5A607B913B0@DB5PR0401MB1928.eurprd04.prod.outlook.com>
 <577E79D4.1010709@cisco.com>
 <DB5PR0401MB1928CD680EFFD3A1712AA9F6913B0@DB5PR0401MB1928.eurprd04.prod.outlook.com>
 <577EB10B.7010601@cisco.com>
 <DB5PR0401MB1928FF35ABE36D8E07BAA079913B0@DB5PR0401MB1928.eurprd04.prod.outlook.com>
 <577EC0FC.8020304@cisco.com>
 <DB5PR0401MB1928FBF1769BCE0DE0E3E503913B0@DB5PR0401MB1928.eurprd04.prod.outlook.com>
From: Daniel Walker <danielwa@cisco.com>
Message-ID: <577ECE6C.3000100@cisco.com>
Date: Thu, 7 Jul 2016 14:49:32 -0700
MIME-Version: 1.0
In-Reply-To: <DB5PR0401MB1928FBF1769BCE0DE0E3E503913B0@DB5PR0401MB1928.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/07/2016 02:23 PM, Scott Wood wrote:
>
> I suspect that add the usage of cspr_ext into the driver would fix the
> issue we have. It reads like you would find that acceptable ?
> What specifically is the problem you're having?  Is it that CSPR_EXT is
> not getting written to, and thus the device does not appear at the
> address that it should?
>
> Or is the driver matching incorrectly?  The only way the driver's lack
> of using CSPR_EXT to match would be a problem would be if you have
> multiple chipselects with the same address in the lower 32 bits, and
> only CSPR_EXT distinguishing them.  Since you proposed a device tree
> binding that assumes all devices have the same CSPR_EXT, I doubt that's
> the case, so I doubt adding CSPR_EXT matching to the driver will solve
> your problem.
>
> -Scott
>

I didn't do the debug on this. From my perspective it's either flash 
works, or it doesn't work. We need the code below for it to work,


+#define IFC_REG_BASEADDR       0x124000
+
+static void rsp3_setup_ifc(void)
+{
+       /* set Extended Base Address for external flash chips */
+       void __iomem *ccsr_ifc;
+       ccsr_ifc = g_ccsrbp + IFC_REG_BASEADDR;
+       iowrite32be(0xF, (ccsr_ifc + 0x0C)); /* Extended Address */
+}
+

And this is our device tree blob,

+       ifc: localbus@ffb124000 {
+               #address-cells = <2>;
+               #size-cells = <1>;
+               compatible = "fsl,ifc", "simple-bus";
+               interrupts = <0x19 0x2 0x0 0x0>;
+               reg = <0xf 0xfb124000 0 0x2000>;
+               ranges = <0 0 0xf 0xfc000000 0x4000000>;
+
+               flash@0,0 {
+                       #address-cells = <1>;
+                       #size-cells = <1>;
+                       compatible = "cfi-flash";
+                       reg = <0x0 0x0 0x4000000>;
+
+                       bank-width = <2>;
+                       device-width = <1>;
+
+                       csl_s@200000 {
+                               label = "csl_s";
+                               reg = <0x20000 0x200000>;
+                       };
+
+                       space_ava@400000 {
+                               label ="Space Available";
+                               reg = <0x400000 0x2BA0000>;
+                       };
+
+                       nvram_backup@35e0000 {
+                               label ="NVRAM Backup";
+                               reg = <0x35e0000 0x20000>;
+                       };
+
+                       upgrade@3600000 {
+                               label ="Upgrade Boot Rom";
+                               reg = <0x3600000 0x200000>;
+                       };
+
+                       nvram@3de0000 {
+                               label ="NVRAM";
+                               reg = <0x3de0000 0x20000>;
+                       };
+
+                       bootrom@3e00000 {
+                               label ="Running Boot Rom";
+                               reg = <0x3e00000 0x200000>;
+                               read-only;
+                       };
+               };
+       };
+
