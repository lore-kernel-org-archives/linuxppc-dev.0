Message-ID: <3959E550.3CC61CD@wibble.net>
Date: Wed, 28 Jun 2000 21:45:20 +1000
From: Steven Hanley <sjh@wibble.net>
MIME-Version: 1.0
To: Gabriel Paubert <paubert@iram.es>,
        Linux PPC Dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: problem with compressing the kernel
References: <Pine.HPX.4.10.10006281021160.5670-100000@gra-ux1.iram.es>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


in response to a few other people, yes I realise you may wish to use
compressed images on non x86 and that it is poossible. Thankyou for
further claryfying some details about the process though. (embedded
machiens hadnt crossed my mind for example)

Gabriel Paubert wrote:
> machines have _always_ been compressed, without a _single_ exception.
> Browsing the tree you'll easily find that there the kernel image is
> compressed (maybe depending on some CONFIG option) on:
>
> - alpha
> - arm
> - i386
> - m68k
> - ppc

well it is how you build them really, you probably type make zImage or
make bzImage or some such, I personally just type make vmlinux for my
ppc kernels as I dont need the compressed kernel so dont use it.

the output is dictated by the command you use to make the kernel, and
the setup in the makefile.

> so please don't claim that it is x86 specific without checking the facts
> first.

it is specific in that x86 is braindead enough that for years the option
was necessary, I am unsure if x86 still needs the compressed image
(anyone?) however as has been pointed out you may use compressed images
on other architectures. I still strongly suspect the person asking on a
ppc list how to compress a kernel for linux on an NT box was somewhat
confused at least.

> This looks more like a documentation error. Nowadays you can get your
> sources with bzip2, but for very long gzip/gunzip was an implicit
> prerequisite to uncompress the kernel tarball (and the patches), otherwise
> you could not even have a look at the requirements. Chicken and egg...

not at all, this list is in the kernel tree, it has nothing to do with
what format you get your kernel in, (rsync or cvs are common, you may
notice, as examples of retrival of both patch updates and full kernel
updates that have no need of gzip (ignoring that both can have and
commonly do have, zlib compiled in and use it during transfer) the
Changes file lists what utilities/tools are needed to actually compile
the kernel. There is no need for bzip2 or gzip in the compilation
process.

> > And of course remember you dont need otr use compressed images on ppc
> > machines.
>
> I do need them. Not all PPC machines are macs, it seems :-)

well if the hardware is embedded or similarly lacking in space as
someone suggested I can understand the need, or possible x86. Otherwise
I would be surprised if the hardware cant handle large images. There is
a difference between "need" and "common use"

>         Regards,
>         Gabriel.

	See You
	    Steve

--
sjh@wibble.net http://wibble.net/~sjh/
Look Up In The Sky
   Is it a bird?  No
      Is it a plane?  No
         Is it a small blue banana?
YES

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
