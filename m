Date: Thu, 25 Mar 1999 10:12:24 +1100
Message-Id: <199903242312.KAA31937@tango.anu.edu.au>
From: Paul Mackerras <paulus@cs.anu.edu.au>
To: paubert@iram.es
CC: bh40@calva.net, linuxppc-dev@lists.linuxppc.org
In-reply-to: <Pine.HPP.3.96.990324094215.1078L-100000@gra-ux1.iram.es>
	(message from Gabriel Paubert on Wed, 24 Mar 1999 10:30:07 +0100
	(MET))
Subject: Re: Blue G3 and machine check
Reply-to: Paul.Mackerras@cs.anu.edu.au
References: <Pine.HPP.3.96.990324094215.1078L-100000@gra-ux1.iram.es>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Gabriel Paubert <paubert@iram.es> wrote:

> Note that you probably only need to protect the PCI config space accesses,

If we are getting machine checks on config space accesses, then it is
truly borken.  Config spaces accesses in PCI are supposed to return ~0
if there is no device there, precisely so that you can safely probe to
see whether the device is there.

Did the original poster say whether the machine checks were on config
space accesses or I/O or memory space accesses?  It's common enough
for drivers written for intel linux to go probing I/O ports to try to
find devices to talk to.

> for example by adding a handler to the actual accesses with code looking
> like (memop may be l[bhw]z, st[bhw], l[hw]brx, st[hw]brx):
> 
> 	sync
> 	isync
> 1:	memop reg,addr
> 2:	sync
> 3:	isync
> 4:	
> 
> (I think that at least one of the isync is probably unnecessary and
> perhaps both, but I'd rather choose the safe solution for this). 
> in the exception table (replace 5f by 4b for the stores):
> 	.long 1b,5f
> 	.long 2b,5f
> 	.long 3b,5f
> 
> and in the fixup section (for the loads only):
> 5:	li reg,-1
> 	b  4b

I think this is not sufficient because you are not generally
guaranteed anything about the state of the registers after a machine
check.  AFAICS, we would have to save the contents of all the
registers (at least all of the callee-saved ones) and restore them
from memory if a machine check occurs.  We could use setjmp/longjmp to
do this.  And yes, we do need the sync after the access, but I don't
see why we would need the isync.

Paul.

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
