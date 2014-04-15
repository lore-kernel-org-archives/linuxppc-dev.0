Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0186.outbound.protection.outlook.com [207.46.163.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 1FA60140309
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Apr 2014 03:15:12 +1000 (EST)
Message-ID: <1397582101.20280.241.camel@snotra.buserror.net>
Subject: Re: [PATCH] powerpc/85xx: Add OCA4080 board support
From: Scott Wood <scottwood@freescale.com>
To: Martijn de Gouw <martijn.de.gouw@prodrive-technologies.com>
Date: Tue, 15 Apr 2014 12:15:01 -0500
In-Reply-To: <534D16F6.9090305@prodrive-technologies.com>
References: <1397478910-26361-1-git-send-email-martijn.de.gouw@prodrive-technologies.com>
 <1397514507.20280.223.camel@snotra.buserror.net>
 <534D16F6.9090305@prodrive-technologies.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: stef.van.os@prodrive-technologies.com,
 Martijn de Gouw <martijn.de.gouw@prodrive.nl>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-04-15 at 13:24 +0200, Martijn de Gouw wrote:
> On 04/15/2014 12:28 AM, Scott Wood wrote:
> > On Mon, 2014-04-14 at 14:35 +0200, Martijn de Gouw wrote:
> >> +	lbc: localbus@ffe124000 {
> >> +		reg = <0xf 0xfe124000 0 0x1000>;
> >> +		ranges = <0 0 0xf 0xef800000 0x800000>;
> >> +
> >> +		flash@0,0 {
> >> +			#address-cells = <1>;
> >> +			#size-cells = <1>;
> >> +			compatible = "cfi-flash";
> >> +			reg = <0 0 0x00800000>;
> >> +			bank-width = <2>;
> >> +			device-width = <2>;
> >> +			partition@rcw {
> >> +				label = "rcw";
> >> +				reg = <0x00000000 0x00020000>;
> >> +			};
> >> +			partition@fman-ucode {
> >> +				label = "fman-ucode";
> >> +				reg = <0x00020000 0x00020000>;
> >> +			};
> >> +			partition@user {
> >> +				label = "user";
> >> +				reg = <0x00040000 0x00680000>;
> >> +			};
> >> +			partition@env0 {
> >> +				label = "env0";
> >> +				reg = <0x006c0000 0x00020000>;
> >> +			};
> >> +			partition@env1 {
> >> +				label = "env1";
> >> +				reg = <0x006e0000 0x00020000>;
> >> +			};
> >> +			partition@u-boot {
> >> +				label = "u-boot";
> >> +				reg = <0x00700000 0x00080000>;
> >> +			};
> >> +			partition@u-boot-backup {
> >> +				label = "u-boot-backup";
> >> +				reg = <0x00780000 0x00080000>;
> >> +			};
> >
> > These are not valid unit addresses.  Regardless, please don't put
> > partition info in the dts.
> 
> How is this different than the partitions defined in i.e. p4080ds.dts?

If you mean the unit addresses, they're supposed to be hex numbers that
match reg.  If you mean why are they there at all in p4080ds.dts, a lot
of existing trees have them but it's bad to mix configuration in with
hardware description and we're discouraging putting partitions in new
dts files.  It would be nice to clean up the old dts files as well,
though I'm concerned about people who are currently relying on them.
OTOH I'm also concerned about users for whom the dts partitions don't
match reality...

> Of course I can remove them from the dts, but where should they be defined?

Either use mtdparts on the kernel command line, or have U-Boot generate
the partition nodes at runtime based on the mtdparts environment
variable (there is already code for this).

-Scott
