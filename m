Message-Id: <4.2.0.37.19990430153444.048303a0@mail.lauterbach.com>
Date: Fri, 30 Apr 1999 15:42:26 +0200
To: Richard Henderson <rth@cygnus.com>
From: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
Subject: Re: PATCH: Fix 2 PPC/SYSV varargs problems
Cc: egcs-patches@egcs.cygnus.com, meissner@cygnus.com,
        David Edelsohn <dje@watson.ibm.com>, linuxppc-dev@lists.linuxppc.org
In-Reply-To: <19990429194817.B20300@cygnus.com>
References: <4.2.0.37.19990430013458.0489a950@mail.lauterbach.com>
 <4.2.0.37.19990430013458.0489a950@mail.lauterbach.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 04:48 30.04.99 , Richard Henderson wrote:
>On Fri, Apr 30, 1999 at 02:09:09AM +0200, Franz Sirl wrote:
> > 1. the varargs save area calculation bug, this is a hack and Richard ;-)
> > probably won't like it, but maybe it's good enough for egcs-1.2
>
>You're right -- I hate it.  You'll have made it so I can't build a
>ppc cross compiler on my Alphas, and you'll have killed the compiler
>for a ppc64-linux.

Yes, thought so ;-).

>Here's an implementation of what I'd suggested before.  It looks ok
>to the eye, but I don't have a ppc-linux box handy to try it out on.

Yes, this looks good (such a patch is certainly above my current knowledge 
of egcs :-) ) and works fine on powerpc-linux-gnu, I just bootstrapped and 
checked the mainline with it. You just missed a small bit in 
setup_incoming_varargs():

    if (DEFAULT_ABI == ABI_V4 || DEFAULT_ABI == ABI_SOLARIS)
      {
        rs6000_sysv_varargs_p = 1;
        if (! no_rtl)
-       save_area = plus_constant (frame_pointer_rtx, RS6000_VARARGS_OFFSET);
+       save_area = plus_constant (virtual_stack_vars_rtx, 
-RS6000_VARARGS_SIZE);
      }

Can you check in this stuff in that shape? And maybe the second part (the 
gnuplot fix) of my patch if it is OK and the testcase?

Franz


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
