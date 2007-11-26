Return-Path: <clemens.koller@anagramm.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.171]) by ozlabs.org (Postfix) with ESMTP id 53CB0DDDD8
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 27 Nov 2007 07:20:17 +1100 (EST)
Message-ID: <474B2A7F.5090607@anagramm.de>
Date: Mon, 26 Nov 2007 21:20:15 +0100
From: Clemens Koller <clemens.koller@anagramm.de>
MIME-Version: 1.0
To: robert lazarski <robertlazarski@gmail.com>
Subject: Re: 85xx software reset problems from paulus.git
References: <f87675ee0711160700m17122edcv51b55f4a0cbe38b1@mail.gmail.com>	<473DB6DF.9010804@anagramm.de>	<f87675ee0711161244h46c23d8byadaf1abb923b3971@mail.gmail.com>	<f87675ee0711161328u3127de3bjdd6341cdf11cd626@mail.gmail.com>	<0B4C1069-9D89-44E8-89F7-9E7CE07B03DF@kernel.crashing.org>	<f87675ee0711161401k600b658ao3d6ae572fb367c47@mail.gmail.com>	<7C2ED552-6644-4FB3-A97B-05FC3E2141FF@kernel.crashing.org>
	<f87675ee0711260941w25e5ed81v7322be1500fd5611@mail.gmail.com>
In-Reply-To: <f87675ee0711260941w25e5ed81v7322be1500fd5611@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi, Robert, Hi, Kumar!

robert lazarski schrieb:
> Hi Kumar, I finally got time to get back to this:
> 
> On Nov 17, 2007 2:52 PM, Kumar Gala <galak@kernel.crashing.org> wrote:
>>
>> On Nov 16, 2007, at 4:01 PM, robert lazarski wrote:
>>
>>>>> Sorry for replying to myself, but thought I'd mention SRESET works
>>>>> fine on 85xx 2.6.23 , ie, the board resets after kernel panic. It
>>>>> doesn't work for me on 2.6.24rc2 .
>>>> What actual 85xx are you using?
>>>>
>>>> - k
>>>>
>>> Custom 8548 board. I'm using the cds 85xx code for a reference and I
>>> calling the same reset functions.
>>>
>> 1. do you have the following in your dts:
>>
>>                  global-utilities@e0000 {        //global utilities reg
>>                          compatible = "fsl,mpc8548-guts";
>>                          reg = <e0000 1000>;
>>                          fsl,has-rstcr;
>>                  };
>>
> 
> Yes.
> 
>> 2. in your platform code are you using fsl_rstcr_restart in
>> define_machine()
>>
>> - k
>>
> 
> Yes. The symptoms in 2.6.24RC2 are that during a kernel panic or when
> calling 'reboot' in the shell, it just hangs. Using the same dts and
> resets in 2.6.23.1 reboots fine. I don't have a cds reference, but
> someone who does should be able to confirm whether the issue exists or
> not by just attempting to reboot via bash.

ACK. Exactly the same over here (mpc8540ads compatible).
I added the global-utilities today as well, but reboot fails.

Why is the guts stuff missing i.e. in most of the shipped
mpc85xx*.dts? Does it depend on some hardware connections
external to the CPU?

Regards,
-- 
Clemens Koller
_______________________________
R&D Imaging Devices
Anagramm GmbH
Rupert-Mayer-Str. 45/1
81379 Muenchen
Germany

http://www.anagramm-technology.com
Phone: +49-89-741518-50
Fax: +49-89-741518-19
