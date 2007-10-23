Return-Path: <jonsmirl@gmail.com>
Message-ID: <9e4733910710221859q6ea54810nba58907d5ddd966d@mail.gmail.com>
Date: Mon, 22 Oct 2007 21:59:00 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "PowerPC dev list" <Linuxppc-dev@ozlabs.org>
Subject: Audio codec device tree entries
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Is this what the device tree entries should look like?

First example is ac97 audio:

ac97@2000 {           // PSC1
      device_type = "sound";
      compatible = "mpc5200b-psc-ac97\0mpc5200-psc-ac97";
      cell-index = <0>;
      reg = <2000 100>;
      interrupts = <2 1 0>;
      interrupt-parent = <&mpc5200_pic>;
      codec-handle = <&codec0>
};

pseudo-sound@0 { // use to trigger loading platform specific fabric driver
      device_type = "pseudo-sound"
};

codec0:codec@0 {
      device_type = "codec"
      compatible = "stac9766\0ac97"
};

Second is i2s/i2c connected:
How do I link this to the i2c bus?

i2s@2000 {           // PSC1
      device_type = "sound";
      compatible = "mpc5200b-psc-i2s\0mpc5200-psc-i2s";
      cell-index = <0>;
      reg = <2000 100>;
      interrupts = <2 1 0>;
      interrupt-parent = <&mpc5200_pic>;
      codec-handle = <&codec0>
};

i2c@3d00 {
      device_type = "i2c";
      compatible = "mpc5200b-i2c\0mpc5200-i2c\0fsl-i2c";
      cell-index = <0>;
      reg = <3d00 40>;
      interrupts = <2 f 0>;
      interrupt-parent = <&mpc5200_pic>;
      fsl5200-clocking;
};

pseudo-sound@0 { // use to trigger loading platform specific fabric driver
      device_type = "pseudo-sound"
};

codec0:codec@0 {
      device_type = "codec"
      compatible = "tas5508"
};





-- 
Jon Smirl
jonsmirl@gmail.com
