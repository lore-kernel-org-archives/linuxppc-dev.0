Date: Tue, 20 Apr 1999 23:26:01 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: David Edelsohn <dje@watson.ibm.com>
cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Current egcs, binutils and kernel (fwd) 
In-Reply-To: <199904202114.RAA69332@kitch12.watson.ibm.com>
Message-ID: <Pine.HPP.3.96.990420231555.20020R-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On Tue, 20 Apr 1999, David Edelsohn wrote:

> 	The purpose of my earlier message was to explain what was
> occurring in rs6000.md and why GCC was calling the function instead of
> inlining the code.  I thought that some people might actually want to
> understand *WHY* the function was required and why GCC was behaving as
> designed. 

Ok, calm down. But I still don't know why GCC does not expand this inline. 
It's 8 or 10 instructions, without branches so it's not much bigger than a
call for which you have to set up 3 parameter registers and which may
destroy many more registers according to the ABI conventions.
Furthermore if only one of the 2 result registers is needed, it may be
simplified quite significantly (i'm not sure it's easy to do in current
GCC to split a variable using 2 registers to remove dead code).

Maybe it's time to add the alternatives in rs6000.md, enabled with a
-minline-longlongshifts option. But I don't yet know enough of GCC to 
implement it.

	Gabriel. 


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
