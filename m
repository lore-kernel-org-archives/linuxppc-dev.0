Date: Sat, 26 Dec 1998 14:14:56 +0100
To: linuxppc-dev@lists.linuxppc.org
CC: Paul Mackerras <paulus@cs.anu.edu.au>
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: PPP & dead serial ports
Message-Id: <19981226141456.008888@smtp.calvacom.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi All !

I don't know exactly how this is expected to work, but I do have a clue
about the serial port problem people are having (after using PPP, the
serial port looks dead and doesn't receive any more chars).

On my testings, I've seen that when PPP fails, it leaves the serial port
opened, probably with a bad flow control state, shutdown() never gets
called (the count is left to 2).
So on later use of the port, the SCC is not properly re-initialized, and
any bad state or setting that would have been left by the previous
connection will still be here.

Another side effect is that the internal modem of the PowerBook will not
be powered down (at least, in my not-yet-unreleased patches that
cleans-up things by moving power-up/power-down of the modem to startup
and shutdown).

I'll try to find out what's going on there, but this may take me very
much longer than people who know linux better than me, so feel free to
give me any clue or do your own testings.


-- 
           E-Mail: <mailto:bh40@calva.net>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>




[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
