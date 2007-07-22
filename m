Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18082.42674.651685.720737@cargo.ozlabs.ibm.com>
Date: Sun, 22 Jul 2007 10:37:06 +1000
From: Paul Mackerras <paulus@samba.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: Someone broke my allmodconfig build
In-Reply-To: <20070722001212.5007001d.sfr@canb.auug.org.au>
References: <20070722001212.5007001d.sfr@canb.auug.org.au>
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Stephen Rothwell writes:

>   WRAP    arch/powerpc/boot/zImage.ps3
> /home/sfr/kernels/linus/arch/powerpc/boot/wrapper: line 113: dtc: command not found
> make[2]: *** [arch/powerpc/boot/zImage.ps3] Error 1

Hmmm, we should be shipping .dtb files with the tree, so people don't
have to have dtc installed.

> ERROR: "pmu_batteries" [drivers/power/pmu_battery.ko] undefined!
> ERROR: "pmu_battery_count" [drivers/power/pmu_battery.ko] undefined!
> ERROR: "pmu_power_flags" [drivers/power/pmu_battery.ko] undefined!

I'd say CONFIG_BATTERY_PMU needs to depend on PPC32.  There are no
battery-powered ppc64 machines with an Apple PMU, and we can say
pretty confidently there never will be.

Paul.
