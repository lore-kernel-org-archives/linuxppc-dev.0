Date: Fri, 20 Aug 1999 15:30:31 -0700 (MST)
From: Matt Porter <mporter@phx.mcd.mot.com>
To: Daniel Jacobowitz <drow@false.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: string.h conflicting types warnings
In-Reply-To: <19990820010445.A7322@them.org>
Message-Id: <Pine.LNX.4.10.9908201527560.22988-100000@fwrsl-11.phx.mcd.mot.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 20 Aug 1999, Daniel Jacobowitz wrote:
> On Thu, Aug 19, 1999 at 02:12:33PM -0700, Matt Porter wrote:
> > I'm working on a standalone driver and have been running into these
> > warnings lately.  Whilst compiling Mac-on-Linux I also got these
> > warnings as well.  Searching around I only found some netbsd folks
> > gettings these same warnings.  Anyone have an idea where this comes from? 
> 
> > /usr/include/linux/string.h:31: warning: conflicting types for built-in
> > function `memset'
> 
> Easy.  Anything that is including linux/string.h should be a module -
> otherwise it needs to rearrange its choice of include files.  Any
> module should use the settings from the kernel makefiles, which
> include:
>  -mmultiple -mstring -ffixed-r2 -fno-builtins
> 
> It's that last one you really want.

That's it.   Only difference is that it is actually "-fno-builtin" for
anybody else reading this...  
 
Thanks,

--
Matt Porter                                       Motorola Computer Group
matt_porter@mcg.mot.com                           CIBU Linux Support


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
