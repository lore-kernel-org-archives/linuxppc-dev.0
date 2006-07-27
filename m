Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7363E679E0
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Jul 2006 01:37:18 +1000 (EST)
In-Reply-To: <5744F4FC-32DC-4F24-9FD4-E6CAC4AFA6A4@freescale.com>
References: <A958F7B12F59EC408E904A912CDE3DAE3D6A07@cvn68.fairmountautomation.com>	<E7ECF775-1E54-4EE8-98DA-89FAD5C7C03A@kernel.crashing.org>
	<A958F7B12F59EC408E904A912CDE3DAE3D6A0A@cvn68.fairmountautomation.com>
	<44C8B330.7030600@smiths-aerospace.com>
	<5744F4FC-32DC-4F24-9FD4-E6CAC4AFA6A4@freescale.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <FA237244-A926-44B4-B669-1C5BC1E8E35B@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Can 750 user-mode binaries run on a 603e core?
Date: Thu, 27 Jul 2006 10:37:24 -0500
To: Andy Fleming <afleming@freescale.com>
Cc: linuxppc-dev@ozlabs.org,
	"Patrick J. Kelsey" <KelseyPJ@fairmountautomation.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jul 27, 2006, at 10:30 AM, Andy Fleming wrote:

> Branch delay slots are evil, and PowerPC did not use them.
>
> 'nuff said.
>
> Pretty much any powerpc binary should work on any PowerPC system.
> Actually, we use a 603-compiled root file system for our e500
> processors (in our lab), and don't run into any problems.  This is

Let's be clear, that is done by emulating the floating point  
instructions in the kernel.  (And there are a few user space integer/ 
control instructions that e500 doesn't implement, but your rarely run  
into them).

- k

> On Jul 27, 2006, at 07:36, Jerry Van Baren wrote:
>
>> Patrick J. Kelsey wrote:
>>> (sorry about that last one. had a bit of trouble with a certain
>>> web based mail client...)
>>>
>>> Thanks for the reply, Kumar.
>>>
>>> That sounds encouraging.  One of the things I was worried about with
>>> scheduling differences would be a differing number of branch delay
>>> slots between the two core versions.  I'm still a bit new to the
>>> details of the PowerPC architecture, and at this point I'm not even
>>> sure if there are branch delay slots, although it does seem from my
>>> reading that the 603e and 750 pipelines are the same, in which case
>>> there would ceratinly be no worries here.
>>
>> FWIIW, the PowerPC architecture has hardware instruction interlocking
>> and scheduling and doesn't require the compiler to implement the
>> branch
>> delay slots like, for instance, the MIPS architecture.  This is much
>> more compiler and portability friendly, but at the expense of more
>> logic
>> in the processor (the PowerPC is not nearly as minimalistic as the
>> MIPS).
>>
>>> At this point, I'm not concerned so much about an inefficient
>>> schedule resulting from running -mcpu=750 code on a 603e as long as
>>> the execution is correct.
>>>
>>> Pat
>>
>> gvb
>> _______________________________________________
>> Linuxppc-dev mailing list
>> Linuxppc-dev@ozlabs.org
>> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
