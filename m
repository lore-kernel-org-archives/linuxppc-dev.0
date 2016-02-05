Return-Path: <philip@turmel.org>
Received: from atl.turmel.org (atl.turmel.org [74.117.157.138])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BFB721A0205
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Feb 2016 10:42:01 +1100 (AEDT)
Subject: Re: Bisected Regression 4.3.5 => 4.4.1 booting HP ZBook in EFI mode
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <56B518C4.8030007@turmel.org> <20160205222936.GA7139@kroah.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, LKML <linux-kernel@vger.kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Thomas Gleixner <tglx@linutronix.de>,
 linuxppc-dev@lists.ozlabs.org
From: Phil Turmel <philip@turmel.org>
Message-ID: <56B53344.3090300@turmel.org>
Date: Fri, 5 Feb 2016 18:41:56 -0500
MIME-Version: 1.0
In-Reply-To: <20160205222936.GA7139@kroah.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/05/2016 05:29 PM, Greg Kroah-Hartman wrote:
> On Fri, Feb 05, 2016 at 04:48:52PM -0500, Phil Turmel wrote:

>> I'm stumped as to how that powerpc patch can affect my x86 laptop, an
>> HP ZBook 17 w/ i7 processor & nouveau graphics, but it certainly
>> does.  The bisect was stable and I confirmed by reverting it on
>> top of the intended v4.4.1.
> 
> That's crazy, nothing should even be rebuilt if you revert that patch,
> so I don't see how that could affect things here.

I thought so too, but ...

> Can you verify that nothing does get rebuilt when you do this?

# git checkout v4.4.1

# make -j15
////// lots of output ///////

# make
  CHK     include/config/kernel.release
  CHK     include/generated/uapi/linux/version.h
  CHK     include/generated/utsrelease.h
  CHK     include/generated/bounds.h
  CHK     include/generated/timeconst.h
  CHK     include/generated/asm-offsets.h
  CALL    scripts/checksyscalls.sh
  CHK     include/generated/compile.h
  CHK     kernel/config_data.h
Kernel: arch/x86/boot/bzImage is ready  (#133)
  Building modules, stage 2.
  MODPOST 1166 modules

# git revert badc688
////// trimmed commit log ///////
 1 file changed, 8 insertions(+), 8 deletions(-)

# make
  CHK     include/config/kernel.release
  UPD     include/config/kernel.release
  CHK     include/generated/uapi/linux/version.h
  CHK     include/generated/utsrelease.h
  UPD     include/generated/utsrelease.h
  CHK     include/generated/bounds.h
  CHK     include/generated/timeconst.h
  CHK     include/generated/asm-offsets.h
  CALL    scripts/checksyscalls.sh
  CHK     include/generated/compile.h
  CC      init/version.o
  LD      init/built-in.o
  CC      kernel/sys.o
  CC      kernel/trace/trace.o
  LD      kernel/trace/built-in.o
  CC      kernel/module.o
  CHK     kernel/config_data.h
  LD      kernel/built-in.o
  CC      drivers/base/firmware_class.o
  LD      drivers/base/built-in.o
  CC      drivers/gpu/drm/i915/i915_gpu_error.o
  LD      drivers/gpu/drm/i915/i915.o
  LD      drivers/gpu/drm/i915/built-in.o
  LD      drivers/gpu/drm/built-in.o
  LD      drivers/gpu/built-in.o
  CC      drivers/target/target_core_configfs.o
  LD      drivers/target/target_core_mod.o
  LD      drivers/target/built-in.o
  CC [M]  drivers/vhost/scsi.o
  LD [M]  drivers/vhost/vhost_scsi.o
  LD      drivers/built-in.o
  LINK    vmlinux
  LD      vmlinux.o
  MODPOST vmlinux.o
  GEN     .version
  CHK     include/generated/compile.h
  UPD     include/generated/compile.h
  CC      init/version.o
  LD      init/built-in.o
  KSYM    .tmp_kallsyms1.o
  KSYM    .tmp_kallsyms2.o
  LD      vmlinux
  SORTEX  vmlinux
  SYSMAP  System.map
  VOFFSET arch/x86/boot/voffset.h
  OBJCOPY arch/x86/boot/compressed/vmlinux.bin
  LZMA    arch/x86/boot/compressed/vmlinux.bin.lzma
  MKPIGGY arch/x86/boot/compressed/piggy.S
  AS      arch/x86/boot/compressed/piggy.o
  LD      arch/x86/boot/compressed/vmlinux
  ZOFFSET arch/x86/boot/zoffset.h
  AS      arch/x86/boot/header.o
  CC      arch/x86/boot/version.o
  LD      arch/x86/boot/setup.elf
  OBJCOPY arch/x86/boot/setup.bin
  OBJCOPY arch/x86/boot/vmlinux.bin
  BUILD   arch/x86/boot/bzImage
Setup is 15564 bytes (padded to 15872 bytes).
System is 26558 kB
CRC 29b78b83
Kernel: arch/x86/boot/bzImage is ready  (#134)
  Building modules, stage 2.
  MODPOST 1166 modules

//////
So, a handful of items in the main kernel get
rebuilt, including i915 stuff.  This laptop does
have the intel graphics base with nvidia layered
on top.

The build proceeded to redo all my modules, shown below.

Phil

//////

  CC      drivers/bcma/bcma.mod.o
  LD [M]  drivers/bcma/bcma.ko
  CC      drivers/block/drbd/drbd.mod.o
  LD [M]  drivers/block/drbd/drbd.ko
  CC      drivers/block/floppy.mod.o
  LD [M]  drivers/block/floppy.ko
  CC      drivers/block/mtip32xx/mtip32xx.mod.o
  LD [M]  drivers/block/mtip32xx/mtip32xx.ko
  CC      drivers/block/nbd.mod.o
  LD [M]  drivers/block/nbd.ko
  CC      drivers/block/rbd.mod.o
  LD [M]  drivers/block/rbd.ko
  CC      drivers/block/rsxx/rsxx.mod.o
  LD [M]  drivers/block/rsxx/rsxx.ko
  CC      drivers/block/virtio_blk.mod.o
  LD [M]  drivers/block/virtio_blk.ko
  CC      drivers/bluetooth/ath3k.mod.o
  LD [M]  drivers/bluetooth/ath3k.ko
  CC      drivers/bluetooth/bcm203x.mod.o
  LD [M]  drivers/bluetooth/bcm203x.ko
  CC      drivers/bluetooth/bfusb.mod.o
  LD [M]  drivers/bluetooth/bfusb.ko
  CC      drivers/bluetooth/bluecard_cs.mod.o
  LD [M]  drivers/bluetooth/bluecard_cs.ko
  CC      drivers/bluetooth/bpa10x.mod.o
  LD [M]  drivers/bluetooth/bpa10x.ko
  CC      drivers/bluetooth/bt3c_cs.mod.o
  LD [M]  drivers/bluetooth/bt3c_cs.ko
  CC      drivers/bluetooth/btbcm.mod.o
  LD [M]  drivers/bluetooth/btbcm.ko
  CC      drivers/bluetooth/btintel.mod.o
  LD [M]  drivers/bluetooth/btintel.ko
  CC      drivers/bluetooth/btmrvl.mod.o
  LD [M]  drivers/bluetooth/btmrvl.ko
  CC      drivers/bluetooth/btmrvl_sdio.mod.o
  LD [M]  drivers/bluetooth/btmrvl_sdio.ko
  CC      drivers/bluetooth/btrtl.mod.o
  LD [M]  drivers/bluetooth/btrtl.ko
  CC      drivers/bluetooth/btsdio.mod.o
  LD [M]  drivers/bluetooth/btsdio.ko
  CC      drivers/bluetooth/btuart_cs.mod.o
  LD [M]  drivers/bluetooth/btuart_cs.ko
  CC      drivers/bluetooth/btusb.mod.o
  LD [M]  drivers/bluetooth/btusb.ko
  CC      drivers/bluetooth/dtl1_cs.mod.o
  LD [M]  drivers/bluetooth/dtl1_cs.ko
  CC      drivers/bluetooth/hci_uart.mod.o
  LD [M]  drivers/bluetooth/hci_uart.ko
  CC      drivers/bluetooth/hci_vhci.mod.o
  LD [M]  drivers/bluetooth/hci_vhci.ko
  CC      drivers/char/mwave/mwave.mod.o
  LD [M]  drivers/char/mwave/mwave.ko
  CC      drivers/char/nvram.mod.o
  LD [M]  drivers/char/nvram.ko
  CC      drivers/char/tpm/st33zp24/tpm_st33zp24.mod.o
  LD [M]  drivers/char/tpm/st33zp24/tpm_st33zp24.ko
  CC      drivers/char/tpm/st33zp24/tpm_st33zp24_i2c.mod.o
  LD [M]  drivers/char/tpm/st33zp24/tpm_st33zp24_i2c.ko
  CC      drivers/char/tpm/st33zp24/tpm_st33zp24_spi.mod.o
  LD [M]  drivers/char/tpm/st33zp24/tpm_st33zp24_spi.ko
  CC      drivers/char/tpm/tpm_atmel.mod.o
  LD [M]  drivers/char/tpm/tpm_atmel.ko
  CC      drivers/char/tpm/tpm_crb.mod.o
  LD [M]  drivers/char/tpm/tpm_crb.ko
  CC      drivers/char/tpm/tpm_i2c_atmel.mod.o
  LD [M]  drivers/char/tpm/tpm_i2c_atmel.ko
  CC      drivers/char/tpm/tpm_i2c_infineon.mod.o
  LD [M]  drivers/char/tpm/tpm_i2c_infineon.ko
  CC      drivers/char/tpm/tpm_i2c_nuvoton.mod.o
  LD [M]  drivers/char/tpm/tpm_i2c_nuvoton.ko
  CC      drivers/char/tpm/tpm_infineon.mod.o
  LD [M]  drivers/char/tpm/tpm_infineon.ko
  CC      drivers/char/tpm/tpm_nsc.mod.o
  LD [M]  drivers/char/tpm/tpm_nsc.ko
  CC      drivers/char/tpm/tpm_tis.mod.o
  LD [M]  drivers/char/tpm/tpm_tis.ko
  CC      drivers/cpufreq/cpufreq_stats.mod.o
  LD [M]  drivers/cpufreq/cpufreq_stats.ko
  CC      drivers/crypto/padlock-aes.mod.o
  LD [M]  drivers/crypto/padlock-aes.ko
  CC      drivers/crypto/padlock-sha.mod.o
  LD [M]  drivers/crypto/padlock-sha.ko
  CC      drivers/gpio/gpio-adp5520.mod.o
  LD [M]  drivers/gpio/gpio-adp5520.ko
  CC      drivers/gpio/gpio-adp5588.mod.o
  LD [M]  drivers/gpio/gpio-adp5588.ko
  CC      drivers/gpio/gpio-amd8111.mod.o
  LD [M]  drivers/gpio/gpio-amd8111.ko
  CC      drivers/gpio/gpio-da9052.mod.o
  LD [M]  drivers/gpio/gpio-da9052.ko
  CC      drivers/gpio/gpio-f7188x.mod.o
  LD [M]  drivers/gpio/gpio-f7188x.ko
  CC      drivers/gpio/gpio-ich.mod.o
  LD [M]  drivers/gpio/gpio-ich.ko
  CC      drivers/gpio/gpio-janz-ttl.mod.o
  LD [M]  drivers/gpio/gpio-janz-ttl.ko
  CC      drivers/gpio/gpio-max7300.mod.o
  LD [M]  drivers/gpio/gpio-max7300.ko
  CC      drivers/gpio/gpio-max7301.mod.o
  LD [M]  drivers/gpio/gpio-max7301.ko
  CC      drivers/gpio/gpio-max730x.mod.o
  LD [M]  drivers/gpio/gpio-max730x.ko
  CC      drivers/gpio/gpio-max732x.mod.o
  LD [M]  drivers/gpio/gpio-max732x.ko
  CC      drivers/gpio/gpio-mc33880.mod.o
  LD [M]  drivers/gpio/gpio-mc33880.ko
  CC      drivers/gpio/gpio-ml-ioh.mod.o
  LD [M]  drivers/gpio/gpio-ml-ioh.ko
  CC      drivers/gpio/gpio-pca953x.mod.o
  LD [M]  drivers/gpio/gpio-pca953x.ko
  CC      drivers/gpio/gpio-pcf857x.mod.o
  LD [M]  drivers/gpio/gpio-pcf857x.ko
  CC      drivers/gpio/gpio-rdc321x.mod.o
  LD [M]  drivers/gpio/gpio-rdc321x.ko
  CC      drivers/gpio/gpio-sch.mod.o
  LD [M]  drivers/gpio/gpio-sch.ko
  CC      drivers/gpio/gpio-twl4030.mod.o
  LD [M]  drivers/gpio/gpio-twl4030.ko
  CC      drivers/gpio/gpio-vx855.mod.o
  LD [M]  drivers/gpio/gpio-vx855.ko
  CC      drivers/gpio/gpio-wm831x.mod.o
  LD [M]  drivers/gpio/gpio-wm831x.ko
  CC      drivers/gpio/gpio-wm8350.mod.o
  LD [M]  drivers/gpio/gpio-wm8350.ko
  CC      drivers/gpio/gpio-wm8994.mod.o
  LD [M]  drivers/gpio/gpio-wm8994.ko
  CC      drivers/gpu/drm/i2c/ch7006.mod.o
  LD [M]  drivers/gpu/drm/i2c/ch7006.ko
  CC      drivers/gpu/drm/i2c/sil164.mod.o
  LD [M]  drivers/gpu/drm/i2c/sil164.ko
  CC      drivers/gpu/drm/i2c/tda998x.mod.o
  LD [M]  drivers/gpu/drm/i2c/tda998x.ko
  CC      drivers/gpu/drm/virtio/virtio-gpu.mod.o
  LD [M]  drivers/gpu/drm/virtio/virtio-gpu.ko
  CC      drivers/hid/hid-a4tech.mod.o
  LD [M]  drivers/hid/hid-a4tech.ko
  CC      drivers/hid/hid-axff.mod.o
  LD [M]  drivers/hid/hid-axff.ko
  CC      drivers/hid/hid-elo.mod.o
  LD [M]  drivers/hid/hid-elo.ko
  CC      drivers/hid/hid-generic.mod.o
  LD [M]  drivers/hid/hid-generic.ko
  CC      drivers/hid/i2c-hid/i2c-hid.mod.o
  LD [M]  drivers/hid/i2c-hid/i2c-hid.ko
  CC      drivers/hwmon/abituguru.mod.o
  LD [M]  drivers/hwmon/abituguru.ko
  CC      drivers/hwmon/abituguru3.mod.o
  LD [M]  drivers/hwmon/abituguru3.ko
  CC      drivers/hwmon/acpi_power_meter.mod.o
  LD [M]  drivers/hwmon/acpi_power_meter.ko
  CC      drivers/hwmon/ad7314.mod.o
  LD [M]  drivers/hwmon/ad7314.ko
  CC      drivers/hwmon/ad7414.mod.o
  LD [M]  drivers/hwmon/ad7414.ko
  CC      drivers/hwmon/ad7418.mod.o
  LD [M]  drivers/hwmon/ad7418.ko
  CC      drivers/hwmon/adc128d818.mod.o
  LD [M]  drivers/hwmon/adc128d818.ko
  CC      drivers/hwmon/adcxx.mod.o
  LD [M]  drivers/hwmon/adcxx.ko
  CC      drivers/hwmon/adm1021.mod.o
  LD [M]  drivers/hwmon/adm1021.ko
  CC      drivers/hwmon/adm1025.mod.o
  LD [M]  drivers/hwmon/adm1025.ko
  CC      drivers/hwmon/adm1026.mod.o
  LD [M]  drivers/hwmon/adm1026.ko
  CC      drivers/hwmon/adm1029.mod.o
  LD [M]  drivers/hwmon/adm1029.ko
  CC      drivers/hwmon/adm1031.mod.o
  LD [M]  drivers/hwmon/adm1031.ko
  CC      drivers/hwmon/adm9240.mod.o
  LD [M]  drivers/hwmon/adm9240.ko
  CC      drivers/hwmon/ads1015.mod.o
  LD [M]  drivers/hwmon/ads1015.ko
  CC      drivers/hwmon/ads7828.mod.o
  LD [M]  drivers/hwmon/ads7828.ko
  CC      drivers/hwmon/ads7871.mod.o
  LD [M]  drivers/hwmon/ads7871.ko
  CC      drivers/hwmon/adt7410.mod.o
  LD [M]  drivers/hwmon/adt7410.ko
  CC      drivers/hwmon/adt7411.mod.o
  LD [M]  drivers/hwmon/adt7411.ko
  CC      drivers/hwmon/adt7462.mod.o
  LD [M]  drivers/hwmon/adt7462.ko
  CC      drivers/hwmon/adt7470.mod.o
  LD [M]  drivers/hwmon/adt7470.ko
  CC      drivers/hwmon/adt7475.mod.o
  LD [M]  drivers/hwmon/adt7475.ko
  CC      drivers/hwmon/adt7x10.mod.o
  LD [M]  drivers/hwmon/adt7x10.ko
  CC      drivers/hwmon/amc6821.mod.o
  LD [M]  drivers/hwmon/amc6821.ko
  CC      drivers/hwmon/applesmc.mod.o
  LD [M]  drivers/hwmon/applesmc.ko
  CC      drivers/hwmon/asb100.mod.o
  LD [M]  drivers/hwmon/asb100.ko
  CC      drivers/hwmon/asc7621.mod.o
  LD [M]  drivers/hwmon/asc7621.ko
  CC      drivers/hwmon/asus_atk0110.mod.o
  LD [M]  drivers/hwmon/asus_atk0110.ko
  CC      drivers/hwmon/atxp1.mod.o
  LD [M]  drivers/hwmon/atxp1.ko
  CC      drivers/hwmon/coretemp.mod.o
  LD [M]  drivers/hwmon/coretemp.ko
  CC      drivers/hwmon/da9052-hwmon.mod.o
  LD [M]  drivers/hwmon/da9052-hwmon.ko
  CC      drivers/hwmon/dme1737.mod.o
  LD [M]  drivers/hwmon/dme1737.ko
  CC      drivers/hwmon/ds1621.mod.o
  LD [M]  drivers/hwmon/ds1621.ko
  CC      drivers/hwmon/ds620.mod.o
  LD [M]  drivers/hwmon/ds620.ko
  CC      drivers/hwmon/emc1403.mod.o
  LD [M]  drivers/hwmon/emc1403.ko
  CC      drivers/hwmon/emc2103.mod.o
  LD [M]  drivers/hwmon/emc2103.ko
  CC      drivers/hwmon/emc6w201.mod.o
  LD [M]  drivers/hwmon/emc6w201.ko
  CC      drivers/hwmon/f71805f.mod.o
  LD [M]  drivers/hwmon/f71805f.ko
  CC      drivers/hwmon/f71882fg.mod.o
  LD [M]  drivers/hwmon/f71882fg.ko
  CC      drivers/hwmon/f75375s.mod.o
  LD [M]  drivers/hwmon/f75375s.ko
  CC      drivers/hwmon/fam15h_power.mod.o
  LD [M]  drivers/hwmon/fam15h_power.ko
  CC      drivers/hwmon/fschmd.mod.o
  LD [M]  drivers/hwmon/fschmd.ko
  CC      drivers/hwmon/g760a.mod.o
  LD [M]  drivers/hwmon/g760a.ko
  CC      drivers/hwmon/g762.mod.o
  LD [M]  drivers/hwmon/g762.ko
  CC      drivers/hwmon/gl518sm.mod.o
  LD [M]  drivers/hwmon/gl518sm.ko
  CC      drivers/hwmon/gl520sm.mod.o
  LD [M]  drivers/hwmon/gl520sm.ko
  CC      drivers/hwmon/gpio-fan.mod.o
  LD [M]  drivers/hwmon/gpio-fan.ko
  CC      drivers/hwmon/hih6130.mod.o
  LD [M]  drivers/hwmon/hih6130.ko
  CC      drivers/hwmon/hwmon-vid.mod.o
  LD [M]  drivers/hwmon/hwmon-vid.ko
  CC      drivers/hwmon/i5k_amb.mod.o
  LD [M]  drivers/hwmon/i5k_amb.ko
  CC      drivers/hwmon/ina209.mod.o
  LD [M]  drivers/hwmon/ina209.ko
  CC      drivers/hwmon/ina2xx.mod.o
  LD [M]  drivers/hwmon/ina2xx.ko
  CC      drivers/hwmon/it87.mod.o
  LD [M]  drivers/hwmon/it87.ko
  CC      drivers/hwmon/jc42.mod.o
  LD [M]  drivers/hwmon/jc42.ko
  CC      drivers/hwmon/k10temp.mod.o
  LD [M]  drivers/hwmon/k10temp.ko
  CC      drivers/hwmon/k8temp.mod.o
  LD [M]  drivers/hwmon/k8temp.ko
  CC      drivers/hwmon/lineage-pem.mod.o
  LD [M]  drivers/hwmon/lineage-pem.ko
  CC      drivers/hwmon/lm63.mod.o
  LD [M]  drivers/hwmon/lm63.ko
  CC      drivers/hwmon/lm70.mod.o
  LD [M]  drivers/hwmon/lm70.ko
  CC      drivers/hwmon/lm73.mod.o
  LD [M]  drivers/hwmon/lm73.ko
  CC      drivers/hwmon/lm75.mod.o
  LD [M]  drivers/hwmon/lm75.ko
  CC      drivers/hwmon/lm77.mod.o
  LD [M]  drivers/hwmon/lm77.ko
  CC      drivers/hwmon/lm78.mod.o
  LD [M]  drivers/hwmon/lm78.ko
  CC      drivers/hwmon/lm80.mod.o
  LD [M]  drivers/hwmon/lm80.ko
  CC      drivers/hwmon/lm83.mod.o
  LD [M]  drivers/hwmon/lm83.ko
  CC      drivers/hwmon/lm85.mod.o
  LD [M]  drivers/hwmon/lm85.ko
  CC      drivers/hwmon/lm87.mod.o
  LD [M]  drivers/hwmon/lm87.ko
  CC      drivers/hwmon/lm90.mod.o
  LD [M]  drivers/hwmon/lm90.ko
  CC      drivers/hwmon/lm92.mod.o
  LD [M]  drivers/hwmon/lm92.ko
  CC      drivers/hwmon/lm93.mod.o
  LD [M]  drivers/hwmon/lm93.ko
  CC      drivers/hwmon/lm95241.mod.o
  LD [M]  drivers/hwmon/lm95241.ko
  CC      drivers/hwmon/lm95245.mod.o
  LD [M]  drivers/hwmon/lm95245.ko
  CC      drivers/hwmon/ltc2945.mod.o
  LD [M]  drivers/hwmon/ltc2945.ko
  CC      drivers/hwmon/ltc4151.mod.o
  LD [M]  drivers/hwmon/ltc4151.ko
  CC      drivers/hwmon/ltc4215.mod.o
  LD [M]  drivers/hwmon/ltc4215.ko
  CC      drivers/hwmon/ltc4222.mod.o
  LD [M]  drivers/hwmon/ltc4222.ko
  CC      drivers/hwmon/ltc4245.mod.o
  LD [M]  drivers/hwmon/ltc4245.ko
  CC      drivers/hwmon/ltc4260.mod.o
  LD [M]  drivers/hwmon/ltc4260.ko
  CC      drivers/hwmon/ltc4261.mod.o
  LD [M]  drivers/hwmon/ltc4261.ko
  CC      drivers/hwmon/max1111.mod.o
  LD [M]  drivers/hwmon/max1111.ko
  CC      drivers/hwmon/max16065.mod.o
  LD [M]  drivers/hwmon/max16065.ko
  CC      drivers/hwmon/max1619.mod.o
  LD [M]  drivers/hwmon/max1619.ko
  CC      drivers/hwmon/max1668.mod.o
  LD [M]  drivers/hwmon/max1668.ko
  CC      drivers/hwmon/max197.mod.o
  LD [M]  drivers/hwmon/max197.ko
  CC      drivers/hwmon/max6639.mod.o
  LD [M]  drivers/hwmon/max6639.ko
  CC      drivers/hwmon/max6642.mod.o
  LD [M]  drivers/hwmon/max6642.ko
  CC      drivers/hwmon/max6650.mod.o
  LD [M]  drivers/hwmon/max6650.ko
  CC      drivers/hwmon/max6697.mod.o
  LD [M]  drivers/hwmon/max6697.ko
  CC      drivers/hwmon/mcp3021.mod.o
  LD [M]  drivers/hwmon/mcp3021.ko
  CC      drivers/hwmon/ntc_thermistor.mod.o
  LD [M]  drivers/hwmon/ntc_thermistor.ko
  CC      drivers/hwmon/pc87360.mod.o
  LD [M]  drivers/hwmon/pc87360.ko
  CC      drivers/hwmon/pc87427.mod.o
  LD [M]  drivers/hwmon/pc87427.ko
  CC      drivers/hwmon/pcf8591.mod.o
  LD [M]  drivers/hwmon/pcf8591.ko
  CC      drivers/hwmon/pmbus/adm1275.mod.o
  LD [M]  drivers/hwmon/pmbus/adm1275.ko
  CC      drivers/hwmon/pmbus/lm25066.mod.o
  LD [M]  drivers/hwmon/pmbus/lm25066.ko
  CC      drivers/hwmon/pmbus/ltc2978.mod.o
  LD [M]  drivers/hwmon/pmbus/ltc2978.ko
  CC      drivers/hwmon/pmbus/max16064.mod.o
  LD [M]  drivers/hwmon/pmbus/max16064.ko
  CC      drivers/hwmon/pmbus/max34440.mod.o
  LD [M]  drivers/hwmon/pmbus/max34440.ko
  CC      drivers/hwmon/pmbus/max8688.mod.o
  LD [M]  drivers/hwmon/pmbus/max8688.ko
  CC      drivers/hwmon/pmbus/pmbus.mod.o
  LD [M]  drivers/hwmon/pmbus/pmbus.ko
  CC      drivers/hwmon/pmbus/pmbus_core.mod.o
  LD [M]  drivers/hwmon/pmbus/pmbus_core.ko
  CC      drivers/hwmon/pmbus/ucd9000.mod.o
  LD [M]  drivers/hwmon/pmbus/ucd9000.ko
  CC      drivers/hwmon/pmbus/ucd9200.mod.o
  LD [M]  drivers/hwmon/pmbus/ucd9200.ko
  CC      drivers/hwmon/pmbus/zl6100.mod.o
  LD [M]  drivers/hwmon/pmbus/zl6100.ko
  CC      drivers/hwmon/sch5627.mod.o
  LD [M]  drivers/hwmon/sch5627.ko
  CC      drivers/hwmon/sch5636.mod.o
  LD [M]  drivers/hwmon/sch5636.ko
  CC      drivers/hwmon/sch56xx-common.mod.o
  LD [M]  drivers/hwmon/sch56xx-common.ko
  CC      drivers/hwmon/sht15.mod.o
  LD [M]  drivers/hwmon/sht15.ko
  CC      drivers/hwmon/sht21.mod.o
  LD [M]  drivers/hwmon/sht21.ko
  CC      drivers/hwmon/sis5595.mod.o
  LD [M]  drivers/hwmon/sis5595.ko
  CC      drivers/hwmon/smm665.mod.o
  LD [M]  drivers/hwmon/smm665.ko
  CC      drivers/hwmon/smsc47b397.mod.o
  LD [M]  drivers/hwmon/smsc47b397.ko
  CC      drivers/hwmon/smsc47m1.mod.o
  LD [M]  drivers/hwmon/smsc47m1.ko
  CC      drivers/hwmon/smsc47m192.mod.o
  LD [M]  drivers/hwmon/smsc47m192.ko
  CC      drivers/hwmon/thmc50.mod.o
  LD [M]  drivers/hwmon/thmc50.ko
  CC      drivers/hwmon/tmp102.mod.o
  LD [M]  drivers/hwmon/tmp102.ko
  CC      drivers/hwmon/tmp401.mod.o
  LD [M]  drivers/hwmon/tmp401.ko
  CC      drivers/hwmon/tmp421.mod.o
  LD [M]  drivers/hwmon/tmp421.ko
  CC      drivers/hwmon/via-cputemp.mod.o
  LD [M]  drivers/hwmon/via-cputemp.ko
  CC      drivers/hwmon/via686a.mod.o
  LD [M]  drivers/hwmon/via686a.ko
  CC      drivers/hwmon/vt1211.mod.o
  LD [M]  drivers/hwmon/vt1211.ko
  CC      drivers/hwmon/vt8231.mod.o
  LD [M]  drivers/hwmon/vt8231.ko
  CC      drivers/hwmon/w83627ehf.mod.o
  LD [M]  drivers/hwmon/w83627ehf.ko
  CC      drivers/hwmon/w83627hf.mod.o
  LD [M]  drivers/hwmon/w83627hf.ko
  CC      drivers/hwmon/w83781d.mod.o
  LD [M]  drivers/hwmon/w83781d.ko
  CC      drivers/hwmon/w83791d.mod.o
  LD [M]  drivers/hwmon/w83791d.ko
  CC      drivers/hwmon/w83792d.mod.o
  LD [M]  drivers/hwmon/w83792d.ko
  CC      drivers/hwmon/w83793.mod.o
  LD [M]  drivers/hwmon/w83793.ko
  CC      drivers/hwmon/w83795.mod.o
  LD [M]  drivers/hwmon/w83795.ko
  CC      drivers/hwmon/w83l785ts.mod.o
  LD [M]  drivers/hwmon/w83l785ts.ko
  CC      drivers/hwmon/w83l786ng.mod.o
  LD [M]  drivers/hwmon/w83l786ng.ko
  CC      drivers/hwmon/wm831x-hwmon.mod.o
  LD [M]  drivers/hwmon/wm831x-hwmon.ko
  CC      drivers/hwmon/wm8350-hwmon.mod.o
  LD [M]  drivers/hwmon/wm8350-hwmon.ko
  CC      drivers/i2c/algos/i2c-algo-pca.mod.o
  LD [M]  drivers/i2c/algos/i2c-algo-pca.ko
  CC      drivers/i2c/busses/i2c-ali1535.mod.o
  LD [M]  drivers/i2c/busses/i2c-ali1535.ko
  CC      drivers/i2c/busses/i2c-ali1563.mod.o
  LD [M]  drivers/i2c/busses/i2c-ali1563.ko
  CC      drivers/i2c/busses/i2c-ali15x3.mod.o
  LD [M]  drivers/i2c/busses/i2c-ali15x3.ko
  CC      drivers/i2c/busses/i2c-amd756-s4882.mod.o
  LD [M]  drivers/i2c/busses/i2c-amd756-s4882.ko
  CC      drivers/i2c/busses/i2c-amd756.mod.o
  LD [M]  drivers/i2c/busses/i2c-amd756.ko
  CC      drivers/i2c/busses/i2c-amd8111.mod.o
  LD [M]  drivers/i2c/busses/i2c-amd8111.ko
  CC      drivers/i2c/busses/i2c-designware-core.mod.o
  LD [M]  drivers/i2c/busses/i2c-designware-core.ko
  CC      drivers/i2c/busses/i2c-designware-pci.mod.o
  LD [M]  drivers/i2c/busses/i2c-designware-pci.ko
  CC      drivers/i2c/busses/i2c-designware-platform.mod.o
  LD [M]  drivers/i2c/busses/i2c-designware-platform.ko
  CC      drivers/i2c/busses/i2c-diolan-u2c.mod.o
  LD [M]  drivers/i2c/busses/i2c-diolan-u2c.ko
  CC      drivers/i2c/busses/i2c-isch.mod.o
  LD [M]  drivers/i2c/busses/i2c-isch.ko
  CC      drivers/i2c/busses/i2c-ismt.mod.o
  LD [M]  drivers/i2c/busses/i2c-ismt.ko
  CC      drivers/i2c/busses/i2c-nforce2-s4985.mod.o
  LD [M]  drivers/i2c/busses/i2c-nforce2-s4985.ko
  CC      drivers/i2c/busses/i2c-ocores.mod.o
  LD [M]  drivers/i2c/busses/i2c-ocores.ko
  CC      drivers/i2c/busses/i2c-pca-platform.mod.o
  LD [M]  drivers/i2c/busses/i2c-pca-platform.ko
  CC      drivers/i2c/busses/i2c-piix4.mod.o
  LD [M]  drivers/i2c/busses/i2c-piix4.ko
  CC      drivers/i2c/busses/i2c-scmi.mod.o
  LD [M]  drivers/i2c/busses/i2c-scmi.ko
  CC      drivers/i2c/busses/i2c-simtec.mod.o
  LD [M]  drivers/i2c/busses/i2c-simtec.ko
  CC      drivers/i2c/busses/i2c-sis5595.mod.o
  LD [M]  drivers/i2c/busses/i2c-sis5595.ko
  CC      drivers/i2c/busses/i2c-sis630.mod.o
  LD [M]  drivers/i2c/busses/i2c-sis630.ko
  CC      drivers/i2c/busses/i2c-sis96x.mod.o
  LD [M]  drivers/i2c/busses/i2c-sis96x.ko
  CC      drivers/i2c/busses/i2c-taos-evm.mod.o
  LD [M]  drivers/i2c/busses/i2c-taos-evm.ko
  CC      drivers/i2c/busses/i2c-tiny-usb.mod.o
  LD [M]  drivers/i2c/busses/i2c-tiny-usb.ko
  CC      drivers/i2c/busses/i2c-via.mod.o
  LD [M]  drivers/i2c/busses/i2c-via.ko
  CC      drivers/i2c/busses/i2c-viapro.mod.o
  LD [M]  drivers/i2c/busses/i2c-viapro.ko
  CC      drivers/i2c/busses/i2c-xiic.mod.o
  LD [M]  drivers/i2c/busses/i2c-xiic.ko
  CC      drivers/i2c/muxes/i2c-mux-pca9541.mod.o
  LD [M]  drivers/i2c/muxes/i2c-mux-pca9541.ko
  CC      drivers/i2c/muxes/i2c-mux-pca954x.mod.o
  LD [M]  drivers/i2c/muxes/i2c-mux-pca954x.ko
  CC      drivers/i2c/muxes/i2c-mux-pinctrl.mod.o
  LD [M]  drivers/i2c/muxes/i2c-mux-pinctrl.ko
  CC      drivers/input/gameport/gameport.mod.o
  LD [M]  drivers/input/gameport/gameport.ko
  CC      drivers/input/joystick/sidewinder.mod.o
  LD [M]  drivers/input/joystick/sidewinder.ko
  CC      drivers/input/joystick/xpad.mod.o
  LD [M]  drivers/input/joystick/xpad.ko
  CC      drivers/input/misc/ati_remote2.mod.o
  LD [M]  drivers/input/misc/ati_remote2.ko
  CC      drivers/input/misc/cm109.mod.o
  LD [M]  drivers/input/misc/cm109.ko
  CC      drivers/input/misc/keyspan_remote.mod.o
  LD [M]  drivers/input/misc/keyspan_remote.ko
  CC      drivers/input/misc/yealink.mod.o
  LD [M]  drivers/input/misc/yealink.ko
  CC      drivers/input/mouse/sermouse.mod.o
  LD [M]  drivers/input/mouse/sermouse.ko
  CC      drivers/input/serio/ct82c710.mod.o
  LD [M]  drivers/input/serio/ct82c710.ko
  CC      drivers/input/serio/pcips2.mod.o
  LD [M]  drivers/input/serio/pcips2.ko
  CC      drivers/input/serio/serport.mod.o
  LD [M]  drivers/input/serio/serport.ko
  CC      drivers/input/tablet/acecad.mod.o
  LD [M]  drivers/input/tablet/acecad.ko
  CC      drivers/input/tablet/aiptek.mod.o
  LD [M]  drivers/input/tablet/aiptek.ko
  CC      drivers/input/tablet/gtco.mod.o
  LD [M]  drivers/input/tablet/gtco.ko
  CC      drivers/input/tablet/hanwang.mod.o
  LD [M]  drivers/input/tablet/hanwang.ko
  CC      drivers/input/tablet/kbtab.mod.o
  LD [M]  drivers/input/tablet/kbtab.ko
  CC      drivers/input/touchscreen/elo.mod.o
  LD [M]  drivers/input/touchscreen/elo.ko
  CC      drivers/input/touchscreen/usbtouchscreen.mod.o
  LD [M]  drivers/input/touchscreen/usbtouchscreen.ko
  CC      drivers/md/dm-multipath.mod.o
  LD [M]  drivers/md/dm-multipath.ko
  CC      drivers/md/dm-queue-length.mod.o
  LD [M]  drivers/md/dm-queue-length.ko
  CC      drivers/md/dm-round-robin.mod.o
  LD [M]  drivers/md/dm-round-robin.ko
  CC      drivers/md/dm-service-time.mod.o
  LD [M]  drivers/md/dm-service-time.ko
  CC      drivers/md/dm-zero.mod.o
  LD [M]  drivers/md/dm-zero.ko
  CC      drivers/media/common/b2c2/b2c2-flexcop.mod.o
  LD [M]  drivers/media/common/b2c2/b2c2-flexcop.ko
  CC      drivers/media/common/cx2341x.mod.o
  LD [M]  drivers/media/common/cx2341x.ko
  CC      drivers/media/common/cypress_firmware.mod.o
  LD [M]  drivers/media/common/cypress_firmware.ko
  CC      drivers/media/common/saa7146/saa7146.mod.o
  LD [M]  drivers/media/common/saa7146/saa7146.ko
  CC      drivers/media/common/saa7146/saa7146_vv.mod.o
  LD [M]  drivers/media/common/saa7146/saa7146_vv.ko
  CC      drivers/media/common/siano/smsdvb.mod.o
  LD [M]  drivers/media/common/siano/smsdvb.ko
  CC      drivers/media/common/siano/smsmdtv.mod.o
  LD [M]  drivers/media/common/siano/smsmdtv.ko
  CC      drivers/media/common/tveeprom.mod.o
  LD [M]  drivers/media/common/tveeprom.ko
  CC      drivers/media/dvb-frontends/a8293.mod.o
  LD [M]  drivers/media/dvb-frontends/a8293.ko
  CC      drivers/media/dvb-frontends/af9013.mod.o
  LD [M]  drivers/media/dvb-frontends/af9013.ko
  CC      drivers/media/dvb-frontends/af9033.mod.o
  LD [M]  drivers/media/dvb-frontends/af9033.ko
  CC      drivers/media/dvb-frontends/atbm8830.mod.o
  LD [M]  drivers/media/dvb-frontends/atbm8830.ko
  CC      drivers/media/dvb-frontends/au8522_common.mod.o
  LD [M]  drivers/media/dvb-frontends/au8522_common.ko
  CC      drivers/media/dvb-frontends/au8522_decoder.mod.o
  LD [M]  drivers/media/dvb-frontends/au8522_decoder.ko
  CC      drivers/media/dvb-frontends/au8522_dig.mod.o
  LD [M]  drivers/media/dvb-frontends/au8522_dig.ko
  CC      drivers/media/dvb-frontends/bcm3510.mod.o
  LD [M]  drivers/media/dvb-frontends/bcm3510.ko
  CC      drivers/media/dvb-frontends/cx22700.mod.o
  LD [M]  drivers/media/dvb-frontends/cx22700.ko
  CC      drivers/media/dvb-frontends/cx22702.mod.o
  LD [M]  drivers/media/dvb-frontends/cx22702.ko
  CC      drivers/media/dvb-frontends/cx24110.mod.o
  LD [M]  drivers/media/dvb-frontends/cx24110.ko
  CC      drivers/media/dvb-frontends/cx24113.mod.o
  LD [M]  drivers/media/dvb-frontends/cx24113.ko
  CC      drivers/media/dvb-frontends/cx24116.mod.o
  LD [M]  drivers/media/dvb-frontends/cx24116.ko
  CC      drivers/media/dvb-frontends/cx24117.mod.o
  LD [M]  drivers/media/dvb-frontends/cx24117.ko
  CC      drivers/media/dvb-frontends/cx24120.mod.o
  LD [M]  drivers/media/dvb-frontends/cx24120.ko
  CC      drivers/media/dvb-frontends/cx24123.mod.o
  LD [M]  drivers/media/dvb-frontends/cx24123.ko
  CC      drivers/media/dvb-frontends/cxd2820r.mod.o
  LD [M]  drivers/media/dvb-frontends/cxd2820r.ko
  CC      drivers/media/dvb-frontends/dib0070.mod.o
  LD [M]  drivers/media/dvb-frontends/dib0070.ko
  CC      drivers/media/dvb-frontends/dib0090.mod.o
  LD [M]  drivers/media/dvb-frontends/dib0090.ko
  CC      drivers/media/dvb-frontends/dib3000mb.mod.o
  LD [M]  drivers/media/dvb-frontends/dib3000mb.ko
  CC      drivers/media/dvb-frontends/dib3000mc.mod.o
  LD [M]  drivers/media/dvb-frontends/dib3000mc.ko
  CC      drivers/media/dvb-frontends/dib7000m.mod.o
  LD [M]  drivers/media/dvb-frontends/dib7000m.ko
  CC      drivers/media/dvb-frontends/dib7000p.mod.o
  LD [M]  drivers/media/dvb-frontends/dib7000p.ko
  CC      drivers/media/dvb-frontends/dib8000.mod.o
  LD [M]  drivers/media/dvb-frontends/dib8000.ko
  CC      drivers/media/dvb-frontends/dibx000_common.mod.o
  LD [M]  drivers/media/dvb-frontends/dibx000_common.ko
  CC      drivers/media/dvb-frontends/drx39xyj/drx39xyj.mod.o
  LD [M]  drivers/media/dvb-frontends/drx39xyj/drx39xyj.ko
  CC      drivers/media/dvb-frontends/drxd.mod.o
  LD [M]  drivers/media/dvb-frontends/drxd.ko
  CC      drivers/media/dvb-frontends/drxk.mod.o
  LD [M]  drivers/media/dvb-frontends/drxk.ko
  CC      drivers/media/dvb-frontends/ds3000.mod.o
  LD [M]  drivers/media/dvb-frontends/ds3000.ko
  CC      drivers/media/dvb-frontends/dvb-pll.mod.o
  LD [M]  drivers/media/dvb-frontends/dvb-pll.ko
  CC      drivers/media/dvb-frontends/ec100.mod.o
  LD [M]  drivers/media/dvb-frontends/ec100.ko
  CC      drivers/media/dvb-frontends/isl6421.mod.o
  LD [M]  drivers/media/dvb-frontends/isl6421.ko
  CC      drivers/media/dvb-frontends/isl6423.mod.o
  LD [M]  drivers/media/dvb-frontends/isl6423.ko
  CC      drivers/media/dvb-frontends/itd1000.mod.o
  LD [M]  drivers/media/dvb-frontends/itd1000.ko
  CC      drivers/media/dvb-frontends/ix2505v.mod.o
  LD [M]  drivers/media/dvb-frontends/ix2505v.ko
  CC      drivers/media/dvb-frontends/l64781.mod.o
  LD [M]  drivers/media/dvb-frontends/l64781.ko
  CC      drivers/media/dvb-frontends/lg2160.mod.o
  LD [M]  drivers/media/dvb-frontends/lg2160.ko
  CC      drivers/media/dvb-frontends/lgdt3305.mod.o
  LD [M]  drivers/media/dvb-frontends/lgdt3305.ko
  CC      drivers/media/dvb-frontends/lgdt3306a.mod.o
  LD [M]  drivers/media/dvb-frontends/lgdt3306a.ko
  CC      drivers/media/dvb-frontends/lgdt330x.mod.o
  LD [M]  drivers/media/dvb-frontends/lgdt330x.ko
  CC      drivers/media/dvb-frontends/lgs8gxx.mod.o
  LD [M]  drivers/media/dvb-frontends/lgs8gxx.ko
  CC      drivers/media/dvb-frontends/lnbp21.mod.o
  LD [M]  drivers/media/dvb-frontends/lnbp21.ko
  CC      drivers/media/dvb-frontends/lnbp22.mod.o
  LD [M]  drivers/media/dvb-frontends/lnbp22.ko
  CC      drivers/media/dvb-frontends/m88ds3103.mod.o
  LD [M]  drivers/media/dvb-frontends/m88ds3103.ko
  CC      drivers/media/dvb-frontends/m88rs2000.mod.o
  LD [M]  drivers/media/dvb-frontends/m88rs2000.ko
  CC      drivers/media/dvb-frontends/mb86a16.mod.o
  LD [M]  drivers/media/dvb-frontends/mb86a16.ko
  CC      drivers/media/dvb-frontends/mb86a20s.mod.o
  LD [M]  drivers/media/dvb-frontends/mb86a20s.ko
  CC      drivers/media/dvb-frontends/mt312.mod.o
  LD [M]  drivers/media/dvb-frontends/mt312.ko
  CC      drivers/media/dvb-frontends/mt352.mod.o
  LD [M]  drivers/media/dvb-frontends/mt352.ko
  CC      drivers/media/dvb-frontends/nxt200x.mod.o
  LD [M]  drivers/media/dvb-frontends/nxt200x.ko
  CC      drivers/media/dvb-frontends/nxt6000.mod.o
  LD [M]  drivers/media/dvb-frontends/nxt6000.ko
  CC      drivers/media/dvb-frontends/or51132.mod.o
  LD [M]  drivers/media/dvb-frontends/or51132.ko
  CC      drivers/media/dvb-frontends/or51211.mod.o
  LD [M]  drivers/media/dvb-frontends/or51211.ko
  CC      drivers/media/dvb-frontends/rtl2830.mod.o
  LD [M]  drivers/media/dvb-frontends/rtl2830.ko
  CC      drivers/media/dvb-frontends/rtl2832.mod.o
  LD [M]  drivers/media/dvb-frontends/rtl2832.ko
  CC      drivers/media/dvb-frontends/s5h1409.mod.o
  LD [M]  drivers/media/dvb-frontends/s5h1409.ko
  CC      drivers/media/dvb-frontends/s5h1411.mod.o
  LD [M]  drivers/media/dvb-frontends/s5h1411.ko
  CC      drivers/media/dvb-frontends/s5h1420.mod.o
  LD [M]  drivers/media/dvb-frontends/s5h1420.ko
  CC      drivers/media/dvb-frontends/s921.mod.o
  LD [M]  drivers/media/dvb-frontends/s921.ko
  CC      drivers/media/dvb-frontends/si2165.mod.o
  LD [M]  drivers/media/dvb-frontends/si2165.ko
  CC      drivers/media/dvb-frontends/si2168.mod.o
  LD [M]  drivers/media/dvb-frontends/si2168.ko
  CC      drivers/media/dvb-frontends/si21xx.mod.o
  LD [M]  drivers/media/dvb-frontends/si21xx.ko
  CC      drivers/media/dvb-frontends/sp8870.mod.o
  LD [M]  drivers/media/dvb-frontends/sp8870.ko
  CC      drivers/media/dvb-frontends/sp887x.mod.o
  LD [M]  drivers/media/dvb-frontends/sp887x.ko
  CC      drivers/media/dvb-frontends/stb0899.mod.o
  LD [M]  drivers/media/dvb-frontends/stb0899.ko
  CC      drivers/media/dvb-frontends/stb6000.mod.o
  LD [M]  drivers/media/dvb-frontends/stb6000.ko
  CC      drivers/media/dvb-frontends/stb6100.mod.o
  LD [M]  drivers/media/dvb-frontends/stb6100.ko
  CC      drivers/media/dvb-frontends/stv0288.mod.o
  LD [M]  drivers/media/dvb-frontends/stv0288.ko
  CC      drivers/media/dvb-frontends/stv0297.mod.o
  LD [M]  drivers/media/dvb-frontends/stv0297.ko
  CC      drivers/media/dvb-frontends/stv0299.mod.o
  LD [M]  drivers/media/dvb-frontends/stv0299.ko
  CC      drivers/media/dvb-frontends/stv0367.mod.o
  LD [M]  drivers/media/dvb-frontends/stv0367.ko
  CC      drivers/media/dvb-frontends/stv0900.mod.o
  LD [M]  drivers/media/dvb-frontends/stv0900.ko
  CC      drivers/media/dvb-frontends/stv090x.mod.o
  LD [M]  drivers/media/dvb-frontends/stv090x.ko
  CC      drivers/media/dvb-frontends/stv6110.mod.o
  LD [M]  drivers/media/dvb-frontends/stv6110.ko
  CC      drivers/media/dvb-frontends/stv6110x.mod.o
  LD [M]  drivers/media/dvb-frontends/stv6110x.ko
  CC      drivers/media/dvb-frontends/tda10021.mod.o
  LD [M]  drivers/media/dvb-frontends/tda10021.ko
  CC      drivers/media/dvb-frontends/tda10023.mod.o
  LD [M]  drivers/media/dvb-frontends/tda10023.ko
  CC      drivers/media/dvb-frontends/tda10048.mod.o
  LD [M]  drivers/media/dvb-frontends/tda10048.ko
  CC      drivers/media/dvb-frontends/tda1004x.mod.o
  LD [M]  drivers/media/dvb-frontends/tda1004x.ko
  CC      drivers/media/dvb-frontends/tda10071.mod.o
  LD [M]  drivers/media/dvb-frontends/tda10071.ko
  CC      drivers/media/dvb-frontends/tda10086.mod.o
  LD [M]  drivers/media/dvb-frontends/tda10086.ko
  CC      drivers/media/dvb-frontends/tda18271c2dd.mod.o
  LD [M]  drivers/media/dvb-frontends/tda18271c2dd.ko
  CC      drivers/media/dvb-frontends/tda665x.mod.o
  LD [M]  drivers/media/dvb-frontends/tda665x.ko
  CC      drivers/media/dvb-frontends/tda8083.mod.o
  LD [M]  drivers/media/dvb-frontends/tda8083.ko
  CC      drivers/media/dvb-frontends/tda8261.mod.o
  LD [M]  drivers/media/dvb-frontends/tda8261.ko
  CC      drivers/media/dvb-frontends/tda826x.mod.o
  LD [M]  drivers/media/dvb-frontends/tda826x.ko
  CC      drivers/media/dvb-frontends/ts2020.mod.o
  LD [M]  drivers/media/dvb-frontends/ts2020.ko
  CC      drivers/media/dvb-frontends/tua6100.mod.o
  LD [M]  drivers/media/dvb-frontends/tua6100.ko
  CC      drivers/media/dvb-frontends/ves1820.mod.o
  LD [M]  drivers/media/dvb-frontends/ves1820.ko
  CC      drivers/media/dvb-frontends/ves1x93.mod.o
  LD [M]  drivers/media/dvb-frontends/ves1x93.ko
  CC      drivers/media/dvb-frontends/zl10039.mod.o
  LD [M]  drivers/media/dvb-frontends/zl10039.ko
  CC      drivers/media/dvb-frontends/zl10353.mod.o
  LD [M]  drivers/media/dvb-frontends/zl10353.ko
  CC      drivers/media/i2c/adv7170.mod.o
  LD [M]  drivers/media/i2c/adv7170.ko
  CC      drivers/media/i2c/adv7175.mod.o
  LD [M]  drivers/media/i2c/adv7175.ko
  CC      drivers/media/i2c/bt819.mod.o
  LD [M]  drivers/media/i2c/bt819.ko
  CC      drivers/media/i2c/bt856.mod.o
  LD [M]  drivers/media/i2c/bt856.ko
  CC      drivers/media/i2c/bt866.mod.o
  LD [M]  drivers/media/i2c/bt866.ko
  CC      drivers/media/i2c/cs5345.mod.o
  LD [M]  drivers/media/i2c/cs5345.ko
  CC      drivers/media/i2c/cs53l32a.mod.o
  LD [M]  drivers/media/i2c/cs53l32a.ko
  CC      drivers/media/i2c/cx25840/cx25840.mod.o
  LD [M]  drivers/media/i2c/cx25840/cx25840.ko
  CC      drivers/media/i2c/ks0127.mod.o
  LD [M]  drivers/media/i2c/ks0127.ko
  CC      drivers/media/i2c/m52790.mod.o
  LD [M]  drivers/media/i2c/m52790.ko
  CC      drivers/media/i2c/msp3400.mod.o
  LD [M]  drivers/media/i2c/msp3400.ko
  CC      drivers/media/i2c/mt9v011.mod.o
  LD [M]  drivers/media/i2c/mt9v011.ko
  CC      drivers/media/i2c/saa6588.mod.o
  LD [M]  drivers/media/i2c/saa6588.ko
  CC      drivers/media/i2c/saa6752hs.mod.o
  LD [M]  drivers/media/i2c/saa6752hs.ko
  CC      drivers/media/i2c/saa7110.mod.o
  LD [M]  drivers/media/i2c/saa7110.ko
  CC      drivers/media/i2c/saa7115.mod.o
  LD [M]  drivers/media/i2c/saa7115.ko
  CC      drivers/media/i2c/saa7127.mod.o
  LD [M]  drivers/media/i2c/saa7127.ko
  CC      drivers/media/i2c/saa717x.mod.o
  LD [M]  drivers/media/i2c/saa717x.ko
  CC      drivers/media/i2c/saa7185.mod.o
  LD [M]  drivers/media/i2c/saa7185.ko
  CC      drivers/media/i2c/tda7432.mod.o
  LD [M]  drivers/media/i2c/tda7432.ko
  CC      drivers/media/i2c/tda9840.mod.o
  LD [M]  drivers/media/i2c/tda9840.ko
  CC      drivers/media/i2c/tea6415c.mod.o
  LD [M]  drivers/media/i2c/tea6415c.ko
  CC      drivers/media/i2c/tea6420.mod.o
  LD [M]  drivers/media/i2c/tea6420.ko
  CC      drivers/media/i2c/tvaudio.mod.o
  LD [M]  drivers/media/i2c/tvaudio.ko
  CC      drivers/media/i2c/tvp5150.mod.o
  LD [M]  drivers/media/i2c/tvp5150.ko
  CC      drivers/media/i2c/upd64031a.mod.o
  LD [M]  drivers/media/i2c/upd64031a.ko
  CC      drivers/media/i2c/upd64083.mod.o
  LD [M]  drivers/media/i2c/upd64083.ko
  CC      drivers/media/i2c/vp27smpx.mod.o
  LD [M]  drivers/media/i2c/vp27smpx.ko
  CC      drivers/media/i2c/vpx3220.mod.o
  LD [M]  drivers/media/i2c/vpx3220.ko
  CC      drivers/media/i2c/wm8739.mod.o
  LD [M]  drivers/media/i2c/wm8739.ko
  CC      drivers/media/i2c/wm8775.mod.o
  LD [M]  drivers/media/i2c/wm8775.ko
  CC      drivers/media/pci/b2c2/b2c2-flexcop-pci.mod.o
  LD [M]  drivers/media/pci/b2c2/b2c2-flexcop-pci.ko
  CC      drivers/media/pci/bt8xx/bt878.mod.o
  LD [M]  drivers/media/pci/bt8xx/bt878.ko
  CC      drivers/media/pci/bt8xx/bttv.mod.o
  LD [M]  drivers/media/pci/bt8xx/bttv.ko
  CC      drivers/media/pci/bt8xx/dst.mod.o
  LD [M]  drivers/media/pci/bt8xx/dst.ko
  CC      drivers/media/pci/bt8xx/dst_ca.mod.o
  LD [M]  drivers/media/pci/bt8xx/dst_ca.ko
  CC      drivers/media/pci/bt8xx/dvb-bt8xx.mod.o
  LD [M]  drivers/media/pci/bt8xx/dvb-bt8xx.ko
  CC      drivers/media/pci/cx18/cx18-alsa.mod.o
  LD [M]  drivers/media/pci/cx18/cx18-alsa.ko
  CC      drivers/media/pci/cx18/cx18.mod.o
  LD [M]  drivers/media/pci/cx18/cx18.ko
  CC      drivers/media/pci/cx23885/altera-ci.mod.o
  LD [M]  drivers/media/pci/cx23885/altera-ci.ko
  CC      drivers/media/pci/cx23885/cx23885.mod.o
  LD [M]  drivers/media/pci/cx23885/cx23885.ko
  CC      drivers/media/pci/cx25821/cx25821-alsa.mod.o
  LD [M]  drivers/media/pci/cx25821/cx25821-alsa.ko
  CC      drivers/media/pci/cx25821/cx25821.mod.o
  LD [M]  drivers/media/pci/cx25821/cx25821.ko
  CC      drivers/media/pci/cx88/cx88-alsa.mod.o
  LD [M]  drivers/media/pci/cx88/cx88-alsa.ko
  CC      drivers/media/pci/cx88/cx88-blackbird.mod.o
  LD [M]  drivers/media/pci/cx88/cx88-blackbird.ko
  CC      drivers/media/pci/cx88/cx88-dvb.mod.o
  LD [M]  drivers/media/pci/cx88/cx88-dvb.ko
  CC      drivers/media/pci/cx88/cx88-vp3054-i2c.mod.o
  LD [M]  drivers/media/pci/cx88/cx88-vp3054-i2c.ko
  CC      drivers/media/pci/cx88/cx8800.mod.o
  LD [M]  drivers/media/pci/cx88/cx8800.ko
  CC      drivers/media/pci/cx88/cx8802.mod.o
  LD [M]  drivers/media/pci/cx88/cx8802.ko
  CC      drivers/media/pci/cx88/cx88xx.mod.o
  LD [M]  drivers/media/pci/cx88/cx88xx.ko
  CC      drivers/media/pci/ddbridge/ddbridge.mod.o
  LD [M]  drivers/media/pci/ddbridge/ddbridge.ko
  CC      drivers/media/pci/ivtv/ivtv-alsa.mod.o
  LD [M]  drivers/media/pci/ivtv/ivtv-alsa.ko
  CC      drivers/media/pci/ivtv/ivtv.mod.o
  LD [M]  drivers/media/pci/ivtv/ivtv.ko
  CC      drivers/media/pci/ivtv/ivtvfb.mod.o
  LD [M]  drivers/media/pci/ivtv/ivtvfb.ko
  CC      drivers/media/pci/mantis/hopper.mod.o
  LD [M]  drivers/media/pci/mantis/hopper.ko
  CC      drivers/media/pci/mantis/mantis.mod.o
  LD [M]  drivers/media/pci/mantis/mantis.ko
  CC      drivers/media/pci/mantis/mantis_core.mod.o
  LD [M]  drivers/media/pci/mantis/mantis_core.ko
  CC      drivers/media/pci/ngene/ngene.mod.o
  LD [M]  drivers/media/pci/ngene/ngene.ko
  CC      drivers/media/pci/pluto2/pluto2.mod.o
  LD [M]  drivers/media/pci/pluto2/pluto2.ko
  CC      drivers/media/pci/pt1/earth-pt1.mod.o
  LD [M]  drivers/media/pci/pt1/earth-pt1.ko
  CC      drivers/media/pci/saa7134/saa7134-alsa.mod.o
  LD [M]  drivers/media/pci/saa7134/saa7134-alsa.ko
  CC      drivers/media/pci/saa7134/saa7134-empress.mod.o
  LD [M]  drivers/media/pci/saa7134/saa7134-empress.ko
  CC      drivers/media/pci/saa7134/saa7134.mod.o
  LD [M]  drivers/media/pci/saa7134/saa7134.ko
  CC      drivers/media/pci/saa7146/hexium_gemini.mod.o
  LD [M]  drivers/media/pci/saa7146/hexium_gemini.ko
  CC      drivers/media/pci/saa7146/hexium_orion.mod.o
  LD [M]  drivers/media/pci/saa7146/hexium_orion.ko
  CC      drivers/media/pci/saa7146/mxb.mod.o
  LD [M]  drivers/media/pci/saa7146/mxb.ko
  CC      drivers/media/pci/saa7164/saa7164.mod.o
  LD [M]  drivers/media/pci/saa7164/saa7164.ko
  CC      drivers/media/pci/ttpci/budget-av.mod.o
  LD [M]  drivers/media/pci/ttpci/budget-av.ko
  CC      drivers/media/pci/ttpci/budget-ci.mod.o
  LD [M]  drivers/media/pci/ttpci/budget-ci.ko
  CC      drivers/media/pci/ttpci/budget-core.mod.o
  LD [M]  drivers/media/pci/ttpci/budget-core.ko
  CC      drivers/media/pci/ttpci/budget-patch.mod.o
  LD [M]  drivers/media/pci/ttpci/budget-patch.ko
  CC      drivers/media/pci/ttpci/budget.mod.o
  LD [M]  drivers/media/pci/ttpci/budget.ko
  CC      drivers/media/pci/ttpci/dvb-ttpci.mod.o
  LD [M]  drivers/media/pci/ttpci/dvb-ttpci.ko
  CC      drivers/media/pci/ttpci/ttpci-eeprom.mod.o
  LD [M]  drivers/media/pci/ttpci/ttpci-eeprom.ko
  CC      drivers/media/pci/zoran/videocodec.mod.o
  LD [M]  drivers/media/pci/zoran/videocodec.ko
  CC      drivers/media/pci/zoran/zr36016.mod.o
  LD [M]  drivers/media/pci/zoran/zr36016.ko
  CC      drivers/media/pci/zoran/zr36050.mod.o
  LD [M]  drivers/media/pci/zoran/zr36050.ko
  CC      drivers/media/pci/zoran/zr36060.mod.o
  LD [M]  drivers/media/pci/zoran/zr36060.ko
  CC      drivers/media/pci/zoran/zr36067.mod.o
  LD [M]  drivers/media/pci/zoran/zr36067.ko
  CC      drivers/media/radio/tea575x.mod.o
  LD [M]  drivers/media/radio/tea575x.ko
  CC      drivers/media/rc/ati_remote.mod.o
  LD [M]  drivers/media/rc/ati_remote.ko
  CC      drivers/media/rc/ene_ir.mod.o
  LD [M]  drivers/media/rc/ene_ir.ko
  CC      drivers/media/rc/fintek-cir.mod.o
  LD [M]  drivers/media/rc/fintek-cir.ko
  CC      drivers/media/rc/iguanair.mod.o
  LD [M]  drivers/media/rc/iguanair.ko
  CC      drivers/media/rc/ite-cir.mod.o
  LD [M]  drivers/media/rc/ite-cir.ko
  CC      drivers/media/rc/mceusb.mod.o
  LD [M]  drivers/media/rc/mceusb.ko
  CC      drivers/media/rc/nuvoton-cir.mod.o
  LD [M]  drivers/media/rc/nuvoton-cir.ko
  CC      drivers/media/rc/redrat3.mod.o
  LD [M]  drivers/media/rc/redrat3.ko
  CC      drivers/media/rc/streamzap.mod.o
  LD [M]  drivers/media/rc/streamzap.ko
  CC      drivers/media/rc/ttusbir.mod.o
  LD [M]  drivers/media/rc/ttusbir.ko
  CC      drivers/media/rc/winbond-cir.mod.o
  LD [M]  drivers/media/rc/winbond-cir.ko
  CC      drivers/media/tuners/e4000.mod.o
  LD [M]  drivers/media/tuners/e4000.ko
  CC      drivers/media/tuners/fc0011.mod.o
  LD [M]  drivers/media/tuners/fc0011.ko
  CC      drivers/media/tuners/fc0012.mod.o
  LD [M]  drivers/media/tuners/fc0012.ko
  CC      drivers/media/tuners/fc0013.mod.o
  LD [M]  drivers/media/tuners/fc0013.ko
  CC      drivers/media/tuners/fc2580.mod.o
  LD [M]  drivers/media/tuners/fc2580.ko
  CC      drivers/media/tuners/it913x.mod.o
  LD [M]  drivers/media/tuners/it913x.ko
  CC      drivers/media/tuners/m88rs6000t.mod.o
  LD [M]  drivers/media/tuners/m88rs6000t.ko
  CC      drivers/media/tuners/max2165.mod.o
  LD [M]  drivers/media/tuners/max2165.ko
  CC      drivers/media/tuners/mt2060.mod.o
  LD [M]  drivers/media/tuners/mt2060.ko
  CC      drivers/media/tuners/mt2063.mod.o
  LD [M]  drivers/media/tuners/mt2063.ko
  CC      drivers/media/tuners/mt2131.mod.o
  LD [M]  drivers/media/tuners/mt2131.ko
  CC      drivers/media/tuners/mt2266.mod.o
  LD [M]  drivers/media/tuners/mt2266.ko
  CC      drivers/media/tuners/mxl5005s.mod.o
  LD [M]  drivers/media/tuners/mxl5005s.ko
  CC      drivers/media/tuners/mxl5007t.mod.o
  LD [M]  drivers/media/tuners/mxl5007t.ko
  CC      drivers/media/tuners/qt1010.mod.o
  LD [M]  drivers/media/tuners/qt1010.ko
  CC      drivers/media/tuners/r820t.mod.o
  LD [M]  drivers/media/tuners/r820t.ko
  CC      drivers/media/tuners/si2157.mod.o
  LD [M]  drivers/media/tuners/si2157.ko
  CC      drivers/media/tuners/tda18212.mod.o
  LD [M]  drivers/media/tuners/tda18212.ko
  CC      drivers/media/tuners/tda18218.mod.o
  LD [M]  drivers/media/tuners/tda18218.ko
  CC      drivers/media/tuners/tua9001.mod.o
  LD [M]  drivers/media/tuners/tua9001.ko
  CC      drivers/media/usb/au0828/au0828.mod.o
  LD [M]  drivers/media/usb/au0828/au0828.ko
  CC      drivers/media/usb/b2c2/b2c2-flexcop-usb.mod.o
  LD [M]  drivers/media/usb/b2c2/b2c2-flexcop-usb.ko
  CC      drivers/media/usb/cpia2/cpia2.mod.o
  LD [M]  drivers/media/usb/cpia2/cpia2.ko
  CC      drivers/media/usb/cx231xx/cx231xx-alsa.mod.o
  LD [M]  drivers/media/usb/cx231xx/cx231xx-alsa.ko
  CC      drivers/media/usb/cx231xx/cx231xx-dvb.mod.o
  LD [M]  drivers/media/usb/cx231xx/cx231xx-dvb.ko
  CC      drivers/media/usb/cx231xx/cx231xx.mod.o
  LD [M]  drivers/media/usb/cx231xx/cx231xx.ko
  CC      drivers/media/usb/dvb-usb-v2/dvb-usb-af9015.mod.o
  LD [M]  drivers/media/usb/dvb-usb-v2/dvb-usb-af9015.ko
  CC      drivers/media/usb/dvb-usb-v2/dvb-usb-af9035.mod.o
  LD [M]  drivers/media/usb/dvb-usb-v2/dvb-usb-af9035.ko
  CC      drivers/media/usb/dvb-usb-v2/dvb-usb-anysee.mod.o
  LD [M]  drivers/media/usb/dvb-usb-v2/dvb-usb-anysee.ko
  CC      drivers/media/usb/dvb-usb-v2/dvb-usb-au6610.mod.o
  LD [M]  drivers/media/usb/dvb-usb-v2/dvb-usb-au6610.ko
  CC      drivers/media/usb/dvb-usb-v2/dvb-usb-az6007.mod.o
  LD [M]  drivers/media/usb/dvb-usb-v2/dvb-usb-az6007.ko
  CC      drivers/media/usb/dvb-usb-v2/dvb-usb-ce6230.mod.o
  LD [M]  drivers/media/usb/dvb-usb-v2/dvb-usb-ce6230.ko
  CC      drivers/media/usb/dvb-usb-v2/dvb-usb-ec168.mod.o
  LD [M]  drivers/media/usb/dvb-usb-v2/dvb-usb-ec168.ko
  CC      drivers/media/usb/dvb-usb-v2/dvb-usb-gl861.mod.o
  LD [M]  drivers/media/usb/dvb-usb-v2/dvb-usb-gl861.ko
  CC      drivers/media/usb/dvb-usb-v2/dvb-usb-lmedm04.mod.o
  LD [M]  drivers/media/usb/dvb-usb-v2/dvb-usb-lmedm04.ko
  CC      drivers/media/usb/dvb-usb-v2/dvb-usb-mxl111sf.mod.o
  LD [M]  drivers/media/usb/dvb-usb-v2/dvb-usb-mxl111sf.ko
  CC      drivers/media/usb/dvb-usb-v2/dvb-usb-rtl28xxu.mod.o
  LD [M]  drivers/media/usb/dvb-usb-v2/dvb-usb-rtl28xxu.ko
  CC      drivers/media/usb/dvb-usb-v2/dvb_usb_v2.mod.o
  LD [M]  drivers/media/usb/dvb-usb-v2/dvb_usb_v2.ko
  CC      drivers/media/usb/dvb-usb-v2/mxl111sf-demod.mod.o
  LD [M]  drivers/media/usb/dvb-usb-v2/mxl111sf-demod.ko
  CC      drivers/media/usb/dvb-usb-v2/mxl111sf-tuner.mod.o
  LD [M]  drivers/media/usb/dvb-usb-v2/mxl111sf-tuner.ko
  CC      drivers/media/usb/dvb-usb/dvb-usb-a800.mod.o
  LD [M]  drivers/media/usb/dvb-usb/dvb-usb-a800.ko
  CC      drivers/media/usb/dvb-usb/dvb-usb-af9005-remote.mod.o
  LD [M]  drivers/media/usb/dvb-usb/dvb-usb-af9005-remote.ko
  CC      drivers/media/usb/dvb-usb/dvb-usb-af9005.mod.o
  LD [M]  drivers/media/usb/dvb-usb/dvb-usb-af9005.ko
  CC      drivers/media/usb/dvb-usb/dvb-usb-az6027.mod.o
  LD [M]  drivers/media/usb/dvb-usb/dvb-usb-az6027.ko
  CC      drivers/media/usb/dvb-usb/dvb-usb-cinergyT2.mod.o
  LD [M]  drivers/media/usb/dvb-usb/dvb-usb-cinergyT2.ko
  CC      drivers/media/usb/dvb-usb/dvb-usb-cxusb.mod.o
  LD [M]  drivers/media/usb/dvb-usb/dvb-usb-cxusb.ko
  CC      drivers/media/usb/dvb-usb/dvb-usb-dib0700.mod.o
  LD [M]  drivers/media/usb/dvb-usb/dvb-usb-dib0700.ko
  CC      drivers/media/usb/dvb-usb/dvb-usb-dibusb-common.mod.o
  LD [M]  drivers/media/usb/dvb-usb/dvb-usb-dibusb-common.ko
  CC      drivers/media/usb/dvb-usb/dvb-usb-dibusb-mb.mod.o
  LD [M]  drivers/media/usb/dvb-usb/dvb-usb-dibusb-mb.ko
  CC      drivers/media/usb/dvb-usb/dvb-usb-dibusb-mc.mod.o
  LD [M]  drivers/media/usb/dvb-usb/dvb-usb-dibusb-mc.ko
  CC      drivers/media/usb/dvb-usb/dvb-usb-digitv.mod.o
  LD [M]  drivers/media/usb/dvb-usb/dvb-usb-digitv.ko
  CC      drivers/media/usb/dvb-usb/dvb-usb-dtt200u.mod.o
  LD [M]  drivers/media/usb/dvb-usb/dvb-usb-dtt200u.ko
  CC      drivers/media/usb/dvb-usb/dvb-usb-dtv5100.mod.o
  LD [M]  drivers/media/usb/dvb-usb/dvb-usb-dtv5100.ko
  CC      drivers/media/usb/dvb-usb/dvb-usb-dw2102.mod.o
  LD [M]  drivers/media/usb/dvb-usb/dvb-usb-dw2102.ko
  CC      drivers/media/usb/dvb-usb/dvb-usb-friio.mod.o
  LD [M]  drivers/media/usb/dvb-usb/dvb-usb-friio.ko
  CC      drivers/media/usb/dvb-usb/dvb-usb-gp8psk.mod.o
  LD [M]  drivers/media/usb/dvb-usb/dvb-usb-gp8psk.ko
  CC      drivers/media/usb/dvb-usb/dvb-usb-m920x.mod.o
  LD [M]  drivers/media/usb/dvb-usb/dvb-usb-m920x.ko
  CC      drivers/media/usb/dvb-usb/dvb-usb-nova-t-usb2.mod.o
  LD [M]  drivers/media/usb/dvb-usb/dvb-usb-nova-t-usb2.ko
  CC      drivers/media/usb/dvb-usb/dvb-usb-opera.mod.o
  LD [M]  drivers/media/usb/dvb-usb/dvb-usb-opera.ko
  CC      drivers/media/usb/dvb-usb/dvb-usb-pctv452e.mod.o
  LD [M]  drivers/media/usb/dvb-usb/dvb-usb-pctv452e.ko
  CC      drivers/media/usb/dvb-usb/dvb-usb-technisat-usb2.mod.o
  LD [M]  drivers/media/usb/dvb-usb/dvb-usb-technisat-usb2.ko
  CC      drivers/media/usb/dvb-usb/dvb-usb-ttusb2.mod.o
  LD [M]  drivers/media/usb/dvb-usb/dvb-usb-ttusb2.ko
  CC      drivers/media/usb/dvb-usb/dvb-usb-umt-010.mod.o
  LD [M]  drivers/media/usb/dvb-usb/dvb-usb-umt-010.ko
  CC      drivers/media/usb/dvb-usb/dvb-usb-vp702x.mod.o
  LD [M]  drivers/media/usb/dvb-usb/dvb-usb-vp702x.ko
  CC      drivers/media/usb/dvb-usb/dvb-usb-vp7045.mod.o
  LD [M]  drivers/media/usb/dvb-usb/dvb-usb-vp7045.ko
  CC      drivers/media/usb/dvb-usb/dvb-usb.mod.o
  LD [M]  drivers/media/usb/dvb-usb/dvb-usb.ko
  CC      drivers/media/usb/em28xx/em28xx-alsa.mod.o
  LD [M]  drivers/media/usb/em28xx/em28xx-alsa.ko
  CC      drivers/media/usb/em28xx/em28xx-dvb.mod.o
  LD [M]  drivers/media/usb/em28xx/em28xx-dvb.ko
  CC      drivers/media/usb/em28xx/em28xx-rc.mod.o
  LD [M]  drivers/media/usb/em28xx/em28xx-rc.ko
  CC      drivers/media/usb/em28xx/em28xx-v4l.mod.o
  LD [M]  drivers/media/usb/em28xx/em28xx-v4l.ko
  CC      drivers/media/usb/em28xx/em28xx.mod.o
  LD [M]  drivers/media/usb/em28xx/em28xx.ko
  CC      drivers/media/usb/gspca/gspca_main.mod.o
  LD [M]  drivers/media/usb/gspca/gspca_main.ko
  CC      drivers/media/usb/gspca/gspca_stk1135.mod.o
  LD [M]  drivers/media/usb/gspca/gspca_stk1135.ko
  CC      drivers/media/usb/hdpvr/hdpvr.mod.o
  LD [M]  drivers/media/usb/hdpvr/hdpvr.ko
  CC      drivers/media/usb/pvrusb2/pvrusb2.mod.o
  LD [M]  drivers/media/usb/pvrusb2/pvrusb2.ko
  CC      drivers/media/usb/pwc/pwc.mod.o
  LD [M]  drivers/media/usb/pwc/pwc.ko
  CC      drivers/media/usb/s2255/s2255drv.mod.o
  LD [M]  drivers/media/usb/s2255/s2255drv.ko
  CC      drivers/media/usb/siano/smsusb.mod.o
  LD [M]  drivers/media/usb/siano/smsusb.ko
  CC      drivers/media/usb/stk1160/stk1160.mod.o
  LD [M]  drivers/media/usb/stk1160/stk1160.ko
  CC      drivers/media/usb/stkwebcam/stkwebcam.mod.o
  LD [M]  drivers/media/usb/stkwebcam/stkwebcam.ko
  CC      drivers/media/usb/ttusb-budget/dvb-ttusb-budget.mod.o
  LD [M]  drivers/media/usb/ttusb-budget/dvb-ttusb-budget.ko
  CC      drivers/media/usb/ttusb-dec/ttusb_dec.mod.o
  LD [M]  drivers/media/usb/ttusb-dec/ttusb_dec.ko
  CC      drivers/media/usb/ttusb-dec/ttusbdecfe.mod.o
  LD [M]  drivers/media/usb/ttusb-dec/ttusbdecfe.ko
  CC      drivers/media/usb/usbtv/usbtv.mod.o
  LD [M]  drivers/media/usb/usbtv/usbtv.ko
  CC      drivers/media/usb/usbvision/usbvision.mod.o
  LD [M]  drivers/media/usb/usbvision/usbvision.ko
  CC      drivers/media/usb/uvc/uvcvideo.mod.o
  LD [M]  drivers/media/usb/uvc/uvcvideo.ko
  CC      drivers/media/usb/zr364xx/zr364xx.mod.o
  LD [M]  drivers/media/usb/zr364xx/zr364xx.ko
  CC      drivers/media/v4l2-core/tuner.mod.o
  LD [M]  drivers/media/v4l2-core/tuner.ko
  CC      drivers/media/v4l2-core/videobuf-core.mod.o
  LD [M]  drivers/media/v4l2-core/videobuf-core.ko
  CC      drivers/media/v4l2-core/videobuf-dma-sg.mod.o
  LD [M]  drivers/media/v4l2-core/videobuf-dma-sg.ko
  CC      drivers/media/v4l2-core/videobuf-dvb.mod.o
  LD [M]  drivers/media/v4l2-core/videobuf-dvb.ko
  CC      drivers/media/v4l2-core/videobuf-vmalloc.mod.o
  LD [M]  drivers/media/v4l2-core/videobuf-vmalloc.ko
  CC      drivers/media/v4l2-core/videobuf2-core.mod.o
  LD [M]  drivers/media/v4l2-core/videobuf2-core.ko
  CC      drivers/media/v4l2-core/videobuf2-dma-sg.mod.o
  LD [M]  drivers/media/v4l2-core/videobuf2-dma-sg.ko
  CC      drivers/media/v4l2-core/videobuf2-dvb.mod.o
  LD [M]  drivers/media/v4l2-core/videobuf2-dvb.ko
  CC      drivers/media/v4l2-core/videobuf2-memops.mod.o
  LD [M]  drivers/media/v4l2-core/videobuf2-memops.ko
  CC      drivers/media/v4l2-core/videobuf2-v4l2.mod.o
  LD [M]  drivers/media/v4l2-core/videobuf2-v4l2.ko
  CC      drivers/media/v4l2-core/videobuf2-vmalloc.mod.o
  LD [M]  drivers/media/v4l2-core/videobuf2-vmalloc.ko
  CC      drivers/memstick/core/ms_block.mod.o
  LD [M]  drivers/memstick/core/ms_block.ko
  CC      drivers/memstick/core/mspro_block.mod.o
  LD [M]  drivers/memstick/core/mspro_block.ko
  CC      drivers/memstick/host/jmb38x_ms.mod.o
  LD [M]  drivers/memstick/host/jmb38x_ms.ko
  CC      drivers/memstick/host/r592.mod.o
  LD [M]  drivers/memstick/host/r592.ko
  CC      drivers/memstick/host/tifm_ms.mod.o
  LD [M]  drivers/memstick/host/tifm_ms.ko
  CC      drivers/mfd/88pm800.mod.o
  LD [M]  drivers/mfd/88pm800.ko
  CC      drivers/mfd/88pm805.mod.o
  LD [M]  drivers/mfd/88pm805.ko
  CC      drivers/mfd/88pm80x.mod.o
  LD [M]  drivers/mfd/88pm80x.ko
  CC      drivers/mfd/arizona-i2c.mod.o
  LD [M]  drivers/mfd/arizona-i2c.ko
  CC      drivers/mfd/arizona-spi.mod.o
  LD [M]  drivers/mfd/arizona-spi.ko
  CC      drivers/mfd/htc-pasic3.mod.o
  LD [M]  drivers/mfd/htc-pasic3.ko
  CC      drivers/mfd/janz-cmodio.mod.o
  LD [M]  drivers/mfd/janz-cmodio.ko
  CC      drivers/mfd/lm3533-core.mod.o
  LD [M]  drivers/mfd/lm3533-core.ko
  CC      drivers/mfd/lm3533-ctrlbank.mod.o
  LD [M]  drivers/mfd/lm3533-ctrlbank.ko
  CC      drivers/mfd/max8907.mod.o
  LD [M]  drivers/mfd/max8907.ko
  CC      drivers/mfd/mc13xxx-core.mod.o
  LD [M]  drivers/mfd/mc13xxx-core.ko
  CC      drivers/mfd/mc13xxx-i2c.mod.o
  LD [M]  drivers/mfd/mc13xxx-i2c.ko
  CC      drivers/mfd/mc13xxx-spi.mod.o
  LD [M]  drivers/mfd/mc13xxx-spi.ko
  CC      drivers/mfd/pcf50633-adc.mod.o
  LD [M]  drivers/mfd/pcf50633-adc.ko
  CC      drivers/mfd/pcf50633-gpio.mod.o
  LD [M]  drivers/mfd/pcf50633-gpio.ko
  CC      drivers/mfd/pcf50633.mod.o
  LD [M]  drivers/mfd/pcf50633.ko
  CC      drivers/mfd/rdc321x-southbridge.mod.o
  LD [M]  drivers/mfd/rdc321x-southbridge.ko
  CC      drivers/mfd/retu-mfd.mod.o
  LD [M]  drivers/mfd/retu-mfd.ko
  CC      drivers/mfd/rtsx_usb.mod.o
  LD [M]  drivers/mfd/rtsx_usb.ko
  CC      drivers/mfd/sm501.mod.o
  LD [M]  drivers/mfd/sm501.ko
  CC      drivers/mfd/ti_am335x_tscadc.mod.o
  LD [M]  drivers/mfd/ti_am335x_tscadc.ko
  CC      drivers/mfd/tps6105x.mod.o
  LD [M]  drivers/mfd/tps6105x.ko
  CC      drivers/mfd/tps65010.mod.o
  LD [M]  drivers/mfd/tps65010.ko
  CC      drivers/mfd/tps6507x.mod.o
  LD [M]  drivers/mfd/tps6507x.ko
  CC      drivers/mfd/tps65217.mod.o
  LD [M]  drivers/mfd/tps65217.ko
  CC      drivers/mfd/ucb1400_core.mod.o
  LD [M]  drivers/mfd/ucb1400_core.ko
  CC      drivers/mfd/viperboard.mod.o
  LD [M]  drivers/mfd/viperboard.ko
  CC      drivers/mfd/vx855.mod.o
  LD [M]  drivers/mfd/vx855.ko
  CC      drivers/mfd/wl1273-core.mod.o
  LD [M]  drivers/mfd/wl1273-core.ko
  CC      drivers/misc/ad525x_dpot-i2c.mod.o
  LD [M]  drivers/misc/ad525x_dpot-i2c.ko
  CC      drivers/misc/ad525x_dpot.mod.o
  LD [M]  drivers/misc/ad525x_dpot.ko
  CC      drivers/misc/altera-stapl/altera-stapl.mod.o
  LD [M]  drivers/misc/altera-stapl/altera-stapl.ko
  CC      drivers/misc/apds9802als.mod.o
  LD [M]  drivers/misc/apds9802als.ko
  CC      drivers/misc/apds990x.mod.o
  LD [M]  drivers/misc/apds990x.ko
  CC      drivers/misc/bh1770glc.mod.o
  LD [M]  drivers/misc/bh1770glc.ko
  CC      drivers/misc/bh1780gli.mod.o
  LD [M]  drivers/misc/bh1780gli.ko
  CC      drivers/misc/cb710/cb710.mod.o
  LD [M]  drivers/misc/cb710/cb710.ko
  CC      drivers/misc/ds1682.mod.o
  LD [M]  drivers/misc/ds1682.ko
  CC      drivers/misc/eeprom/at24.mod.o
  LD [M]  drivers/misc/eeprom/at24.ko
  CC      drivers/misc/eeprom/eeprom.mod.o
  LD [M]  drivers/misc/eeprom/eeprom.ko
  CC      drivers/misc/eeprom/eeprom_93cx6.mod.o
  LD [M]  drivers/misc/eeprom/eeprom_93cx6.ko
  CC      drivers/misc/eeprom/max6875.mod.o
  LD [M]  drivers/misc/eeprom/max6875.ko
  CC      drivers/misc/fsa9480.mod.o
  LD [M]  drivers/misc/fsa9480.ko
  CC      drivers/misc/hmc6352.mod.o
  LD [M]  drivers/misc/hmc6352.ko
  CC      drivers/misc/ics932s401.mod.o
  LD [M]  drivers/misc/ics932s401.ko
  CC      drivers/misc/isl29003.mod.o
  LD [M]  drivers/misc/isl29003.ko
  CC      drivers/misc/isl29020.mod.o
  LD [M]  drivers/misc/isl29020.ko
  CC      drivers/misc/lis3lv02d/lis3lv02d_i2c.mod.o
  LD [M]  drivers/misc/lis3lv02d/lis3lv02d_i2c.ko
  CC      drivers/misc/mei/mei-txe.mod.o
  LD [M]  drivers/misc/mei/mei-txe.ko
  CC      drivers/misc/mei/mei.mod.o
  LD [M]  drivers/misc/mei/mei.ko
  CC      drivers/misc/tifm_7xx1.mod.o
  LD [M]  drivers/misc/tifm_7xx1.ko
  CC      drivers/misc/tifm_core.mod.o
  LD [M]  drivers/misc/tifm_core.ko
  CC      drivers/misc/tsl2550.mod.o
  LD [M]  drivers/misc/tsl2550.ko
  CC      drivers/mmc/card/sdio_uart.mod.o
  LD [M]  drivers/mmc/card/sdio_uart.ko
  CC      drivers/mmc/host/cb710-mmc.mod.o
  LD [M]  drivers/mmc/host/cb710-mmc.ko
  CC      drivers/mmc/host/sdhci-acpi.mod.o
  LD [M]  drivers/mmc/host/sdhci-acpi.ko
  CC      drivers/mmc/host/sdhci-pci.mod.o
  LD [M]  drivers/mmc/host/sdhci-pci.ko
  CC      drivers/mmc/host/sdhci-pltfm.mod.o
  LD [M]  drivers/mmc/host/sdhci-pltfm.ko
  CC      drivers/mmc/host/sdhci.mod.o
  LD [M]  drivers/mmc/host/sdhci.ko
  CC      drivers/mmc/host/sdricoh_cs.mod.o
  LD [M]  drivers/mmc/host/sdricoh_cs.ko
  CC      drivers/mmc/host/tifm_sd.mod.o
  LD [M]  drivers/mmc/host/tifm_sd.ko
  CC      drivers/mmc/host/ushc.mod.o
  LD [M]  drivers/mmc/host/ushc.ko
  CC      drivers/mmc/host/via-sdmmc.mod.o
  LD [M]  drivers/mmc/host/via-sdmmc.ko
  CC      drivers/mmc/host/vub300.mod.o
  LD [M]  drivers/mmc/host/vub300.ko
  CC      drivers/mmc/host/wbsd.mod.o
  LD [M]  drivers/mmc/host/wbsd.ko
  CC      drivers/mtd/chips/cfi_cmdset_0001.mod.o
  LD [M]  drivers/mtd/chips/cfi_cmdset_0001.ko
  CC      drivers/mtd/chips/cfi_cmdset_0002.mod.o
  LD [M]  drivers/mtd/chips/cfi_cmdset_0002.ko
  CC      drivers/mtd/chips/cfi_cmdset_0020.mod.o
  LD [M]  drivers/mtd/chips/cfi_cmdset_0020.ko
  CC      drivers/mtd/chips/cfi_probe.mod.o
  LD [M]  drivers/mtd/chips/cfi_probe.ko
  CC      drivers/mtd/chips/cfi_util.mod.o
  LD [M]  drivers/mtd/chips/cfi_util.ko
  CC      drivers/mtd/chips/gen_probe.mod.o
  LD [M]  drivers/mtd/chips/gen_probe.ko
  CC      drivers/mtd/chips/jedec_probe.mod.o
  LD [M]  drivers/mtd/chips/jedec_probe.ko
  CC      drivers/mtd/chips/map_absent.mod.o
  LD [M]  drivers/mtd/chips/map_absent.ko
  CC      drivers/mtd/chips/map_ram.mod.o
  LD [M]  drivers/mtd/chips/map_ram.ko
  CC      drivers/mtd/chips/map_rom.mod.o
  LD [M]  drivers/mtd/chips/map_rom.ko
  CC      drivers/mtd/devices/block2mtd.mod.o
  LD [M]  drivers/mtd/devices/block2mtd.ko
  CC      drivers/mtd/devices/docg3.mod.o
  LD [M]  drivers/mtd/devices/docg3.ko
  CC      drivers/mtd/devices/phram.mod.o
  LD [M]  drivers/mtd/devices/phram.ko
  CC      drivers/mtd/devices/slram.mod.o
  LD [M]  drivers/mtd/devices/slram.ko
  CC      drivers/mtd/ftl.mod.o
  LD [M]  drivers/mtd/ftl.ko
  CC      drivers/mtd/inftl.mod.o
  LD [M]  drivers/mtd/inftl.ko
  CC      drivers/mtd/maps/amd76xrom.mod.o
  LD [M]  drivers/mtd/maps/amd76xrom.ko
  CC      drivers/mtd/maps/ck804xrom.mod.o
  LD [M]  drivers/mtd/maps/ck804xrom.ko
  CC      drivers/mtd/maps/esb2rom.mod.o
  LD [M]  drivers/mtd/maps/esb2rom.ko
  CC      drivers/mtd/maps/ichxrom.mod.o
  LD [M]  drivers/mtd/maps/ichxrom.ko
  CC      drivers/mtd/maps/intel_vr_nor.mod.o
  LD [M]  drivers/mtd/maps/intel_vr_nor.ko
  CC      drivers/mtd/maps/l440gx.mod.o
  LD [M]  drivers/mtd/maps/l440gx.ko
  CC      drivers/mtd/maps/nettel.mod.o
  LD [M]  drivers/mtd/maps/nettel.ko
  CC      drivers/mtd/maps/physmap.mod.o
  LD [M]  drivers/mtd/maps/physmap.ko
  CC      drivers/mtd/maps/plat-ram.mod.o
  LD [M]  drivers/mtd/maps/plat-ram.ko
  CC      drivers/mtd/maps/scb2_flash.mod.o
  LD [M]  drivers/mtd/maps/scb2_flash.ko
  CC      drivers/mtd/mtd_blkdevs.mod.o
  LD [M]  drivers/mtd/mtd_blkdevs.ko
  CC      drivers/mtd/mtdblock.mod.o
  LD [M]  drivers/mtd/mtdblock.ko
  CC      drivers/mtd/mtdblock_ro.mod.o
  LD [M]  drivers/mtd/mtdblock_ro.ko
  CC      drivers/mtd/nand/nand.mod.o
  LD [M]  drivers/mtd/nand/nand.ko
  CC      drivers/mtd/nand/nand_ecc.mod.o
  LD [M]  drivers/mtd/nand/nand_ecc.ko
  CC      drivers/mtd/nand/nand_ids.mod.o
  LD [M]  drivers/mtd/nand/nand_ids.ko
  CC      drivers/mtd/nftl.mod.o
  LD [M]  drivers/mtd/nftl.ko
  CC      drivers/mtd/onenand/generic.mod.o
  LD [M]  drivers/mtd/onenand/generic.ko
  CC      drivers/mtd/onenand/onenand.mod.o
  LD [M]  drivers/mtd/onenand/onenand.ko
  CC      drivers/mtd/rfd_ftl.mod.o
  LD [M]  drivers/mtd/rfd_ftl.ko
  CC      drivers/mtd/sm_ftl.mod.o
  LD [M]  drivers/mtd/sm_ftl.ko
  CC      drivers/mtd/ssfdc.mod.o
  LD [M]  drivers/mtd/ssfdc.ko
  CC      drivers/net/can/c_can/c_can.mod.o
  LD [M]  drivers/net/can/c_can/c_can.ko
  CC      drivers/net/can/sja1000/ems_pci.mod.o
  LD [M]  drivers/net/can/sja1000/ems_pci.ko
  CC      drivers/net/can/sja1000/kvaser_pci.mod.o
  LD [M]  drivers/net/can/sja1000/kvaser_pci.ko
  CC      drivers/net/can/sja1000/plx_pci.mod.o
  LD [M]  drivers/net/can/sja1000/plx_pci.ko
  CC      drivers/net/can/sja1000/sja1000.mod.o
  LD [M]  drivers/net/can/sja1000/sja1000.ko
  CC      drivers/net/can/sja1000/sja1000_platform.mod.o
  LD [M]  drivers/net/can/sja1000/sja1000_platform.ko
  CC      drivers/net/can/slcan.mod.o
  LD [M]  drivers/net/can/slcan.ko
  CC      drivers/net/can/softing/softing.mod.o
  LD [M]  drivers/net/can/softing/softing.ko
  CC      drivers/net/can/softing/softing_cs.mod.o
  LD [M]  drivers/net/can/softing/softing_cs.ko
  CC      drivers/net/can/usb/ems_usb.mod.o
  LD [M]  drivers/net/can/usb/ems_usb.ko
  CC      drivers/net/can/usb/esd_usb2.mod.o
  LD [M]  drivers/net/can/usb/esd_usb2.ko
  CC      drivers/net/can/usb/kvaser_usb.mod.o
  LD [M]  drivers/net/can/usb/kvaser_usb.ko
  CC      drivers/net/can/usb/peak_usb/peak_usb.mod.o
  LD [M]  drivers/net/can/usb/peak_usb/peak_usb.ko
  CC      drivers/net/can/usb/usb_8dev.mod.o
  LD [M]  drivers/net/can/usb/usb_8dev.ko
  CC      drivers/net/ethernet/broadcom/b44.mod.o
  LD [M]  drivers/net/ethernet/broadcom/b44.ko
  CC      drivers/net/ethernet/broadcom/bnx2.mod.o
  LD [M]  drivers/net/ethernet/broadcom/bnx2.ko
  CC      drivers/net/ethernet/broadcom/bnx2x/bnx2x.mod.o
  LD [M]  drivers/net/ethernet/broadcom/bnx2x/bnx2x.ko
  CC      drivers/net/ethernet/broadcom/cnic.mod.o
  LD [M]  drivers/net/ethernet/broadcom/cnic.ko
  CC      drivers/net/ethernet/broadcom/tg3.mod.o
  LD [M]  drivers/net/ethernet/broadcom/tg3.ko
  CC      drivers/net/ethernet/hp/hp100.mod.o
  LD [M]  drivers/net/ethernet/hp/hp100.ko
  CC      drivers/net/ethernet/intel/e100.mod.o
  LD [M]  drivers/net/ethernet/intel/e100.ko
  CC      drivers/net/ethernet/intel/e1000/e1000.mod.o
  LD [M]  drivers/net/ethernet/intel/e1000/e1000.ko
  CC      drivers/net/ethernet/intel/igb/igb.mod.o
  LD [M]  drivers/net/ethernet/intel/igb/igb.ko
  CC      drivers/net/ethernet/intel/igbvf/igbvf.mod.o
  LD [M]  drivers/net/ethernet/intel/igbvf/igbvf.ko
  CC      drivers/net/ethernet/intel/ixgb/ixgb.mod.o
  LD [M]  drivers/net/ethernet/intel/ixgb/ixgb.ko
  CC      drivers/net/ethernet/intel/ixgbe/ixgbe.mod.o
  LD [M]  drivers/net/ethernet/intel/ixgbe/ixgbe.ko
  CC      drivers/net/ethernet/intel/ixgbevf/ixgbevf.mod.o
  LD [M]  drivers/net/ethernet/intel/ixgbevf/ixgbevf.ko
  CC      drivers/net/ethernet/marvell/skge.mod.o
  LD [M]  drivers/net/ethernet/marvell/skge.ko
  CC      drivers/net/ethernet/marvell/sky2.mod.o
  LD [M]  drivers/net/ethernet/marvell/sky2.ko
  CC      drivers/net/ethernet/realtek/8139cp.mod.o
  LD [M]  drivers/net/ethernet/realtek/8139cp.ko
  CC      drivers/net/ethernet/realtek/8139too.mod.o
  LD [M]  drivers/net/ethernet/realtek/8139too.ko
  CC      drivers/net/irda/act200l-sir.mod.o
  LD [M]  drivers/net/irda/act200l-sir.ko
  CC      drivers/net/irda/actisys-sir.mod.o
  LD [M]  drivers/net/irda/actisys-sir.ko
  CC      drivers/net/irda/ali-ircc.mod.o
  LD [M]  drivers/net/irda/ali-ircc.ko
  CC      drivers/net/irda/esi-sir.mod.o
  LD [M]  drivers/net/irda/esi-sir.ko
  CC      drivers/net/irda/girbil-sir.mod.o
  LD [M]  drivers/net/irda/girbil-sir.ko
  CC      drivers/net/irda/irda-usb.mod.o
  LD [M]  drivers/net/irda/irda-usb.ko
  CC      drivers/net/irda/irtty-sir.mod.o
  LD [M]  drivers/net/irda/irtty-sir.ko
  CC      drivers/net/irda/kingsun-sir.mod.o
  LD [M]  drivers/net/irda/kingsun-sir.ko
  CC      drivers/net/irda/ks959-sir.mod.o
  LD [M]  drivers/net/irda/ks959-sir.ko
  CC      drivers/net/irda/ksdazzle-sir.mod.o
  LD [M]  drivers/net/irda/ksdazzle-sir.ko
  CC      drivers/net/irda/litelink-sir.mod.o
  LD [M]  drivers/net/irda/litelink-sir.ko
  CC      drivers/net/irda/ma600-sir.mod.o
  LD [M]  drivers/net/irda/ma600-sir.ko
  CC      drivers/net/irda/mcp2120-sir.mod.o
  LD [M]  drivers/net/irda/mcp2120-sir.ko
  CC      drivers/net/irda/mcs7780.mod.o
  LD [M]  drivers/net/irda/mcs7780.ko
  CC      drivers/net/irda/nsc-ircc.mod.o
  LD [M]  drivers/net/irda/nsc-ircc.ko
  CC      drivers/net/irda/old_belkin-sir.mod.o
  LD [M]  drivers/net/irda/old_belkin-sir.ko
  CC      drivers/net/irda/sir-dev.mod.o
  LD [M]  drivers/net/irda/sir-dev.ko
  CC      drivers/net/irda/smsc-ircc2.mod.o
  LD [M]  drivers/net/irda/smsc-ircc2.ko
  CC      drivers/net/irda/stir4200.mod.o
  LD [M]  drivers/net/irda/stir4200.ko
  CC      drivers/net/irda/tekram-sir.mod.o
  LD [M]  drivers/net/irda/tekram-sir.ko
  CC      drivers/net/irda/toim3232-sir.mod.o
  LD [M]  drivers/net/irda/toim3232-sir.ko
  CC      drivers/net/irda/via-ircc.mod.o
  LD [M]  drivers/net/irda/via-ircc.ko
  CC      drivers/net/irda/vlsi_ir.mod.o
  LD [M]  drivers/net/irda/vlsi_ir.ko
  CC      drivers/net/irda/w83977af_ir.mod.o
  LD [M]  drivers/net/irda/w83977af_ir.ko
  CC      drivers/net/mdio.mod.o
  LD [M]  drivers/net/mdio.ko
  CC      drivers/net/phy/bcm-phy-lib.mod.o
  LD [M]  drivers/net/phy/bcm-phy-lib.ko
  CC      drivers/net/phy/broadcom.mod.o
  LD [M]  drivers/net/phy/broadcom.ko
  CC      drivers/net/phy/cicada.mod.o
  LD [M]  drivers/net/phy/cicada.ko
  CC      drivers/net/phy/davicom.mod.o
  LD [M]  drivers/net/phy/davicom.ko
  CC      drivers/net/phy/dp83640.mod.o
  LD [M]  drivers/net/phy/dp83640.ko
  CC      drivers/net/phy/dp83867.mod.o
  LD [M]  drivers/net/phy/dp83867.ko
  CC      drivers/net/phy/et1011c.mod.o
  LD [M]  drivers/net/phy/et1011c.ko
  CC      drivers/net/phy/icplus.mod.o
  LD [M]  drivers/net/phy/icplus.ko
  CC      drivers/net/phy/lxt.mod.o
  LD [M]  drivers/net/phy/lxt.ko
  CC      drivers/net/phy/marvell.mod.o
  LD [M]  drivers/net/phy/marvell.ko
  CC      drivers/net/phy/micrel.mod.o
  LD [M]  drivers/net/phy/micrel.ko
  CC      drivers/net/phy/national.mod.o
  LD [M]  drivers/net/phy/national.ko
  CC      drivers/net/phy/qsemi.mod.o
  LD [M]  drivers/net/phy/qsemi.ko
  CC      drivers/net/phy/realtek.mod.o
  LD [M]  drivers/net/phy/realtek.ko
  CC      drivers/net/phy/smsc.mod.o
  LD [M]  drivers/net/phy/smsc.ko
  CC      drivers/net/phy/ste10Xp.mod.o
  LD [M]  drivers/net/phy/ste10Xp.ko
  CC      drivers/net/phy/vitesse.mod.o
  LD [M]  drivers/net/phy/vitesse.ko
  CC      drivers/net/ppp/bsd_comp.mod.o
  LD [M]  drivers/net/ppp/bsd_comp.ko
  CC      drivers/net/ppp/ppp_async.mod.o
  LD [M]  drivers/net/ppp/ppp_async.ko
  CC      drivers/net/ppp/ppp_deflate.mod.o
  LD [M]  drivers/net/ppp/ppp_deflate.ko
  CC      drivers/net/ppp/ppp_generic.mod.o
  LD [M]  drivers/net/ppp/ppp_generic.ko
  CC      drivers/net/ppp/ppp_mppe.mod.o
  LD [M]  drivers/net/ppp/ppp_mppe.ko
  CC      drivers/net/ppp/ppp_synctty.mod.o
  LD [M]  drivers/net/ppp/ppp_synctty.ko
  CC      drivers/net/ppp/pppoe.mod.o
  LD [M]  drivers/net/ppp/pppoe.ko
  CC      drivers/net/ppp/pppox.mod.o
  LD [M]  drivers/net/ppp/pppox.ko
  CC      drivers/net/ppp/pptp.mod.o
  LD [M]  drivers/net/ppp/pptp.ko
  CC      drivers/net/slip/slhc.mod.o
  LD [M]  drivers/net/slip/slhc.ko
  CC      drivers/net/slip/slip.mod.o
  LD [M]  drivers/net/slip/slip.ko
  CC      drivers/net/usb/asix.mod.o
  LD [M]  drivers/net/usb/asix.ko
  CC      drivers/net/usb/ax88179_178a.mod.o
  LD [M]  drivers/net/usb/ax88179_178a.ko
  CC      drivers/net/usb/catc.mod.o
  LD [M]  drivers/net/usb/catc.ko
  CC      drivers/net/usb/cdc_eem.mod.o
  LD [M]  drivers/net/usb/cdc_eem.ko
  CC      drivers/net/usb/cdc_ether.mod.o
  LD [M]  drivers/net/usb/cdc_ether.ko
  CC      drivers/net/usb/cdc_mbim.mod.o
  LD [M]  drivers/net/usb/cdc_mbim.ko
  CC      drivers/net/usb/cdc_ncm.mod.o
  LD [M]  drivers/net/usb/cdc_ncm.ko
  CC      drivers/net/usb/cdc_subset.mod.o
  LD [M]  drivers/net/usb/cdc_subset.ko
  CC      drivers/net/usb/cx82310_eth.mod.o
  LD [M]  drivers/net/usb/cx82310_eth.ko
  CC      drivers/net/usb/dm9601.mod.o
  LD [M]  drivers/net/usb/dm9601.ko
  CC      drivers/net/usb/gl620a.mod.o
  LD [M]  drivers/net/usb/gl620a.ko
  CC      drivers/net/usb/hso.mod.o
  LD [M]  drivers/net/usb/hso.ko
  CC      drivers/net/usb/huawei_cdc_ncm.mod.o
  LD [M]  drivers/net/usb/huawei_cdc_ncm.ko
  CC      drivers/net/usb/int51x1.mod.o
  LD [M]  drivers/net/usb/int51x1.ko
  CC      drivers/net/usb/ipheth.mod.o
  LD [M]  drivers/net/usb/ipheth.ko
  CC      drivers/net/usb/kalmia.mod.o
  LD [M]  drivers/net/usb/kalmia.ko
  CC      drivers/net/usb/kaweth.mod.o
  LD [M]  drivers/net/usb/kaweth.ko
  CC      drivers/net/usb/lg-vl600.mod.o
  LD [M]  drivers/net/usb/lg-vl600.ko
  CC      drivers/net/usb/mcs7830.mod.o
  LD [M]  drivers/net/usb/mcs7830.ko
  CC      drivers/net/usb/net1080.mod.o
  LD [M]  drivers/net/usb/net1080.ko
  CC      drivers/net/usb/pegasus.mod.o
  LD [M]  drivers/net/usb/pegasus.ko
  CC      drivers/net/usb/plusb.mod.o
  LD [M]  drivers/net/usb/plusb.ko
  CC      drivers/net/usb/rndis_host.mod.o
  LD [M]  drivers/net/usb/rndis_host.ko
  CC      drivers/net/usb/rtl8150.mod.o
  LD [M]  drivers/net/usb/rtl8150.ko
  CC      drivers/net/usb/sierra_net.mod.o
  LD [M]  drivers/net/usb/sierra_net.ko
  CC      drivers/net/usb/smsc75xx.mod.o
  LD [M]  drivers/net/usb/smsc75xx.ko
  CC      drivers/net/usb/smsc95xx.mod.o
  LD [M]  drivers/net/usb/smsc95xx.ko
  CC      drivers/net/usb/sr9700.mod.o
  LD [M]  drivers/net/usb/sr9700.ko
  CC      drivers/net/usb/sr9800.mod.o
  LD [M]  drivers/net/usb/sr9800.ko
  CC      drivers/net/usb/usbnet.mod.o
  LD [M]  drivers/net/usb/usbnet.ko
  CC      drivers/net/usb/zaurus.mod.o
  LD [M]  drivers/net/usb/zaurus.ko
  CC      drivers/net/vmxnet3/vmxnet3.mod.o
  LD [M]  drivers/net/vmxnet3/vmxnet3.ko
  CC      drivers/net/wimax/i2400m/i2400m-usb.mod.o
  LD [M]  drivers/net/wimax/i2400m/i2400m-usb.ko
  CC      drivers/net/wimax/i2400m/i2400m.mod.o
  LD [M]  drivers/net/wimax/i2400m/i2400m.ko
  CC      drivers/net/wireless/at76c50x-usb.mod.o
  LD [M]  drivers/net/wireless/at76c50x-usb.ko
  CC      drivers/net/wireless/brcm80211/brcmsmac/brcmsmac.mod.o
  LD [M]  drivers/net/wireless/brcm80211/brcmsmac/brcmsmac.ko
  CC      drivers/net/wireless/brcm80211/brcmutil/brcmutil.mod.o
  LD [M]  drivers/net/wireless/brcm80211/brcmutil/brcmutil.ko
  CC      drivers/net/wireless/iwlwifi/dvm/iwldvm.mod.o
  LD [M]  drivers/net/wireless/iwlwifi/dvm/iwldvm.ko
  CC      drivers/net/wireless/realtek/rtl818x/rtl8187/rtl8187.mod.o
  LD [M]  drivers/net/wireless/realtek/rtl818x/rtl8187/rtl8187.ko
  CC
drivers/net/wireless/realtek/rtlwifi/rtl8192c/rtl8192c-common.mod.o
  LD [M]  drivers/net/wireless/realtek/rtlwifi/rtl8192c/rtl8192c-common.ko
  CC      drivers/net/wireless/realtek/rtlwifi/rtl8192cu/rtl8192cu.mod.o
  LD [M]  drivers/net/wireless/realtek/rtlwifi/rtl8192cu/rtl8192cu.ko
  CC      drivers/net/wireless/realtek/rtlwifi/rtl_usb.mod.o
  LD [M]  drivers/net/wireless/realtek/rtlwifi/rtl_usb.ko
  CC      drivers/net/wireless/realtek/rtlwifi/rtlwifi.mod.o
  LD [M]  drivers/net/wireless/realtek/rtlwifi/rtlwifi.ko
  CC      drivers/net/wireless/rndis_wlan.mod.o
  LD [M]  drivers/net/wireless/rndis_wlan.ko
  CC      drivers/net/wireless/zd1201.mod.o
  LD [M]  drivers/net/wireless/zd1201.ko
  CC      drivers/net/wireless/zd1211rw/zd1211rw.mod.o
  LD [M]  drivers/net/wireless/zd1211rw/zd1211rw.ko
  CC      drivers/phy/phy-bcm-kona-usb2.mod.o
  LD [M]  drivers/phy/phy-bcm-kona-usb2.ko
  CC      drivers/power/ds2782_battery.mod.o
  LD [M]  drivers/power/ds2782_battery.ko
  CC      drivers/power/max17040_battery.mod.o
  LD [M]  drivers/power/max17040_battery.ko
  CC      drivers/regulator/aat2870-regulator.mod.o
  LD [M]  drivers/regulator/aat2870-regulator.ko
  CC      drivers/regulator/ab3100.mod.o
  LD [M]  drivers/regulator/ab3100.ko
  CC      drivers/regulator/ad5398.mod.o
  LD [M]  drivers/regulator/ad5398.ko
  CC      drivers/regulator/as3711-regulator.mod.o
  LD [M]  drivers/regulator/as3711-regulator.ko
  CC      drivers/regulator/da903x.mod.o
  LD [M]  drivers/regulator/da903x.ko
  CC      drivers/regulator/da9052-regulator.mod.o
  LD [M]  drivers/regulator/da9052-regulator.ko
  CC      drivers/regulator/da9055-regulator.mod.o
  LD [M]  drivers/regulator/da9055-regulator.ko
  CC      drivers/regulator/da9063-regulator.mod.o
  LD [M]  drivers/regulator/da9063-regulator.ko
  CC      drivers/regulator/da9210-regulator.mod.o
  LD [M]  drivers/regulator/da9210-regulator.ko
  CC      drivers/regulator/fan53555.mod.o
  LD [M]  drivers/regulator/fan53555.ko
  CC      drivers/regulator/fixed.mod.o
  LD [M]  drivers/regulator/fixed.ko
  CC      drivers/regulator/gpio-regulator.mod.o
  LD [M]  drivers/regulator/gpio-regulator.ko
  CC      drivers/regulator/isl6271a-regulator.mod.o
  LD [M]  drivers/regulator/isl6271a-regulator.ko
  CC      drivers/regulator/lp3971.mod.o
  LD [M]  drivers/regulator/lp3971.ko
  CC      drivers/regulator/lp3972.mod.o
  LD [M]  drivers/regulator/lp3972.ko
  CC      drivers/regulator/lp8755.mod.o
  LD [M]  drivers/regulator/lp8755.ko
  CC      drivers/regulator/max1586.mod.o
  LD [M]  drivers/regulator/max1586.ko
  CC      drivers/regulator/max77693.mod.o
  LD [M]  drivers/regulator/max77693.ko
  CC      drivers/regulator/max8649.mod.o
  LD [M]  drivers/regulator/max8649.ko
  CC      drivers/regulator/max8660.mod.o
  LD [M]  drivers/regulator/max8660.ko
  CC      drivers/regulator/max8907-regulator.mod.o
  LD [M]  drivers/regulator/max8907-regulator.ko
  CC      drivers/regulator/max8925-regulator.mod.o
  LD [M]  drivers/regulator/max8925-regulator.ko
  CC      drivers/regulator/max8952.mod.o
  LD [M]  drivers/regulator/max8952.ko
  CC      drivers/regulator/max8973-regulator.mod.o
  LD [M]  drivers/regulator/max8973-regulator.ko
  CC      drivers/regulator/max8997.mod.o
  LD [M]  drivers/regulator/max8997.ko
  CC      drivers/regulator/max8998.mod.o
  LD [M]  drivers/regulator/max8998.ko
  CC      drivers/regulator/mc13783-regulator.mod.o
  LD [M]  drivers/regulator/mc13783-regulator.ko
  CC      drivers/regulator/mc13892-regulator.mod.o
  LD [M]  drivers/regulator/mc13892-regulator.ko
  CC      drivers/regulator/mc13xxx-regulator-core.mod.o
  LD [M]  drivers/regulator/mc13xxx-regulator-core.ko
  CC      drivers/regulator/palmas-regulator.mod.o
  LD [M]  drivers/regulator/palmas-regulator.ko
  CC      drivers/regulator/pcf50633-regulator.mod.o
  LD [M]  drivers/regulator/pcf50633-regulator.ko
  CC      drivers/regulator/pfuze100-regulator.mod.o
  LD [M]  drivers/regulator/pfuze100-regulator.ko
  CC      drivers/regulator/rc5t583-regulator.mod.o
  LD [M]  drivers/regulator/rc5t583-regulator.ko
  CC      drivers/regulator/s2mps11.mod.o
  LD [M]  drivers/regulator/s2mps11.ko
  CC      drivers/regulator/s5m8767.mod.o
  LD [M]  drivers/regulator/s5m8767.ko
  CC      drivers/regulator/tps51632-regulator.mod.o
  LD [M]  drivers/regulator/tps51632-regulator.ko
  CC      drivers/regulator/tps6105x-regulator.mod.o
  LD [M]  drivers/regulator/tps6105x-regulator.ko
  CC      drivers/regulator/tps62360-regulator.mod.o
  LD [M]  drivers/regulator/tps62360-regulator.ko
  CC      drivers/regulator/tps65023-regulator.mod.o
  LD [M]  drivers/regulator/tps65023-regulator.ko
  CC      drivers/regulator/tps6507x-regulator.mod.o
  LD [M]  drivers/regulator/tps6507x-regulator.ko
  CC      drivers/regulator/tps65090-regulator.mod.o
  LD [M]  drivers/regulator/tps65090-regulator.ko
  CC      drivers/regulator/tps65217-regulator.mod.o
  LD [M]  drivers/regulator/tps65217-regulator.ko
  CC      drivers/regulator/tps6524x-regulator.mod.o
  LD [M]  drivers/regulator/tps6524x-regulator.ko
  CC      drivers/regulator/tps6586x-regulator.mod.o
  LD [M]  drivers/regulator/tps6586x-regulator.ko
  CC      drivers/regulator/tps65910-regulator.mod.o
  LD [M]  drivers/regulator/tps65910-regulator.ko
  CC      drivers/regulator/tps65912-regulator.mod.o
  LD [M]  drivers/regulator/tps65912-regulator.ko
  CC      drivers/regulator/tps80031-regulator.mod.o
  LD [M]  drivers/regulator/tps80031-regulator.ko
  CC      drivers/regulator/wm831x-dcdc.mod.o
  LD [M]  drivers/regulator/wm831x-dcdc.ko
  CC      drivers/regulator/wm831x-isink.mod.o
  LD [M]  drivers/regulator/wm831x-isink.ko
  CC      drivers/regulator/wm831x-ldo.mod.o
  LD [M]  drivers/regulator/wm831x-ldo.ko
  CC      drivers/regulator/wm8350-regulator.mod.o
  LD [M]  drivers/regulator/wm8350-regulator.ko
  CC      drivers/regulator/wm8400-regulator.mod.o
  LD [M]  drivers/regulator/wm8400-regulator.ko
  CC      drivers/regulator/wm8994-regulator.mod.o
  LD [M]  drivers/regulator/wm8994-regulator.ko
  CC      drivers/rtc/rtc-bq4802.mod.o
  LD [M]  drivers/rtc/rtc-bq4802.ko
  CC      drivers/rtc/rtc-ds1286.mod.o
  LD [M]  drivers/rtc/rtc-ds1286.ko
  CC      drivers/rtc/rtc-ds1307.mod.o
  LD [M]  drivers/rtc/rtc-ds1307.ko
  CC      drivers/rtc/rtc-ds1374.mod.o
  LD [M]  drivers/rtc/rtc-ds1374.ko
  CC      drivers/rtc/rtc-ds1511.mod.o
  LD [M]  drivers/rtc/rtc-ds1511.ko
  CC      drivers/rtc/rtc-ds1553.mod.o
  LD [M]  drivers/rtc/rtc-ds1553.ko
  CC      drivers/rtc/rtc-ds1672.mod.o
  LD [M]  drivers/rtc/rtc-ds1672.ko
  CC      drivers/rtc/rtc-ds1742.mod.o
  LD [M]  drivers/rtc/rtc-ds1742.ko
  CC      drivers/rtc/rtc-fm3130.mod.o
  LD [M]  drivers/rtc/rtc-fm3130.ko
  CC      drivers/rtc/rtc-isl1208.mod.o
  LD [M]  drivers/rtc/rtc-isl1208.ko
  CC      drivers/rtc/rtc-m41t80.mod.o
  LD [M]  drivers/rtc/rtc-m41t80.ko
  CC      drivers/rtc/rtc-m48t35.mod.o
  LD [M]  drivers/rtc/rtc-m48t35.ko
  CC      drivers/rtc/rtc-m48t59.mod.o
  LD [M]  drivers/rtc/rtc-m48t59.ko
  CC      drivers/rtc/rtc-m48t86.mod.o
  LD [M]  drivers/rtc/rtc-m48t86.ko
  CC      drivers/rtc/rtc-max6900.mod.o
  LD [M]  drivers/rtc/rtc-max6900.ko
  CC      drivers/rtc/rtc-pcf50633.mod.o
  LD [M]  drivers/rtc/rtc-pcf50633.ko
  CC      drivers/rtc/rtc-pcf8563.mod.o
  LD [M]  drivers/rtc/rtc-pcf8563.ko
  CC      drivers/rtc/rtc-pcf8583.mod.o
  LD [M]  drivers/rtc/rtc-pcf8583.ko
  CC      drivers/rtc/rtc-rs5c372.mod.o
  LD [M]  drivers/rtc/rtc-rs5c372.ko
  CC      drivers/rtc/rtc-rx8025.mod.o
  LD [M]  drivers/rtc/rtc-rx8025.ko
  CC      drivers/rtc/rtc-rx8581.mod.o
  LD [M]  drivers/rtc/rtc-rx8581.ko
  CC      drivers/rtc/rtc-s35390a.mod.o
  LD [M]  drivers/rtc/rtc-s35390a.ko
  CC      drivers/rtc/rtc-stk17ta8.mod.o
  LD [M]  drivers/rtc/rtc-stk17ta8.ko
  CC      drivers/rtc/rtc-v3020.mod.o
  LD [M]  drivers/rtc/rtc-v3020.ko
  CC      drivers/rtc/rtc-x1205.mod.o
  LD [M]  drivers/rtc/rtc-x1205.ko
  CC      drivers/spi/spi-altera.mod.o
  LD [M]  drivers/spi/spi-altera.ko
  CC      drivers/spi/spi-bitbang.mod.o
  LD [M]  drivers/spi/spi-bitbang.ko
  CC      drivers/spi/spi-cadence.mod.o
  LD [M]  drivers/spi/spi-cadence.ko
  CC      drivers/spi/spi-dw-midpci.mod.o
  LD [M]  drivers/spi/spi-dw-midpci.ko
  CC      drivers/spi/spi-dw.mod.o
  LD [M]  drivers/spi/spi-dw.ko
  CC      drivers/spi/spi-pxa2xx-pci.mod.o
  LD [M]  drivers/spi/spi-pxa2xx-pci.ko
  CC      drivers/spi/spi-pxa2xx-platform.mod.o
  LD [M]  drivers/spi/spi-pxa2xx-platform.ko
  CC      drivers/spi/spi-sc18is602.mod.o
  LD [M]  drivers/spi/spi-sc18is602.ko
  CC      drivers/spi/spi-tle62x0.mod.o
  LD [M]  drivers/spi/spi-tle62x0.ko
  CC      drivers/spi/spi-xcomm.mod.o
  LD [M]  drivers/spi/spi-xcomm.ko
  CC      drivers/spi/spi-xilinx.mod.o
  LD [M]  drivers/spi/spi-xilinx.ko
  CC      drivers/spi/spi-zynqmp-gqspi.mod.o
  LD [M]  drivers/spi/spi-zynqmp-gqspi.ko
  CC      drivers/spi/spidev.mod.o
  LD [M]  drivers/spi/spidev.ko
  CC      drivers/ssb/ssb.mod.o
  LD [M]  drivers/ssb/ssb.ko
  CC      drivers/staging/rts5208/rts5208.mod.o
  LD [M]  drivers/staging/rts5208/rts5208.ko
  CC      drivers/thermal/x86_pkg_temp_thermal.mod.o
  LD [M]  drivers/thermal/x86_pkg_temp_thermal.ko
  CC      drivers/tty/n_r3964.mod.o
  LD [M]  drivers/tty/n_r3964.ko
  CC      drivers/tty/serial/8250/serial_cs.mod.o
  LD [M]  drivers/tty/serial/8250/serial_cs.ko
  CC      drivers/uio/uio_aec.mod.o
  LD [M]  drivers/uio/uio_aec.ko
  CC      drivers/uio/uio_cif.mod.o
  LD [M]  drivers/uio/uio_cif.ko
  CC      drivers/uio/uio_dmem_genirq.mod.o
  LD [M]  drivers/uio/uio_dmem_genirq.ko
  CC      drivers/uio/uio_netx.mod.o
  LD [M]  drivers/uio/uio_netx.ko
  CC      drivers/uio/uio_pdrv_genirq.mod.o
  LD [M]  drivers/uio/uio_pdrv_genirq.ko
  CC      drivers/uio/uio_sercos3.mod.o
  LD [M]  drivers/uio/uio_sercos3.ko
  CC      drivers/usb/class/cdc-acm.mod.o
  LD [M]  drivers/usb/class/cdc-acm.ko
  CC      drivers/usb/class/cdc-wdm.mod.o
  LD [M]  drivers/usb/class/cdc-wdm.ko
  CC      drivers/usb/class/usblp.mod.o
  LD [M]  drivers/usb/class/usblp.ko
  CC      drivers/usb/class/usbtmc.mod.o
  LD [M]  drivers/usb/class/usbtmc.ko
  CC      drivers/usb/dwc3/dwc3-pci.mod.o
  LD [M]  drivers/usb/dwc3/dwc3-pci.ko
  CC      drivers/usb/dwc3/dwc3.mod.o
  LD [M]  drivers/usb/dwc3/dwc3.ko
  CC      drivers/usb/host/hwa-hc.mod.o
  LD [M]  drivers/usb/host/hwa-hc.ko
  CC      drivers/usb/host/whci/whci-hcd.mod.o
  LD [M]  drivers/usb/host/whci/whci-hcd.ko
  CC      drivers/usb/host/xhci-plat-hcd.mod.o
  LD [M]  drivers/usb/host/xhci-plat-hcd.ko
  CC      drivers/usb/image/mdc800.mod.o
  LD [M]  drivers/usb/image/mdc800.ko
  CC      drivers/usb/image/microtek.mod.o
  LD [M]  drivers/usb/image/microtek.ko
  CC      drivers/usb/misc/adutux.mod.o
  LD [M]  drivers/usb/misc/adutux.ko
  CC      drivers/usb/misc/chaoskey.mod.o
  LD [M]  drivers/usb/misc/chaoskey.ko
  CC      drivers/usb/misc/cypress_cy7c63.mod.o
  LD [M]  drivers/usb/misc/cypress_cy7c63.ko
  CC      drivers/usb/misc/cytherm.mod.o
  LD [M]  drivers/usb/misc/cytherm.ko
  CC      drivers/usb/misc/ehset.mod.o
  LD [M]  drivers/usb/misc/ehset.ko
  CC      drivers/usb/misc/emi26.mod.o
  LD [M]  drivers/usb/misc/emi26.ko
  CC      drivers/usb/misc/emi62.mod.o
  LD [M]  drivers/usb/misc/emi62.ko
  CC      drivers/usb/misc/ezusb.mod.o
  LD [M]  drivers/usb/misc/ezusb.ko
  CC      drivers/usb/misc/ftdi-elan.mod.o
  LD [M]  drivers/usb/misc/ftdi-elan.ko
  CC      drivers/usb/misc/idmouse.mod.o
  LD [M]  drivers/usb/misc/idmouse.ko
  CC      drivers/usb/misc/iowarrior.mod.o
  LD [M]  drivers/usb/misc/iowarrior.ko
  CC      drivers/usb/misc/isight_firmware.mod.o
  LD [M]  drivers/usb/misc/isight_firmware.ko
  CC      drivers/usb/misc/ldusb.mod.o
  LD [M]  drivers/usb/misc/ldusb.ko
  CC      drivers/usb/misc/legousbtower.mod.o
  LD [M]  drivers/usb/misc/legousbtower.ko
  CC      drivers/usb/misc/rio500.mod.o
  LD [M]  drivers/usb/misc/rio500.ko
  CC      drivers/usb/misc/sisusbvga/sisusbvga.mod.o
  LD [M]  drivers/usb/misc/sisusbvga/sisusbvga.ko
  CC      drivers/usb/misc/trancevibrator.mod.o
  LD [M]  drivers/usb/misc/trancevibrator.ko
  CC      drivers/usb/misc/usb3503.mod.o
  LD [M]  drivers/usb/misc/usb3503.ko
  CC      drivers/usb/misc/usblcd.mod.o
  LD [M]  drivers/usb/misc/usblcd.ko
  CC      drivers/usb/misc/usbled.mod.o
  LD [M]  drivers/usb/misc/usbled.ko
  CC      drivers/usb/misc/usbsevseg.mod.o
  LD [M]  drivers/usb/misc/usbsevseg.ko
  CC      drivers/usb/misc/yurex.mod.o
  LD [M]  drivers/usb/misc/yurex.ko
  CC      drivers/usb/mon/usbmon.mod.o
  LD [M]  drivers/usb/mon/usbmon.ko
  CC      drivers/usb/phy/phy-gpio-vbus-usb.mod.o
  LD [M]  drivers/usb/phy/phy-gpio-vbus-usb.ko
  CC      drivers/usb/phy/phy-isp1301.mod.o
  LD [M]  drivers/usb/phy/phy-isp1301.ko
  CC      drivers/usb/serial/aircable.mod.o
  LD [M]  drivers/usb/serial/aircable.ko
  CC      drivers/usb/serial/ark3116.mod.o
  LD [M]  drivers/usb/serial/ark3116.ko
  CC      drivers/usb/serial/belkin_sa.mod.o
  LD [M]  drivers/usb/serial/belkin_sa.ko
  CC      drivers/usb/serial/ch341.mod.o
  LD [M]  drivers/usb/serial/ch341.ko
  CC      drivers/usb/serial/cp210x.mod.o
  LD [M]  drivers/usb/serial/cp210x.ko
  CC      drivers/usb/serial/cyberjack.mod.o
  LD [M]  drivers/usb/serial/cyberjack.ko
  CC      drivers/usb/serial/cypress_m8.mod.o
  LD [M]  drivers/usb/serial/cypress_m8.ko
  CC      drivers/usb/serial/digi_acceleport.mod.o
  LD [M]  drivers/usb/serial/digi_acceleport.ko
  CC      drivers/usb/serial/empeg.mod.o
  LD [M]  drivers/usb/serial/empeg.ko
  CC      drivers/usb/serial/f81232.mod.o
  LD [M]  drivers/usb/serial/f81232.ko
  CC      drivers/usb/serial/ftdi_sio.mod.o
  LD [M]  drivers/usb/serial/ftdi_sio.ko
  CC      drivers/usb/serial/garmin_gps.mod.o
  LD [M]  drivers/usb/serial/garmin_gps.ko
  CC      drivers/usb/serial/io_edgeport.mod.o
  LD [M]  drivers/usb/serial/io_edgeport.ko
  CC      drivers/usb/serial/io_ti.mod.o
  LD [M]  drivers/usb/serial/io_ti.ko
  CC      drivers/usb/serial/ipaq.mod.o
  LD [M]  drivers/usb/serial/ipaq.ko
  CC      drivers/usb/serial/ipw.mod.o
  LD [M]  drivers/usb/serial/ipw.ko
  CC      drivers/usb/serial/ir-usb.mod.o
  LD [M]  drivers/usb/serial/ir-usb.ko
  CC      drivers/usb/serial/iuu_phoenix.mod.o
  LD [M]  drivers/usb/serial/iuu_phoenix.ko
  CC      drivers/usb/serial/keyspan.mod.o
  LD [M]  drivers/usb/serial/keyspan.ko
  CC      drivers/usb/serial/keyspan_pda.mod.o
  LD [M]  drivers/usb/serial/keyspan_pda.ko
  CC      drivers/usb/serial/kl5kusb105.mod.o
  LD [M]  drivers/usb/serial/kl5kusb105.ko
  CC      drivers/usb/serial/kobil_sct.mod.o
  LD [M]  drivers/usb/serial/kobil_sct.ko
  CC      drivers/usb/serial/mct_u232.mod.o
  LD [M]  drivers/usb/serial/mct_u232.ko
  CC      drivers/usb/serial/metro-usb.mod.o
  LD [M]  drivers/usb/serial/metro-usb.ko
  CC      drivers/usb/serial/mos7720.mod.o
  LD [M]  drivers/usb/serial/mos7720.ko
  CC      drivers/usb/serial/mos7840.mod.o
  LD [M]  drivers/usb/serial/mos7840.ko
  CC      drivers/usb/serial/mxuport.mod.o
  LD [M]  drivers/usb/serial/mxuport.ko
  CC      drivers/usb/serial/navman.mod.o
  LD [M]  drivers/usb/serial/navman.ko
  CC      drivers/usb/serial/omninet.mod.o
  LD [M]  drivers/usb/serial/omninet.ko
  CC      drivers/usb/serial/opticon.mod.o
  LD [M]  drivers/usb/serial/opticon.ko
  CC      drivers/usb/serial/option.mod.o
  LD [M]  drivers/usb/serial/option.ko
  CC      drivers/usb/serial/oti6858.mod.o
  LD [M]  drivers/usb/serial/oti6858.ko
  CC      drivers/usb/serial/pl2303.mod.o
  LD [M]  drivers/usb/serial/pl2303.ko
  CC      drivers/usb/serial/qcaux.mod.o
  LD [M]  drivers/usb/serial/qcaux.ko
  CC      drivers/usb/serial/qcserial.mod.o
  LD [M]  drivers/usb/serial/qcserial.ko
  CC      drivers/usb/serial/quatech2.mod.o
  LD [M]  drivers/usb/serial/quatech2.ko
  CC      drivers/usb/serial/safe_serial.mod.o
  LD [M]  drivers/usb/serial/safe_serial.ko
  CC      drivers/usb/serial/sierra.mod.o
  LD [M]  drivers/usb/serial/sierra.ko
  CC      drivers/usb/serial/spcp8x5.mod.o
  LD [M]  drivers/usb/serial/spcp8x5.ko
  CC      drivers/usb/serial/ssu100.mod.o
  LD [M]  drivers/usb/serial/ssu100.ko
  CC      drivers/usb/serial/symbolserial.mod.o
  LD [M]  drivers/usb/serial/symbolserial.ko
  CC      drivers/usb/serial/ti_usb_3410_5052.mod.o
  LD [M]  drivers/usb/serial/ti_usb_3410_5052.ko
  CC      drivers/usb/serial/usb-serial-simple.mod.o
  LD [M]  drivers/usb/serial/usb-serial-simple.ko
  CC      drivers/usb/serial/usb_wwan.mod.o
  LD [M]  drivers/usb/serial/usb_wwan.ko
  CC      drivers/usb/serial/usbserial.mod.o
  LD [M]  drivers/usb/serial/usbserial.ko
  CC      drivers/usb/serial/visor.mod.o
  LD [M]  drivers/usb/serial/visor.ko
  CC      drivers/usb/serial/whiteheat.mod.o
  LD [M]  drivers/usb/serial/whiteheat.ko
  CC      drivers/usb/serial/wishbone-serial.mod.o
  LD [M]  drivers/usb/serial/wishbone-serial.ko
  CC      drivers/usb/serial/xsens_mt.mod.o
  LD [M]  drivers/usb/serial/xsens_mt.ko
  CC      drivers/usb/storage/uas.mod.o
  LD [M]  drivers/usb/storage/uas.ko
  CC      drivers/usb/storage/ums-alauda.mod.o
  LD [M]  drivers/usb/storage/ums-alauda.ko
  CC      drivers/usb/storage/ums-cypress.mod.o
  LD [M]  drivers/usb/storage/ums-cypress.ko
  CC      drivers/usb/storage/ums-datafab.mod.o
  LD [M]  drivers/usb/storage/ums-datafab.ko
  CC      drivers/usb/storage/ums-eneub6250.mod.o
  LD [M]  drivers/usb/storage/ums-eneub6250.ko
  CC      drivers/usb/storage/ums-freecom.mod.o
  LD [M]  drivers/usb/storage/ums-freecom.ko
  CC      drivers/usb/storage/ums-isd200.mod.o
  LD [M]  drivers/usb/storage/ums-isd200.ko
  CC      drivers/usb/storage/ums-jumpshot.mod.o
  LD [M]  drivers/usb/storage/ums-jumpshot.ko
  CC      drivers/usb/storage/ums-karma.mod.o
  LD [M]  drivers/usb/storage/ums-karma.ko
  CC      drivers/usb/storage/ums-onetouch.mod.o
  LD [M]  drivers/usb/storage/ums-onetouch.ko
  CC      drivers/usb/storage/ums-realtek.mod.o
  LD [M]  drivers/usb/storage/ums-realtek.ko
  CC      drivers/usb/storage/ums-sddr09.mod.o
  LD [M]  drivers/usb/storage/ums-sddr09.ko
  CC      drivers/usb/storage/ums-sddr55.mod.o
  LD [M]  drivers/usb/storage/ums-sddr55.ko
  CC      drivers/usb/storage/ums-usbat.mod.o
  LD [M]  drivers/usb/storage/ums-usbat.ko
  CC      drivers/usb/storage/usb-storage.mod.o
  LD [M]  drivers/usb/storage/usb-storage.ko
  CC      drivers/usb/wusbcore/wusb-wa.mod.o
  LD [M]  drivers/usb/wusbcore/wusb-wa.ko
  CC      drivers/uwb/hwa-rc.mod.o
  LD [M]  drivers/uwb/hwa-rc.ko
  CC      drivers/uwb/i1480/dfu/i1480-dfu-usb.mod.o
  LD [M]  drivers/uwb/i1480/dfu/i1480-dfu-usb.ko
  CC      drivers/uwb/i1480/i1480-est.mod.o
  LD [M]  drivers/uwb/i1480/i1480-est.ko
  CC      drivers/uwb/umc.mod.o
  LD [M]  drivers/uwb/umc.ko
  CC      drivers/uwb/whc-rc.mod.o
  LD [M]  drivers/uwb/whc-rc.ko
  CC      drivers/uwb/whci.mod.o
  LD [M]  drivers/uwb/whci.ko
  CC      drivers/vhost/vhost_scsi.mod.o
  LD [M]  drivers/vhost/vhost_scsi.ko
  CC      drivers/w1/masters/ds1wm.mod.o
  LD [M]  drivers/w1/masters/ds1wm.ko
  CC      drivers/w1/masters/ds2482.mod.o
  LD [M]  drivers/w1/masters/ds2482.ko
  CC      drivers/w1/masters/ds2490.mod.o
  LD [M]  drivers/w1/masters/ds2490.ko
  CC      drivers/w1/masters/matrox_w1.mod.o
  LD [M]  drivers/w1/masters/matrox_w1.ko
  CC      drivers/w1/masters/w1-gpio.mod.o
  LD [M]  drivers/w1/masters/w1-gpio.ko
  CC      drivers/w1/slaves/w1_bq27000.mod.o
  LD [M]  drivers/w1/slaves/w1_bq27000.ko
  CC      drivers/w1/slaves/w1_ds2408.mod.o
  LD [M]  drivers/w1/slaves/w1_ds2408.ko
  CC      drivers/w1/slaves/w1_ds2413.mod.o
  LD [M]  drivers/w1/slaves/w1_ds2413.ko
  CC      drivers/w1/slaves/w1_ds2423.mod.o
  LD [M]  drivers/w1/slaves/w1_ds2423.ko
  CC      drivers/w1/slaves/w1_ds2431.mod.o
  LD [M]  drivers/w1/slaves/w1_ds2431.ko
  CC      drivers/w1/slaves/w1_ds2433.mod.o
  LD [M]  drivers/w1/slaves/w1_ds2433.ko
  CC      drivers/w1/slaves/w1_ds2760.mod.o
  LD [M]  drivers/w1/slaves/w1_ds2760.ko
  CC      drivers/w1/slaves/w1_ds2780.mod.o
  LD [M]  drivers/w1/slaves/w1_ds2780.ko
  CC      drivers/w1/slaves/w1_ds2781.mod.o
  LD [M]  drivers/w1/slaves/w1_ds2781.ko
  CC      drivers/w1/slaves/w1_ds28e04.mod.o
  LD [M]  drivers/w1/slaves/w1_ds28e04.ko
  CC      drivers/w1/slaves/w1_smem.mod.o
  LD [M]  drivers/w1/slaves/w1_smem.ko
  CC      drivers/w1/slaves/w1_therm.mod.o
  LD [M]  drivers/w1/slaves/w1_therm.ko
  CC      drivers/w1/wire.mod.o
  LD [M]  drivers/w1/wire.ko
  CC      fs/f2fs/f2fs.mod.o
  LD [M]  fs/f2fs/f2fs.ko
  CC      fs/logfs/logfs.mod.o
  LD [M]  fs/logfs/logfs.ko
  CC      fs/nfs/flexfilelayout/nfs_layout_flexfiles.mod.o
  LD [M]  fs/nfs/flexfilelayout/nfs_layout_flexfiles.ko
  CC      fs/nls/nls_ascii.mod.o
  LD [M]  fs/nls/nls_ascii.ko
  CC      fs/nls/nls_cp1250.mod.o
  LD [M]  fs/nls/nls_cp1250.ko
  CC      fs/nls/nls_cp1251.mod.o
  LD [M]  fs/nls/nls_cp1251.ko
  CC      fs/nls/nls_cp1255.mod.o
  LD [M]  fs/nls/nls_cp1255.ko
  CC      fs/nls/nls_cp737.mod.o
  LD [M]  fs/nls/nls_cp737.ko
  CC      fs/nls/nls_cp775.mod.o
  LD [M]  fs/nls/nls_cp775.ko
  CC      fs/nls/nls_cp850.mod.o
  LD [M]  fs/nls/nls_cp850.ko
  CC      fs/nls/nls_cp852.mod.o
  LD [M]  fs/nls/nls_cp852.ko
  CC      fs/nls/nls_cp855.mod.o
  LD [M]  fs/nls/nls_cp855.ko
  CC      fs/nls/nls_cp857.mod.o
  LD [M]  fs/nls/nls_cp857.ko
  CC      fs/nls/nls_cp860.mod.o
  LD [M]  fs/nls/nls_cp860.ko
  CC      fs/nls/nls_cp861.mod.o
  LD [M]  fs/nls/nls_cp861.ko
  CC      fs/nls/nls_cp862.mod.o
  LD [M]  fs/nls/nls_cp862.ko
  CC      fs/nls/nls_cp863.mod.o
  LD [M]  fs/nls/nls_cp863.ko
  CC      fs/nls/nls_cp864.mod.o
  LD [M]  fs/nls/nls_cp864.ko
  CC      fs/nls/nls_cp865.mod.o
  LD [M]  fs/nls/nls_cp865.ko
  CC      fs/nls/nls_cp866.mod.o
  LD [M]  fs/nls/nls_cp866.ko
  CC      fs/nls/nls_cp869.mod.o
  LD [M]  fs/nls/nls_cp869.ko
  CC      fs/nls/nls_cp874.mod.o
  LD [M]  fs/nls/nls_cp874.ko
  CC      fs/nls/nls_cp932.mod.o
  LD [M]  fs/nls/nls_cp932.ko
  CC      fs/nls/nls_cp936.mod.o
  LD [M]  fs/nls/nls_cp936.ko
  CC      fs/nls/nls_cp949.mod.o
  LD [M]  fs/nls/nls_cp949.ko
  CC      fs/nls/nls_cp950.mod.o
  LD [M]  fs/nls/nls_cp950.ko
  CC      fs/nls/nls_euc-jp.mod.o
  LD [M]  fs/nls/nls_euc-jp.ko
  CC      fs/nls/nls_iso8859-13.mod.o
  LD [M]  fs/nls/nls_iso8859-13.ko
  CC      fs/nls/nls_iso8859-14.mod.o
  LD [M]  fs/nls/nls_iso8859-14.ko
  CC      fs/nls/nls_iso8859-2.mod.o
  LD [M]  fs/nls/nls_iso8859-2.ko
  CC      fs/nls/nls_iso8859-3.mod.o
  LD [M]  fs/nls/nls_iso8859-3.ko
  CC      fs/nls/nls_iso8859-4.mod.o
  LD [M]  fs/nls/nls_iso8859-4.ko
  CC      fs/nls/nls_iso8859-5.mod.o
  LD [M]  fs/nls/nls_iso8859-5.ko
  CC      fs/nls/nls_iso8859-6.mod.o
  LD [M]  fs/nls/nls_iso8859-6.ko
  CC      fs/nls/nls_iso8859-7.mod.o
  LD [M]  fs/nls/nls_iso8859-7.ko
  CC      fs/nls/nls_iso8859-9.mod.o
  LD [M]  fs/nls/nls_iso8859-9.ko
  CC      fs/nls/nls_koi8-r.mod.o
  LD [M]  fs/nls/nls_koi8-r.ko
  CC      fs/nls/nls_koi8-ru.mod.o
  LD [M]  fs/nls/nls_koi8-ru.ko
  CC      fs/nls/nls_koi8-u.mod.o
  LD [M]  fs/nls/nls_koi8-u.ko
  CC      lib/bch.mod.o
  LD [M]  lib/bch.ko
  CC      lib/lru_cache.mod.o
  LD [M]  lib/lru_cache.ko
  CC      net/irda/ircomm/ircomm-tty.mod.o
  LD [M]  net/irda/ircomm/ircomm-tty.ko
  CC      net/irda/ircomm/ircomm.mod.o
  LD [M]  net/irda/ircomm/ircomm.ko
  CC      net/irda/irlan/irlan.mod.o
  LD [M]  net/irda/irlan/irlan.ko
  CC      net/irda/irnet/irnet.mod.o
  LD [M]  net/irda/irnet/irnet.ko
  CC      net/l2tp/l2tp_ppp.mod.o
  LD [M]  net/l2tp/l2tp_ppp.ko
  CC      sound/ac97_bus.mod.o
  LD [M]  sound/ac97_bus.ko
  CC      sound/core/seq/snd-seq-midi-emul.mod.o
  LD [M]  sound/core/seq/snd-seq-midi-emul.ko
  CC      sound/core/seq/snd-seq-midi-event.mod.o
  LD [M]  sound/core/seq/snd-seq-midi-event.ko
  CC      sound/core/seq/snd-seq-midi.mod.o
  LD [M]  sound/core/seq/snd-seq-midi.ko
  CC      sound/core/seq/snd-seq-virmidi.mod.o
  LD [M]  sound/core/seq/snd-seq-virmidi.ko
  CC      sound/core/snd-rawmidi.mod.o
  LD [M]  sound/core/snd-rawmidi.ko
  CC      sound/drivers/mpu401/snd-mpu401-uart.mod.o
  LD [M]  sound/drivers/mpu401/snd-mpu401-uart.ko
  CC      sound/drivers/mpu401/snd-mpu401.mod.o
  LD [M]  sound/drivers/mpu401/snd-mpu401.ko
  CC      sound/drivers/opl3/snd-opl3-lib.mod.o
  LD [M]  sound/drivers/opl3/snd-opl3-lib.ko
  CC      sound/drivers/opl3/snd-opl3-synth.mod.o
  LD [M]  sound/drivers/opl3/snd-opl3-synth.ko
  CC      sound/drivers/snd-mtpav.mod.o
  LD [M]  sound/drivers/snd-mtpav.ko
  CC      sound/drivers/snd-serial-u16550.mod.o
  LD [M]  sound/drivers/snd-serial-u16550.ko
  CC      sound/drivers/vx/snd-vx-lib.mod.o
  LD [M]  sound/drivers/vx/snd-vx-lib.ko
  CC      sound/i2c/other/snd-ak4113.mod.o
  LD [M]  sound/i2c/other/snd-ak4113.ko
  CC      sound/i2c/other/snd-ak4114.mod.o
  LD [M]  sound/i2c/other/snd-ak4114.ko
  CC      sound/i2c/other/snd-ak4xxx-adda.mod.o
  LD [M]  sound/i2c/other/snd-ak4xxx-adda.ko
  CC      sound/i2c/other/snd-pt2258.mod.o
  LD [M]  sound/i2c/other/snd-pt2258.ko
  CC      sound/i2c/snd-cs8427.mod.o
  LD [M]  sound/i2c/snd-cs8427.ko
  CC      sound/i2c/snd-i2c.mod.o
  LD [M]  sound/i2c/snd-i2c.ko
  CC      sound/isa/sb/snd-sb-common.mod.o
  LD [M]  sound/isa/sb/snd-sb-common.ko
  CC      sound/pci/ac97/snd-ac97-codec.mod.o
  LD [M]  sound/pci/ac97/snd-ac97-codec.ko
  CC      sound/pci/ali5451/snd-ali5451.mod.o
  LD [M]  sound/pci/ali5451/snd-ali5451.ko
  CC      sound/pci/asihpi/snd-asihpi.mod.o
  LD [M]  sound/pci/asihpi/snd-asihpi.ko
  CC      sound/pci/au88x0/snd-au8810.mod.o
  LD [M]  sound/pci/au88x0/snd-au8810.ko
  CC      sound/pci/au88x0/snd-au8820.mod.o
  LD [M]  sound/pci/au88x0/snd-au8820.ko
  CC      sound/pci/au88x0/snd-au8830.mod.o
  LD [M]  sound/pci/au88x0/snd-au8830.ko
  CC      sound/pci/aw2/snd-aw2.mod.o
  LD [M]  sound/pci/aw2/snd-aw2.ko
  CC      sound/pci/ca0106/snd-ca0106.mod.o
  LD [M]  sound/pci/ca0106/snd-ca0106.ko
  CC      sound/pci/cs46xx/snd-cs46xx.mod.o
  LD [M]  sound/pci/cs46xx/snd-cs46xx.ko
  CC      sound/pci/ctxfi/snd-ctxfi.mod.o
  LD [M]  sound/pci/ctxfi/snd-ctxfi.ko
  CC      sound/pci/echoaudio/snd-darla20.mod.o
  LD [M]  sound/pci/echoaudio/snd-darla20.ko
  CC      sound/pci/echoaudio/snd-darla24.mod.o
  LD [M]  sound/pci/echoaudio/snd-darla24.ko
  CC      sound/pci/echoaudio/snd-echo3g.mod.o
  LD [M]  sound/pci/echoaudio/snd-echo3g.ko
  CC      sound/pci/echoaudio/snd-gina20.mod.o
  LD [M]  sound/pci/echoaudio/snd-gina20.ko
  CC      sound/pci/echoaudio/snd-gina24.mod.o
  LD [M]  sound/pci/echoaudio/snd-gina24.ko
  CC      sound/pci/echoaudio/snd-indigo.mod.o
  LD [M]  sound/pci/echoaudio/snd-indigo.ko
  CC      sound/pci/echoaudio/snd-indigodj.mod.o
  LD [M]  sound/pci/echoaudio/snd-indigodj.ko
  CC      sound/pci/echoaudio/snd-indigodjx.mod.o
  LD [M]  sound/pci/echoaudio/snd-indigodjx.ko
  CC      sound/pci/echoaudio/snd-indigoio.mod.o
  LD [M]  sound/pci/echoaudio/snd-indigoio.ko
  CC      sound/pci/echoaudio/snd-indigoiox.mod.o
  LD [M]  sound/pci/echoaudio/snd-indigoiox.ko
  CC      sound/pci/echoaudio/snd-layla20.mod.o
  LD [M]  sound/pci/echoaudio/snd-layla20.ko
  CC      sound/pci/echoaudio/snd-layla24.mod.o
  LD [M]  sound/pci/echoaudio/snd-layla24.ko
  CC      sound/pci/echoaudio/snd-mia.mod.o
  LD [M]  sound/pci/echoaudio/snd-mia.ko
  CC      sound/pci/echoaudio/snd-mona.mod.o
  LD [M]  sound/pci/echoaudio/snd-mona.ko
  CC      sound/pci/emu10k1/snd-emu10k1-synth.mod.o
  LD [M]  sound/pci/emu10k1/snd-emu10k1-synth.ko
  CC      sound/pci/emu10k1/snd-emu10k1.mod.o
  LD [M]  sound/pci/emu10k1/snd-emu10k1.ko
  CC      sound/pci/emu10k1/snd-emu10k1x.mod.o
  LD [M]  sound/pci/emu10k1/snd-emu10k1x.ko
  CC      sound/pci/ice1712/snd-ice1712.mod.o
  LD [M]  sound/pci/ice1712/snd-ice1712.ko
  CC      sound/pci/ice1712/snd-ice1724.mod.o
  LD [M]  sound/pci/ice1712/snd-ice1724.ko
  CC      sound/pci/ice1712/snd-ice17xx-ak4xxx.mod.o
  LD [M]  sound/pci/ice1712/snd-ice17xx-ak4xxx.ko
  CC      sound/pci/korg1212/snd-korg1212.mod.o
  LD [M]  sound/pci/korg1212/snd-korg1212.ko
  CC      sound/pci/lola/snd-lola.mod.o
  LD [M]  sound/pci/lola/snd-lola.ko
  CC      sound/pci/lx6464es/snd-lx6464es.mod.o
  LD [M]  sound/pci/lx6464es/snd-lx6464es.ko
  CC      sound/pci/mixart/snd-mixart.mod.o
  LD [M]  sound/pci/mixart/snd-mixart.ko
  CC      sound/pci/nm256/snd-nm256.mod.o
  LD [M]  sound/pci/nm256/snd-nm256.ko
  CC      sound/pci/oxygen/snd-oxygen-lib.mod.o
  LD [M]  sound/pci/oxygen/snd-oxygen-lib.ko
  CC      sound/pci/oxygen/snd-oxygen.mod.o
  LD [M]  sound/pci/oxygen/snd-oxygen.ko
  CC      sound/pci/oxygen/snd-virtuoso.mod.o
  LD [M]  sound/pci/oxygen/snd-virtuoso.ko
  CC      sound/pci/pcxhr/snd-pcxhr.mod.o
  LD [M]  sound/pci/pcxhr/snd-pcxhr.ko
  CC      sound/pci/riptide/snd-riptide.mod.o
  LD [M]  sound/pci/riptide/snd-riptide.ko
  CC      sound/pci/rme9652/snd-hdsp.mod.o
  LD [M]  sound/pci/rme9652/snd-hdsp.ko
  CC      sound/pci/rme9652/snd-hdspm.mod.o
  LD [M]  sound/pci/rme9652/snd-hdspm.ko
  CC      sound/pci/rme9652/snd-rme9652.mod.o
  LD [M]  sound/pci/rme9652/snd-rme9652.ko
  CC      sound/pci/snd-ad1889.mod.o
  LD [M]  sound/pci/snd-ad1889.ko
  CC      sound/pci/snd-als300.mod.o
  LD [M]  sound/pci/snd-als300.ko
  CC      sound/pci/snd-als4000.mod.o
  LD [M]  sound/pci/snd-als4000.ko
  CC      sound/pci/snd-atiixp-modem.mod.o
  LD [M]  sound/pci/snd-atiixp-modem.ko
  CC      sound/pci/snd-atiixp.mod.o
  LD [M]  sound/pci/snd-atiixp.ko
  CC      sound/pci/snd-azt3328.mod.o
  LD [M]  sound/pci/snd-azt3328.ko
  CC      sound/pci/snd-bt87x.mod.o
  LD [M]  sound/pci/snd-bt87x.ko
  CC      sound/pci/snd-cmipci.mod.o
  LD [M]  sound/pci/snd-cmipci.ko
  CC      sound/pci/snd-cs4281.mod.o
  LD [M]  sound/pci/snd-cs4281.ko
  CC      sound/pci/snd-ens1370.mod.o
  LD [M]  sound/pci/snd-ens1370.ko
  CC      sound/pci/snd-ens1371.mod.o
  LD [M]  sound/pci/snd-ens1371.ko
  CC      sound/pci/snd-es1938.mod.o
  LD [M]  sound/pci/snd-es1938.ko
  CC      sound/pci/snd-es1968.mod.o
  LD [M]  sound/pci/snd-es1968.ko
  CC      sound/pci/snd-fm801.mod.o
  LD [M]  sound/pci/snd-fm801.ko
  CC      sound/pci/snd-intel8x0.mod.o
  LD [M]  sound/pci/snd-intel8x0.ko
  CC      sound/pci/snd-intel8x0m.mod.o
  LD [M]  sound/pci/snd-intel8x0m.ko
  CC      sound/pci/snd-maestro3.mod.o
  LD [M]  sound/pci/snd-maestro3.ko
  CC      sound/pci/snd-rme32.mod.o
  LD [M]  sound/pci/snd-rme32.ko
  CC      sound/pci/snd-rme96.mod.o
  LD [M]  sound/pci/snd-rme96.ko
  CC      sound/pci/snd-sonicvibes.mod.o
  LD [M]  sound/pci/snd-sonicvibes.ko
  CC      sound/pci/snd-via82xx-modem.mod.o
  LD [M]  sound/pci/snd-via82xx-modem.ko
  CC      sound/pci/snd-via82xx.mod.o
  LD [M]  sound/pci/snd-via82xx.ko
  CC      sound/pci/trident/snd-trident.mod.o
  LD [M]  sound/pci/trident/snd-trident.ko
  CC      sound/pci/vx222/snd-vx222.mod.o
  LD [M]  sound/pci/vx222/snd-vx222.ko
  CC      sound/pci/ymfpci/snd-ymfpci.mod.o
  LD [M]  sound/pci/ymfpci/snd-ymfpci.ko
  CC      sound/synth/emux/snd-emux-synth.mod.o
  LD [M]  sound/synth/emux/snd-emux-synth.ko
  CC      sound/synth/snd-util-mem.mod.o
  LD [M]  sound/synth/snd-util-mem.ko
  CC      sound/usb/6fire/snd-usb-6fire.mod.o
  LD [M]  sound/usb/6fire/snd-usb-6fire.ko
  CC      sound/usb/bcd2000/snd-bcd2000.mod.o
  LD [M]  sound/usb/bcd2000/snd-bcd2000.ko
  CC      sound/usb/caiaq/snd-usb-caiaq.mod.o
  LD [M]  sound/usb/caiaq/snd-usb-caiaq.ko
  CC      sound/usb/hiface/snd-usb-hiface.mod.o
  LD [M]  sound/usb/hiface/snd-usb-hiface.ko
  CC      sound/usb/line6/snd-usb-line6.mod.o
  LD [M]  sound/usb/line6/snd-usb-line6.ko
  CC      sound/usb/line6/snd-usb-pod.mod.o
  LD [M]  sound/usb/line6/snd-usb-pod.ko
  CC      sound/usb/line6/snd-usb-podhd.mod.o
  LD [M]  sound/usb/line6/snd-usb-podhd.ko
  CC      sound/usb/line6/snd-usb-toneport.mod.o
  LD [M]  sound/usb/line6/snd-usb-toneport.ko
  CC      sound/usb/line6/snd-usb-variax.mod.o
  LD [M]  sound/usb/line6/snd-usb-variax.ko
  CC      sound/usb/misc/snd-ua101.mod.o
  LD [M]  sound/usb/misc/snd-ua101.ko
  CC      sound/usb/snd-usb-audio.mod.o
  LD [M]  sound/usb/snd-usb-audio.ko
  CC      sound/usb/snd-usbmidi-lib.mod.o
  LD [M]  sound/usb/snd-usbmidi-lib.ko
  CC      sound/usb/usx2y/snd-usb-us122l.mod.o
  LD [M]  sound/usb/usx2y/snd-usb-us122l.ko
  CC      sound/usb/usx2y/snd-usb-usx2y.mod.o
  LD [M]  sound/usb/usx2y/snd-usb-usx2y.ko
