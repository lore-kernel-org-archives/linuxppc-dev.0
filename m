Date: Fri, 19 Feb 1999 15:36:05 +0100
To: linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Serial port test
Message-Id: <19990219153605.011726@mail.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


If you have an heathrow, paddington or ohare based machine, and
especially if you have problems (garbage) with the serial port, please
test the following with xmon or MacsBug:

Test if there is a 1 byte register at (baseaddress + 0x80). baseaddress
is the base of the escc itself, that is the base of channel B (f3013000
on heathrow based machines). test also baseaddress+0x60.

On my machines, I have 0x08. If you have problems, try changing your
value to 0x08 or higher. This is the recovery count value of the ESCC
(the number of cycles to wait between each access) and it may not be
correctly initialised by OF. I'm not sure yet, but I think one some
models, MacOS will reinit  it too late in the boot process for BootX
Extension.

Try this from linux booted via OF, BootX Extension and BootX App, tell me
if you see different values.


-- 
           E-Mail: <mailto:bh40@calva.net>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>





[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
