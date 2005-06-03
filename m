Return-Path: <vbordug@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (RT-soft-2.Moscow.itn.ru [80.240.96.70])
	by ozlabs.org (Postfix) with SMTP id 04C5F67B2B
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  4 Jun 2005 01:21:50 +1000 (EST)
Message-ID: <42A0758D.5040000@ru.mvista.com>
Date: Fri, 03 Jun 2005 19:21:49 +0400
From: Vitaly Bordug <vbordug@ru.mvista.com>
MIME-Version: 1.0
To: Kumar Gala <kumar.gala@freescale.com>
References: <429F30D7.2040806@ru.mvista.com>
	<81bbf71b42314c9168681be6ef2725e1@freescale.com>
In-Reply-To: <81bbf71b42314c9168681be6ef2725e1@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

Kumar Gala wrote:

>
> On Jun 2, 2005, at 11:16 AM, Vitaly Bordug wrote:
>
>> Hi!
>> This adds platform definition files for 82xx, while the platform_info is
>> filled in board-specific .C file residing in platforms/82xx. Another
>> disputable thing I did - I moved m8260_setup.c from the syslib/ up to
>> platforms/82xx/. The file was slightly changed  - added 2 prototypes
>> from the cpm2_pic.h and removed the respective include.
>
>
> Why the move of m8260_setup.c?  Also, if this is required can we do 
> this as two different patches so we can see clearly any changes also 
> maded to m8260_setup.c
>
To my opinion platforms/82xx/m8260_setup.c is more relevant than in 
syslib. This is not a vital requirement though, I just want to know 
whether someone considers the same.

> mpc82xx_devices.c need a bit of work we need to at least cover the 
> same set of devices that 85xx does for the CPM:
>     SPI, I2C, USB, SCC1-4, FCC1-3, MCC1-2, SMC1-2
>
OK. These stuff is not there yet because I wasn't sure what should come 
first - the platform stuff or driver that will utilize it. So, the 
correct way is to define PD first, than add drivers.

> Additionally, the device name can not me FS_ENET_NAME, which assumes 
> that FCC is only used for enet.
>
OK

> mpc82xx_sys.c: what is the .value field?  is this the IMMR and if so 
> why bother shifting it?  

Because I want only partnum & masknum (RM, Fig. 4.26), remaining part is 
HRCW-dependent and can be written so couldn't be used as a device 
identification.

> Also there are a whole bunch of variants that need to be captured
>
What exactly do you mean by this? Enumerate all the 82xx boards in 
mpc82xx_sys.c identifying them by immr, or?

> Let's get clean versions of these two files before we worry about how 
> to handle FCC enet specific bits.

Agreed.

>
> - kumar
>
>


-- 
Sincerely, 
Vitaly
