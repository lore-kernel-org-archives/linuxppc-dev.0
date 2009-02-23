Return-Path: <sumedhtirodkar@gmail.com>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.173])
	by ozlabs.org (Postfix) with ESMTP id A5D8ADDF0F
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Feb 2009 05:02:07 +1100 (EST)
Received: by wf-out-1314.google.com with SMTP id 27so2236474wfd.15
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Feb 2009 10:02:04 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <d194b8ce0902230933w2b985134m55b4bf69e8ba20ae@mail.gmail.com>
References: <d2b9ccd90902222354o2e42db77h2f86fda45b5483b6@mail.gmail.com>
	<85a5c2010902230439n1096196dr519462513bc3910d@mail.gmail.com>
	<d2b9ccd90902230503i4c2535d5lbd05b7ddeddf3192@mail.gmail.com>
	<85a5c2010902230648m72b63eeds70b4e7a5ec4d8c51@mail.gmail.com>
	<d2b9ccd90902230904h148827fey293aebd2962c892a@mail.gmail.com>
	<d194b8ce0902230933w2b985134m55b4bf69e8ba20ae@mail.gmail.com>
Date: Mon, 23 Feb 2009 23:32:04 +0530
Message-ID: <d2b9ccd90902231002m41062108kb36c9ba4e7b70aa4@mail.gmail.com>
Subject: Re: Problem with decrementer interrupt
From: sumedh tirodkar <sumedhtirodkar@gmail.com>
To: sjoyeau@wanadoo.fr
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I have initialised to stack pointer(r1) properly...actually...i went
thru the object dump...bt when i juz use

  bla <function_name_handler>

the link register is not getting pushed on to the stack in the prolog
of that function...so the stack is basically not coming into the
picture...
@IRQ originator, that doesn't seem to be a problem...

The only thing that i am able to think of is that when i do a "bla",
the return address is not getting stored in link register...and i m
not able to figure out why...

Regards,
Sumedh

On Mon, Feb 23, 2009 at 11:03 PM, sjoyeau@wanadoo.fr <sjoyeau@wanadoo.fr> w=
rote:
> Hi Sumedh,
>
> You may check the context in which your CPU in running the C code from
> interrupt context (ie stack pointer (r1), kernel locks disabling
> rescheduling etc..) and double check the IRQ originator (the decrementer)=
 is
> acknowlegded somewhere your handler before enabling back interrupts, else
> your handler gets fired.
>
> --
> sj
>
> 2009/2/23 sumedh tirodkar <sumedhtirodkar@gmail.com>
>>
>> Alright...I am trying to develop a system of my own..
>> Consider that i am not using any linux kernel...I m writing some
>> program right from scratch.........
>> The major steps that i have taken are...
>>
>> 1. Started with a assembly file...
>> 2. Have relocated the interrupt handlers to there respective
>> positions...The interrupt handlers are written in assembly language...
>> 3. Initialised Decrementer register to get an interrupt after some
>> interval...
>> 4. Jump to some function using
>>
>>    bl <function_name_main>
>>
>>    function_name_main which will have a infinite while loop..
>> This works fine i.e. the interrupts(decrementer interrupt to be more
>> specific) work fine...I have initialised serial port to get the
>> output...
>>
>> Now, the problem that i am facing....
>>
>> If in interrupt handler of the decrementer, i make a call to some C
>> function in some other C file...using the follwing statement...
>>
>> Dec_handler:  /* I have relocated this to interrupt vector address of
>> decrementer interrupt*/
>>     /*code to print using serial port*/
>>     bla <function_name_handler> /*code to call some function in C file*/
>>     /*code to print using serial port---but i m never able to see this
>> output*/
>>     RFI
>>
>> This starts creating a problem...somehow we dont return to this code
>> after the end of the function_name_handler...
>> Consider the following code for the function_name_handler:
>> void function_name_handler(void)
>> {
>>   /*Some action*/
>> }
>>
>> So, if its possible for anyone to help me with this...please reply...
>>
>> Regards,
>> Sumedh
>>
>>
>> On Mon, Feb 23, 2009 at 8:18 PM, Matt Gessner <mgessner@gmail.com> wrote=
:
>> >
>> >
>> > On Mon, Feb 23, 2009 at 8:03 AM, sumedh tirodkar
>> > <sumedhtirodkar@gmail.com>
>> > wrote:
>> >>
>> >> I am using PowerPC 7447A...I am trying to port SA-RTL on PowerPC...
>> >
>> > What I said earlier was: You need to tell people what cpu you're using=
,
>> > what
>> > linux kernel, etc etc etc.
>> >
>> > Fine, we know the CPU.  What kernel are you using?  Is it ancient?
>> >
>> > I doubt the information below is going to be useful...
>> >
>> >>
>> >> I am using
>> >>
>> >> bla <function_name>
>> >>
>> >> from the assembly code to call the function in C file...This i am
>> >> doing from interrupt handler of the decrementer...
>> >> If any more details are required, please let me know...
>> >
>> >
>> _______________________________________________
>> Linuxppc-dev mailing list
>> Linuxppc-dev@ozlabs.org
>> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>
>
>
> --
> ------------------
> Sylvain JOYEAU
> Freelance Engineer
> Software RT-OS R&D
> sylvain.joyeau@gmail.com
> T=E9l: +33-(0)667 477 052
> "A good idea is one side of the coin. The other side is the practical
> usefulness". J. Liedke.
>
