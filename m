Date: Mon, 1 Feb 1999 22:18:53 +0100
To: linuxppc-dev@lists.linuxppc.org, Paul Mackerras <paulus@cs.anu.edu.au>
CC: Cort Dougan <cort@ladron.cs.nmt.edu>
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Bogus mouse key events
Message-Id: <19990201221853.005850@mail.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I finally found where my conflicts on the PowerBook G3 Series and the
"Fn" key came from. It's simple: the "fake" keycode used by the console
code (and so by Xpmac) for the middle button is 0x3f, which is also the
keycode used by this "Fn" key...

So either we change the middle key code in both the kernel and Xpmac, or
(simpler), we add code for remapping the "Fn" key to something else.

I'm not (yet) very familiar with the linux keymap and keycode-map, so I
would like someone who knows this better than me to suggest a keycode to
which I could remap the "Fn" key without conflicting. I was thinking
about the equivalent of PC's alt-gr, but it may cause other kind of trouble.

This key must be handled in a really special way, since it may be used as
a mouse button modifier (using the "adb_buttons=2,x,y" patch), but it
should be ingnored in some cases (page-up, page down for example) since
the keyboard hardware will automatically send the correct modified keycodes.

So, any suggestion for a new keycode that won't conflict with anyone ?


-- 
           E-Mail: <mailto:bh40@calva.net>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>





[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
