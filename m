Return-Path: <Geoffrey.Levand@am.sony.com>
Message-ID: <487274DA.7020203@am.sony.com>
Date: Mon, 7 Jul 2008 12:56:10 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: arnd@arndb.de
Subject: Re: [patch 05/11] powerpc/cell: add spu aware cpufreq governor
References: <20080704190535.316377278@arndb.de>
	<20080704190806.162475834@arndb.de>
In-Reply-To: <20080704190806.162475834@arndb.de>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: Paul Mackerras <paulus@samba.org>, cbe-oss-dev@ozlabs.org,
	Christian Krafft <krafft@de.ibm.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

arnd@arndb.de wrote:
> This patch adds a cpufreq governor that takes the number of running spus
> into account. It's very similar to the ondemand governor, but not as complex.
> Instead of hacking spu load into the ondemand governor it might be easier to
> have cpufreq accepting multiple governors per cpu in future.
> Don't know if this is the right way, but it would keep the governors simple.

I tried your current cell-2.6.git #cell_next branch with ps3_defconfig and
get these. ps3_defconfig has

 CONFIG_CBE_CPUFREQ=m
 CONFIG_CBE_CPUFREQ_SPU_GOVERNOR=m

I'm not sure if this patch is the one that introduced the problem though.
I guess we need to make an adjustment in the Kconfig.  I'll be away the
rest of this week, and will look at it next week if you don't.

-Geoff

cell-2.6/arch/powerpc/platforms/cell/cbe_spu_governor.c: In function 'calc_freq':
cell-2.6/arch/powerpc/platforms/cell/cbe_spu_governor.c:53: warning: format '%d' expects type 'int', but argument 4 has type 'long unsigned int'

ERROR: ".cpufreq_register_governor" [arch/powerpc/platforms/cell/cbe_spu_governor.ko] undefined!
ERROR: ".__cpufreq_driver_target" [arch/powerpc/platforms/cell/cbe_spu_governor.ko] undefined!
ERROR: ".cpufreq_unregister_governor" [arch/powerpc/platforms/cell/cbe_spu_governor.ko] undefined!
ERROR: ".cpufreq_frequency_table_target" [arch/powerpc/platforms/cell/cbe-cpufreq.ko] undefined!
ERROR: ".cpufreq_register_driver" [arch/powerpc/platforms/cell/cbe-cpufreq.ko] undefined!
ERROR: ".cpufreq_frequency_table_verify" [arch/powerpc/platforms/cell/cbe-cpufreq.ko] undefined!
ERROR: ".cpufreq_frequency_table_get_attr" [arch/powerpc/platforms/cell/cbe-cpufreq.ko] undefined!
ERROR: ".cpufreq_notify_transition" [arch/powerpc/platforms/cell/cbe-cpufreq.ko] undefined!
ERROR: ".cpufreq_frequency_table_cpuinfo" [arch/powerpc/platforms/cell/cbe-cpufreq.ko] undefined!
ERROR: ".cbe_get_cpu_mic_tm_regs" [arch/powerpc/platforms/cell/cbe-cpufreq.ko] undefined!
ERROR: ".cbe_get_cpu_pmd_regs" [arch/powerpc/platforms/cell/cbe-cpufreq.ko] undefined!
ERROR: ".cpufreq_unregister_driver" [arch/powerpc/platforms/cell/cbe-cpufreq.ko] undefined!
ERROR: ".cpufreq_frequency_table_put_attr" [arch/powerpc/platforms/cell/cbe-cpufreq.ko] undefined!
