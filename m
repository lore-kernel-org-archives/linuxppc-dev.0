Date: Mon, 12 Jun 2000 13:42:56 +0200
From: Olaf Hering <olh@suse.de>
To: Michel Lanners <mlan@cpu.lu>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Out of memory?
Message-ID: <20000612134256.B12226@suse.de>
References: <200006121039.MAA03014@piglet.grunz.lu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200006121039.MAA03014@piglet.grunz.lu>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Jun 12, Michel Lanners wrote:


> Jun 12 10:53:13 piglet kernel: VM: killing process gimp
> Jun 12 10:55:03 piglet kernel: VM: killing process X
> Jun 12 10:59:46 piglet kernel: VM: killing process X
> Jun 12 12:04:27 piglet kernel: VM: killing process xfs
>
> and so on... acording to the comment in arch/ppc/mm/fault.c, this
> happens when for some reason the kernel cannot satisfy a paging request.
>
> xfs gets killed when rendering a really big font, X when sending it over
> to gimp, and gimp when working with large images....
>
> What reason is there to kill a process for memory reasons? Does a single
> process need to fit _entirely_ into RAM, or can part of a process be
> swapped out? In all of the above cases, I've always had over 100 megs of
> swap free. Or is there a fixed limit on how big a process can get?

It is only self protection of the kernel to run not out of memory.
The last process that want to allocate memory when memory is low gets
killed. Looks like that is not smart enough when swap is still
available.


Gruss Olaf

--
 $ man clone

BUGS
       Main feature not yet implemented...

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
