From: Benjamin Herrenschmidt <bh40@calva.net>
To: Dan Malek <dan@mvista.com>
Cc: <linuxppc-dev@lists.linuxppc.org>, Gabriel Paubert <paubert@iram.es>
Subject: Re: prepboot, head.S questions.
Date: Fri, 8 Dec 2000 13:26:31 +0100
Message-Id: <19341102055815.534@192.168.1.2>
In-Reply-To: <3A2FCFFF.79119495@mvista.com>
References: <3A2FCFFF.79119495@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>> Actually I would like to see a lot of the functionality of kernel/head.S
>> moved to the bootloader.
>
>I disagree (and you knew I would :-).  I think we currently have the
>proper separation here.  The code in kernel/head.S is entered with
>everything properly located in memory (usually), MMUs and caches
>disabled (or at least in a consistent state).  The code in kernel/head.S
>initializes the system as the rest of the Linux kernel requires.
>
>The code in the "boot" directories should do things that are unique
>to the different platform environments.

Well, I beleive Gabriel rants are more about what's in prom.c and called
from head.S.

Cort and I want to move that to the bootloader too and have a cleaner
and more "common" way to enter the kernel and pass it informations
(OF tree, residual datas, whatever...). I have various ideas in mind
and that's already more or less what happens with BootX (the OF tree
is passed by BootX already in the format the kernel expect it, the code
in prom.c does very few things in this case, but it's still a "special case").

All that is "real 2.5" work. Let's get 2.4 working and stable on all boxes
out there first ;)

>OK....but that doesn't require changes to kernel/head.S.  The OF/RTAS
>is used by other kernel functions, the code in head.S doesn't care.
>Just allocate a register or memory location and pass the information.
>We need to clean up the parameter passing stuff between the boot loader
>and the Linux kernel, and you could just pass it in there.

Definitely. My position is to use a tagged structure (the bootinfo stuff
Cort added recently is nice, but I don't like the way it's "found" by
the kernel). Then, we could enter the kernel with something like

  r3 = magic value (just to be able to have a clean transition of
       old & new booting style)
  r4 = physical pointer to the boot infos (which are
       supposed to be appended after the kernel image).


The kernel would be required to be entered with MMU off (or MMU on with
a 1:1 mapping, but I'd like to avoid handling all those nasty cases in
head.S). It could be located anywhere, but the bootinfos would have to
be appended to the kernel image to avoid some nasty overlap issues when
the kernel moves itself down to 0. We can eventually add more restrictions
to the location of the kernel & bootinfos on entry if we want to avoid
all cases of overlap.

The bootinfos would contain no absolute pointers. If pointers are needed,
they must be relative to the beginning of the boot-infos (well, except
for things like pointer to the framebuffer). We can stuff there anything
we want. The OF tree can be a single tag, the initrd too, etc...

>I think all of the boot loaders do this (at least any I have used).
>They determine where they are, move things around in memory and set up
>parameter blocks so the kernel and initrd (or whatever) can run  in
>their proper places.

Right now, they all do it differently, and for OF machines, most of the
job is done by the kernel in the infamous prom.c ;)

>I already have minor modifications from folks at MontaVista to allow
>the kernel to run from masked rom at a relatively arbitrary location.
>I am trying to make these more generic and will be checking them into
>the sources pretty soon.  It is based upon the structure of the
>software as it is today, which seems to work pretty well.

In your case, the kernel could be in ROM, and the boot infos just after
it. The only thing is that the first few instructions of the kernel should
be to load the value of the bootinfos. A way to acheive that would be
to have the kernel begin with a few nops, and have a post-processing pass
of the kernel image that adds the lis/ori pair, append the boot infos,
and generates the flash-able image.

For all other cases (like gemini, etc..), I'd like to avoid special cases
in head.S, and replace those by board-specific piggy-back bootloaders
(arch/ppc/geminiboot for example).

Of course, I'm open to comments & suggestions as I don't intend to hack this
before we have a real 2.5 tree ;)

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
