Message-ID: <3FC55D8C.50200@cs.fujitsu.co.jp>
Date: Thu, 27 Nov 2003 11:12:28 +0900
From: Takeharu KATO <tkato@cs.fujitsu.co.jp>
MIME-Version: 1.0
To: Matt Porter <mporter@kernel.crashing.org>
Cc: Felix Domke <tmbinc@elitedvb.net>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: 405 Critical Interrupts
References: <3FC4D4B5.2030901@elitedvb.net> <20031126134814.A9704@home.com>
In-Reply-To: <20031126134814.A9704@home.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Domke :

>>Does CRIT_EXCEPTION work? Is do_IRQ reentrant? Should i use the same
>>interrupt processing as a normal hardware interrupt, with the exception
>>that only "critical"-flagged interrupts are processed?
>>
>>Any suggestions?
>>
>>
As far as I know, critical interrupt in ppc4xx archetecture is handled
as  a kind of unknown Interrupts. So It make system down in 2.6 series
(this may also be true in 2.4).

In linux kernel , the kernel stack is changed to critical interrupt
stack instead of
user process's kernel stack when it occuers in super visor mode.
So do_IRQ can not be called in crittical interrupt(because it call
preempt relevant
functions).

We have  implemeted critical interrupt handling facilites in 2.6 kernel .
In this implementation, critical interrupt specific interrupt handling
routines.
If you need our patch, please contact me(cause we need some periods to
prepare the patch).

Regards,

--
Takeharu KATO
Fujitsu Limited
Email:tkato@cs.fujitsu.co.jp (ext. 7112-4621)


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
