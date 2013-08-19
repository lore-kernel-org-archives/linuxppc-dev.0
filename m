Return-Path: <kirjanov@gmail.com>
Received: from mail-ee0-x229.google.com (mail-ee0-x229.google.com
 [IPv6:2a00:1450:4013:c00::229])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 91EDF2C00F4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Aug 2013 07:04:18 +1000 (EST)
Received: by mail-ee0-f41.google.com with SMTP id d17so2381715eek.14
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Aug 2013 14:04:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1376945799.25016.77.camel@pasglop>
References: <63d2635a$648939a4$b3aeac8$@deltatau.com>
 <1376945799.25016.77.camel@pasglop>
Date: Tue, 20 Aug 2013 01:04:12 +0400
Message-ID: <CAHj3AVmAnwMQRstyU3rH=JX277=iqTcNii7cvVHBKBwJrMc6rw@mail.gmail.com>
Subject: Re: Critical Interrupt Input
From: Denis Kirjanov <kirjanov@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org, hbausley@deltatau.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The easy thing is to start to experimenting with scratch/preserve registers=
 :)

On 8/20/13, Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> On Mon, 2013-08-19 at 12:00 -0700, Henry Bausley wrote:
>>
>> Support does appear to be present but there is a problem returning
>> back to user space I suspect.
>
> Probably a problem with TLB misses vs. crit interrupts.
>
> A critical interrupt can re-enter a TLB miss.
>
> I can see two potential issues there:
>
>  - A bug where we don't properly restore "something" (I thought we did
> save and restore MMUCR though, but that's worth dbl checking if it works
> properly) accross the crit entry/exit
>
>  - Something in your crit code causing a TLB miss (the
> kernel .text/.data/.bss should be bolted but anything else can). We
> don't currently support re-entering the TLB miss that way.
>
> If we were to support the latter, we'd need to detect on entering a crit
> that the PC is within the TLB miss handler, and setup a return context
> to the original instruction (replay the miss) rather than trying to
> resume it..
>
> Cheers,
> Ben.
>
>> What fails is it causes Linux user space programs to get Segmentation
>> errors.
>> Issuing a simple ls causes a segmentation fault sometimes.  The shell
>> gets terminated
>> and you cannot log back in.  INIT: Id "T0" respawning too fast:
>> disabled for 5 minutes pops up.
>>
>> However, the critical interrupt handler keeps running.  I know this by
>> adding the reading
>> of a physical I/O location in the handler and can see it is being read
>> on the scope.
>>
>>
>> The only code in the handler is below.
>>
>> void critintr_handler(void *dev)
>> {
>>   critintrcount++;          // increment a variable
>>   iodata =3D *piom;           // read an I/O location
>>   mtdcr(0x0c0, 0x00002000); // clear critical interrupt
>> }
>>
>>
>> Below is a log of the type of crashes that occur:
>>
>> root@10.34.9.213:/opt/ppmac/ktest# ls
>> Segmentation fault
>> root@10.34.9.213:/opt/ppmac/ktest# ls
>> Segmentation fault
>> root@10.34.9.213:/opt/ppmac/ktest# ls
>> Makefile        ktest.c    ktest.ko     ktest.mod.o  modules.order
>> Module.symvers  ktest.cbp  ktest.mod.c  ktest.o
>> root@10.34.9.213:/opt/ppmac/ktest# ls
>>
>> Debian GNU/Linux 7 powerpmac ttyS0
>>
>> powerpmac login: root
>>
>> Debian GNU/Linux 7 powerpmac ttyS0
>>
>> powerpmac login: root
>>
>> Debian GNU/Linux 7 powerpmac ttyS0
>>
>> powerpmac login: root
>>
>> Debian GNU/Linux 7 powerpmac ttyS0
>>
>> powerpmac login: root
>> Password:
>> Last login: Thu Nov 30 20:42:16 UTC 1933 on ttyS0
>> Linux powerpmac 3.2.21-aspen_2.01.09 #10 Mon Aug 19 08:49:12 PDT 2013
>> ppc
>>
>> The programs included with the Debian GNU/Linux system are free
>> software;
>> the exact distribution terms for each program are described in the
>> individual files in /usr/share/doc/*/copyright.
>>
>> Debian GNU/Linux comes with ABSOLUTELY NO WARRANTY, to the extent
>> permitted by applicable law.
>> INIT: Id "T0" respawning too fast: disabled for 5 minutes
>>
>>
>> ______________________________________________________________________
>> From: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
>> Sent: Saturday, August 17, 2013 3:05 PM
>> To: "Kumar Gala" <galak@kernel.crashing.org>
>> Cc: linuxppc-dev@lists.ozlabs.org, hbausley@deltatau.com
>> Subject: Re: Critical Interrupt Input
>>
>> On Fri, 2013-08-16 at 06:04 -0500, Kumar Gala wrote:
>> > The 44x low level code needs to handle exception stacks properly for
>> > this to work. Since its possible to have a critical exception occur
>> > while in a normal exception level, you have to have proper saving of
>> > additional register state and a stack frame for the critical
>> > exception, etc. I'm not sure if that was ever done for 44x.
>>
>> Don't 44x and FSL BookE share the same macros ? I would think 44x does
>> indeed implement the same crit support as e500...
>>
>> What does the crash look like ?
>>
>> Ben.
>>
>>
>> _______________________________________________
>> Linuxppc-dev mailing list
>> Linuxppc-dev@lists.ozlabs.org
>> https://lists.ozlabs.org/listinfo/linuxppc-dev
>>
>>
>>   =AD=AD
>
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev


--=20
Regards,
Denis
