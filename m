Return-Path: <owner-linuxppc-dev@lists.linuxppc.org>
Message-ID: <3AB1A57E.669B3166@tejasnetworks.com>
Date: Fri, 16 Mar 2001 11:02:46 +0530
From: Soumya Desai <soumya@tejasnetworks.com>
MIME-Version: 1.0
To: wd@denx.de
Cc: gopi@tejasnetworks.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: Accessing file from drivers (fwd)
References: <Pine.LNX.4.21.0103160943270.9927-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>

Hi Wolfgang,

     The exact problem that we're trying to solve, is to program an FPGA with a hex file
which is in our file system.  But the problem is general is to have a way to write  a
system  call  say 'sys_copy'  which will copy one file to another.  An user-mode
application would read from one file and write back to another, which would result in
copying  the data from the file driver ( kernel space ) to the user-space,  and again
back to the kernel space.  We were curious as to whether a way existed by which we can
do the read and write, sitting in the kernel space itself.  Of course adding our own
ioctl to the drivers will serve the purpose,  but we were looking for some way in which
we would NOT need to modify the existing file system drivers.  I was wondering if it
would be possible to bypass the read/write call themselves, but hack our way into the
buffer caches of block drivers, to do this ?   Anyone tried something similar ?

Regards,
Soumya.

>
> ---------- Forwarded message ----------
> Date: Thu, 15 Mar 2001 15:04:31 +0100
> From: Wolfgang Denk <wd@denx.de>
> To: gopi@tejasnetworks.com
> Cc: linuxppc-dev@lists.linuxppc.org
> Subject: Re: Accessing file from drivers
>
> In message <Pine.LNX.4.21.0103151822090.9108-100000@localhost.localdomain> you wrote:
> >
> >   Is it possible to read and write to files (say /etc/xyz)
> > in a device driver without resorting to user space?  I want
>
> You do not want to do this. It's bad design. Implement an ioctl() for
> the configuration, and use that.
>
> Wolfgang Denk
>
> --
> Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
> Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
> "Send lawyers, guns and money..."  - Lyrics from a Warren Zevon song


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
