Date: Fri, 20 Aug 1999 01:04:45 -0400
From: Daniel Jacobowitz <drow@false.org>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: string.h conflicting types warnings
Message-ID: <19990820010445.A7322@them.org>
References: <Pine.LNX.3.96.990819141202.8759P-100000@liberty.chnd1.az.home.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.3.96.990819141202.8759P-100000@liberty.chnd1.az.home.com>; from Matt Porter on Thu, Aug 19, 1999 at 02:12:33PM -0700
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Aug 19, 1999 at 02:12:33PM -0700, Matt Porter wrote:
> 
> Hi,
>                      
> I'm working on a standalone driver and have been running into these
> warnings lately.  Whilst compiling Mac-on-Linux I also got these
> warnings as well.  Searching around I only found some netbsd folks
> gettings these same warnings.  Anyone have an idea where this comes from? 

> /usr/include/linux/string.h:31: warning: conflicting types for built-in
> function `memset'

Easy.  Anything that is including linux/string.h should be a module -
otherwise it needs to rearrange its choice of include files.  Any
module should use the settings from the kernel makefiles, which
include:
 -mmultiple -mstring -ffixed-r2 -fno-builtins

It's that last one you really want.

Dan

/--------------------------------\  /--------------------------------\
|       Daniel Jacobowitz        |__|        SCS Class of 2002       |
|   Debian GNU/Linux Developer    __    Carnegie Mellon University   |
|         dan@debian.org         |  |       dmj+@andrew.cmu.edu      |
\--------------------------------/  \--------------------------------/

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
