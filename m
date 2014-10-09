Return-Path: <linux@roeck-us.net>
Received: from bh-25.webhostbox.net (bh-25.webhostbox.net [208.91.199.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F0FD91A0AA4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Oct 2014 00:26:53 +1100 (EST)
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
 (envelope-from <linux@roeck-us.net>) id 1XcDk4-000kwV-6q
 for linuxppc-dev@lists.ozlabs.org; Thu, 09 Oct 2014 13:26:52 +0000
Message-ID: <54368D16.40404@roeck-us.net>
Date: Thu, 09 Oct 2014 06:26:46 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Lee Jones <lee.jones@linaro.org>,
 Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 12/44] mfd: ab8500-sysctrl: Register with kernel poweroff
 handler
References: <1412659726-29957-1-git-send-email-linux@roeck-us.net>
 <1412659726-29957-13-git-send-email-linux@roeck-us.net>
 <20141007080048.GB25331@lee--X1>
 <20141009103656.GF17836@e104818-lin.cambridge.arm.com>
 <20141009104927.GN20647@lee--X1>
In-Reply-To: <20141009104927.GN20647@lee--X1>
Content-Type: text/plain; charset=utf-8; format=flowed
Cc: "linux-m32r-ja@ml.linux-m32r.org" <linux-m32r-ja@ml.linux-m32r.org>,
 "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
 "linux-m68k@vger.kernel.org" <linux-m68k@vger.kernel.org>,
 "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
 "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
 "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
 "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
 "lguest@lists.ozlabs.org" <lguest@lists.ozlabs.org>,
 "linux-c6x-dev@linux-c6x.org" <linux-c6x-dev@linux-c6x.org>,
 "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>,
 "user-mode-linux-devel@lists.sourceforge.net"
 <user-mode-linux-devel@lists.sourceforge.net>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "adi-buildroot-devel@lists.sourceforge.net"
 <adi-buildroot-devel@lists.sourceforge.net>,
 "linux-am33-list@redhat.com" <linux-am33-list@redhat.com>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
 "openipmi-developer@lists.sourceforge.net"
 <openipmi-developer@lists.sourceforge.net>,
 "linux-metag@vger.kernel.org" <linux-metag@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Samuel Ortiz <sameo@linux.intel.com>,
 "linux-cris-kernel@axis.com" <linux-cris-kernel@axis.com>,
 "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/09/2014 03:49 AM, Lee Jones wrote:
> On Thu, 09 Oct 2014, Catalin Marinas wrote:
>
>> On Tue, Oct 07, 2014 at 09:00:48AM +0100, Lee Jones wrote:
>>> On Mon, 06 Oct 2014, Guenter Roeck wrote:
>>>> --- a/drivers/mfd/ab8500-sysctrl.c
>>>> +++ b/drivers/mfd/ab8500-sysctrl.c
>>>> @@ -6,6 +6,7 @@
>>>
>>> [...]
>>>
>>>> +static int ab8500_power_off(struct notifier_block *this, unsigned long unused1,
>>>> +			    void *unused2)
>>>>   {
>>>>   	sigset_t old;
>>>>   	sigset_t all;
>>>> @@ -34,11 +36,6 @@ static void ab8500_power_off(void)
>>>>   	struct power_supply *psy;
>>>>   	int ret;
>>>>
>>>> -	if (sysctrl_dev == NULL) {
>>>> -		pr_err("%s: sysctrl not initialized\n", __func__);
>>>> -		return;
>>>> -	}
>>>
>>> Can you explain the purpose of this change please?
>>
>> I guess it's because the sysctrl_dev is already initialised when
>> registering the power_off handler, so there isn't a way to call the
>> above function with a NULL sysctrl_dev. Probably even with the original
>> code you didn't need this check (after some race fix in
>> ab8500_sysctrl_remove but races is one of the things Guenter's patches
>> try to address).
>
> Sounds reasonable, although I think this change should be part of
> another patch.
>
Sure, no problem. I'll split this into two patches.

Since we are at it, any idea what to do with the restart function
in the same file ? It is not used anywhere.

Guenter
