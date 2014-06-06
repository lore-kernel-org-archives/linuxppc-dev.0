Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0205.outbound.protection.outlook.com [207.46.163.205])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 750DF1A0008
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Jun 2014 06:47:52 +1000 (EST)
Message-ID: <1402087652.6603.450.camel@snotra.buserror.net>
Subject: Re: [linuxppc-release] [PATCH][v10] powerpc/mpc85xx:Add initial
 device	tree support of T104x
From: Scott Wood <scottwood@freescale.com>
To: Liu Shengzhou-B36685 <Shengzhou.Liu@freescale.com>
Date: Fri, 6 Jun 2014 15:47:32 -0500
In-Reply-To: <c0213fde8dd24026af31ccce2fec21bf@DM2PR03MB398.namprd03.prod.outlook.com>
References: <1398080069-3807-1-git-send-email-prabhakar@freescale.com>
 <c0213fde8dd24026af31ccce2fec21bf@DM2PR03MB398.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Aggrwal Poonam-B10812 <Poonam.Aggrwal@freescale.com>, Jain
 Priyanka-B32167 <Priyanka.Jain@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Kushwaha Prabhakar-B32579 <prabhakar@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2014-06-06 at 00:04 -0500, Liu Shengzhou-B36685 wrote:
> 
> > -----Original Message-----
> > From: linuxppc-release-bounces@linux.freescale.net [mailto:linuxppc-
> > release-bounces@linux.freescale.net] On Behalf Of Prabhakar Kushwaha
> > Sent: Monday, April 21, 2014 7:34 PM
> > To: linuxppc-dev@lists.ozlabs.org
> > Cc: Wood Scott-B07421; Jain Priyanka-B32167; Aggrwal Poonam-B10812;
> > Kushwaha Prabhakar-B32579
> > Subject: [linuxppc-release] [PATCH][v10] powerpc/mpc85xx:Add initial
> > device tree support of T104x
> > 
> > The QorIQ T1040/T1042 processor support four integrated 64-bit e5500 PA
> > processor cores with high-performance data path acceleration architecture
> > and network peripheral interfaces required for networking &
> > telecommunications.
> > 
> > +
> > +	iommu@20000 {
> > +		compatible = "fsl,pamu-v1.0", "fsl,pamu";
> > +		reg = <0x20000 0x1000>;
> > +		ranges = <0 0x20000 0x1000>;
> > +		#address-cells = <1>;
> > +		#size-cells = <1>;
> > +		interrupts = <
> > +			24 2 0 0
> > +			16 2 1 30>;
> > +		pamu0: pamu@0 {
> > +			reg = <0 0x1000>;
> > +			fsl,primary-cache-geometry = <128 1>;
> > +			fsl,secondary-cache-geometry = <16 2>;
> > +		};
> 
> 
> [Shengzhou]  T1040 RM says:
> Hardware coherent PAMU Look-aside caches to improve performance
> * A 32-entry, direct-mapped primary PAACT cache
> * A 128-entry, 2-way, set-associative secondary PAACT cache
> It appears it should be: 
>        fsl,primary-cache-geometry = <32 1>;
>        fsl,secondary-cache-geometry = <128 2>;
> 
> is there any reason that it was "<128 1>,  <16 2>" ?

The B4 device trees are also suspicous.

-Scott
