Return-Path: <kumar.gala@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id C00E067E74
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  2 Aug 2005 23:39:57 +1000 (EST)
In-Reply-To: <20050802034517.F3D0167E42@ozlabs.org>
References: <20050802034517.F3D0167E42@ozlabs.org>
Mime-Version: 1.0 (Apple Message framework v733)
Content-Type: text/plain; charset=ISO-8859-1; delsp=yes; format=flowed
Message-Id: <E227A82E-9A6F-449F-9CD9-9FD6D1893082@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Tue, 2 Aug 2005 08:39:56 -0500
To: JohnsonCheng <johnsoncheng@qnap.com.tw>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Serial console
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Aug 1, 2005, at 10:38 PM, JohnsonCheng wrote:

> Dear Daniel,
>
> I also meet this problem on MPC8245 with linux-2.6.12.3, and I =20
> found it uses
> LEVEL for interrupt in sandpoint.c. Do you have any idea for it?

All internal interrupts on the MPC8245/1 should be LEVEL interrupts.

- kumar

> -----Original Message-----
> From: linuxppc-embedded-bounces@ozlabs.org
> [mailto:linuxppc-embedded-bounces@ozlabs.org] On Behalf Of Daniel Ann
> Sent: Monday, August 01, 2005 9:27 AM
> To: Anton W=F6llert
> Cc: linuxppc-embedded@ozlabs.org
> Subject: Re: Serial console
>
> Thanks for your input Anton.
> I'm not all that certain about sandpoint platform has its own serial
> driver so I've worked with 8250.c. Anyway, I've got it working now. It
> was problem with interrupt. As soon as I changed interrupt from EGDE
> to LEVEL it began working. Altho I'm faced with yet another problem
> with openpic but I'm digging thru it at the moment.
>
> BTW, I have no idea why EDGE didnt work and LEVEL does.
>
> Cheers,
> Daniel
>
> On 7/30/05, Anton W=F6llert <a.woellert@gmail.com> wrote:
>
>> Daniel Ann wrote:
>>
>>> Hi folks,
>>>
>>> Having all the kernel boot up log on console means that I've done =20=

>>> some
>>> part right. But why am I not getting anything from the user =20
>>> processes
>>> on the console screen ?
>>>
>>> Is there anything I need to do on the kernel config ?
>>>
>>>
>>
>> Hi, we've had the same problem some time ago on a tqm850l =20
>> (mpc850). Our
>> problem was, that we had registered two serial consoles in the kernel
>> config or something like that. we had to disable all serial-driver =20=

>> stuff
>> and enable just the platform-specific serial-console driver. we =20
>> tracked
>> this down with inserting a printk(buf) into the tty_write fs-op of =20=

>> the
>> serial-port driver in drivers/char/tty_io.c. the ttyS0 was used =20
>> but has
>> taken another serial-driver than the platform specific.
>>
>> may this help you :)
>>
>>
>> anton
>>
>>
>
>
> --=20
> Daniel
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
