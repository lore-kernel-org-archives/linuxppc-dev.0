Date: Fri, 13 Sep 2002 20:41:42 -0800
From: Ethan Benson <erbenson@alaska.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: RFC: Performance Monitor Counters device
Message-ID: <20020914044142.GR714@plato.local.lan>
References: <3D80F2F7.3FB3AE4B@koffie.nl>
Mime-Version: 1.0
In-Reply-To: <3D80F2F7.3FB3AE4B@koffie.nl>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Sep 12, 2002 at 10:03:02PM +0200, Segher Boessenkool wrote:
>
> Now the questions ;)
>
> 1) What's the best interface for this kind of thing?  A char
>    device?  With ioctl()'s?  a sysctl?  something in /proc?
>    I'm not interested in ease of implementation (I'll have to
>    hack some on gprof too, for this -- so I'm not afraid of
>    the kernel ;) ), but in what's philosophically/technically/
>    procatically the best interface.


just my humble opinions but:

ioctl() is the sewer of unix, its satanic don't use it.

/proc is a linux dumping ground for endless random cruft that belongs
somewhere else.  stop the pollution.

sysctl doesn't seem applicable since its more to flip flags and
switchs in the kernel at runtime. (it sounds like your developing a
more involved interface then that).

that leaves a /dev node which i think is probably most appropriate
(and gives you simple access control via standard permissions for
free)

> 4) Security: I want to generate most of the settings in userland,
>    for maximum ease of use and ease of implementation; but that
>    brings up some security issues.  Only allowing root to
>    profile code isn't ideal, either.  So:
>    a) Don't automagically load the module; if root loads it, let's
>       hope he knows what he's doing;

just loading the module shouldn't remove all security IMO.

>    b) Have the pmc device be accessible only to a 'trusted' group;

this i think is the best way, just implement the interface solely
though a /dev device node, the admin can set the mode to 660 and group
to whatever and thus control access through standard unix permissions.

>    c) A setuid driver program to start profiling;

ugh, don't do setuid, its a massive ammount of work to try and make it
safe.

--
Ethan Benson
http://www.alaska.net/~erbenson/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
