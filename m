Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-03.arcor-online.net (mail-in-03.arcor-online.net
	[151.189.21.43])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2FEB9DDEDB
	for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2007 16:32:17 +1000 (EST)
In-Reply-To: <17993.20745.432703.238649@cargo.ozlabs.ibm.com>
References: <20070514163219.9d78cde0.sfr@canb.auug.org.au>
	<17993.20745.432703.238649@cargo.ozlabs.ibm.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <e1629d824068540e703ba7d661753992@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] [POWERPC] remove build warnings in windfarm_core
Date: Tue, 15 May 2007 08:32:08 +0200
To: Paul Mackerras <paulus@samba.org>
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> -	device_create_file(&wf_platform_device.dev, &new_ct->attr);
>> +	ret = device_create_file(&wf_platform_device.dev, &new_ct->attr);
>> +	if (ret) {
>> +		list_del(&new_ct->link);
>> +		printk(KERN_WARNING "windfarm: device_creat_file failed"
>> +			"for %s\n", new_ct->name);
>> +		goto out_unlock;
>
> This shows up why I hate the must_check stuff.  The sysfs files are
> not essential for the operation of the windfarm subsystem.

They are essential for the user expectations of the
subsystem though; if registration fails, a warning
should be printed.

> If the
> sysfs registration fails for any reason, we now have a completely
> non-functional windfarm subsystem instead of a mostly-working one. :(

Yeah, but that's not must_check's fault, it doesn't
say *what* to do with the error code :-)


Segher
