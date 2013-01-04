Return-Path: <jjo.braun@gmail.com>
Received: from mail-ia0-f173.google.com (mail-ia0-f173.google.com
 [209.85.210.173])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id F37F02C0086
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Jan 2013 18:50:07 +1100 (EST)
Received: by mail-ia0-f173.google.com with SMTP id w21so13584033iac.32
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 03 Jan 2013 23:50:04 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20130103151106.04e1ae94@crub>
References: <CADwvPCve5GaRZZXuLUq4Es2FLN8AxtbRP4TQP7gQVRXoMw3S0g@mail.gmail.com>
 <20130103151106.04e1ae94@crub>
Date: Fri, 4 Jan 2013 08:50:03 +0100
Message-ID: <CADwvPCuw7p+O6bXtAoR=6yK9UgBR4JV58f+4s42KMDsvQ-dB6w@mail.gmail.com>
Subject: Re: tqm5200s i2c bus timeout
From: Johannes Braun <jjo.braun@gmail.com>
To: Anatolij Gustschin <agust@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> This is expected since you didn't add sub-nodes for your i2c devices
> 24c32a and PCF8563 in the i2c adapter node.

Ok this was the issue.

>> Is there something wrong with my dtb file or is it a bug in the mpc-i2c driver
>
> It is an issue with our dtb file. Please look at the I2C eeprom
> sub-node in the arch/powerpc/boot/dts/mpc5121ads.dts file and at
> the pcf8563 RTC sub-node in the arch/powerpc/boot/dts/mucmc52.dts
> file for an example how to add needed nodes for your devices.

According to the two examples, I added the subnodes to both i2c nodes.
Now I can see the rtc clock and the eeproms in /sys/..
# root@generic-powerpc:/sys/bus/i2c/devices# ls
# 0-0050  1-0050  1-0051  i2c-0   i2c-1

Now the i2c section in my dtb file looks as follows:
i2c@3d00 {
   #address-cells = <1>;
   #size-cells = <0>;
   compatible = "fsl,mpc5200-i2c","fsl-i2c";
   reg = <0x3d00 0x00>;
   interrupts = <2 15 0>;

   eeprom@50 {
      compatible = "at,24c32";
      reg = <0x50>;
   };
};

i2c@3d40 {
   #address-cells = <1>;
   #size-cells = <0>;
   compatible = "fsl,mpc5200-i2c","fsl-i2c";
   reg = <0x3d40 0x40>;
   interrupts = <2 16 0>;

   eeprom@50 {
      compatible = "at,24c32";
      reg = <0x50>;
   };

   rtc@51 {
      compatible = "pcf8563";
      reg = <0x51>;
   };
};


The good thing is that I can see all the devices now. Also the driver
for the rtc clock is loading. But the time can`t be read through the
registered rtc0 device. This is the kernel log. But I think this is a
driver issue and I should have a look inside the driver.

[    1.483761] rtc-pcf8563 1-0051: chip found, driver version 0.4.3
[    1.490382] rtc-pcf8563 1-0051: pcf8563_get_datetime: read error
[    1.497478] rtc-pcf8563 1-0051: rtc core: registered rtc-pcf8563 as rtc0
...
...
[    1.536540] rtc-pcf8563 1-0051: pcf8563_get_datetime: read error
[    1.542759] rtc-pcf8563 1-0051: hctosys: unable to read the hardware clock


Thanks,
Johannes
