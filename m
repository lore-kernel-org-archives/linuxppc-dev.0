Date: Wed, 2 Aug 2000 23:33:25 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: Gong Zhuo <gongzhuo@163.net>
cc: Linux PPC Mailing List <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: How to using Raven timer interrupt on MVME2600?
In-Reply-To: <001f01bffc66$d4da4000$4607a8c0@LocalHost>
Message-ID: <Pine.HPX.4.10.10008022331170.9070-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, 2 Aug 2000, Gong Zhuo wrote:

>
> Hi:
>    I want to using the timer of RAVEN to get cycle interrupt.
>    I have done sth. like this:
>
>    1. 0x1092f107 ==> timer base count 0 (0xfc001110) ( the cycle is 16s and
> value is 0x07f19210 on pci bus)
>    2. 0x80000700 ==> timer 0 vector/priority reg.(0xfc001120) ( vector 80,
> priority 7)
>    3. 0x01000000 ==> timer 0 destination reg. (0xfc001130) ( interrupt to
> processor 0)
>    4. 0x06000000 ==> interrupt task priority reg. (0xfc020080) (task
> priority is 6)
>
>    I can see the value of timer 0 current count reg. is changing and the 'T'
> bit of timer 0 current count reg. changing between 0 and 1.
>    The 'ACT' bit of timer0 vector/priority reg. is 1 (the whole value is
> 0x80000740) after interrupt enabled.
>
>    In my interrupt processing:
>    1. read interrupt ack reg.
>    2. judge the vector to see if it is 0x80 (the timer 0 vector)
>    3. do the interrupte processing
>    4. write a value to EOI register
>
>    But it seems that the interrupt has never happened. After I read the
> interrupt ack reg. under PPCbug , the 'ACT' bit of vector/priority reg. will
> not change. Is that right? Something else I should do?

Yes, write 0 to the processor EOI register. I donn't understand why you
want to do it BTW, but have a look at the OpenPIC code to see how it's
done (although I don't like the code nor generally the whole PPC interrupt
mangement which was too messy last time I looked at it).

	Regards,
	Gabriel.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
