Return-Path: <acahalan@gmail.com>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) by ozlabs.org (Postfix) with ESMTP id 1DF67B7D2D
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 29 May 2010 20:31:35 +1000 (EST)
Received: by vws16 with SMTP id 16so1598358vws.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 29 May 2010 03:31:33 -0700 (PDT)
MIME-Version: 1.0
Date: Sat, 29 May 2010 06:31:32 -0400
Message-ID: <AANLkTimDfbJkAuoK1-asvk8Ub9C9QBkK5RkzLR3ilJUY@mail.gmail.com>
Subject: Re: [PATCH v21 011/100] eclone (11/11): Document sys_eclone
From: Albert Cahalan <acahalan@gmail.com>
To: linux-kernel <linux-kernel@vger.kernel.org>, sukadev@linux.vnet.ibm.com,
	randy.dunlap@oracle.com, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Sukadev Bhattiprolu writes:

> Randy Dunlap [randy.dunlap at oracle.com] wrote:
>>> base of the region allocated for stack. These architectures
>>> must pass in the size of the stack-region in ->child_stack_size.
>>
>>                               stack region
>>
>> Seems unfortunate that different architectures use
>> the fields differently.
>
> Yes and no. The field still has a single purpose, just that
> some architectures may not need it. We enforce that if unused
> on an architecture, the field must be 0. It looked like
> the easiest way to keep the API common across architectures.

Yuck. You're forcing userspace to have #ifdef messes or,
more likely, just not work on all architectures. There is
no reason to have field usage vary by architecture. The
original clone syscall was not designed with ia64 and hppa
in mind, and has been causing trouble ever since. Let's not
perpetuate the problem.

Given code like this:   stack_base = malloc(stack_size);
stack_base and stack_size are what the kernel needs.

I suspect that you chose the defective method for some reason
related to restarting processes that were created with the
older system calls. I can't say most of us even care, but in
that broken-already case your process restarter can make up
some numbers that will work. (for i386, the base could be the
lowest address in the vma in which %esp lies, or even address 0)

A related issue is that stack allocation and deallocation can
be quite painful: it is difficult (some assembly required) to
free one's own stack, and impossible if one is already dead.
We could use a flag to let the kernel handle allocation, with
the stack getting freed just after any ptracer gets a last look.
This issue is especially troublesome for me because the syscall
essentially requires per-thread memory to work; it is currently
extremely difficult to use the syscall in code which lacks that.
