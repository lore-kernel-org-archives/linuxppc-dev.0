Return-Path: <bsingharora@gmail.com>
Received: from mail-pa0-x231.google.com (mail-pa0-x231.google.com
 [IPv6:2607:f8b0:400e:c03::231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rvN9Z608JzDqPH
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jul 2016 13:45:54 +1000 (AEST)
Received: by mail-pa0-x231.google.com with SMTP id ks6so13636074pab.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jul 2016 20:45:54 -0700 (PDT)
Subject: Re: [RFC 0/3] extend kexec_file_load system call
To: Vivek Goyal <vgoyal@redhat.com>
References: <20160712225805.0d27fe5d@hananiah.suse.cz>
 <20160712221804.GV1041@n2100.armlinux.org.uk>
 <87twfunneg.fsf@linux.vnet.ibm.com>
 <20160713073657.GX1041@n2100.armlinux.org.uk>
 <87poqinf9m.fsf@linux.vnet.ibm.com>
 <20160713082639.GZ1041@n2100.armlinux.org.uk>
 <20160713130338.GB16900@redhat.com>
 <20160713174009.GA1041@n2100.armlinux.org.uk>
 <20160713182247.GA25232@redhat.com> <1468845964.2800.3.camel@gmail.com>
 <20160718132629.GB32512@redhat.com>
Cc: Russell King - ARM Linux <linux@armlinux.org.uk>,
 Stewart Smith <stewart@linux.vnet.ibm.com>, bhe@redhat.com, arnd@arndb.de,
 Petr Tesarik <ptesarik@suse.cz>, linuxppc-dev@lists.ozlabs.org,
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 "Eric W. Biederman" <ebiederm@xmission.com>,
 Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>, dyoung@redhat.com,
 linux-arm-kernel@lists.infradead.org
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <8a8b2909-7f95-03e4-bf8e-dd29b5fc1fba@gmail.com>
Date: Wed, 20 Jul 2016 13:45:42 +1000
MIME-Version: 1.0
In-Reply-To: <20160718132629.GB32512@redhat.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>>>>>  
>>>>> Command line options are not signed. I thought idea behind secureboot
>>>>> was to execute only trusted code and command line options don't enforce
>>>>> you to execute unsigned code.
>>>>>  
>>
>> You can set module.sig_enforce=0 and open up the system a bit assuming
>> that you can get a module to load with another attack
> 
> IIUC, sig_enforce bool_enable_only so it can only be enabled. Default
> value of it is 0 if CONFIG_MODULE_SIG_FORCE=n.
> 
> IOW, if your kernel forced signature verification, you should not be
> able to do sig_enforce=0. If you kernel did not have
> CONFIG_MODULE_SIG_FORCE=y, then sig_enforce should be 0 by default anyway
> and you are not making it worse using command line.
> 

OK.. I checked and you are right, but that is an example and there are
other things like security=, thermal.*, nosmep, nosmap that need auditing
for safety and might hurt the system security if used. I still think
think that assuming you can pass any command line without breaking security
is a broken argument.

>>
>>>>> So it sounds like different class of security problems which you are
>>>>> referring to and not necessarily covered by secureboot or signed
>>>>> kernel.
>>>> Let me give you an example.
>>>>  
>>>> You have a secure boot setup, where the firmware/ROM validates the boot
>>>> loader.  Good, the boot loader hasn't been tampered with.
>>>>  
>>>> You interrupt the boot loader and are able to modify the command line
>>>> for the booted kernel.
>>>>  
>>>> The boot loader loads the kernel and verifies the kernel's signature.
>>>> Good, the kernel hasn't been tampered with.  The kernel starts running.
>>>>  
>>>> You've plugged in a USB drive to the device, and specified a partition
>>>> containing a root filesystem that you control to the kernel.  The
>>>> validated kernel finds the USB drive, and mounts it, and executes
>>>> your own binaries on the USB drive.
>>> You will require physical access to the machine to be able to
>>> insert your usb drive. And IIRC, argument was that if attacker has
>>> physical access to machine, all bets are off anyway.
>>>
>>
>> You don't need physical access -- your machine controller BMC can
>> do the magic for you. So its not always physical access, is it?
> 
> Well, idea was that if you have physical access to machine, then all
> bets are off. If BMC can do something which allows running unsigned
> code at ring level 0, its a problem I think from secureboot model of
> security.
> 
>>  
>>>>  
>>>>  
>>>> You run a shell on the console.  You now have control of the system,
>>>> and can mount the real rootfs, inspect it, and work out what it does,
>>>> etc.
>>>>  
>>>> At this point, what use was all the validation that the secure boot
>>>> has done?  Absolutely useless.
>>>>  
>>>> If you can change the command line arguments given to the kernel, you
>>>> have no security, no matter how much you verify signatures.  It's
>>>> the illusion of security, nothing more, nothing less.
>>>>  
>>
>> I agree, if you can change command line arguments, all bets are of lesser value
> 
> If changing command line allows execution of unsigned code at ring level
> 0, then it is a problem. Otherwise we are talking of security issues which
> are not covered by secure


I agree that from what I can see/grep there is nothing that allows unsigned
code to run at boot in ring0, but there are implications like the ones
I've mentioned above.

Attacks are typically built as a chain and every bit might matter. One could
turn off features that might lead to the system being attacked at run-time


Balbir Singh.
