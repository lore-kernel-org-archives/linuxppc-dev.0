Message-ID: <36DF4486.6E098903@andrew.cmu.edu>
Date: Thu, 04 Mar 1999 21:42:14 -0500
From: Randy Gobbel <gobbel@andrew.cmu.edu>
MIME-Version: 1.0
To: David Edelsohn <dje@watson.ibm.com>
CC: kbhend@business.wm.edu, gdt@linuxppc.org, sbb@gnu.org,
        linuxppc-dev@lists.linuxppc.org, egcs@egcs.cygnus.com
Subject: Re: Problem with egcs and denormalized constants?
References: <9903042352.AA37658@marc.watson.ibm.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


David Edelsohn wrote:
> 
> >>>>> Randy Gobbel writes:
> 
> Randy> P.S.: I just said the flMin problem was an egcs bug.  It's actually an
> Randy> asm bug, because the constant is correct in the .s file:
> 
> Randy> .LC8:
> Randy> .float 0d1.40129846432481707092e-45
> 
>         If I understand correctly, the bug actually is in glibc.  I
> presume that the GNU assembler is not receiving the correct value when it
> calls upon glibc to parse the constant for it to emit into the object
> file.

I've been poking around in binutils a bit, and it looks to me like the
badness is actually in gas.  Somewhere in expr.c is my current best
guess.  As far as I can tell, gas doesn't actually call glibc to
translate numbers, it has its own hairy platform-independent stuff for
that.

-Randy
-- 
http://www.cnbc.cmu.edu/~gobbel/
PGP fingerprint: 32 8A E8 24 A1 46 26 BC  F9 9D 0E B6 81 A9 02 0C

NOTICE: I DO NOT ACCEPT UNSOLICITED COMMERCIAL EMAIL MESSAGES OF ANY
KIND.

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
