Date: Wed, 23 Dec 1998 11:14:12 +0100
To: "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
CC: linuxppc-user@lists.linuxppc.org, Paul Mackerras <paulus@cs.anu.edu.au>
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: ADB spy tool
Message-Id: <19981223111412.008601@mail.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I've built a little tools for tracing ADB requests issued by MacOS.
There's a little INIT that records all ADB commands issues thru the
_ADBOp trap and an application for displaying those traces. It also
records the datas with the outgoing command. Since it's not a tail patch,
it won't display incoming datas, but you can use a tool like ADB Parser
to read the content of registers.

With this tool, you can spy the activity of your device, see all the
commands issued by the driver to the device, etc...

The INIT will start recording in a ring buffer as soon as it's loaded, so
if you want to to loard earlier, you may want to change it's type to
'scri'. The ring buffer is about 32k and older traces are lost when it's
full. The application for emptying the buffer is PPC only unless you ask
for a 68k version. If you use MountX, make sure you don't use the debug
version of MountX nor it's trace application, it will conflict with this
patch (will be fixed in an new bootx release).



-- 
           E-Mail: <mailto:bh40@calva.net>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>





[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
