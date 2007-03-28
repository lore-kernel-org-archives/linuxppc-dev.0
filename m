Return-Path: <segher@kernel.crashing.org>
In-Reply-To: <1175041735.14065.37.camel@localhost.localdomain>
References: <20070327222840.GA1266@mag.az.mvista.com>
	<17929.44043.728362.712648@cargo.ozlabs.ibm.com>
	<20070328001215.GA25080@mag.az.mvista.com>
	<1175041735.14065.37.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <f9bdca27dfc8ea20d0020261a5022ec4@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Disable external interrupts in bootwrapper
Date: Wed, 28 Mar 2007 18:52:33 +0200
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>>> Disable external interrupts very early in the bootwrapper in case
>>>> the firmware left a device generating interrupts.
>>>
>>> Sounds reasonable, except that I wonder if systems running under a
>>> real OF want to do this...
>>
>> I don't know.  Would someone who knows OF speak up?
>
> OF isn't supposed to use external interrupts

That isn't a hard rule.  But yeah, hardly any OF
will ever use interrupts for normal operation --
the kernel can have taken control of the exception
vector and still want to access devices via OF, for
example.

> but I wouldn't bet on what
> Apple's one does... I think it's not safe to do that thus on OF based
> platforms.

Until you take control of the external interrupt and
decrementer interrupt (and overtemp interrupt, on
some CPUs), you really shouldn't turn off the EE bit
for extended periods of time.

Set EE=0 right before the earliest of a) you want OF
to be dead dead dead; or b) you copy the kernel's
exception vectors to 0; and all will be fine.


Segher
