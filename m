Return-Path: <aiyuanwang@yahoo.com>
Received: from web52904.mail.re2.yahoo.com (web52904.mail.re2.yahoo.com
	[206.190.49.14]) by ozlabs.org (Postfix) with SMTP id 6751BB6F0A
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  4 Jan 2010 10:15:08 +1100 (EST)
Message-ID: <892012.72702.qm@web52904.mail.re2.yahoo.com>
Date: Sun, 3 Jan 2010 15:15:06 -0800 (PST)
From: Allan Wang <aiyuanwang@yahoo.com>
Subject: /dev does not have the devices I have configured with initramfs as my
	root file system
To: linuxppc-dev@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1852684706-1262560506=:72702"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--0-1852684706-1262560506=:72702
Content-Type: text/plain; charset=us-ascii

Hello, All,

Happy New Year to everyone! 
I am running ppc440epx board which is similar Sequoia board. I have configured a I2C RTC device. From the console debug message, it is working, but I do not see /dev/rtc0 file. My kernel version is 2.6.30.4. I use initramfs as my root file system. Here is my initramfs.txt:
dir /dev 755 0 0
dir /bin 755 1000 1000
dir /proc 755 0 0
slink /bin/sh busybox 777 0 0
file /bin/busybox /home/awang/proj/linux-2.6.30.4/usr/busybox 755 0 0
dir /sys 755 0 0
dir /usr 755 0 0
dir /usr/bin 755 0 0
dir /usr/sbin 755 0 0
dir /sbin 755 0 0
dir /mnt 755 0 0
dir /etc 755 0 0
dir /var 755 0 0
file /init /home/awang/proj/linux-2.6.30.4/usr/init.sh 755 0 0

Here is my init.sh:

#!/bin/sh

/bin/busybox echo " "
/bin/busybox echo "Hello, I am alive!!!!"
busybox mkdir /mnt/flash
busybox mount -t proc /proc /proc
busybox mount -t sysfs none /sys
busybox mount -t jffs2 mtd2 /mnt/flash

busybox sleep  2
/bin/busybox --install -s
#start a shell
ifconfig eth0 192.168.0.201
/bin/sh


Here is my configurations:

RTC kernel configuration:

CONFIG_RTC_LIB=y
CONFIG_RTC_CLASS=y
CONFIG_RTC_HCTOSYS=y
CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
CONFIG_RTC_DEBUG=y

#
# RTC interfaces
#
CONFIG_RTC_INTF_SYSFS=y
CONFIG_RTC_INTF_PROC=y
CONFIG_RTC_INTF_DEV=y

dts configuration:

 IIC0: i2c@ef600700 {
                                #address-cells = <1>;
                                #size-cells = <0>;
                                compatible = "ibm,iic-440epx", "ibm,iic";
                                reg = <0xef600700 0x00000014>;
                                interrupt-parent = <&UIC0>;
                                interrupts = <0x2 0x4>;
                                rtc@68 {
                                        compatible = "stm,m41t80";
                                        reg = <0x68>;
                                };
                                eeprom0@50 {
                                        compatible = "eeprom";
                                        reg = <0x50>;
                                };
                                eeprom1@54 {
                                        compatible = "eeprom";
                                        reg = <0x54>;
                                };
                        };

The debug messages:

i2c /dev entries driver
rtc-m41t80 1-0068: chip found, driver version 0.05
rtc-m41t80 1-0068: rtc core: registered m41t80 as rtc0
ibm-iic 1ef600700.i2c: using standard (100 kHz) mode
TCP cubic registered
NET: Registered protocol family 17
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
TIPC: Activated (version 1.6.4 compiled Jan  3 2010 12:21:35)
NET: Registered protocol family 30
TIPC: Started in single node mode
rtc-m41t80 1-0068: setting system clock to 2010-01-03 19:43:06 UTC (1262547786)

I have struggled for a few days. Thank you very much.

Allan


      
--0-1852684706-1262560506=:72702
Content-Type: text/html; charset=us-ascii

<html><head><style type="text/css"><!-- DIV {margin:0px;} --></style></head><body><div style="font-family:lucida console,sans-serif;font-size:12pt">
<div style="font-family: lucida console,sans-serif; font-size: 12pt;"><div>Hello, All,<br><br>Happy New Year to everyone! <br>I am running ppc440epx board which is similar Sequoia board. I have configured a I2C RTC device. From the console debug message, it is working, but I do not see /dev/rtc0 file. My kernel version is 2.6.30.4. I use initramfs as my root file system. Here is my initramfs.txt:<br>dir /dev 755 0 0<br>dir /bin 755 1000 1000<br>dir /proc 755 0 0<br>slink /bin/sh busybox 777 0 0<br>file /bin/busybox /home/awang/proj/linux-2.6.30.4/usr/busybox 755 0 0<br>dir /sys 755 0 0<br>dir /usr 755 0 0<br>dir /usr/bin 755 0 0<br>dir /usr/sbin 755 0 0<br>dir /sbin 755 0 0<br>dir /mnt 755 0 0<br>dir /etc 755 0 0<br>dir /var 755 0 0<br>file /init /home/awang/proj/linux-2.6.30.4/usr/init.sh 755 0 0<br><br>Here is my <a target="_blank" href="http://init.sh">init.sh</a>:<br><br>#!/bin/sh<br><br>/bin/busybox echo "
 "<br>/bin/busybox echo "Hello, I am alive!!!!"<br>busybox mkdir /mnt/flash<br>busybox mount -t proc /proc /proc<br>busybox mount -t sysfs none /sys<br>busybox mount -t jffs2 mtd2 /mnt/flash<br><br>busybox sleep&nbsp; 2<br>/bin/busybox --install -s<br>#start a shell<br>ifconfig eth0 192.168.0.201<br>/bin/sh<br><br><br>Here is my configurations:<br><br>RTC kernel configuration:<br><br>CONFIG_RTC_LIB=y<br>CONFIG_RTC_CLASS=y<br>CONFIG_RTC_HCTOSYS=y<br>CONFIG_RTC_HCTOSYS_DEVICE="rtc0"<br>CONFIG_RTC_DEBUG=y<br><br>#<br># RTC interfaces<br>#<br>CONFIG_RTC_INTF_SYSFS=y<br>CONFIG_RTC_INTF_PROC=y<br>CONFIG_RTC_INTF_DEV=y<br><br>dts configuration:<br><br>&nbsp;IIC0: i2c@ef600700 {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #address-cells =
 &lt;1&gt;;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #size-cells = &lt;0&gt;;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; compatible = "ibm,iic-440epx", "ibm,iic";<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg = &lt;0xef600700 0x00000014&gt;;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; interrupt-parent =
 &lt;&amp;UIC0&gt;;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; interrupts = &lt;0x2 0x4&gt;;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rtc@68 {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; compatible = "stm,m41t80";<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg =
 &lt;0x68&gt;;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; };<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; eeprom0@50 {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; compatible = "eeprom";<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg =
 &lt;0x50&gt;;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; };<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; eeprom1@54 {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; compatible = "eeprom";<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg =
 &lt;0x54&gt;;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; };<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; };<br><br>The debug messages:<br><br>i2c /dev entries driver<br>rtc-m41t80 1-0068: chip found, driver version 0.05<br>rtc-m41t80 1-0068: rtc core: registered m41t80 as rtc0<br>ibm-iic 1ef600700.i2c: using standard (100 kHz) mode<br>TCP cubic registered<br>NET: Registered protocol family 17<br>RPC: Registered udp transport module.<br>RPC: Registered tcp transport module.<br>TIPC: Activated (version 1.6.4 compiled Jan&nbsp; 3 2010 12:21:35)<br>NET: Registered protocol family 30<br>TIPC: Started in single node mode<br>rtc-m41t80 1-0068: setting system clock to 2010-01-03 19:43:06 UTC (1262547786)<br><br>I have
 struggled for a few days. Thank you very much.<br><br>Allan<br><br><br><br><br><br>&nbsp; <br></div>

</div>
<!-- cg9.c2.mail.ac4.yahoo.com compressed/chunked Fri Jan  1 20:21:24 PST 2010 -->
</div><br>

      </body></html>
--0-1852684706-1262560506=:72702--
