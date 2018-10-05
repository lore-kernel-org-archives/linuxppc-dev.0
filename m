Return-Path: <SRS0=9KTJ=MR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFA8BC00449
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 17:23:03 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4930A208E7
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 17:23:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4930A208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Rc5x2Qq1zF3bT
	for <linuxppc-dev@archiver.kernel.org>; Sat,  6 Oct 2018 03:23:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.167.193; helo=mail-oi1-f193.google.com;
 envelope-from=robherring2@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Received: from mail-oi1-f193.google.com (mail-oi1-f193.google.com
 [209.85.167.193])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42RbZK2wnQzDrJl
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Oct 2018 02:59:05 +1000 (AEST)
Received: by mail-oi1-f193.google.com with SMTP id a203-v6so10981308oib.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Oct 2018 09:59:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ZC8t4Idln4S7ORmFnf/SrAK5cNn1ZboPvxmN3CleSFM=;
 b=gwDhQcOnuQEoorr1Q6ZpVY+ib8HJdo3jE+WpNBTKjca+jAmn7MoIyas+PbTrPD0iZx
 2JzzE34nybpw82/jusyJCkz00uXzCaBGpIFxgRLzOMP8ze2DCivERfsUE6VDUzI+h5qX
 R8fxD63rpesaGvd9ynOeziIbDOcCI7BO6nogg74JtknX+UTjWtQrnwuszQMcU9WHbSiL
 erJlCWka0BUgju/RS9EpCRvkdvOGEgIw4IT0m85TK2RBFEPD3fTeB/4e2Nf4NASv+xCl
 SCeKuktd1d81O9FS1ah5J0xjk4Z7ml2R7VaVfLmN/sdOnSy6nKi+v9i/avWtZRM8pPDC
 Z4RA==
X-Gm-Message-State: ABuFfoh27TrLm3xLjVMpZqbWAsjBsYF/QTlhUtncWakg/eJIN2DzX6ZZ
 S1Pk/8GQ40Uotfq2qgr0DdfJafeGkw==
X-Google-Smtp-Source: ACcGV62M2mlM92INfgpASuKJASzQEEL6UnrUwH1838TJLcnTB7H/a/G3Pyx6m096L5IlPwjcj3bRtA==
X-Received: by 2002:aca:f341:: with SMTP id
 r62-v6mr5554485oih.230.1538758742731; 
 Fri, 05 Oct 2018 09:59:02 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49]) by smtp.googlemail.com with ESMTPSA id
 u63-v6sm2904328ota.75.2018.10.05.09.59.01
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 05 Oct 2018 09:59:02 -0700 (PDT)
From: Rob Herring <robh@kernel.org>
To: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 09/36] dt-bindings: Convert trivial-devices.txt to json-schema
Date: Fri,  5 Oct 2018 11:58:21 -0500
Message-Id: <20181005165848.3474-10-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181005165848.3474-1-robh@kernel.org>
References: <20181005165848.3474-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Cc: Mark Rutland <mark.rutland@arm.com>, Tom Rini <trini@konsulko.com>,
 Kumar Gala <kumar.gala@linaro.org>, Grant Likely <glikely@secretlab.ca>,
 Arnd Bergmann <arnd@arndb.de>, Linus Walleij <linus.walleij@linaro.org>,
 Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
 Bjorn Andersson <bjorn.andersson@linaro.org>, Mark Brown <broonie@kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Olof Johansson <olof@lixom.net>,
 Frank Rowand <frowand.list@gmail.com>, Jonathan Cameron <jic23@kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Convert trivial-devices.txt to DT schema format using json-schema.

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: devicetree@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/trivial-devices.txt   | 201 ---------
 .../devicetree/bindings/trivial-devices.yaml  | 414 ++++++++++++++++++
 2 files changed, 414 insertions(+), 201 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/trivial-devices.txt
 create mode 100644 Documentation/devicetree/bindings/trivial-devices.yaml

diff --git a/Documentation/devicetree/bindings/trivial-devices.txt b/Documentation/devicetree/bindings/trivial-devices.txt
deleted file mode 100644
index 763a2808a95c..000000000000
--- a/Documentation/devicetree/bindings/trivial-devices.txt
+++ /dev/null
@@ -1,201 +0,0 @@
-This is a list of trivial i2c devices that have simple device tree
-bindings, consisting only of a compatible field, an address and
-possibly an interrupt line.
-
-If a device needs more specific bindings, such as properties to
-describe some aspect of it, there needs to be a specific binding
-document for it just like any other devices.
-
-
-Compatible		Vendor / Chip
-==========		=============
-abracon,abb5zes3		AB-RTCMC-32.768kHz-B5ZE-S3: Real Time Clock/Calendar Module with I2C Interface
-ad,ad7414		SMBus/I2C Digital Temperature Sensor in 6-Pin SOT with SMBus Alert and Over Temperature Pin
-ad,adm9240		ADM9240:  Complete System Hardware Monitor for uProcessor-Based Systems
-adi,adt7461		+/-1C TDM Extended Temp Range I.C
-adt7461			+/-1C TDM Extended Temp Range I.C
-adi,adt7473		+/-1C TDM Extended Temp Range I.C
-adi,adt7475		+/-1C TDM Extended Temp Range I.C
-adi,adt7476		+/-1C TDM Extended Temp Range I.C
-adi,adt7490		+/-1C TDM Extended Temp Range I.C
-adi,adxl345		Three-Axis Digital Accelerometer
-adi,adxl346		Three-Axis Digital Accelerometer (backward-compatibility value "adi,adxl345" must be listed too)
-ams,iaq-core		AMS iAQ-Core VOC Sensor
-amstaos,tsl2571		AMS/TAOS ALS and proximity sensor
-amstaos,tsl2671		AMS/TAOS ALS and proximity sensor
-amstaos,tmd2671		AMS/TAOS ALS and proximity sensor
-amstaos,tsl2771		AMS/TAOS ALS and proximity sensor
-amstaos,tmd2771		AMS/TAOS ALS and proximity sensor
-amstaos,tsl2572		AMS/TAOS ALS and proximity sensor
-amstaos,tsl2672		AMS/TAOS ALS and proximity sensor
-amstaos,tmd2672		AMS/TAOS ALS and proximity sensor
-amstaos,tsl2772		AMS/TAOS ALS and proximity sensor
-amstaos,tmd2772		AMS/TAOS ALS and proximity sensor
-at,24c08		i2c serial eeprom  (24cxx)
-atmel,at97sc3204t	i2c trusted platform module (TPM)
-capella,cm32181		CM32181: Ambient Light Sensor
-capella,cm3232		CM3232: Ambient Light Sensor
-cirrus,cs42l51		Cirrus Logic CS42L51 audio codec
-dallas,ds1374		I2C, 32-Bit Binary Counter Watchdog RTC with Trickle Charger and Reset Input/Output
-dallas,ds1631		High-Precision Digital Thermometer
-dallas,ds1672		Dallas DS1672 Real-time Clock
-dallas,ds1682		Total-Elapsed-Time Recorder with Alarm
-dallas,ds1775		Tiny Digital Thermometer and Thermostat
-dallas,ds3232		Extremely Accurate I²C RTC with Integrated Crystal and SRAM
-dallas,ds4510		CPU Supervisor with Nonvolatile Memory and Programmable I/O
-dallas,ds75		Digital Thermometer and Thermostat
-devantech,srf02		Devantech SRF02 ultrasonic ranger in I2C mode
-devantech,srf08		Devantech SRF08 ultrasonic ranger
-devantech,srf10		Devantech SRF10 ultrasonic ranger
-dlg,da9053		DA9053: flexible system level PMIC with multicore support
-dlg,da9063		DA9063: system PMIC for quad-core application processors
-domintech,dmard09	DMARD09: 3-axis Accelerometer
-domintech,dmard10	DMARD10: 3-axis Accelerometer
-epson,rx8010		I2C-BUS INTERFACE REAL TIME CLOCK MODULE
-epson,rx8581		I2C-BUS INTERFACE REAL TIME CLOCK MODULE
-emmicro,em3027		EM Microelectronic EM3027 Real-time Clock
-fsl,mag3110		MAG3110: Xtrinsic High Accuracy, 3D Magnetometer
-fsl,mma7660		MMA7660FC: 3-Axis Orientation/Motion Detection Sensor
-fsl,mma8450		MMA8450Q: Xtrinsic Low-power, 3-axis Xtrinsic Accelerometer
-fsl,mpl3115		MPL3115: Absolute Digital Pressure Sensor
-fsl,mpr121		MPR121: Proximity Capacitive Touch Sensor Controller
-fsl,sgtl5000		SGTL5000: Ultra Low-Power Audio Codec
-gmt,g751		G751: Digital Temperature Sensor and Thermal Watchdog with Two-Wire Interface
-infineon,slb9635tt	Infineon SLB9635 (Soft-) I2C TPM (old protocol, max 100khz)
-infineon,slb9645tt	Infineon SLB9645 I2C TPM (new protocol, max 400khz)
-infineon,tlv493d-a1b6	Infineon TLV493D-A1B6 I2C 3D Magnetic Sensor
-isil,isl1208		Intersil ISL1208 Low Power RTC with Battery Backed SRAM
-isil,isl1218		Intersil ISL1218 Low Power RTC with Battery Backed SRAM
-isil,isl12022		Intersil ISL12022 Real-time Clock
-isil,isl29028		Intersil ISL29028 Ambient Light and Proximity Sensor
-isil,isl29030		Intersil ISL29030 Ambient Light and Proximity Sensor
-maxim,ds1050		5 Bit Programmable, Pulse-Width Modulator
-maxim,max1237		Low-Power, 4-/12-Channel, 2-Wire Serial, 12-Bit ADCs
-maxim,max6621		PECI-to-I2C translator for PECI-to-SMBus/I2C protocol conversion
-maxim,max6625		9-Bit/12-Bit Temperature Sensors with I²C-Compatible Serial Interface
-mcube,mc3230		mCube 3-axis 8-bit digital accelerometer
-memsic,mxc6225		MEMSIC 2-axis 8-bit digital accelerometer
-microchip,mcp4017-502	Microchip 7-bit Single I2C Digital POT (5k)
-microchip,mcp4017-103	Microchip 7-bit Single I2C Digital POT (10k)
-microchip,mcp4017-503	Microchip 7-bit Single I2C Digital POT (50k)
-microchip,mcp4017-104	Microchip 7-bit Single I2C Digital POT (100k)
-microchip,mcp4018-502	Microchip 7-bit Single I2C Digital POT (5k)
-microchip,mcp4018-103	Microchip 7-bit Single I2C Digital POT (10k)
-microchip,mcp4018-503	Microchip 7-bit Single I2C Digital POT (50k)
-microchip,mcp4018-104	Microchip 7-bit Single I2C Digital POT (100k)
-microchip,mcp4019-502	Microchip 7-bit Single I2C Digital POT (5k)
-microchip,mcp4019-103	Microchip 7-bit Single I2C Digital POT (10k)
-microchip,mcp4019-503	Microchip 7-bit Single I2C Digital POT (50k)
-microchip,mcp4019-104	Microchip 7-bit Single I2C Digital POT (100k)
-microchip,mcp4531-502	Microchip 7-bit Single I2C Digital Potentiometer (5k)
-microchip,mcp4531-103	Microchip 7-bit Single I2C Digital Potentiometer (10k)
-microchip,mcp4531-503	Microchip 7-bit Single I2C Digital Potentiometer (50k)
-microchip,mcp4531-104	Microchip 7-bit Single I2C Digital Potentiometer (100k)
-microchip,mcp4532-502	Microchip 7-bit Single I2C Digital Potentiometer (5k)
-microchip,mcp4532-103	Microchip 7-bit Single I2C Digital Potentiometer (10k)
-microchip,mcp4532-503	Microchip 7-bit Single I2C Digital Potentiometer (50k)
-microchip,mcp4532-104	Microchip 7-bit Single I2C Digital Potentiometer (100k)
-microchip,mcp4541-502	Microchip 7-bit Single I2C Digital Potentiometer with NV Memory (5k)
-microchip,mcp4541-103	Microchip 7-bit Single I2C Digital Potentiometer with NV Memory (10k)
-microchip,mcp4541-503	Microchip 7-bit Single I2C Digital Potentiometer with NV Memory (50k)
-microchip,mcp4541-104	Microchip 7-bit Single I2C Digital Potentiometer with NV Memory (100k)
-microchip,mcp4542-502	Microchip 7-bit Single I2C Digital Potentiometer with NV Memory (5k)
-microchip,mcp4542-103	Microchip 7-bit Single I2C Digital Potentiometer with NV Memory (10k)
-microchip,mcp4542-503	Microchip 7-bit Single I2C Digital Potentiometer with NV Memory (50k)
-microchip,mcp4542-104	Microchip 7-bit Single I2C Digital Potentiometer with NV Memory (100k)
-microchip,mcp4551-502	Microchip 8-bit Single I2C Digital Potentiometer (5k)
-microchip,mcp4551-103	Microchip 8-bit Single I2C Digital Potentiometer (10k)
-microchip,mcp4551-503	Microchip 8-bit Single I2C Digital Potentiometer (50k)
-microchip,mcp4551-104	Microchip 8-bit Single I2C Digital Potentiometer (100k)
-microchip,mcp4552-502	Microchip 8-bit Single I2C Digital Potentiometer (5k)
-microchip,mcp4552-103	Microchip 8-bit Single I2C Digital Potentiometer (10k)
-microchip,mcp4552-503	Microchip 8-bit Single I2C Digital Potentiometer (50k)
-microchip,mcp4552-104	Microchip 8-bit Single I2C Digital Potentiometer (100k)
-microchip,mcp4561-502	Microchip 8-bit Single I2C Digital Potentiometer with NV Memory (5k)
-microchip,mcp4561-103	Microchip 8-bit Single I2C Digital Potentiometer with NV Memory (10k)
-microchip,mcp4561-503	Microchip 8-bit Single I2C Digital Potentiometer with NV Memory (50k)
-microchip,mcp4561-104	Microchip 8-bit Single I2C Digital Potentiometer with NV Memory (100k)
-microchip,mcp4562-502	Microchip 8-bit Single I2C Digital Potentiometer with NV Memory (5k)
-microchip,mcp4562-103	Microchip 8-bit Single I2C Digital Potentiometer with NV Memory (10k)
-microchip,mcp4562-503	Microchip 8-bit Single I2C Digital Potentiometer with NV Memory (50k)
-microchip,mcp4562-104	Microchip 8-bit Single I2C Digital Potentiometer with NV Memory (100k)
-microchip,mcp4631-502	Microchip 7-bit Dual I2C Digital Potentiometer (5k)
-microchip,mcp4631-103	Microchip 7-bit Dual I2C Digital Potentiometer (10k)
-microchip,mcp4631-503	Microchip 7-bit Dual I2C Digital Potentiometer (50k)
-microchip,mcp4631-104	Microchip 7-bit Dual I2C Digital Potentiometer (100k)
-microchip,mcp4632-502	Microchip 7-bit Dual I2C Digital Potentiometer (5k)
-microchip,mcp4632-103	Microchip 7-bit Dual I2C Digital Potentiometer (10k)
-microchip,mcp4632-503	Microchip 7-bit Dual I2C Digital Potentiometer (50k)
-microchip,mcp4632-104	Microchip 7-bit Dual I2C Digital Potentiometer (100k)
-microchip,mcp4641-502	Microchip 7-bit Dual I2C Digital Potentiometer with NV Memory (5k)
-microchip,mcp4641-103	Microchip 7-bit Dual I2C Digital Potentiometer with NV Memory (10k)
-microchip,mcp4641-503	Microchip 7-bit Dual I2C Digital Potentiometer with NV Memory (50k)
-microchip,mcp4641-104	Microchip 7-bit Dual I2C Digital Potentiometer with NV Memory (100k)
-microchip,mcp4642-502	Microchip 7-bit Dual I2C Digital Potentiometer with NV Memory (5k)
-microchip,mcp4642-103	Microchip 7-bit Dual I2C Digital Potentiometer with NV Memory (10k)
-microchip,mcp4642-503	Microchip 7-bit Dual I2C Digital Potentiometer with NV Memory (50k)
-microchip,mcp4642-104	Microchip 7-bit Dual I2C Digital Potentiometer with NV Memory (100k)
-microchip,mcp4651-502	Microchip 8-bit Dual I2C Digital Potentiometer (5k)
-microchip,mcp4651-103	Microchip 8-bit Dual I2C Digital Potentiometer (10k)
-microchip,mcp4651-503	Microchip 8-bit Dual I2C Digital Potentiometer (50k)
-microchip,mcp4651-104	Microchip 8-bit Dual I2C Digital Potentiometer (100k)
-microchip,mcp4652-502	Microchip 8-bit Dual I2C Digital Potentiometer (5k)
-microchip,mcp4652-103	Microchip 8-bit Dual I2C Digital Potentiometer (10k)
-microchip,mcp4652-503	Microchip 8-bit Dual I2C Digital Potentiometer (50k)
-microchip,mcp4652-104	Microchip 8-bit Dual I2C Digital Potentiometer (100k)
-microchip,mcp4661-502	Microchip 8-bit Dual I2C Digital Potentiometer with NV Memory (5k)
-microchip,mcp4661-103	Microchip 8-bit Dual I2C Digital Potentiometer with NV Memory (10k)
-microchip,mcp4661-503	Microchip 8-bit Dual I2C Digital Potentiometer with NV Memory (50k)
-microchip,mcp4661-104	Microchip 8-bit Dual I2C Digital Potentiometer with NV Memory (100k)
-microchip,mcp4662-502	Microchip 8-bit Dual I2C Digital Potentiometer with NV Memory (5k)
-microchip,mcp4662-103	Microchip 8-bit Dual I2C Digital Potentiometer with NV Memory (10k)
-microchip,mcp4662-503	Microchip 8-bit Dual I2C Digital Potentiometer with NV Memory (50k)
-microchip,mcp4662-104	Microchip 8-bit Dual I2C Digital Potentiometer with NV Memory (100k)
-microchip,tc654		PWM Fan Speed Controller With Fan Fault Detection
-microchip,tc655		PWM Fan Speed Controller With Fan Fault Detection
-microcrystal,rv3029	Real Time Clock Module with I2C-Bus
-miramems,da226		MiraMEMS DA226 2-axis 14-bit digital accelerometer
-miramems,da280		MiraMEMS DA280 3-axis 14-bit digital accelerometer
-miramems,da311		MiraMEMS DA311 3-axis 12-bit digital accelerometer
-national,lm63		Temperature sensor with integrated fan control
-national,lm75		I2C TEMP SENSOR
-national,lm80		Serial Interface ACPI-Compatible Microprocessor System Hardware Monitor
-national,lm85		Temperature sensor with integrated fan control
-national,lm92		±0.33°C Accurate, 12-Bit + Sign Temperature Sensor and Thermal Window Comparator with Two-Wire Interface
-nuvoton,npct501		i2c trusted platform module (TPM)
-nuvoton,npct601		i2c trusted platform module (TPM2)
-nuvoton,w83773g		Nuvoton Temperature Sensor
-nxp,pca9556		Octal SMBus and I2C registered interface
-nxp,pca9557		8-bit I2C-bus and SMBus I/O port with reset
-nxp,pcf2127		Real-time clock
-nxp,pcf2129		Real-time clock
-nxp,pcf8523		Real-time Clock
-nxp,pcf8563		Real-time clock/calendar
-nxp,pcf85063		Tiny Real-Time Clock
-oki,ml86v7667		OKI ML86V7667 video decoder
-ovti,ov5642		OV5642: Color CMOS QSXGA (5-megapixel) Image Sensor with OmniBSI and Embedded TrueFocus
-pericom,pt7c4338	Real-time Clock Module
-plx,pex8648		48-Lane, 12-Port PCI Express Gen 2 (5.0 GT/s) Switch
-pulsedlight,lidar-lite-v2	Pulsedlight LIDAR range-finding sensor
-ricoh,r2025sd		I2C bus SERIAL INTERFACE REAL-TIME CLOCK IC
-ricoh,r2221tl		I2C bus SERIAL INTERFACE REAL-TIME CLOCK IC
-ricoh,rs5c372a		I2C bus SERIAL INTERFACE REAL-TIME CLOCK IC
-ricoh,rs5c372b		I2C bus SERIAL INTERFACE REAL-TIME CLOCK IC
-ricoh,rv5c386		I2C bus SERIAL INTERFACE REAL-TIME CLOCK IC
-ricoh,rv5c387a		I2C bus SERIAL INTERFACE REAL-TIME CLOCK IC
-samsung,24ad0xd1	S524AD0XF1 (128K/256K-bit Serial EEPROM for Low Power)
-sgx,vz89x		SGX Sensortech VZ89X Sensors
-sii,s35390a		2-wire CMOS real-time clock
-silabs,si7020		Relative Humidity and Temperature Sensors
-skyworks,sky81452	Skyworks SKY81452: Six-Channel White LED Driver with Touch Panel Bias Supply
-st,24c256		i2c serial eeprom  (24cxx)
-taos,tsl2550		Ambient Light Sensor with SMBUS/Two Wire Serial Interface
-ti,ads7828		8-Channels, 12-bit ADC
-ti,ads7830		8-Channels, 8-bit ADC
-ti,amc6821		Temperature Monitoring and Fan Control
-ti,tsc2003		I2C Touch-Screen Controller
-ti,tmp102		Low Power Digital Temperature Sensor with SMBUS/Two Wire Serial Interface
-ti,tmp103		Low Power Digital Temperature Sensor with SMBUS/Two Wire Serial Interface
-ti,tmp275		Digital Temperature Sensor
-winbond,w83793		Winbond/Nuvoton H/W Monitor
-winbond,wpct301		i2c trusted platform module (TPM)
diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
new file mode 100644
index 000000000000..a17278a44699
--- /dev/null
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -0,0 +1,414 @@
+# SPDX-License-Identifier: None
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/bindings/trivial-devices.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Trivial I2C and SPI devices that have simple device tree bindings
+
+maintainers:
+  - Rob Herring <robh@kernel.org>
+
+description: |
+  This is a list of trivial I2C and SPI devices that have simple device tree
+  bindings, consisting only of a compatible field, an address and possibly an
+  interrupt line.
+
+  If a device needs more specific bindings, such as properties to
+  describe some aspect of it, there needs to be a specific binding
+  document for it just like any other devices.
+
+properties:
+  reg:
+    maxItems: 1
+  interrupts:
+    maxItems: 1
+  compatible:
+    items:
+      - enum:
+            # AB-RTCMC-32.768kHz-B5ZE-S3: Real Time Clock/Calendar Module with I2C Interface
+          - abracon,abb5zes3
+            # SMBus/I2C Digital Temperature Sensor in 6-Pin SOT with SMBus Alert and Over Temperature Pin
+          - ad,ad7414
+            # ADM9240:  Complete System Hardware Monitor for uProcessor-Based Systems
+          - ad,adm9240
+            # +/-1C TDM Extended Temp Range I.C
+          - adi,adt7461
+            # +/-1C TDM Extended Temp Range I.C
+          - adt7461
+            # +/-1C TDM Extended Temp Range I.C
+          - adi,adt7473
+            # +/-1C TDM Extended Temp Range I.C
+          - adi,adt7475
+            # +/-1C TDM Extended Temp Range I.C
+          - adi,adt7476
+            # +/-1C TDM Extended Temp Range I.C
+          - adi,adt7490
+            # Three-Axis Digital Accelerometer
+          - adi,adxl345
+            # Three-Axis Digital Accelerometer (backward-compatibility value "adi,adxl345" must be listed too)
+          - adi,adxl346
+            # AMS iAQ-Core VOC Sensor
+          - ams,iaq-core
+            # AMS/TAOS ALS and proximity sensor
+          - amstaos,tsl2571
+            # AMS/TAOS ALS and proximity sensor
+          - amstaos,tsl2671
+            # AMS/TAOS ALS and proximity sensor
+          - amstaos,tmd2671
+            # AMS/TAOS ALS and proximity sensor
+          - amstaos,tsl2771
+            # AMS/TAOS ALS and proximity sensor
+          - amstaos,tmd2771
+            # AMS/TAOS ALS and proximity sensor
+          - amstaos,tsl2572
+            # AMS/TAOS ALS and proximity sensor
+          - amstaos,tsl2672
+            # AMS/TAOS ALS and proximity sensor
+          - amstaos,tmd2672
+            # AMS/TAOS ALS and proximity sensor
+          - amstaos,tsl2772
+            # AMS/TAOS ALS and proximity sensor
+          - amstaos,tmd2772
+            # i2c serial eeprom  (24cxx)
+          - at,24c08
+            # i2c trusted platform module (TPM)
+          - atmel,at97sc3204t
+            # CM32181: Ambient Light Sensor
+          - capella,cm32181
+            # CM3232: Ambient Light Sensor
+          - capella,cm3232
+            # Cirrus Logic CS42L51 audio codec
+          - cirrus,cs42l51
+            # I2C, 32-Bit Binary Counter Watchdog RTC with Trickle Charger and Reset Input/Output
+          - dallas,ds1374
+            # High-Precision Digital Thermometer
+          - dallas,ds1631
+            # Dallas DS1672 Real-time Clock
+          - dallas,ds1672
+            # Total-Elapsed-Time Recorder with Alarm
+          - dallas,ds1682
+            # Tiny Digital Thermometer and Thermostat
+          - dallas,ds1775
+            # Extremely Accurate I²C RTC with Integrated Crystal and SRAM
+          - dallas,ds3232
+            # CPU Supervisor with Nonvolatile Memory and Programmable I/O
+          - dallas,ds4510
+            # Digital Thermometer and Thermostat
+          - dallas,ds75
+            # Devantech SRF02 ultrasonic ranger in I2C mode
+          - devantech,srf02
+            # Devantech SRF08 ultrasonic ranger
+          - devantech,srf08
+            # Devantech SRF10 ultrasonic ranger
+          - devantech,srf10
+            # DA9053: flexible system level PMIC with multicore support
+          - dlg,da9053
+            # DA9063: system PMIC for quad-core application processors
+          - dlg,da9063
+            # DMARD09: 3-axis Accelerometer
+          - domintech,dmard09
+            # DMARD10: 3-axis Accelerometer
+          - domintech,dmard10
+            # I2C-BUS INTERFACE REAL TIME CLOCK MODULE
+          - epson,rx8010
+            # I2C-BUS INTERFACE REAL TIME CLOCK MODULE
+          - epson,rx8581
+            # EM Microelectronic EM3027 Real-time Clock
+          - emmicro,em3027
+            # MAG3110: Xtrinsic High Accuracy, 3D Magnetometer
+          - fsl,mag3110
+            # MMA7660FC: 3-Axis Orientation/Motion Detection Sensor
+          - fsl,mma7660
+            # MMA8450Q: Xtrinsic Low-power, 3-axis Xtrinsic Accelerometer
+          - fsl,mma8450
+            # MPL3115: Absolute Digital Pressure Sensor
+          - fsl,mpl3115
+            # MPR121: Proximity Capacitive Touch Sensor Controller
+          - fsl,mpr121
+            # SGTL5000: Ultra Low-Power Audio Codec
+          - fsl,sgtl5000
+            # G751: Digital Temperature Sensor and Thermal Watchdog with Two-Wire Interface
+          - gmt,g751
+            # Infineon SLB9635 (Soft-) I2C TPM (old protocol, max 100khz)
+          - infineon,slb9635tt
+            # Infineon SLB9645 I2C TPM (new protocol, max 400khz)
+          - infineon,slb9645tt
+            # Infineon TLV493D-A1B6 I2C 3D Magnetic Sensor
+          - infineon,tlv493d-a1b6
+            # Intersil ISL1208 Low Power RTC with Battery Backed SRAM
+          - isil,isl1208
+            # Intersil ISL1218 Low Power RTC with Battery Backed SRAM
+          - isil,isl1218
+            # Intersil ISL12022 Real-time Clock
+          - isil,isl12022
+            # Intersil ISL29028 Ambient Light and Proximity Sensor
+          - isil,isl29028
+            # Intersil ISL29030 Ambient Light and Proximity Sensor
+          - isil,isl29030
+            # 5 Bit Programmable, Pulse-Width Modulator
+          - maxim,ds1050
+            # Low-Power, 4-/12-Channel, 2-Wire Serial, 12-Bit ADCs
+          - maxim,max1237
+            # PECI-to-I2C translator for PECI-to-SMBus/I2C protocol conversion
+          - maxim,max6621
+            # 9-Bit/12-Bit Temperature Sensors with I²C-Compatible Serial Interface
+          - maxim,max6625
+            # mCube 3-axis 8-bit digital accelerometer
+          - mcube,mc3230
+            # MEMSIC 2-axis 8-bit digital accelerometer
+          - memsic,mxc6225
+            # Microchip 7-bit Single I2C Digital POT (5k)
+          - microchip,mcp4017-502
+            # Microchip 7-bit Single I2C Digital POT (10k)
+          - microchip,mcp4017-103
+            # Microchip 7-bit Single I2C Digital POT (50k)
+          - microchip,mcp4017-503
+            # Microchip 7-bit Single I2C Digital POT (100k)
+          - microchip,mcp4017-104
+            # Microchip 7-bit Single I2C Digital POT (5k)
+          - microchip,mcp4018-502
+            # Microchip 7-bit Single I2C Digital POT (10k)
+          - microchip,mcp4018-103
+            # Microchip 7-bit Single I2C Digital POT (50k)
+          - microchip,mcp4018-503
+            # Microchip 7-bit Single I2C Digital POT (100k)
+          - microchip,mcp4018-104
+            # Microchip 7-bit Single I2C Digital POT (5k)
+          - microchip,mcp4019-502
+            # Microchip 7-bit Single I2C Digital POT (10k)
+          - microchip,mcp4019-103
+            # Microchip 7-bit Single I2C Digital POT (50k)
+          - microchip,mcp4019-503
+            # Microchip 7-bit Single I2C Digital POT (100k)
+          - microchip,mcp4019-104
+            # Microchip 7-bit Single I2C Digital Potentiometer (5k)
+          - microchip,mcp4531-502
+            # Microchip 7-bit Single I2C Digital Potentiometer (10k)
+          - microchip,mcp4531-103
+            # Microchip 7-bit Single I2C Digital Potentiometer (50k)
+          - microchip,mcp4531-503
+            # Microchip 7-bit Single I2C Digital Potentiometer (100k)
+          - microchip,mcp4531-104
+            # Microchip 7-bit Single I2C Digital Potentiometer (5k)
+          - microchip,mcp4532-502
+            # Microchip 7-bit Single I2C Digital Potentiometer (10k)
+          - microchip,mcp4532-103
+            # Microchip 7-bit Single I2C Digital Potentiometer (50k)
+          - microchip,mcp4532-503
+            # Microchip 7-bit Single I2C Digital Potentiometer (100k)
+          - microchip,mcp4532-104
+            # Microchip 7-bit Single I2C Digital Potentiometer with NV Memory (5k)
+          - microchip,mcp4541-502
+            # Microchip 7-bit Single I2C Digital Potentiometer with NV Memory (10k)
+          - microchip,mcp4541-103
+            # Microchip 7-bit Single I2C Digital Potentiometer with NV Memory (50k)
+          - microchip,mcp4541-503
+            # Microchip 7-bit Single I2C Digital Potentiometer with NV Memory (100k)
+          - microchip,mcp4541-104
+            # Microchip 7-bit Single I2C Digital Potentiometer with NV Memory (5k)
+          - microchip,mcp4542-502
+            # Microchip 7-bit Single I2C Digital Potentiometer with NV Memory (10k)
+          - microchip,mcp4542-103
+            # Microchip 7-bit Single I2C Digital Potentiometer with NV Memory (50k)
+          - microchip,mcp4542-503
+            # Microchip 7-bit Single I2C Digital Potentiometer with NV Memory (100k)
+          - microchip,mcp4542-104
+            # Microchip 8-bit Single I2C Digital Potentiometer (5k)
+          - microchip,mcp4551-502
+            # Microchip 8-bit Single I2C Digital Potentiometer (10k)
+          - microchip,mcp4551-103
+            # Microchip 8-bit Single I2C Digital Potentiometer (50k)
+          - microchip,mcp4551-503
+            # Microchip 8-bit Single I2C Digital Potentiometer (100k)
+          - microchip,mcp4551-104
+            # Microchip 8-bit Single I2C Digital Potentiometer (5k)
+          - microchip,mcp4552-502
+            # Microchip 8-bit Single I2C Digital Potentiometer (10k)
+          - microchip,mcp4552-103
+            # Microchip 8-bit Single I2C Digital Potentiometer (50k)
+          - microchip,mcp4552-503
+            # Microchip 8-bit Single I2C Digital Potentiometer (100k)
+          - microchip,mcp4552-104
+            # Microchip 8-bit Single I2C Digital Potentiometer with NV Memory (5k)
+          - microchip,mcp4561-502
+            # Microchip 8-bit Single I2C Digital Potentiometer with NV Memory (10k)
+          - microchip,mcp4561-103
+            # Microchip 8-bit Single I2C Digital Potentiometer with NV Memory (50k)
+          - microchip,mcp4561-503
+            # Microchip 8-bit Single I2C Digital Potentiometer with NV Memory (100k)
+          - microchip,mcp4561-104
+            # Microchip 8-bit Single I2C Digital Potentiometer with NV Memory (5k)
+          - microchip,mcp4562-502
+            # Microchip 8-bit Single I2C Digital Potentiometer with NV Memory (10k)
+          - microchip,mcp4562-103
+            # Microchip 8-bit Single I2C Digital Potentiometer with NV Memory (50k)
+          - microchip,mcp4562-503
+            # Microchip 8-bit Single I2C Digital Potentiometer with NV Memory (100k)
+          - microchip,mcp4562-104
+            # Microchip 7-bit Dual I2C Digital Potentiometer (5k)
+          - microchip,mcp4631-502
+            # Microchip 7-bit Dual I2C Digital Potentiometer (10k)
+          - microchip,mcp4631-103
+            # Microchip 7-bit Dual I2C Digital Potentiometer (50k)
+          - microchip,mcp4631-503
+            # Microchip 7-bit Dual I2C Digital Potentiometer (100k)
+          - microchip,mcp4631-104
+            # Microchip 7-bit Dual I2C Digital Potentiometer (5k)
+          - microchip,mcp4632-502
+            # Microchip 7-bit Dual I2C Digital Potentiometer (10k)
+          - microchip,mcp4632-103
+            # Microchip 7-bit Dual I2C Digital Potentiometer (50k)
+          - microchip,mcp4632-503
+            # Microchip 7-bit Dual I2C Digital Potentiometer (100k)
+          - microchip,mcp4632-104
+            # Microchip 7-bit Dual I2C Digital Potentiometer with NV Memory (5k)
+          - microchip,mcp4641-502
+            # Microchip 7-bit Dual I2C Digital Potentiometer with NV Memory (10k)
+          - microchip,mcp4641-103
+            # Microchip 7-bit Dual I2C Digital Potentiometer with NV Memory (50k)
+          - microchip,mcp4641-503
+            # Microchip 7-bit Dual I2C Digital Potentiometer with NV Memory (100k)
+          - microchip,mcp4641-104
+            # Microchip 7-bit Dual I2C Digital Potentiometer with NV Memory (5k)
+          - microchip,mcp4642-502
+            # Microchip 7-bit Dual I2C Digital Potentiometer with NV Memory (10k)
+          - microchip,mcp4642-103
+            # Microchip 7-bit Dual I2C Digital Potentiometer with NV Memory (50k)
+          - microchip,mcp4642-503
+            # Microchip 7-bit Dual I2C Digital Potentiometer with NV Memory (100k)
+          - microchip,mcp4642-104
+            # Microchip 8-bit Dual I2C Digital Potentiometer (5k)
+          - microchip,mcp4651-502
+            # Microchip 8-bit Dual I2C Digital Potentiometer (10k)
+          - microchip,mcp4651-103
+            # Microchip 8-bit Dual I2C Digital Potentiometer (50k)
+          - microchip,mcp4651-503
+            # Microchip 8-bit Dual I2C Digital Potentiometer (100k)
+          - microchip,mcp4651-104
+            # Microchip 8-bit Dual I2C Digital Potentiometer (5k)
+          - microchip,mcp4652-502
+            # Microchip 8-bit Dual I2C Digital Potentiometer (10k)
+          - microchip,mcp4652-103
+            # Microchip 8-bit Dual I2C Digital Potentiometer (50k)
+          - microchip,mcp4652-503
+            # Microchip 8-bit Dual I2C Digital Potentiometer (100k)
+          - microchip,mcp4652-104
+            # Microchip 8-bit Dual I2C Digital Potentiometer with NV Memory (5k)
+          - microchip,mcp4661-502
+            # Microchip 8-bit Dual I2C Digital Potentiometer with NV Memory (10k)
+          - microchip,mcp4661-103
+            # Microchip 8-bit Dual I2C Digital Potentiometer with NV Memory (50k)
+          - microchip,mcp4661-503
+            # Microchip 8-bit Dual I2C Digital Potentiometer with NV Memory (100k)
+          - microchip,mcp4661-104
+            # Microchip 8-bit Dual I2C Digital Potentiometer with NV Memory (5k)
+          - microchip,mcp4662-502
+            # Microchip 8-bit Dual I2C Digital Potentiometer with NV Memory (10k)
+          - microchip,mcp4662-103
+            # Microchip 8-bit Dual I2C Digital Potentiometer with NV Memory (50k)
+          - microchip,mcp4662-503
+            # Microchip 8-bit Dual I2C Digital Potentiometer with NV Memory (100k)
+          - microchip,mcp4662-104
+            # PWM Fan Speed Controller With Fan Fault Detection
+          - microchip,tc654
+            # PWM Fan Speed Controller With Fan Fault Detection
+          - microchip,tc655
+            # Real Time Clock Module with I2C-Bus
+          - microcrystal,rv3029
+            # MiraMEMS DA226 2-axis 14-bit digital accelerometer
+          - miramems,da226
+            # MiraMEMS DA280 3-axis 14-bit digital accelerometer
+          - miramems,da280
+            # MiraMEMS DA311 3-axis 12-bit digital accelerometer
+          - miramems,da311
+            # Temperature sensor with integrated fan control
+          - national,lm63
+            # I2C TEMP SENSOR
+          - national,lm75
+            # Serial Interface ACPI-Compatible Microprocessor System Hardware Monitor
+          - national,lm80
+            # Temperature sensor with integrated fan control
+          - national,lm85
+            # ±0.33°C Accurate, 12-Bit + Sign Temperature Sensor and Thermal Window Comparator with Two-Wire Interface
+          - national,lm92
+            # i2c trusted platform module (TPM)
+          - nuvoton,npct501
+            # i2c trusted platform module (TPM2)
+          - nuvoton,npct601
+            # Nuvoton Temperature Sensor
+          - nuvoton,w83773g
+            # Octal SMBus and I2C registered interface
+          - nxp,pca9556
+            # 8-bit I2C-bus and SMBus I/O port with reset
+          - nxp,pca9557
+            # Real-time clock
+          - nxp,pcf2127
+            # Real-time clock
+          - nxp,pcf2129
+            # Real-time Clock
+          - nxp,pcf8523
+            # Real-time clock/calendar
+          - nxp,pcf8563
+            # Tiny Real-Time Clock
+          - nxp,pcf85063
+            # OKI ML86V7667 video decoder
+          - oki,ml86v7667
+            # OV5642: Color CMOS QSXGA (5-megapixel) Image Sensor with OmniBSI and Embedded TrueFocus
+          - ovti,ov5642
+            # Real-time Clock Module
+          - pericom,pt7c4338
+            # 48-Lane, 12-Port PCI Express Gen 2 (5.0 GT/s) Switch
+          - plx,pex8648
+            # Pulsedlight LIDAR range-finding sensor
+          - pulsedlight,lidar-lite-v2
+            # I2C bus SERIAL INTERFACE REAL-TIME CLOCK IC
+          - ricoh,r2025sd
+            # I2C bus SERIAL INTERFACE REAL-TIME CLOCK IC
+          - ricoh,r2221tl
+            # I2C bus SERIAL INTERFACE REAL-TIME CLOCK IC
+          - ricoh,rs5c372a
+            # I2C bus SERIAL INTERFACE REAL-TIME CLOCK IC
+          - ricoh,rs5c372b
+            # I2C bus SERIAL INTERFACE REAL-TIME CLOCK IC
+          - ricoh,rv5c386
+            # I2C bus SERIAL INTERFACE REAL-TIME CLOCK IC
+          - ricoh,rv5c387a
+            # S524AD0XF1 (128K/256K-bit Serial EEPROM for Low Power)
+          - samsung,24ad0xd1
+            # SGX Sensortech VZ89X Sensors
+          - sgx,vz89x
+            # 2-wire CMOS real-time clock
+          - sii,s35390a
+            # Relative Humidity and Temperature Sensors
+          - silabs,si7020
+            # Skyworks SKY81452: Six-Channel White LED Driver with Touch Panel Bias Supply
+          - skyworks,sky81452
+            # i2c serial eeprom  (24cxx)
+          - st,24c256
+            # Ambient Light Sensor with SMBUS/Two Wire Serial Interface
+          - taos,tsl2550
+            # 8-Channels, 12-bit ADC
+          - ti,ads7828
+            # 8-Channels, 8-bit ADC
+          - ti,ads7830
+            # Temperature Monitoring and Fan Control
+          - ti,amc6821
+            # I2C Touch-Screen Controller
+          - ti,tsc2003
+            # Low Power Digital Temperature Sensor with SMBUS/Two Wire Serial Interface
+          - ti,tmp102
+            # Low Power Digital Temperature Sensor with SMBUS/Two Wire Serial Interface
+          - ti,tmp103
+            # Digital Temperature Sensor
+          - ti,tmp275
+            # Winbond/Nuvoton H/W Monitor
+          - winbond,w83793
+            # i2c trusted platform module (TPM)
+          - winbond,wpct301
+
+required:
+  - compatible
+  - reg
+
+...
-- 
2.17.1

