Date: Wed, 7 Mar 2001 14:10:14 -0500
From: Daniel Jacobowitz <dmj+@andrew.cmu.edu>
To: Alexandre.Nikolaev@matrox.com
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: who loads argc in elf binary???????
Message-ID: <20010307141014.A28040@nevyn.them.org>
References: <3AA50A43.FA070FDE@matrox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3AA50A43.FA070FDE@matrox.com>; from anikolae@matrox.com on Tue, Mar 06, 2001 at 11:03:15AM -0500
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Mar 06, 2001 at 11:03:15AM -0500, Alexandre Nikolaev wrote:
>
> Hi!
>
> We are trying montavista kernel .4 on G4. Upon starting of ELF binary,
> the r3, which should contain argc, always reads 0 (for any program). r4
> is ok.
> What could be the problem?
> Who is responsible for loading r3?
>
> I would really appreciate if someone can help!

argc and argv are created by the kernel, based on what is given in
exec().  It has to go through the dynamic loader and any start code
before it gets to main, though.  Are you using any custom crt* code, or
otherwise linking oddly?  If so, look there.

I also seem to recall that the arguments are loaded into registers by
the application, off the stack.  I'm not entirely sure of that, though.

--
Daniel Jacobowitz                           Debian GNU/Linux Developer
Monta Vista Software                              Debian Security Team
                         "I am croutons!"

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
