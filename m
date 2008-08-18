Return-Path: <grigore.mihaela@gmail.com>
Received: from mail-gx0-f21.google.com (mail-gx0-f21.google.com
	[209.85.217.21]) by ozlabs.org (Postfix) with ESMTP id 0FC41DE174
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Aug 2008 05:58:00 +1000 (EST)
Received: by gxk14 with SMTP id 14so3909499gxk.9
	for <linuxppc-dev@ozlabs.org>; Mon, 18 Aug 2008 12:57:58 -0700 (PDT)
Message-ID: <78ef7ce10808181257u637c5597xaa992b9e4e7a0925@mail.gmail.com>
Date: Mon, 18 Aug 2008 22:57:58 +0300
From: "Mihaela Grigore" <grigore.mihaela@gmail.com>
To: "Michael Neuling" <mikey@neuling.org>, linuxppc-dev@ozlabs.org
Subject: Re: self-modifying code in 2.6 kernel for ppc writes into readonly
	section
In-Reply-To: <1586.1219087193@neuling.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <78ef7ce10808180901v6c694e63xefc37dd97485533@mail.gmail.com>
	<1586.1219087193@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The mmu is still disabled at this point.

What is marked as readonly is the text section of the vmlinux file
generated when compiling the kernel. And since the code tries to write
to the text section, I assumed it was the reason for the segmentation
fault.

I'm not sure how this is dealt with on real hardware.

Can somebody please explain how is it supposed to work ? Is it ok to
write to text section that you load on real hardware as readonly ?
(again, no mmu involved, as it is still turned off, so i'm not sure
who's guarding this section against writing)

On Mon, Aug 18, 2008 at 10:19 PM, Michael Neuling <mikey@neuling.org> wrote:
> In message <78ef7ce10808180901v6c694e63xefc37dd97485533@mail.gmail.com> you wrote:
>> Hello,
>>
>> First, I'm talkin about the 2.6.11 version. I know arch/ppc is gone in
>> latest versions,
>> but i assume the code is still the same and just moved to powerpc.
>>
>> There is a piece of code in the early initialization of the 2.6 kernel
>> that identifies the cpu type and then tries to eliminate code that
>> does not apply to the current cpu. This is done by writing nop's over
>> sections of code that are not needed (do_cpu_ftr_fixups in
>> arch/ppc/kernel/misc.S)
>>
>> When I try to run the kernel in a ppc emulator, I get a segmentation
>> fault in do_cpu_ftr_fixups. From examining the section headers of the
>> vmlinux, the text section is marked as readonly. The piece of code
>> above mentioned is trying to write a nop to memory location inside the
>> text section which is readonly, so that explains the sigsegv  error.
>
> Any segv in the emulator sounds like a bug in the emulator.
>
> If the page really is marked read only, then writing to it should cause
> a page fault.
>
>> Since the kernel does run on boards with ppc cpu's, can somebody
>> explain how come this is actually working ? Or if/where I am mistaking
>> with my assumptions ?
>>
>> Thank you
>>
>> P.S. please add me in cc in a reply to this message
>> _______________________________________________
>> Linuxppc-dev mailing list
>> Linuxppc-dev@ozlabs.org
>> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>>
>
