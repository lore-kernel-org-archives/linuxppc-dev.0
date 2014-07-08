Return-Path: <linux@roeck-us.net>
Received: from mail.active-venture.com (mail.active-venture.com
 [67.228.131.205])
 by lists.ozlabs.org (Postfix) with ESMTP id C6C3B1A00C1
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Jul 2014 23:34:46 +1000 (EST)
Message-ID: <53BBF373.6020703@roeck-us.net>
Date: Tue, 08 Jul 2014 06:34:43 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Neelesh Gupta <neelegup@linux.vnet.ibm.com>,
 devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 lm-sensors@lm-sensors.org
Subject: Re: [PATCH v5] powerpc/powernv: hwmon driver for power, fan rpm,
 voltage and temperature
References: <20140708090315.3866.15604.stgit@localhost.localdomain>
In-Reply-To: <20140708090315.3866.15604.stgit@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: sbhat@linux.vnet.ibm.com, jdelvare@suse.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/08/2014 02:08 AM, Neelesh Gupta wrote:
> This patch adds basic kernel support for reading power values, fan
> speed rpm, voltage and temperature data on powernv platforms which
> will be exported to user space through sysfs interface.
>
> Test results:
> -------------
> [root@tul163p1 ~]# sensors
> ibmpowernv-isa-0000
> Adapter: ISA adapter
> fan1:        5465 RPM  (min =    0 RPM)
> fan2:        5152 RPM  (min =    0 RPM)
> fan3:        5521 RPM  (min =    0 RPM)
> fan4:        4891 RPM  (min =    0 RPM)
> fan5:           0 RPM  (min =    0 RPM)
> fan6:           0 RPM  (min =    0 RPM)
> fan7:        7480 RPM  (min =    0 RPM)
> fan8:        7944 RPM  (min =    0 RPM)
> temp1:        +39.0°C  (high =  +0.0°C)
> power1:      190.00 W
>
> [root@tul163p1 ~]# ls /sys/devices/platform/
> alarmtimer  ibmpowernv.0  power  rtc-generic  serial8250  uevent
> [root@tul163p1 ~]# ls /sys/devices/platform/ibmpowernv.0/hwmon/hwmon0/
> device	    fan2_min	fan4_min    fan6_min	fan8_min   power
> fan1_fault  fan3_fault	fan5_fault  fan7_fault	in1_fault  power1_input
> fan1_input  fan3_input	fan5_input  fan7_input	in2_fault  subsystem
> fan1_min    fan3_min	fan5_min    fan7_min	in3_fault  temp1_input
> fan2_fault  fan4_fault	fan6_fault  fan8_fault	in4_fault  temp1_max
> fan2_input  fan4_input	fan6_input  fan8_input	name	   uevent
> [root@tul163p1 ~]# ls /sys/class/hwmon/hwmon0/
> device	    fan2_min	fan4_min    fan6_min	fan8_min   power
> fan1_fault  fan3_fault	fan5_fault  fan7_fault	in1_fault  power1_input
> fan1_input  fan3_input	fan5_input  fan7_input	in2_fault  subsystem
> fan1_min    fan3_min	fan5_min    fan7_min	in3_fault  temp1_input
> fan2_fault  fan4_fault	fan6_fault  fan8_fault	in4_fault  temp1_max
> fan2_input  fan4_input	fan6_input  fan8_input	name	   uevent
> [root@tul163p1 ~]#
>
> Signed-off-by: Neelesh Gupta <neelegup@linux.vnet.ibm.com>

Applied to -next, with a minor cleanup.

Thanks for your patience,

Guenter


> diff --git a/Documentation/hwmon/ibmpowernv b/Documentation/hwmon/ibmpowernv
> new file mode 100644
> index 0000000..644245a
> --- /dev/null
> +++ b/Documentation/hwmon/ibmpowernv
> @@ -0,0 +1,41 @@
> +Kernel Driver IBMPOWENV

s/IBMPOWENV/IBMPOWERNV/
