In-Reply-To: <19990618195918.021366>
Date: Fri, 18 Jun 1999 20:47:36 +0200
To: Josh Huber <huberj@WPI.EDU>, linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: Sleeping the powerbook G3 (small progress)
Message-Id: <19990618204736.028551@mail.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Jun 18, 1999, Benjamin Herrenschmidt <bh40@calva.net> wrote:

>>if(*(addr+4) != magic_word) return;
>>*(addr+4) = 0;
>>branch to **addr;

Apparently, that's it, we need to put 'Lars' at address 4 (physical) and
a pointer to a function pointer at address 0. Since the kernel's own
entrypoint is located at those addresses, it should be harmless to
overwrite them.

So basically, to enable sleep, we should, just after sending the PMU
sleep command (the PMU will wait a little bit before shutting you down,
around 1 second I think), backup a complete CPU context along with SPRs
(BATs, segment regs, latest TB value, DEC value, ....), put a physical
pointer to a structure containing the physical pointer to the restore
code first, and the backup infos just after, at address 0, 'Lars' and
then wait to be shutdown.
The restore code will read at 0 to get the pointer to the structure,
restore the registers and, last, re-enable the MMU and jump back to the
sleep code.

If you don't have time to experient with actual coding, tell me, I'll try
this, but I won't have time myself until one or two weeks from now.


-- 
           Perso. e-mail: <mailto:bh40@calva.net>
           Work   e-mail: <mailto:benh@mipsys.com>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>




[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
