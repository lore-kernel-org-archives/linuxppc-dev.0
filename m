Date: Thu, 7 Dec 2000 12:04:41 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: jlhagen@collins.rockwell.com
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: prepboot, head.S questions.
In-Reply-To: <OF2FC5D6C8.697FC432-ON862569AD.007549C4@collins.rockwell.com>
Message-ID: <Pine.HPX.4.10.10012071058180.25689-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 6 Dec 2000 jlhagen@collins.rockwell.com wrote:

>
> Hello all,
>
> does a FAQ exist for this list?? I have an obvious newbie question. Could
> someone quickly explain the structure of arch/ppc, I'm really looking at
> the different head.S files. It looks like the arch/ppc/kernel/head.S
> contains low-level code for all architectures and the arch/ppc/[boot
> coffboot etc..] are the different bootloaders. Is this correct??
>
> Also from reading the list archives it sounded like the prepboot code from
> Gabriel, or code based on his work,  was to eventually make it into the ppc
> source tree. I believe this discussion was quite a while ago, 1999
> sometime. Is this still the plan? Or maybe items from prepboot are being
> merged into arch/ppc/boot ( If I understand the structure correctly )?

I hope to build a better version of my prepboot code early next year. This
has nothing to do with arch/ppc/kernel/head.S which runs after and
is the true early kernel boot but is too much of a mess.

Actually I would like to see a lot of the functionality of kernel/head.S
moved to the bootloader. I have a version of "prepboot" which is able to
read OF device tree and put it in some place for late use by the kernel,
instantiating RTAS would also be easy if I could test it but my OF machine
does not have RTAS.

This is much cleaner that the whole mess of running code at an address it
has not been foreseen to run. prepboot is compliled with -mrelocatable and
will run anywhere it is loaded even by funky firmware like PPCBUG (the
load address depends on whether I boot from disk or network) and move
itself to make room to uncompress the kernel if necessary. There is no
built-in fixed address in prepboot, absolutely none except for the
exception handlers (determined by hardware). It could be used on machines
which do not have RAM at 0 with very minor modifications affecting only
the installation of the exception handlers.


	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
