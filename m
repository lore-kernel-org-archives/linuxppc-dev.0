To: Christopher E Cordahi <chris@nanometrics.ca>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Random EMT crashes 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 27 May 2004 13:13:06 EDT."
             <OF831E5D0B.E0575821-ON85256EA1.005CAC65-85256EA1.005E95B8@nanometrics.ca>
Date: Thu, 27 May 2004 20:38:55 +0200
Message-Id: <20040527183900.10913C109F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Christopher,

in message <OF831E5D0B.E0575821-ON85256EA1.005CAC65-85256EA1.005E95B8@nanometrics.ca> you wrote:
>
> When I run Qt/Embedded applications on my DENX 2.4.24 kernel, on a
> MPC852T processor the application tends to randomly crash with EMT trap.

Are you sure that your memory is OK? Problems  like  this  are  very,
very  often  caused by incorrect initialization of the SDRAMs on your
system - they appear to be working fine, but  actually  they  aren;t.
Check  especially  burst accesses. Remember that it is NOT sufficient
to set up the UPM tables, you must also  perform  the  required  chip
initialization sequence as described in the SDRAM manual.

> Running gdb on the target causes problems with several drivers,

And probably any other application  that  uses  lots  of  memory  and
causes  otherwise  heavy load and/or network traffinc will fail, too.
This fortifys my suspicion.

> I've tried running gdbserver on the target, but I can't get it to run.

Why not? The dbserver as included with our ELDK  works  fine  on  all
systems we tested.

> I've read http://www.denx.de/twiki/bin/view/DULG/DebuggingApplication
> guessing as to how to correct a few of the errors on the page.
> (should CROSS_COMPILE include the hyphen, the commands require it
> to be "ppc_8xx-", but the root directory is "/opt/eldk/ppc_8xx")

I see. Yes, this is a bit misleading. Thanks for pointing out.

> Any suggestions where I should look or how to get more information

Check your SDRAM initialization.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
A conservative is a man with two perfectly good legs  who  has  never
learned to walk.                              - Franklin D. Roosevelt

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
