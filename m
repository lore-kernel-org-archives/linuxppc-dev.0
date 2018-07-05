Return-Path: <groeck7@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41M1zg10QZzF1Ry
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Jul 2018 01:31:26 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id e10-v6so5756336pfn.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Jul 2018 08:31:26 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH v3 3/3] hwmon: Document the sensor enable attribute and
 update ibmpowernv
To: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org, ego@linux.vnet.ibm.com
References: <1530798689-27742-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <1530798689-27742-4-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <4355fd2a-8cd1-ffff-e308-dcd621baad53@roeck-us.net>
Date: Thu, 5 Jul 2018 08:31:23 -0700
MIME-Version: 1.0
In-Reply-To: <1530798689-27742-4-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/05/2018 06:51 AM, Shilpasri G Bhat wrote:
> Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
> ---
>   Documentation/hwmon/ibmpowernv      | 35 +++++++++++++++-
>   Documentation/hwmon/sysfs-interface | 82 +++++++++++++++++++++++++++++++++++++

I guess I wasn't specific enough. The sysfs ABI change must be a separate patch,
independent of the driver (and driver documentation) changes. If you want to document
the driver changes with the same patch as the driver or in a separate patch is up
to you, but I'll want the ABI changes in a separate patch.

Guenter

>   2 files changed, 115 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/hwmon/ibmpowernv b/Documentation/hwmon/ibmpowernv
> index 8826ba2..77ddba7 100644
> --- a/Documentation/hwmon/ibmpowernv
> +++ b/Documentation/hwmon/ibmpowernv
> @@ -33,9 +33,40 @@ fanX_input		Measured RPM value.
>   fanX_min		Threshold RPM for alert generation.
>   fanX_fault		0: No fail condition
>   			1: Failing fan
> +
>   tempX_input		Measured ambient temperature.
>   tempX_max		Threshold ambient temperature for alert generation.
> -inX_input		Measured power supply voltage
> +tempX_highest		Historical maximum temperature
> +tempX_lowest		Historical minimum temperature
> +temp1_enable		Enable/disable all temperature sensors
> +			1: Enable
> +			0: Disable
> +temp[2-N]_enable	State of the sensor (enabled/disabled)
> +
> +inX_input		Measured power supply voltage (millivolt)
>   inX_fault		0: No fail condition.
>   			1: Failing power supply.
> -power1_input		System power consumption (microWatt)
> +inX_highest		Historical maximum voltage
> +inX_lowest		Historical minimum voltage
> +in1_enable		Enable/disable all voltage sensors
> +			1: Enable
> +			0: Disable
> +in[2-N]_enable		State of the sensor (enabled/disabled)
> +
> +powerX_input		Power consumption (microWatt)
> +powerX_input_highest	Historical maximum power
> +powerX_input_lowest	Historical minimum power
> +power1_enable		Enable/disable all power sensors
> +			1: Enable
> +			0: Disable
> +power[2-N]_enable	State of the sensor (enabled/disabled)
> +
> +currX_input		Measured current (milliampere)
> +currX_highest		Historical maximum current
> +currX_lowest		Historical minimum current
> +curr1_enable		Enable/disable all current sensors
> +			1: Enable
> +			0: Disable
> +curr[2-N]_enable	State of the sensor (enabled/disabled)
> +
> +energyX_input		Cumulative energy (microJoule)
> diff --git a/Documentation/hwmon/sysfs-interface b/Documentation/hwmon/sysfs-interface
> index fc337c3..d81109c 100644
> --- a/Documentation/hwmon/sysfs-interface
> +++ b/Documentation/hwmon/sysfs-interface
> @@ -171,6 +171,17 @@ in[0-*]_label	Suggested voltage channel label.
>   		user-space.
>   		RO
>   
> +in[0-*]_enable
> +		Enable or disable the sensor.
> +		When disabled the sensor read will return -ENODATA. For chips
> +		which do not have the capability to disable/enable single sensor
> +		but have support for sensor-group disable/enable, will only have
> +		the first attribute with write permission. In such cases write
> +		to the first attribute will affect all the sensors of this type.
> +		1: Enable
> +		0: Disable
> +		RW/RO
> +
>   cpu[0-*]_vid	CPU core reference voltage.
>   		Unit: millivolt
>   		RO
> @@ -236,6 +247,17 @@ fan[1-*]_label	Suggested fan channel label.
>   		In all other cases, the label is provided by user-space.
>   		RO
>   
> +fan[1-*]_enable
> +		Enable or disable the sensor.
> +		When disabled the sensor read will return -ENODATA. For chips
> +		which do not have the capability to disable/enable single sensor
> +		but have support for sensor-group disable/enable, will only have
> +		the first attribute with write permission. In such cases write
> +		to the first attribute will affect all the sensors of this type.
> +		1: Enable
> +		0: Disable
> +		RW/RO
> +
>   Also see the Alarms section for status flags associated with fans.
>   
>   
> @@ -409,6 +431,17 @@ temp_reset_history
>   		Reset temp_lowest and temp_highest for all sensors
>   		WO
>   
> +temp[1-*]_enable
> +		Enable or disable the sensor.
> +		When disabled the sensor read will return -ENODATA. For chips
> +		which do not have the capability to disable/enable single sensor
> +		but have support for sensor-group disable/enable, will only have
> +		the first attribute with write permission. In such cases write
> +		to the first attribute will affect all the sensors of this type.
> +		1: Enable
> +		0: Disable
> +		RW/RO
> +
>   Some chips measure temperature using external thermistors and an ADC, and
>   report the temperature measurement as a voltage. Converting this voltage
>   back to a temperature (or the other way around for limits) requires
> @@ -468,6 +501,17 @@ curr_reset_history
>   		Reset currX_lowest and currX_highest for all sensors
>   		WO
>   
> +curr[1-*]_enable
> +		Enable or disable the sensor.
> +		When disabled the sensor read will return -ENODATA. For chips
> +		which do not have the capability to disable/enable single sensor
> +		but have support for sensor-group disable/enable, will only have
> +		the first attribute with write permission. In such cases write
> +		to the first attribute will affect all the sensors of this type.
> +		1: Enable
> +		0: Disable
> +		RW/RO
> +
>   Also see the Alarms section for status flags associated with currents.
>   
>   *********
> @@ -566,6 +610,19 @@ power[1-*]_crit			Critical maximum power.
>   				Unit: microWatt
>   				RW
>   
> +power[1-*]_enable		Enable or disable the sensor.
> +				When disabled the sensor read will return
> +				-ENODATA. For chips which do not have the
> +				capability to disable/enable single sensor but
> +				have support for sensor-group disable/enable,
> +				will only have the first attribute with write
> +				permission. In such cases write	to the first
> +				attribute will affect all the sensors of this
> +				type.
> +				1: Enable
> +				0: Disable
> +				RW/RO
> +
>   Also see the Alarms section for status flags associated with power readings.
>   
>   **********
> @@ -576,6 +633,18 @@ energy[1-*]_input		Cumulative energy use
>   				Unit: microJoule
>   				RO
>   
> +energy[1-*]_enable		Enable or disable the sensor.
> +				When disabled the sensor read will return
> +				-ENODATA. For chips which do not have the
> +				capability to disable/enable single sensor but
> +				have support for sensor-group disable/enable,
> +				will only have the first attribute with write
> +				permission. In such cases write	to the first
> +				attribute will affect all the sensors of this
> +				type.
> +				1: Enable
> +				0: Disable
> +				RW/RO
>   
>   ************
>   * Humidity *
> @@ -586,6 +655,19 @@ humidity[1-*]_input		Humidity
>   				RO
>   
>   
> +humidity[1-*]_enable		Enable or disable the sensor.
> +				When disabled the sensor read will return
> +				-ENODATA. For chips which do not have the
> +				capability to disable/enable single sensor but
> +				have support for sensor-group disable/enable,
> +				will only have the first attribute with write
> +				permission. In such cases write	to the first
> +				attribute will affect all the sensors of this
> +				type.
> +				1: Enable
> +				0: Disable
> +				RW/RO
> +
>   **********
>   * Alarms *
>   **********
> 
