Return-Path: <kumar.gala@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id D101367B2B
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  4 Jun 2005 01:27:03 +1000 (EST)
In-Reply-To: <42A0758D.5040000@ru.mvista.com>
References: <42A0758D.5040000@ru.mvista.com>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <a4941c185e8e58216a420cc3d6ff5e02@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Fri, 3 Jun 2005 10:26:56 -0500
To: "Vitaly Bordug" <vbordug@ru.mvista.com>
Cc: linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
Subject: Re: [RFC] PlatformDevice definitions for 82xx
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Jun 3, 2005, at 10:21 AM, Vitaly Bordug wrote:

> Kumar Gala wrote:
>
>>
>> On Jun 2, 2005, at 11:16 AM, Vitaly Bordug wrote:
>>
>>> Hi!
>>> This adds platform definition files for 82xx, while the 
>>> platform_info is
>>> filled in board-specific .C file residing in platforms/82xx. Another
>>> disputable thing I did - I moved m8260_setup.c from the syslib/ up to
>>> platforms/82xx/. The file was slightly changed  - added 2 prototypes
>>> from the cpm2_pic.h and removed the respective include.
>>
>>
>> Why the move of m8260_setup.c?  Also, if this is required can we do
>> this as two different patches so we can see clearly any changes also
>> maded to m8260_setup.c
>>
> To my opinion platforms/82xx/m8260_setup.c is more relevant than in
> syslib. This is not a vital requirement though, I just want to know
> whether someone considers the same.

Let's leave it where it is for now.

>> mpc82xx_devices.c need a bit of work we need to at least cover the
>> same set of devices that 85xx does for the CPM:
>>     SPI, I2C, USB, SCC1-4, FCC1-3, MCC1-2, SMC1-2
>>
> OK. These stuff is not there yet because I wasn't sure what should come
> first - the platform stuff or driver that will utilize it. So, the
> correct way is to define PD first, than add drivers.
>
>> Additionally, the device name can not me FS_ENET_NAME, which assumes
>> that FCC is only used for enet.
>>
> OK
>
>> mpc82xx_sys.c: what is the .value field?  is this the IMMR and if so
>> why bother shifting it?
>
> Because I want only partnum & masknum (RM, Fig. 4.26), remaining part 
> is
> HRCW-dependent and can be written so couldn't be used as a device
> identification.

Ok, but is there any need to shift it?  Just setup the mask up 
correctly.

>> Also there are a whole bunch of variants that need to be captured
>>
> What exactly do you mean by this? Enumerate all the 82xx boards in
> mpc82xx_sys.c identifying them by immr, or?

Not boards, but chips.  Yes, enumerating the various IMMRs, I will ask 
one of our engineers to help with this.

- kumar
