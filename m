In-Reply-To: <199908310148.LAA14647@tango.anu.edu.au>
Date: Tue, 31 Aug 1999 15:08:26 +0200
To: Paul.Mackerras@cs.anu.edu.au, linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Improving gatwick interrupts
Message-Id: <19990831150826.024152@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi !

The current implementation of the interrupt handler for gatwick (the
second mac-io found on some PowerBooks) is not perfect. Currently, it's a
special handler for the cascaded interrupt which will decode the GW
interrupt and call back recursively the ppc_irq_dispatch_handler.

That means that while a given GW interrupt is beeing handled, all other
GW interrupts are suspended (masked). In theory, once we have ask&mask'ed
the real interrupt in GW controller, we could re-enable the GW cascade
interrupt itself to let other interrupts come in from the second controller. 

The problem is that it requires an awful hack to the current
architecture, like passing a special parameter to
ppc_irq_dispatch_handler with the interrupt to re-enable after the
ack&mask operation.

Do you think there is interest in doing that ? Currently, the only
possible users of GW interrupts are the internal modem of the wallstreet,
the left media bay IDE devices or the left media bay floppies.


-- 
           Perso. e-mail: <mailto:bh40@calva.net>
           Work   e-mail: <mailto:benh@mipsys.com>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
