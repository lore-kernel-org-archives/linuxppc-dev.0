Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id F1DE0DDE19
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Oct 2007 19:57:26 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1IkzSt-0006LR-9D
	for linuxppc-dev@ozlabs.org; Thu, 25 Oct 2007 02:57:23 -0700
Message-ID: <13403420.post@talk.nabble.com>
Date: Thu, 25 Oct 2007 02:57:23 -0700 (PDT)
From: Martin Krause <Martin.Krause@tqs.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 05/11] [POWERPC] TQM5200 DTS
In-Reply-To: <20071023231333.29359.35252.stgit@hekate.izotz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <20071023231302.29359.27417.stgit@hekate.izotz.org>
	<20071023231333.29359.35252.stgit@hekate.izotz.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



< +		flash@00000000 {
< +			compatible = "cfi-flash";
< +			reg = <00000000 02000000>;
< +			bank-width = <4>;
< +			device-width = <2>;
< +			#size-cells = <1>;
< +			#address-cells = <1>;
< +			partition@0 {
< +				label = "firmware";
< +				reg = <0 a0000>;
< +			};
< +			partition@a0000 {
< +				label = "dtb";
< +				reg = <a0000 20000>;
< +			};
< +			partition@c0000 {
< +				label = "kernel";
< +				reg = <c0000 240000>;
< +			};
< +			partition@300000 {
< +				label = "initrd";
< +				reg = <300000 200000>;
< +			};
< +			partition@500000 {
< +				label = "small-fs";
< +				reg = <500000 400000>;
< +			};
< +			partition@900000 {
< +				label = "misc";
< +				reg = <900000 800000>;
< +			};
< +			partition@1100000 {
< +				label = "big-fs";
< +				reg = <1100000 f00000>;
< +			};
< +		};
< +	};

This MTD layout only works on boards with 32 MiB (or 64 MiB) flash
memory. On TQM5200 boards with smaller Flashes (16 MiB, 8 MiB and 4 MiB) 
the MTD partition borders do not match with the physikal memory borders.
On a board with 16 MiB FLASH for example the "big-fs" _and_ the "misc"
partition could not be used. "big-fs", because the memory is too small
(which is OK) and "misc", because it overlaps 1 MiB over the physikal
flash border. So only the first 9 MiB of the flash could be used in Linux.
The remaining 7 MiB couldn't be accessed.

I would propose a Flash layout, where the (filesystem) partitions end 
on powers of two, to match the physical flash boarders:

			partition@0 {
				label = "firmware";
				reg = <0 a0000>;
			};
			partition@a0000 {
				label = "dtb";
				reg = <a0000 20000>;
			};
			partition@c0000 {
				label = "kernel";
				reg = <c0000 180000>;
			};
			partition@240000 {
				label = "initrd";
				reg = <240000 1c0000>;
			};
			partition@400000 {
				label = "small-fs";
				reg = <400000 400000>;
			};
			partition@800000 {
				label = "misc";
				reg = <800000 800000>;
			};
			partition@1000000 {
				label = "big-fs";
				reg = <1000000 1000000>;
			};
		};
	};

Best Regards,
Martin Krause
-- 
View this message in context: http://www.nabble.com/-PATCH-00-11---POWERPC--Add-TQM5200-CM5200-Motion-PRO-board-support-tf4680980.html#a13403420
Sent from the linuxppc-dev mailing list archive at Nabble.com.
