Return-Path: <rdunlap@xenotime.net>
Received: from oproxy3-pub.bluehost.com (oproxy3-pub.bluehost.com [69.89.21.8])
 by ozlabs.org (Postfix) with SMTP id EFF181007D7
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Dec 2011 06:07:24 +1100 (EST)
Message-ID: <0b83a8b65ef53f7892e639c89667af1b.squirrel@xenotime.net>
In-Reply-To: <4EE19DA0.5010705@goop.org>
References: <20111209012746.GC20353@thor.bakeyournoodle.com>
 <4EE19DA0.5010705@goop.org>
Date: Fri, 9 Dec 2011 11:00:00 -0800
Subject: Re: linux-next bad Kconfig for drivers/hid
From: "Randy Dunlap" <rdunlap@xenotime.net>
To: "Jeremy Fitzhardinge" <jeremy@goop.org>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Cc: Jiri Kosina <jkosina@suse.cz>, LinuxPPC-dev <linuxppc-dev@lists.ozlabs.org>,
 Linux Kernel ML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Thu, December 8, 2011 9:33 pm, Jeremy Fitzhardinge wrote:
> On 12/08/2011 05:27 PM, Tony Breeds wrote:
>> Commit 4f5ca836bef3 (HID: hid-input: add support for HID devices
>> reporting Battery Strength) went into linux-next on Dec 1st since then a
>> ppc6xx_defconfig has been failing with:
>>
>> ---
>> drivers/built-in.o: In function `hidinput_cleanup_battery':
>> /scratch/tony/working/drivers/hid/hid-input.c:351: undefined reference
>> to `power_supply_unregister'
>> drivers/built-in.o: In function `hidinput_setup_battery':
>> /scratch/tony/working/drivers/hid/hid-input.c:338: undefined reference
>> to `power_supply_register'
>> make[1]: *** [.tmp_vmlinux1] Error 1
>> ---
>>
>> http://kisskb.ellerman.id.au/kisskb/buildresult/5012563/
>> vs
>> http://kisskb.ellerman.id.au/kisskb/buildresult/5017366/
>>
>> The defconfig in question doens't mention either option
>> (CONFIG_POWER_SUPPLY or CONFIG_HID_BATTERY_STRENGTH) and kbuild is
>> genertaing
>> CONFIG_HID_BATTERY_STRENGTH=y
>> CONFIG_POWER_SUPPLY=m
>> which clearly isn't going to work.
>>
>> The following change to HID_BATTERY_STRENGTH Kconfig "works" but seems a
>> little gross.
>>
>> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
>> index 5ed64f6..d2a94e6 100644
>> --- a/drivers/hid/Kconfig
>> +++ b/drivers/hid/Kconfig
>> @@ -33,7 +33,7 @@ config HID
>>
>>  config HID_BATTERY_STRENGTH
>>         bool
>> -       depends on POWER_SUPPLY
>> +       depends on POWER_SUPPLY=y
>>         default y
>>
>>  config HIDRAW
>>
>> Any chance we can get a fix into linux-next?
>
> Hm.  How about making it "depends on HID && POWER_SUPPLY"?  I think that
> would needlessly disable it if HID is also modular, but I'm not sure how
> to fix that.  "depends on HID && POWER_SUPPLY && HID == POWER_SUPPLY"?

The last suggestion looks good to me.

-- 
~Randy
