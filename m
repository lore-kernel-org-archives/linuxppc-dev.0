MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Ctrl-C works just fine.
Date: Thu, 6 Sep 2001 11:07:34 -0500
Message-ID: <3A494DE356A49A40B37442E1E0D9F3B5063440@ptah.ad.newisys.com>
From: "Navin Boppuri" <navin.boppuri@newisys.com>
To: "Mark Hatle" <fray@mvista.com>,
	"Linuxppc-Embedded (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Ctrl-C works just fine on everything now, thanks to Cal Erickson. The
trick is to make /dev/console a symbolic link to ur serial port
/dev/ttyS0 or S1.

Navin.


-----Original Message-----
From: Mark Hatle [mailto:fray@mvista.com]
Sent: Thursday, September 06, 2001 10:38 AM
To: Navin Boppuri
Cc: Linuxppc-Embedded (E-mail)
Subject: Re: Ctrl-C does not work


Navin Boppuri wrote:
>
> Hello everyone,
>
> Ctrl-C does on work on my serial console when I use the sample file
> system from Hardhat 1.0 toolkit. It , however, works with the Hardhat
> 1.2 toolkit sample file system. I am using the same kernel to test
both
> the file systems. What could be different between these two file
> systems?
>
> Thank you,
> Navin

Actually control-c should _NOT_ be working on Cross Dev Kit 1.0, or
1.2.  If it does work in one you are lucky.  There is a problem with the
way the serial consoles are started on CDK 1.0 and 1.2, it was left up
to the serial driver to turn on or off the control-c activation.

Under HHL 2.0, this problem has been resolved by using getty and login
to start a serial connection.  login has a patch that ensures that the
control-c stuff is enabled.

I would highly recommend that you move forward to HHL 2.0 if you can, it
has a lot of these minor annoyances fixed.

--Mark Hatle
MontaVista Software, Inc.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
