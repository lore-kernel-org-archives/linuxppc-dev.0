Message-Id: <199906110911.LAA32422@denx.muc.de>
To: Marcus Sundberg <erammsu@kieraypc01.p.y.ki.era.ericsson.se>
cc: linuxppc-dev@lists.linuxppc.org
From: Wolfgang Denk <wd@denx.muc.de>
Subject: Re: MPC8xx: Bad emulation
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 11 Jun 1999 09:23:16 +0200."
             <3760B964.E1424E37@switchboard.ericsson.se>
Date: Fri, 11 Jun 1999 11:11:17 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


In message <3760B964.E1424E37@switchboard.ericsson.se>
Marcus Sundberg wrote:
> 
> Don't use floating point instructions in the programs, embedded PPC
> doesn't have FPUs. Use -mcpu=860 -msoft-float when compiling to use

Yes, I know this.

> soft floats (note that all FP using programs and libraries must
> be recompiled with these options to work properly).
> You will also need to patch glibc to remove the FP inline assembly
> and the inline memcpy  which assumes 32 byte cache lines.

And this is exactly the point that  makes  this  option  unacceptable
from  the  practical  point  of  view. We would have to build special
MPC8xx releases of LinuxPPC then. 

How does this work for you? You may have a small embedded system with
just  a  small  set  of  applications  in  mind,   where   `-mcpu=860
-msoft-float'  works  fine; but once you have Linux running on such a
board, it *always* happens that you run  into  situations  where  you
want  to  do some things in native mode - well, no problem: mount the
Linux environment over NFS. Then you can dynamically load and  unload
(and debug) device drivers, etc.

And suddenly you will need this tool and that one, too.

Your customer asks: And could I run a web server on  this  box,  too?
You say: well, no problem, just start appache - and "Bad emulation".

There are *many* situations where it is really necessary to  be  able
to run _any_ binary from a standrad LinuxPPC distribution on the 860,
too.  I agree that it makes sense to recompile dedicated applications
for an embedded solution.

Wolfgang Denk

-- 
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"He only drinks when he gets depressed." "Why does he get depressed?"
"Sometimes it's because he hasn't had a drink."
                                     - Terry Pratchett, _Men at Arms_

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
