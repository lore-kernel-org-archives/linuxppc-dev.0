From: Joe Green <jgreen@mvista.com>
To: Mark Hatle <fray@mvista.com>, Kent Borg <kentborg@wavemark.com>
Subject: Re: Running from ROM
Date: Mon, 5 Jun 2000 15:21:14 -0700
Content-Type: text/plain
Cc: linuxppc-embedded@lists.linuxppc.org
References: <200006052137.RAA29282@rome.wavemark.com> <393C23CC.3289DD1F@mvista.com>
In-Reply-To: <393C23CC.3289DD1F@mvista.com>
MIME-Version: 1.0
Message-Id: <00060516034300.24189@minotaur.mvista.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, 05 Jun 2000, Mark Hatle wrote:
> We (MontaVista Software) are working on that.  I'm not sure schedules or
> status of the project.
>
> The idea is to have the ROM at 0x000000000 and run the kernel out of
> ROM, and then have the writable structures of the kernel is some RAM
> space.

We already have this working for a customer, though the RAM is actually
still mapped at 0, with the ROM at another address.

> Kent Borg wrote:
> > I am doing some early investigation of the suitability of embedded
> > Linux.  I am wondering about program loading.
> >
> > Traditionally, embedded systems run their programming directly out of
> > ROM.  Linux doesn't seem to have any concept of such a thing.  But if
> > I have a large embedded application that needs every bit of its RAM
> > and ROM, I would like to find a way to get Linux to run directly out
> > of ROM with no moving parts (no disks).  Anyone doing that?

The project Mark mentioned is specifically for running the kernel from
ROM.  Are you also asking about running application code from ROM?  We
have customers now who keep compressed file systems in ROM, where pages
are copied into RAM to be executed.  We're also looking into direct
execution of application code from ROM, but keep in mind that this
would mean the code could not be compressed.  If significant amounts of
your code are executed infrequently, a compressed file system with
pages brought in as needed may produce the best overall footprint.

--
Joe Green <jgreen@mvista.com>
MontaVista Software, Inc.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
