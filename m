Date: Thu, 31 Jan 2002 12:09:22 -0500
From: Daniel Jacobowitz <dmj+@andrew.cmu.edu>
To: gopi@india.tejasnetworks.com
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: why is tty->pgrp set to -1 for console?
Message-ID: <20020131120922.A6447@nevyn.them.org>
References: <Pine.LNX.4.21.0201301141250.25516-100000@tn100build.india.tejasnetworks.com> <Pine.LNX.4.21.0201312050570.1490-100000@tn100build.india.tejasnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.21.0201312050570.1490-100000@tn100build.india.tejasnetworks.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Jan 31, 2002 at 08:58:58PM +0000, gopi@india.tejasnetworks.com wrote:
>
> hi..
>
>   We had a problem that ctrl-c was not working on the console.  I
> figured out that, ctrl-c was getting recognized as the 'intr' signal,
> but the function isig (in drivers/char/n_tty.c) sends a signal only if
> the tty->pgrp > 0.
>
>   I have put a print stmt in this function and checked that the value
>   is 'tty->pgrp = ffffffff' (which is -1).
>
>   What is the correct procedure to follow to get around this problem
> and get ctrl-c working on console?

You need to run a getty on the console in order for SIGINT to get sent
properly.  That should be all it takes.  If the pgrp hasn't been set
yet, the kernel doesn't know where to send them.

--
Daniel Jacobowitz                           Carnegie Mellon University
MontaVista Software                         Debian GNU/Linux Developer

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
