Date: Sat, 19 Jun 1999 00:19:46 +0200
To: linuxppc-dev@lists.linuxppc.org, huberj@WPI.EDU
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Sleeping the powerbook G3 (more)
Message-Id: <19990619001946.029087@mail.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I think I have located the piece of MacOS nanokernel code that handles
the lowest level steps of the sleep/wakeup process.

You need MacOS 8.6. Open the 'krnl' resource, it contains the nanokernel.
The function that handles storing the CPU context, putting the 'Lars' and
function pointers to low memory, and the code called just after wakeup
(the function pointer) begins at offset 0x6c54 of the nanokernel. It's a
huge function that does all sorts of things, mostly saving lots of stuffs
to memory (registers, sprs, ...), calling a function at offset 0x7228
that puts things to low-mem 0 & 4, and resuming.
The function pointer itself is the lr on entry of the function at offset
0x7228, so waking up just resume normal execution after the call to this
function.

If you want to disassemble that stuff with MacsBug, either load manually
this resource somewhere in RAM, or locate the nanokernel in memory with
the 'f' command.

I can't spend more time on this for now, so if someone wants to continue...


-- 
           Perso. e-mail: <mailto:bh40@calva.net>
           Work   e-mail: <mailto:benh@mipsys.com>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>




[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
