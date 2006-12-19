Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-12.arcor-online.net (mail-in-12.arcor-online.net
	[151.189.21.52])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id F25A7DDEC3
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Dec 2006 04:49:10 +1100 (EST)
In-Reply-To: <200612182323.11262.arnd@arndb.de>
References: <20061218163846.337fed65@localhost>
	<20061218164229.6a8b0df7@localhost>
	<A45F8443-A031-41AC-887C-669FABBE0F09@kernel.crashing.org>
	<200612182323.11262.arnd@arndb.de>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <8AE62F56-5166-4701-AFF0-04D901EB6FD6@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [patch 0/1] ipmi: update: add autosensing of ipmi devices on
	powerpc using of device tree
Date: Tue, 19 Dec 2006 18:48:58 +0100
To: Arnd Bergmann <arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, openipmi-developer@lists.sourceforge.net,
	Christian Krafft <krafft@linux.vnet.ibm.com>,
	Paul Mackerras <paulus@samba.org>, Christian Krafft <krafft@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>> +     regsize = get_property(np, "reg-size", NULL);
>>> +     regspacing = get_property(np, "reg-spacing", NULL);
>>> +     regshift = get_property(np, "reg-shift", NULL);
>>
>> You should check whether you get exactly 4 bytes back or not.
>>
>>> +     if (!regsize)
>>> +             info->io.regsize = DEFAULT_REGSPACING;
>>> +     else
>>> +             info->io.regsize = *regsize;
>>
>> info->io_regsize = regsize ? *regsize : DEFAULT_REGSIZE;
>>
>> [Please note that fixes a copy/paste bug, too].
>
> These two changes are contradictory.

No they're not.  If you don't get exactly 4 bytes back, you have
to fail the device, since you don't know how to handle it.  If
on the other hand you don't have the property at all, you use
the default value.

>>> +static int ipmi_of_remove(struct of_device *dev)
>>> +{
>>> +     /* should call
>>> +      * cleanup_one_si(dev->dev.driver_data); */
>>
>> So fix that :-)
>
> That should be a separate patch that fixes the same thing for
> pci ipmi devices as well. It needs to move code around for this
> (or introduce forward declarations), and the effect is no
> different, so it's really just a cleanup.

Oh, this is broken in the existing stuff as well?  Never mind then.

>>> +static struct of_device_id ipmi_match[] =
>>> +{
>>> +     { .type = "ipmi", .compatible = "ipmi-kcs",  .data = (void*)
>>> SI_KCS },
>>> +     { .type = "ipmi", .compatible = "ipmi-smic", .data = (void*)
>>> SI_SMIC },
>>> +     { .type = "ipmi", .compatible = "ipmi-bt",   .data = (void*) 
>>> SI_BT },
>>
>> That cast-to-pointer is what gives you that warning when
>> casting back.  Is there no better solution?
>
> The one alternative might be something more complicated like:
>
> static const enum si_type __devinitdata of_ipmi_dev_info[] = {
> 	[SI_KCS] SI_KCS,
> 	[SI_SMIC] SI_SMIC,
> 	[SI_BT] SI_BT,
> };
>
> static const struct of_device_id of_ipmi_match[] = {
> 	{ .type = "ipmi", .compatible = "ipmi-kcs",  .data =  
> &of_ipmi_dev_info[SI_KCS] },
> 	{ .type = "ipmi", .compatible = "ipmi-kcs",  .data =  
> &of_ipmi_dev_info[SI_SMIC] },
> 	{ .type = "ipmi", .compatible = "ipmi-kcs",  .data =  
> &of_ipmi_dev_info[SI_BT] },
> };
>
> Not sure if that's worth it.

Yeah, I don't think so either.  Maybe we should have some macro's
though that hide the casts (and make them right!), this stuff is
(ab)used a lot in Linux (and everyone gets it wrong always).

Any way around, the cast in this driver needs fixing.


Segher
