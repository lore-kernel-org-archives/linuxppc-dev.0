Date: Sat, 16 Jan 1999 20:22:12 +0100
To: paulus@cs.anu.edu.au, linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: PowerBook battery test
Message-Id: <19990116202212.005640@smtp.calvacom.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I've made a little MacOS tool (with source) that:

 - Gets infos about batteries and charger from MacOS using the Power Manager
 - Gets infos about batteries and charger using 3 different PMU commands:

  0x6b - currently used by Paul's Batmon tool, seems to be obsolete and only
         partially implemented on recent machines. (only flags)

  0x68 - this one is sent by old Power manager functions when querying
the battery. I've not found the exact meaning yet.

  0x6f - this one is sent all the time by MacOS on my machine. It looks
like an extended version of 0x6b with a parameter - the battery number
(1=left, 2=right). I've decoded some of the flags (different from 0x6b)
but not the voltage/current formulas yet.

The MacOS version of the calls will give you decoded values for the
voltage, so we should be able to get a formula easily. They also give
some remaining time estimations, this will probably be more complex to
implement.

I suggest people interested use this tool to gather infos about their
batteries and the PMU behaviour with those 3 different commands. For
example, if the 0x6f command works on the 3400/2400 series, we can make a
new Batmon that works will all powerbooks.

The archive is at:

<ftp://ftp.linuxppc.org/development/users/benh/BatTest.sit>

-- 
           E-Mail: <mailto:bh40@calva.net>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>




[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
