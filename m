To: Soumya Desai <soumya@tejasnetworks.com>
Cc: gopi@tejasnetworks.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: Accessing file from drivers (fwd) 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 16 Mar 2001 11:02:46 +0530."
             <3AB1A57E.669B3166@tejasnetworks.com>
Date: Fri, 16 Mar 2001 16:06:12 +0100
Message-Id: <20010316150617.953CB281DB@denx.denx.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Dear Soumya,

in message <3AB1A57E.669B3166@tejasnetworks.com> you wrote:
>
>      The exact problem that we're trying to solve, is to program an FPGA with a hex file
> which is in our file system.  But the problem is general is to have a way to write  a

I thought it was something like that. The conventional way  to  solve
this  is  implementing  an  ioctl() call for this function, and use a
user-space program to select the file and feed it into the driver.

> system  call  say 'sys_copy'  which will copy one file to another.  An user-mode
> application would read from one file and write back to another, which would result in
> copying  the data from the file driver ( kernel space ) to the user-space,  and again
> back to the kernel space.  We were curious as to whether a way existed by which we can
> do the read and write, sitting in the kernel space itself.  Of course adding our own

Why do you want to do that? Is this such atime-critical operation? Of
course it's possible to implement such a function, but I'm  not  sure
if it really makes sense.

> ioctl to the drivers will serve the purpose,  but we were looking for some way in which
> we would NOT need to modify the existing file system drivers.  I was wondering if it

Ummm... I don't understand this sentence. Adding an ioctl() for  YOUR
OWN  driver  to  accept  a  buffer with FPGA image date and load that
image into the FLGA does not mean you have to modify  anything  else.
You just have to write a small user application which opens the file,
reads or mmap()s it, and calls that ioctl().

> would be possible to bypass the read/write call themselves, but hack our way into the
> buffer caches of block drivers, to do this ?   Anyone tried something similar ?

Possible? Sure it's possible. But there is some effort involved,  and
your  resulting  solution  is  probably very restricted to a specific
setup. What do you want to save that you are willing to  pay  such  a
price for?

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
I have the simplest tastes.  I am always satisfied with the best.
                                                       -- Oscar Wilde

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
