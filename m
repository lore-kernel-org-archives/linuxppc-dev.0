Date: Mon, 8 Mar 1999 12:17:36 +1100
Message-Id: <199903080117.MAA05033@tango.anu.edu.au>
From: Paul Mackerras <paulus@cs.anu.edu.au>
To: David.Mentre@irisa.fr
CC: linuxppc-dev@lists.linuxppc.org
In-reply-to: <wd8d82m7cjn.fsf@parate.irisa.fr> (David.Mentre@irisa.fr)
Subject: Re: [Linux SMP FAQ] Info request for SMP PPC systems Linux support
Reply-to: Paul.Mackerras@cs.anu.edu.au
References: <wd8d82m7cjn.fsf@parate.irisa.fr>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


David Mentr\\'e <David.Mentre@irisa.fr> wrote:

> I'm the maintainer of the Linux SMP FAQ (see pointer below if you want
> to have a look). Right know, this FAQ is very x86 centric but I plan to
> change that. Looking at linuxppc.org, it seems that :
> 
>  - support is beeing developed (by lead programmer Cort Dougan )for
>    PowerSurge boards. This includes the UMAX s900.

Cort did the initial work to put in the SMP support, I've hacked on it
a bit too to get it working on my SMP powermac (a powermac 7600
upgraded with a dual-processor CPU card).

BTW, "lead programmer" is Cort's designation for himself.  As the
person who did most of the powermac port and is primarily responsible
for its maintenance, that seems a little grandiose to me.  Not that I
want to detract from Cort's enormous contribution, particularly in the
area of Linux for PReP and embedded systems.

>  2. is there any specific things to do to make a PPC SMP system?
>     (kernel compilation, boot, etc.)

Booting is the same as UP.  To compile a kernel, you have to select
CONFIG_SMP and `make clean', then make vmlinux.

If you want to be able to boot either an SMP or UP kernel, you have to
have a separate set of modules for each.  I do this by having
/lib/modules/2.2.2-UP and /lib/modules/2.2.2-SMP (for example) and the
startup scripts make /lib/modules/2.2.2 a symlink to one or the other,
depending on which kernel I have booted.

>  3. is there a mailing-list I should subscribe to to have further info
>     on this subject (i.e. SMP && PPC && Linux)?

There isn't any specific mailing list for SMP Linux/PPC, partly
because SMP PPC systems are rare - only the highest-end powermacs were
SMP, and there aren't any SMP powermacs being made by Apple at present
AFAIK.  There are PPC-based RS/6000 machines which are SMP but AFAIK
they are not supported by Linux/PPC currently.

>  4. any bench result of SMP system?

What would you like?  I could try an lmbench run.  It won't give
terribly impressive numbers on my SMP machine, though, since it's a >3
year old motherboard with a relatively slow memory system.  (In fact
my iMac running Linux/PPC can compile a kernel faster than my SMP
box. :-)

Paul.

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
