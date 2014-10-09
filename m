Return-Path: <linux@roeck-us.net>
Received: from bh-25.webhostbox.net (bh-25.webhostbox.net [208.91.199.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3B2B91A1684
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Oct 2014 00:25:31 +1100 (EST)
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
 (envelope-from <linux@roeck-us.net>) id 1XcDii-000izA-1w
 for linuxppc-dev@lists.ozlabs.org; Thu, 09 Oct 2014 13:25:28 +0000
Message-ID: <54368C7D.5040402@roeck-us.net>
Date: Thu, 09 Oct 2014 06:24:13 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 03/44] hibernate: Call have_kernel_poweroff instead of
 checking pm_power_off
References: <1412659726-29957-1-git-send-email-linux@roeck-us.net>
 <1412659726-29957-4-git-send-email-linux@roeck-us.net>
 <20141009103254.GB6787@amd>
In-Reply-To: <20141009103254.GB6787@amd>
Content-Type: text/plain; charset=windows-1252; format=flowed
Cc: linux-m32r-ja@ml.linux-m32r.org, linux-mips@linux-mips.org,
 linux-efi@vger.kernel.org, linux-ia64@vger.kernel.org,
 Len Brown <len.brown@intel.com>, linux-xtensa@linux-xtensa.org,
 devel@driverdev.osuosl.org, linux-s390@vger.kernel.org,
 lguest@lists.ozlabs.org, linux-c6x-dev@linux-c6x.org,
 linux-hexagon@vger.kernel.org, linux-sh@vger.kernel.org,
 linux-acpi@vger.kernel.org, xen-devel@lists.xenproject.org,
 devicetree@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
 linux-pm@vger.kernel.org, adi-buildroot-devel@lists.sourceforge.net,
 linux-m68k@lists.linux-m68k.org, linux-am33-list@redhat.com,
 linux-tegra@vger.kernel.org, openipmi-developer@lists.sourceforge.net,
 linux-metag@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-parisc@vger.kernel.org, linux-cris-kernel@axis.com,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org,
 linux-alpha@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/09/2014 03:32 AM, Pavel Machek wrote:
> On Mon 2014-10-06 22:28:05, Guenter Roeck wrote:
>> Poweroff handlers may now be installed with register_poweroff_handler.
>> Use the new API function have_kernel_poweroff to determine if a poweroff
>> handler has been installed.
>>
>> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
>> Cc: Pavel Machek <pavel@ucw.cz>
>> Cc: Len Brown <len.brown@intel.com>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>>   kernel/power/hibernate.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
>> index a9dfa79..20353c5 100644
>> --- a/kernel/power/hibernate.c
>> +++ b/kernel/power/hibernate.c
>> @@ -602,7 +602,7 @@ static void power_down(void)
>>   	case HIBERNATION_PLATFORM:
>>   		hibernation_platform_enter();
>>   	case HIBERNATION_SHUTDOWN:
>> -		if (pm_power_off)
>> +		if (have_kernel_poweroff())
>>   			kernel_power_off();
>>   		break;
>
> poweroff -> power_off.
>
As mentioned in my other reply, that was on purpose to distinguish
existing functions from poweroff handler functions.

> But if you are playing with this, anyway... does it make sense to
> introduce kernel_power_off() that just works, no need to check
> have_..?
> 									Pavel

I am trying not to change existing behavior.

kernel_power_off is an existing function which does some cleanup
before calling machine_power_off which in turn calls do_kernel_poweroff
(or currently pm_power_off and may do some other machine specific stuff.

Sure, poweroff handling could be unified further. We could decide to
enter an endless loop if machine_power_off() returns, or we could decide
to dump a warning or panic in this case. But that is all separate from
the issue I am trying to solve here, which is to provide a capability to
register more than one poweroff handler. It would also not be that simple,
since some architectures call machine_power_off() directly from various
places.

Guenter
