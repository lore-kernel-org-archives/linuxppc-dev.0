Return-Path: <groeck7@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41P3Zv2sW6zDqyp
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Jul 2018 08:50:30 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id b17-v6so12247495pfi.0
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 08 Jul 2018 15:50:30 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH v4 3/3] hwmon: Document the sensor enable attribute
To: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org, ego@linux.vnet.ibm.com
References: <1530878166-12589-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <1530878166-12589-4-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <7f9c672a-ae52-0bb3-8820-22049c445a4e@roeck-us.net>
Date: Sun, 8 Jul 2018 15:50:26 -0700
MIME-Version: 1.0
In-Reply-To: <1530878166-12589-4-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/06/2018 04:56 AM, Shilpasri G Bhat wrote:
> Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>

Applied to hwmon-next, after updating the commit description.
I also removed the text "This attribute can be used as per-sensor or
per-sub-group attribute depending on what is supported by the hardware."
from the attribute descriptions; this is an implementation detail
which should be described in driver documentations.

Thanks,
Guenter

> ---
>   Documentation/hwmon/sysfs-interface | 62 +++++++++++++++++++++++++++++++++++++
>   1 file changed, 62 insertions(+)
> 
> diff --git a/Documentation/hwmon/sysfs-interface b/Documentation/hwmon/sysfs-interface
> index fc337c3..f865dd7 100644
> --- a/Documentation/hwmon/sysfs-interface
> +++ b/Documentation/hwmon/sysfs-interface
> @@ -171,6 +171,15 @@ in[0-*]_label	Suggested voltage channel label.
>   		user-space.
>   		RO
>   
> +in[0-*]_enable
> +		Enable or disable the sensors.
> +		When disabled the sensor read will return -ENODATA. This
> +		attribute can be used as per-sensor or per-sub-group attribute
> +		depending on what is supported by the hardware.
> +		1: Enable
> +		0: Disable
> +		RW
> +
>   cpu[0-*]_vid	CPU core reference voltage.
>   		Unit: millivolt
>   		RO
> @@ -236,6 +245,15 @@ fan[1-*]_label	Suggested fan channel label.
>   		In all other cases, the label is provided by user-space.
>   		RO
>   
> +fan[1-*]_enable
> +		Enable or disable the sensors.
> +		When disabled the sensor read will return -ENODATA. This
> +		attribute can be used as per-sensor or per-sub-group attribute
> +		depending on what is supported by the hardware.
> +		1: Enable
> +		0: Disable
> +		RW
> +
>   Also see the Alarms section for status flags associated with fans.
>   
>   
> @@ -409,6 +427,15 @@ temp_reset_history
>   		Reset temp_lowest and temp_highest for all sensors
>   		WO
>   
> +temp[1-*]_enable
> +		Enable or disable the sensors.
> +		When disabled the sensor read will return -ENODATA. This
> +		attribute can be used as per-sensor or per-sub-group attribute
> +		depending on what is supported by the hardware.
> +		1: Enable
> +		0: Disable
> +		RW
> +
>   Some chips measure temperature using external thermistors and an ADC, and
>   report the temperature measurement as a voltage. Converting this voltage
>   back to a temperature (or the other way around for limits) requires
> @@ -468,6 +495,15 @@ curr_reset_history
>   		Reset currX_lowest and currX_highest for all sensors
>   		WO
>   
> +curr[1-*]_enable
> +		Enable or disable the sensors.
> +		When disabled the sensor read will return -ENODATA. This
> +		attribute can be used as per-sensor or per-sub-group attribute
> +		depending on what is supported by the hardware.
> +		1: Enable
> +		0: Disable
> +		RW
> +
>   Also see the Alarms section for status flags associated with currents.
>   
>   *********
> @@ -566,6 +602,15 @@ power[1-*]_crit			Critical maximum power.
>   				Unit: microWatt
>   				RW
>   
> +power[1-*]_enable		Enable or disable the sensors.
> +				When disabled the sensor read will return
> +				-ENODATA. This attribute can be used as
> +				per-sensor or per-sub-group attribute depending
> +				on what is supported by the hardware.
> +				1: Enable
> +				0: Disable
> +				RW
> +
>   Also see the Alarms section for status flags associated with power readings.
>   
>   **********
> @@ -576,6 +621,14 @@ energy[1-*]_input		Cumulative energy use
>   				Unit: microJoule
>   				RO
>   
> +energy[1-*]_enable		Enable or disable the sensors.
> +				When disabled the sensor read will return
> +				-ENODATA. This attribute can be used as
> +				per-sensor or per-sub-group attribute depending
> +				on what is supported by the hardware.
> +				1: Enable
> +				0: Disable
> +				RW
>   
>   ************
>   * Humidity *
> @@ -586,6 +639,15 @@ humidity[1-*]_input		Humidity
>   				RO
>   
>   
> +humidity[1-*]_enable		Enable or disable the sensors
> +				When disabled the sensor read will return
> +				-ENODATA. This attribute can be used as
> +				per-sensor or per-sub-group attribute depending
> +				on what is supported by the hardware.
> +				1: Enable
> +				0: Disable
> +				RW
> +
>   **********
>   * Alarms *
>   **********
> 
