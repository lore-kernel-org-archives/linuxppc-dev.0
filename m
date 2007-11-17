Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A3FACDDDFF
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 18 Nov 2007 06:53:08 +1100 (EST)
Message-Id: <7C2ED552-6644-4FB3-A97B-05FC3E2141FF@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: robert lazarski <robertlazarski@gmail.com>
In-Reply-To: <f87675ee0711161401k600b658ao3d6ae572fb367c47@mail.gmail.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: 85xx software reset problems from paulus.git
Date: Sat, 17 Nov 2007 13:52:35 -0600
References: <f87675ee0711160700m17122edcv51b55f4a0cbe38b1@mail.gmail.com>
	<473DB6DF.9010804@anagramm.de>
	<f87675ee0711161244h46c23d8byadaf1abb923b3971@mail.gmail.com>
	<f87675ee0711161328u3127de3bjdd6341cdf11cd626@mail.gmail.com>
	<0B4C1069-9D89-44E8-89F7-9E7CE07B03DF@kernel.crashing.org>
	<f87675ee0711161401k600b658ao3d6ae572fb367c47@mail.gmail.com>
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


On Nov 16, 2007, at 4:01 PM, robert lazarski wrote:

> On Nov 16, 2007 4:46 PM, Kumar Gala <galak@kernel.crashing.org> wrote:
>>
>>
>> On Nov 16, 2007, at 3:28 PM, robert lazarski wrote:
>>
>>> On Nov 16, 2007 3:44 PM, robert lazarski <robertlazarski@gmail.com>
>>> wrote:
>>>> On Nov 16, 2007 10:27 AM, Clemens Koller
>>>> <clemens.koller@anagramm.de> wrote:
>>>>> The SRESET# (pin AF20) is the soft reset input, causes
>>>>> an mcp assertion to the core.... (RTFM)
>>>>>
>>>>
>>>> That's what we are doing. The 85xx docs say "Soft reset. Causes a
>>>> machine check interrupt to the e500 core. Note that if the e500  
>>>> core
>>>> is not configured to process machine check interrupts, the  
>>>> assertion
>>>> of SRESET causes a core checkstop. SRESET need not be asserted  
>>>> during
>>>> a hard reset."
>>>>
>>>
>>> Sorry for replying to myself, but thought I'd mention SRESET works
>>> fine on 85xx 2.6.23 , ie, the board resets after kernel panic. It
>>> doesn't work for me on 2.6.24rc2 .
>>
>> What actual 85xx are you using?
>>
>> - k
>>
>
> Custom 8548 board. I'm using the cds 85xx code for a reference and I
> calling the same reset functions.
>
1. do you have the following in your dts:

                 global-utilities@e0000 {        //global utilities reg
                         compatible = "fsl,mpc8548-guts";
                         reg = <e0000 1000>;
                         fsl,has-rstcr;
                 };


2. in your platform code are you using fsl_rstcr_restart in  
define_machine()

- k
