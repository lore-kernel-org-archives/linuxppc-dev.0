Return-Path: <gary@mlbassoc.com>
Message-ID: <48BDB68E.8040806@mlbassoc.com>
Date: Tue, 02 Sep 2008 15:56:30 -0600
From: Gary Thomas <gary@mlbassoc.com>
MIME-Version: 1.0
To: Linuxppc-dev@ozlabs.org
Subject: DTS question
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Following on with my RTC problem, I cut&pasted this from
the TQM5200 dts file:
                 i2c@3d40 {
                         #address-cells = <1>;
                         #size-cells = <0>;
                         compatible = "fsl,mpc5200-i2c","fsl-i2c";
                         reg = <0x3d40 0x40>;
                         interrupts = <2 16 0>;
                         interrupt-parent = <&mpc5200_pic>;
                         fsl5200-clocking;

                          rtc@68 {
                                 device_type = "rtc";
                                 compatible = "dallas,ds1307";
                                 reg = <0x68>;
                         };
                 };

However, the dts file I started with had this (*mine*):
		i2c@3d40 {
			#address-cells = <1>;
			#size-cells = <0>;
			compatible = "fsl,mpc5200-i2c","fsl-i2c";
			cell-index = <1>;
			reg = <3d40 40>;
			interrupts = <2 10 0>;
			interrupt-parent = <&mpc5200_pic>;
			fsl5200-clocking;
		};

Notice the different mix of hex (0xNNN) and implied hex values.
This is really confusing to me.  Even more so when I added the
RTC snippet cut directly from the TQM5200 file:

                          rtc@68 {
                                 device_type = "rtc";
                                 compatible = "dallas,ds1307";
                                 reg = <0x68>;
                         };

This yielded a syntax error when merged with my platform dts.
When I changed the 'reg=<0x68>' to 'reg=<68>', the syntax error
went away & it worked perfectly.

What gives?  Why is explicit hex sometimes an error and sometimes not?
Is the format of this file documented anywhere (I've not found it)?

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------
