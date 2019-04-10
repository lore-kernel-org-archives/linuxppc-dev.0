Return-Path: <SRS0=mr1i=SM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EEF0C10F14
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 11:19:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B57820818
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 11:19:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="E86sbIt+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B57820818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44fM9b63G7zDqQb
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 21:18:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=none (mailfrom)
 smtp.mailfrom=bombadil.infradead.org (client-ip=2607:7c80:54:e::133;
 helo=bombadil.infradead.org; envelope-from=mchehab@bombadil.infradead.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.b="E86sbIt+"; dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44fM2506ZJzDqNv;
 Wed, 10 Apr 2019 21:12:28 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
 MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=pbgIj0qAT0vXeTqjyGCNTFbNi0mZJGFkM+L7DMuLhDM=; b=E86sbIt+As8BfGH8+H3Xfdg+6
 8nfaGl+XFiSxGRdS97baeuX1kY/sdx9AFaSDTxDwNHLe69ajMyD/gO/vyishAC8OFesHdCFTzXg/U
 itNOZgQx4JQj85c3pT5AADhCV/rCbW5Sz+SrcEIXUwhs6gnm9kEY0O2eCzapKvIFRrMyzAucpuukr
 0L0OBiAc5erf4DriEUVbUWtoS0P1Mvjg/mswljYriX3TsW/31mw2qu/UewyorG4vAWxfMoF6kz09w
 hJZpagtqaJbJCawQ/ene76kVlzS7BFFxxxYe3IQ+MW5D+ANcq4kug4SPb4paUPm8MxplQAmDvX4yw
 bOjagSuRw==;
Received: from 177.41.129.23.dynamic.adsl.gvt.net.br ([177.41.129.23]
 helo=bombadil.infradead.org)
 by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hEB9L-0006n5-NV; Wed, 10 Apr 2019 11:12:16 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
 (envelope-from <mchehab@bombadil.infradead.org>)
 id 1hEB9J-0007SK-6f; Wed, 10 Apr 2019 08:12:13 -0300
From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Subject: [PATCH 00/21] Convert hwmon documentation to ReST
Date: Wed, 10 Apr 2019 08:11:50 -0300
Message-Id: <cover.1554893881.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linux-arm-kernel@lists.infradead.org, linux-hwmon@vger.kernel.org,
 Jean Delvare <jdelvare@suse.com>, linux-aspeed@lists.ozlabs.org,
 Jonathan Corbet <corbet@lwn.net>, Andrew Jeffery <andrew@aj.id.au>,
 Sudeep Holla <sudeep.holla@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 linux-kernel@vger.kernel.org, Mauro Carvalho Chehab <mchehab@infradead.org>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Paul Mackerras <paulus@samba.org>, Joel Stanley <joel@jms.id.au>,
 Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
 linuxppc-dev@lists.ozlabs.org, Guenter Roeck <linux@roeck-us.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This series converts the contents of Documentation/hwmon to ReST
format.

PS.: I opted to group the conversion files per groups of maintainer
set, as, if I were to generate one patch per file, it would give around
160 patches.

I also added those patches to my development tree at:
	https://git.linuxtv.org/mchehab/experimental.git/log/?h=hwmon

If you want to see the results, they're at:
	https://www.infradead.org/~mchehab/hwmon/

Mauro Carvalho Chehab (21):
  docs: hwmon: k10temp: convert to ReST format
  docs: hwmon: vexpress: convert to ReST format
  docs: hwmon: menf21bmc: convert to ReST format
  docs: hwmon: sch5627: convert to ReST format
  docs: hwmon: emc2103: convert to ReST format
  docs: hwmon: pc87360: convert to ReST format
  docs: hwmon: fam15h_power: convert to ReST format
  docs: hwmon: w83791d: convert to ReST format
  docs: hwmon: coretemp: convert to ReST format
  docs: hwmon: aspeed-pwm-tacho: convert to ReST format
  docs: hwmon: ibmpowernv: convert to ReST format
  docs: hwmon: asc7621: convert to ReST format
  docs: hwmon: ads1015: convert to ReST format
  docs: hwmon: dme1737, vt1211: convert to ReST format
  docs: hwmon: wm831x, wm8350: convert to ReST format
  docs: hwmon: da9052, da9055: convert to ReST format
  docs: hwmon: k8temp, w83793: convert to ReST format
  docs: hwmon: pmbus files: convert to ReST format
  docs: hwmon: misc files: convert to ReST format
  docs: hwmon: convert remaining files to ReST format
  docs: hwmon: Add an index file and rename docs to *.rst

 .../devicetree/bindings/hwmon/g762.txt        |   2 +-
 Documentation/hwmon/{ab8500 => ab8500.rst}    |  10 +-
 Documentation/hwmon/abituguru                 |  92 ---
 ...guru-datasheet => abituguru-datasheet.rst} | 160 ++--
 Documentation/hwmon/abituguru.rst             | 113 +++
 .../hwmon/{abituguru3 => abituguru3.rst}      |  36 +-
 Documentation/hwmon/{abx500 => abx500.rst}    |   8 +-
 ...{acpi_power_meter => acpi_power_meter.rst} |  25 +-
 Documentation/hwmon/{ad7314 => ad7314.rst}    |   9 +
 .../hwmon/{adc128d818 => adc128d818.rst}      |   7 +-
 Documentation/hwmon/{adm1021 => adm1021.rst}  |  44 +-
 Documentation/hwmon/{adm1025 => adm1025.rst}  |  13 +-
 Documentation/hwmon/{adm1026 => adm1026.rst}  |  24 +-
 Documentation/hwmon/{adm1031 => adm1031.rst}  |  16 +-
 Documentation/hwmon/{adm1275 => adm1275.rst}  |  30 +-
 Documentation/hwmon/{adm9240 => adm9240.rst}  |  50 +-
 Documentation/hwmon/{ads1015 => ads1015.rst}  |  72 +-
 Documentation/hwmon/{ads7828 => ads7828.rst}  |  29 +-
 Documentation/hwmon/{adt7410 => adt7410.rst}  |  49 +-
 Documentation/hwmon/{adt7411 => adt7411.rst}  |  20 +-
 Documentation/hwmon/{adt7462 => adt7462.rst}  |  10 +-
 Documentation/hwmon/{adt7470 => adt7470.rst}  |   8 +-
 Documentation/hwmon/{adt7475 => adt7475.rst}  |  38 +-
 Documentation/hwmon/{amc6821 => amc6821.rst}  |  19 +-
 Documentation/hwmon/{asb100 => asb100.rst}    |  50 +-
 Documentation/hwmon/{asc7621 => asc7621.rst}  | 146 ++--
 ...{aspeed-pwm-tacho => aspeed-pwm-tacho.rst} |   2 +
 .../hwmon/{coretemp => coretemp.rst}          |  46 +-
 Documentation/hwmon/{da9052 => da9052.rst}    |  40 +-
 Documentation/hwmon/{da9055 => da9055.rst}    |  20 +-
 Documentation/hwmon/{dme1737 => dme1737.rst}  |  88 ++-
 Documentation/hwmon/{ds1621 => ds1621.rst}    | 154 ++--
 Documentation/hwmon/{ds620 => ds620.rst}      |  12 +-
 Documentation/hwmon/{emc1403 => emc1403.rst}  |  33 +-
 Documentation/hwmon/{emc2103 => emc2103.rst}  |   6 +-
 .../hwmon/{emc6w201 => emc6w201.rst}          |   5 +
 Documentation/hwmon/{f71805f => f71805f.rst}  |  36 +-
 .../hwmon/{f71882fg => f71882fg.rst}          |  56 +-
 .../hwmon/{fam15h_power => fam15h_power.rst}  |  85 ++-
 .../hwmon/{ftsteutates => ftsteutates.rst}    |  14 +-
 Documentation/hwmon/{g760a => g760a.rst}      |   4 +
 Documentation/hwmon/{g762 => g762.rst}        |  67 +-
 Documentation/hwmon/{gl518sm => gl518sm.rst}  |  21 +-
 Documentation/hwmon/{hih6130 => hih6130.rst}  |  14 +-
 ...on-kernel-api.txt => hwmon-kernel-api.rst} | 298 ++++----
 .../hwmon/{ibm-cffps => ibm-cffps.rst}        |   3 +
 Documentation/hwmon/{ibmaem => ibmaem.rst}    |  10 +-
 .../hwmon/{ibmpowernv => ibmpowernv.rst}      |   3 +
 Documentation/hwmon/{ina209 => ina209.rst}    |  18 +-
 Documentation/hwmon/{ina2xx => ina2xx.rst}    |  41 +-
 Documentation/hwmon/{ina3221 => ina3221.rst}  |  17 +-
 Documentation/hwmon/index.rst                 | 179 +++++
 Documentation/hwmon/{ir35221 => ir35221.rst}  |  12 +-
 Documentation/hwmon/{it87 => it87.rst}        | 102 ++-
 Documentation/hwmon/{jc42 => jc42.rst}        |  55 +-
 Documentation/hwmon/{k10temp => k10temp.rst}  |  37 +-
 Documentation/hwmon/{k8temp => k8temp.rst}    |  17 +-
 .../hwmon/{lineage-pem => lineage-pem.rst}    |  16 +-
 Documentation/hwmon/{lm25066 => lm25066.rst}  |  32 +-
 Documentation/hwmon/{lm63 => lm63.rst}        |  24 +-
 Documentation/hwmon/{lm70 => lm70.rst}        |  13 +-
 Documentation/hwmon/{lm73 => lm73.rst}        |  16 +-
 Documentation/hwmon/{lm75 => lm75.rst}        |  96 ++-
 Documentation/hwmon/{lm77 => lm77.rst}        |   9 +-
 Documentation/hwmon/{lm78 => lm78.rst}        |  20 +-
 Documentation/hwmon/{lm80 => lm80.rst}        |  19 +-
 Documentation/hwmon/{lm83 => lm83.rst}        |  16 +-
 Documentation/hwmon/{lm85 => lm85.rst}        |  97 ++-
 Documentation/hwmon/{lm87 => lm87.rst}        |  23 +-
 Documentation/hwmon/{lm90 => lm90.rst}        | 174 ++++-
 Documentation/hwmon/{lm92 => lm92.rst}        |  17 +-
 Documentation/hwmon/{lm93 => lm93.rst}        | 157 ++--
 Documentation/hwmon/{lm95234 => lm95234.rst}  |  11 +-
 Documentation/hwmon/{lm95245 => lm95245.rst}  |  13 +-
 Documentation/hwmon/{ltc2945 => ltc2945.rst}  |  16 +-
 Documentation/hwmon/{ltc2978 => ltc2978.rst}  | 267 +++++--
 Documentation/hwmon/{ltc2990 => ltc2990.rst}  |  23 +-
 Documentation/hwmon/{ltc3815 => ltc3815.rst}  |  12 +-
 Documentation/hwmon/{ltc4151 => ltc4151.rst}  |  16 +-
 Documentation/hwmon/{ltc4215 => ltc4215.rst}  |  16 +-
 Documentation/hwmon/{ltc4245 => ltc4245.rst}  |  17 +-
 Documentation/hwmon/{ltc4260 => ltc4260.rst}  |  16 +-
 Documentation/hwmon/{ltc4261 => ltc4261.rst}  |  16 +-
 .../hwmon/{max16064 => max16064.rst}          |  17 +-
 .../hwmon/{max16065 => max16065.rst}          |  24 +-
 Documentation/hwmon/{max1619 => max1619.rst}  |  11 +-
 Documentation/hwmon/{max1668 => max1668.rst}  |  14 +-
 Documentation/hwmon/{max197 => max197.rst}    |  36 +-
 .../hwmon/{max20751 => max20751.rst}          |   9 +-
 .../hwmon/{max31722 => max31722.rst}          |  12 +
 .../hwmon/{max31785 => max31785.rst}          |   6 +
 .../hwmon/{max31790 => max31790.rst}          |   6 +
 .../hwmon/{max34440 => max34440.rst}          |  90 ++-
 Documentation/hwmon/{max6639 => max6639.rst}  |  16 +-
 Documentation/hwmon/{max6642 => max6642.rst}  |  10 +-
 Documentation/hwmon/{max6650 => max6650.rst}  |  16 +-
 Documentation/hwmon/{max6697 => max6697.rst}  |  33 +
 Documentation/hwmon/{max8688 => max8688.rst}  |  20 +-
 .../hwmon/{mc13783-adc => mc13783-adc.rst}    |  27 +-
 Documentation/hwmon/{mcp3021 => mcp3021.rst}  |  15 +-
 .../hwmon/{menf21bmc => menf21bmc.rst}        |   5 +
 .../hwmon/{mlxreg-fan => mlxreg-fan.rst}      |  60 +-
 Documentation/hwmon/{nct6683 => nct6683.rst}  |  11 +-
 Documentation/hwmon/{nct6775 => nct6775.rst}  | 114 ++-
 Documentation/hwmon/{nct7802 => nct7802.rst}  |  11 +-
 Documentation/hwmon/{nct7904 => nct7904.rst}  |   9 +-
 .../{npcm750-pwm-fan => npcm750-pwm-fan.rst}  |   4 +
 Documentation/hwmon/{nsa320 => nsa320.rst}    |  15 +-
 .../{ntc_thermistor => ntc_thermistor.rst}    | 123 ++--
 Documentation/hwmon/{occ => occ.rst}          |  93 ++-
 Documentation/hwmon/{pc87360 => pc87360.rst}  |  38 +-
 Documentation/hwmon/{pc87427 => pc87427.rst}  |   4 +
 Documentation/hwmon/{pcf8591 => pcf8591.rst}  |  52 +-
 .../hwmon/{pmbus-core => pmbus-core.rst}      | 173 +++--
 Documentation/hwmon/{pmbus => pmbus.rst}      |  90 ++-
 .../hwmon/{powr1220 => powr1220.rst}          |  12 +-
 Documentation/hwmon/{pwm-fan => pwm-fan.rst}  |   0
 ...aspberrypi-hwmon => raspberrypi-hwmon.rst} |   3 +
 Documentation/hwmon/{sch5627 => sch5627.rst}  |   4 +
 Documentation/hwmon/{sch5636 => sch5636.rst}  |   3 +
 .../hwmon/{scpi-hwmon => scpi-hwmon.rst}      |   7 +-
 Documentation/hwmon/{sht15 => sht15.rst}      |  28 +-
 Documentation/hwmon/{sht21 => sht21.rst}      |  24 +-
 Documentation/hwmon/{sht3x => sht3x.rst}      |  42 +-
 Documentation/hwmon/{shtc1 => shtc1.rst}      |  19 +-
 Documentation/hwmon/{sis5595 => sis5595.rst}  |  40 +-
 Documentation/hwmon/{smm665 => smm665.rst}    |  42 +-
 .../hwmon/{smsc47b397 => smsc47b397.rst}      | 158 ++--
 .../hwmon/{smsc47m1 => smsc47m1.rst}          |  43 +-
 Documentation/hwmon/smsc47m192                | 103 ---
 Documentation/hwmon/smsc47m192.rst            | 116 +++
 ...mitting-patches => submitting-patches.rst} |  17 +-
 .../{sysfs-interface => sysfs-interface.rst}  | 696 ++++++++++++------
 Documentation/hwmon/{tc654 => tc654.rst}      |   9 +-
 Documentation/hwmon/{tc74 => tc74.rst}        |   3 +
 Documentation/hwmon/{thmc50 => thmc50.rst}    |  36 +-
 Documentation/hwmon/{tmp102 => tmp102.rst}    |   7 +-
 Documentation/hwmon/{tmp103 => tmp103.rst}    |   7 +-
 Documentation/hwmon/{tmp108 => tmp108.rst}    |   7 +-
 Documentation/hwmon/{tmp401 => tmp401.rst}    |  32 +-
 Documentation/hwmon/{tmp421 => tmp421.rst}    |  26 +-
 .../hwmon/{tps40422 => tps40422.rst}          |  25 +-
 ...4030-madc-hwmon => twl4030-madc-hwmon.rst} |   8 +-
 Documentation/hwmon/{ucd9000 => ucd9000.rst}  |  35 +-
 Documentation/hwmon/{ucd9200 => ucd9200.rst}  |  46 +-
 .../{userspace-tools => userspace-tools.rst}  |   3 +
 .../hwmon/{vexpress => vexpress.rst}          |  13 +-
 Documentation/hwmon/{via686a => via686a.rst}  |  30 +-
 Documentation/hwmon/{vt1211 => vt1211.rst}    |  84 ++-
 .../hwmon/{w83627ehf => w83627ehf.rst}        | 160 ++--
 .../hwmon/{w83627hf => w83627hf.rst}          |  65 +-
 Documentation/hwmon/{w83773g => w83773g.rst}  |  12 +-
 Documentation/hwmon/{w83781d => w83781d.rst}  | 330 +++++----
 Documentation/hwmon/{w83791d => w83791d.rst}  | 123 ++--
 Documentation/hwmon/{w83792d => w83792d.rst}  | 112 +--
 Documentation/hwmon/w83793                    | 106 ---
 Documentation/hwmon/w83793.rst                | 113 +++
 Documentation/hwmon/w83795                    | 127 ----
 Documentation/hwmon/w83795.rst                | 142 ++++
 .../hwmon/{w83l785ts => w83l785ts.rst}        |   9 +-
 .../hwmon/{w83l786ng => w83l786ng.rst}        |  42 +-
 Documentation/hwmon/{wm831x => wm831x.rst}    |   9 +-
 Documentation/hwmon/{wm8350 => wm8350.rst}    |  10 +-
 .../hwmon/{xgene-hwmon => xgene-hwmon.rst}    |  24 +-
 Documentation/hwmon/{zl6100 => zl6100.rst}    |  71 +-
 Documentation/index.rst                       |   1 +
 Documentation/thermal/sysfs-api.txt           |   2 +-
 MAINTAINERS                                   | 108 +--
 drivers/hwmon/Kconfig                         |   8 +-
 drivers/hwmon/ads7828.c                       |   2 +-
 drivers/hwmon/max197.c                        |   2 +-
 drivers/hwmon/sht15.c                         |   2 +-
 include/linux/platform_data/ads7828.h         |   2 +-
 include/linux/platform_data/ds620.h           |   2 +-
 include/linux/platform_data/ina2xx.h          |   2 +-
 include/linux/platform_data/max197.h          |   2 +-
 include/linux/platform_data/ntc_thermistor.h  |   2 +-
 177 files changed, 5602 insertions(+), 2607 deletions(-)
 rename Documentation/hwmon/{ab8500 => ab8500.rst} (69%)
 delete mode 100644 Documentation/hwmon/abituguru
 rename Documentation/hwmon/{abituguru-datasheet => abituguru-datasheet.rst} (69%)
 create mode 100644 Documentation/hwmon/abituguru.rst
 rename Documentation/hwmon/{abituguru3 => abituguru3.rst} (75%)
 rename Documentation/hwmon/{abx500 => abx500.rst} (89%)
 rename Documentation/hwmon/{acpi_power_meter => acpi_power_meter.rst} (65%)
 rename Documentation/hwmon/{ad7314 => ad7314.rst} (98%)
 rename Documentation/hwmon/{adc128d818 => adc128d818.rst} (95%)
 rename Documentation/hwmon/{adm1021 => adm1021.rst} (97%)
 rename Documentation/hwmon/{adm1025 => adm1025.rst} (96%)
 rename Documentation/hwmon/{adm1026 => adm1026.rst} (89%)
 rename Documentation/hwmon/{adm1031 => adm1031.rst} (80%)
 rename Documentation/hwmon/{adm1275 => adm1275.rst} (93%)
 rename Documentation/hwmon/{adm9240 => adm9240.rst} (85%)
 rename Documentation/hwmon/{ads1015 => ads1015.rst} (64%)
 rename Documentation/hwmon/{ads7828 => ads7828.rst} (68%)
 rename Documentation/hwmon/{adt7410 => adt7410.rst} (70%)
 rename Documentation/hwmon/{adt7411 => adt7411.rst} (67%)
 rename Documentation/hwmon/{adt7462 => adt7462.rst} (94%)
 rename Documentation/hwmon/{adt7470 => adt7470.rst} (95%)
 rename Documentation/hwmon/{adt7475 => adt7475.rst} (89%)
 rename Documentation/hwmon/{amc6821 => amc6821.rst} (90%)
 rename Documentation/hwmon/{asb100 => asb100.rst} (69%)
 rename Documentation/hwmon/{asc7621 => asc7621.rst} (80%)
 rename Documentation/hwmon/{aspeed-pwm-tacho => aspeed-pwm-tacho.rst} (79%)
 rename Documentation/hwmon/{coretemp => coretemp.rst} (78%)
 rename Documentation/hwmon/{da9052 => da9052.rst} (66%)
 rename Documentation/hwmon/{da9055 => da9055.rst} (80%)
 rename Documentation/hwmon/{dme1737 => dme1737.rst} (89%)
 rename Documentation/hwmon/{ds1621 => ds1621.rst} (68%)
 rename Documentation/hwmon/{ds620 => ds620.rst} (88%)
 rename Documentation/hwmon/{emc1403 => emc1403.rst} (83%)
 rename Documentation/hwmon/{emc2103 => emc2103.rst} (95%)
 rename Documentation/hwmon/{emc6w201 => emc6w201.rst} (99%)
 rename Documentation/hwmon/{f71805f => f71805f.rst} (88%)
 rename Documentation/hwmon/{f71882fg => f71882fg.rst} (97%)
 rename Documentation/hwmon/{fam15h_power => fam15h_power.rst} (63%)
 rename Documentation/hwmon/{ftsteutates => ftsteutates.rst} (65%)
 rename Documentation/hwmon/{g760a => g760a.rst} (99%)
 rename Documentation/hwmon/{g762 => g762.rst} (59%)
 rename Documentation/hwmon/{gl518sm => gl518sm.rst} (89%)
 rename Documentation/hwmon/{hih6130 => hih6130.rst} (85%)
 rename Documentation/hwmon/{hwmon-kernel-api.txt => hwmon-kernel-api.rst} (59%)
 rename Documentation/hwmon/{ibm-cffps => ibm-cffps.rst} (90%)
 rename Documentation/hwmon/{ibmaem => ibmaem.rst} (92%)
 rename Documentation/hwmon/{ibmpowernv => ibmpowernv.rst} (94%)
 rename Documentation/hwmon/{ina209 => ina209.rst} (90%)
 rename Documentation/hwmon/{ina2xx => ina2xx.rst} (81%)
 rename Documentation/hwmon/{ina3221 => ina3221.rst} (77%)
 create mode 100644 Documentation/hwmon/index.rst
 rename Documentation/hwmon/{ir35221 => ir35221.rst} (89%)
 rename Documentation/hwmon/{it87 => it87.rst} (92%)
 rename Documentation/hwmon/{jc42 => jc42.rst} (92%)
 rename Documentation/hwmon/{k10temp => k10temp.rst} (98%)
 rename Documentation/hwmon/{k8temp => k8temp.rst} (83%)
 rename Documentation/hwmon/{lineage-pem => lineage-pem.rst} (88%)
 rename Documentation/hwmon/{lm25066 => lm25066.rst} (91%)
 rename Documentation/hwmon/{lm63 => lm63.rst} (95%)
 rename Documentation/hwmon/{lm70 => lm70.rst} (96%)
 rename Documentation/hwmon/{lm73 => lm73.rst} (92%)
 rename Documentation/hwmon/{lm75 => lm75.rst} (80%)
 rename Documentation/hwmon/{lm77 => lm77.rst} (97%)
 rename Documentation/hwmon/{lm78 => lm78.rst} (95%)
 rename Documentation/hwmon/{lm80 => lm80.rst} (94%)
 rename Documentation/hwmon/{lm83 => lm83.rst} (95%)
 rename Documentation/hwmon/{lm85 => lm85.rst} (86%)
 rename Documentation/hwmon/{lm87 => lm87.rst} (89%)
 rename Documentation/hwmon/{lm90 => lm90.rst} (85%)
 rename Documentation/hwmon/{lm92 => lm92.rst} (90%)
 rename Documentation/hwmon/{lm93 => lm93.rst} (80%)
 rename Documentation/hwmon/{lm95234 => lm95234.rst} (94%)
 rename Documentation/hwmon/{lm95245 => lm95245.rst} (91%)
 rename Documentation/hwmon/{ltc2945 => ltc2945.rst} (89%)
 rename Documentation/hwmon/{ltc2978 => ltc2978.rst} (58%)
 rename Documentation/hwmon/{ltc2990 => ltc2990.rst} (76%)
 rename Documentation/hwmon/{ltc3815 => ltc3815.rst} (83%)
 rename Documentation/hwmon/{ltc4151 => ltc4151.rst} (80%)
 rename Documentation/hwmon/{ltc4215 => ltc4215.rst} (78%)
 rename Documentation/hwmon/{ltc4245 => ltc4245.rst} (89%)
 rename Documentation/hwmon/{ltc4260 => ltc4260.rst} (85%)
 rename Documentation/hwmon/{ltc4261 => ltc4261.rst} (88%)
 rename Documentation/hwmon/{max16064 => max16064.rst} (88%)
 rename Documentation/hwmon/{max16065 => max16065.rst} (95%)
 rename Documentation/hwmon/{max1619 => max1619.rst} (82%)
 rename Documentation/hwmon/{max1668 => max1668.rst} (85%)
 rename Documentation/hwmon/{max197 => max197.rst} (59%)
 rename Documentation/hwmon/{max20751 => max20751.rst} (89%)
 rename Documentation/hwmon/{max31722 => max31722.rst} (83%)
 rename Documentation/hwmon/{max31785 => max31785.rst} (92%)
 rename Documentation/hwmon/{max31790 => max31790.rst} (88%)
 rename Documentation/hwmon/{max34440 => max34440.rst} (77%)
 rename Documentation/hwmon/{max6639 => max6639.rst} (83%)
 rename Documentation/hwmon/{max6642 => max6642.rst} (82%)
 rename Documentation/hwmon/{max6650 => max6650.rst} (86%)
 rename Documentation/hwmon/{max6697 => max6697.rst} (91%)
 rename Documentation/hwmon/{max8688 => max8688.rst} (85%)
 rename Documentation/hwmon/{mc13783-adc => mc13783-adc.rst} (82%)
 rename Documentation/hwmon/{mcp3021 => mcp3021.rst} (90%)
 rename Documentation/hwmon/{menf21bmc => menf21bmc.rst} (93%)
 rename Documentation/hwmon/{mlxreg-fan => mlxreg-fan.rst} (53%)
 rename Documentation/hwmon/{nct6683 => nct6683.rst} (89%)
 rename Documentation/hwmon/{nct6775 => nct6775.rst} (86%)
 rename Documentation/hwmon/{nct7802 => nct7802.rst} (73%)
 rename Documentation/hwmon/{nct7904 => nct7904.rst} (88%)
 rename Documentation/hwmon/{npcm750-pwm-fan => npcm750-pwm-fan.rst} (79%)
 rename Documentation/hwmon/{nsa320 => nsa320.rst} (93%)
 rename Documentation/hwmon/{ntc_thermistor => ntc_thermistor.rst} (52%)
 rename Documentation/hwmon/{occ => occ.rst} (67%)
 rename Documentation/hwmon/{pc87360 => pc87360.rst} (88%)
 rename Documentation/hwmon/{pc87427 => pc87427.rst} (99%)
 rename Documentation/hwmon/{pcf8591 => pcf8591.rst} (62%)
 rename Documentation/hwmon/{pmbus-core => pmbus-core.rst} (68%)
 rename Documentation/hwmon/{pmbus => pmbus.rst} (88%)
 rename Documentation/hwmon/{powr1220 => powr1220.rst} (90%)
 rename Documentation/hwmon/{pwm-fan => pwm-fan.rst} (100%)
 rename Documentation/hwmon/{raspberrypi-hwmon => raspberrypi-hwmon.rst} (85%)
 rename Documentation/hwmon/{sch5627 => sch5627.rst} (99%)
 rename Documentation/hwmon/{sch5636 => sch5636.rst} (99%)
 rename Documentation/hwmon/{scpi-hwmon => scpi-hwmon.rst} (96%)
 rename Documentation/hwmon/{sht15 => sht15.rst} (74%)
 rename Documentation/hwmon/{sht21 => sht21.rst} (92%)
 rename Documentation/hwmon/{sht3x => sht3x.rst} (75%)
 rename Documentation/hwmon/{shtc1 => shtc1.rst} (94%)
 rename Documentation/hwmon/{sis5595 => sis5595.rst} (79%)
 rename Documentation/hwmon/{smm665 => smm665.rst} (92%)
 rename Documentation/hwmon/{smsc47b397 => smsc47b397.rst} (62%)
 rename Documentation/hwmon/{smsc47m1 => smsc47m1.rst} (77%)
 delete mode 100644 Documentation/hwmon/smsc47m192
 create mode 100644 Documentation/hwmon/smsc47m192.rst
 rename Documentation/hwmon/{submitting-patches => submitting-patches.rst} (95%)
 rename Documentation/hwmon/{sysfs-interface => sysfs-interface.rst} (70%)
 rename Documentation/hwmon/{tc654 => tc654.rst} (81%)
 rename Documentation/hwmon/{tc74 => tc74.rst} (99%)
 rename Documentation/hwmon/{thmc50 => thmc50.rst} (84%)
 rename Documentation/hwmon/{tmp102 => tmp102.rst} (92%)
 rename Documentation/hwmon/{tmp103 => tmp103.rst} (91%)
 rename Documentation/hwmon/{tmp108 => tmp108.rst} (95%)
 rename Documentation/hwmon/{tmp401 => tmp401.rst} (92%)
 rename Documentation/hwmon/{tmp421 => tmp421.rst} (96%)
 rename Documentation/hwmon/{tps40422 => tps40422.rst} (75%)
 rename Documentation/hwmon/{twl4030-madc-hwmon => twl4030-madc-hwmon.rst} (82%)
 rename Documentation/hwmon/{ucd9000 => ucd9000.rst} (87%)
 rename Documentation/hwmon/{ucd9200 => ucd9200.rst} (80%)
 rename Documentation/hwmon/{userspace-tools => userspace-tools.rst} (97%)
 rename Documentation/hwmon/{vexpress => vexpress.rst} (85%)
 rename Documentation/hwmon/{via686a => via686a.rst} (79%)
 rename Documentation/hwmon/{vt1211 => vt1211.rst} (73%)
 rename Documentation/hwmon/{w83627ehf => w83627ehf.rst} (64%)
 rename Documentation/hwmon/{w83627hf => w83627hf.rst} (73%)
 rename Documentation/hwmon/{w83773g => w83773g.rst} (91%)
 rename Documentation/hwmon/{w83781d => w83781d.rst} (66%)
 rename Documentation/hwmon/{w83791d => w83791d.rst} (59%)
 rename Documentation/hwmon/{w83792d => w83792d.rst} (78%)
 delete mode 100644 Documentation/hwmon/w83793
 create mode 100644 Documentation/hwmon/w83793.rst
 delete mode 100644 Documentation/hwmon/w83795
 create mode 100644 Documentation/hwmon/w83795.rst
 rename Documentation/hwmon/{w83l785ts => w83l785ts.rst} (91%)
 rename Documentation/hwmon/{w83l786ng => w83l786ng.rst} (64%)
 rename Documentation/hwmon/{wm831x => wm831x.rst} (86%)
 rename Documentation/hwmon/{wm8350 => wm8350.rst} (81%)
 rename Documentation/hwmon/{xgene-hwmon => xgene-hwmon.rst} (51%)
 rename Documentation/hwmon/{zl6100 => zl6100.rst} (83%)

-- 
2.20.1


