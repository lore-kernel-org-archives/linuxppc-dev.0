Message-ID: <36D506B0.72582B7E@wanadoo.fr>
Date: Thu, 25 Feb 1999 09:15:44 +0100
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: nsheeley@austin.rr.com
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: semaphore-helper.h
References: <013092421221829FE5@mail5.austin.rr.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


When I just rechecked, I saw that it is fixed now!
Paul and Gary are faster than the delays in the mailing lists.
Thanks!

--
Martin

nsheeley@austin.rr.com wrote:
> 
> I just checked out the current CVS from
> 
> :pserver:cvs@cvs.samba.org:/cvsroot
> 
> All seems well until I try to do a make:
> 
> make[2]: Entering directory `/local/src/CVS_kernel/linux/kernel'
> gcc -D__KERNEL__ -I/local/src/CVS_kernel/linux/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -D__powerpc__ -fsigned-char -msoft-float -pipe -fno-builtin -ffixed-r2 -Wno-uninitialized -mmultiple -mstring   -fno-omit-frame-pointer -c -o sched.o sched.c
> sched.c:39: asm/semaphore-helper.h: No such file or directory

You don't get the __down_trylock error in ksyms.c? Did they already
start repairing the 2.2.2 bug?

> 
> Hmm.. only three arch's asm-includes have semaphore-helper.h
> (i386, sparc, sparc64), but its not ifdef'ed in any way in
> sched.c
> 
> So my question are:
> 
>         a.  Should I expect to be able to CVS checkout and
>             make a working kernel?  I am wondering about the stability
>             of the tree -- what's my percent chance that I won't have
>             to debug anything?

In principle, it should work. But there are always bugs possible. And
then there are guys with a weird sense of humour, in this case Linus
Himself. Read
http://lists.linuxppc.org/listarcs/linuxppc-user/199902/msg01298.html

>         b.  If yes to a., does anyone have a patch for the above problem.

Check out ("cvs update") kernel/ksyms.c -r1.107 and kernel/sched.c
-r1.124.

--
Martin

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
