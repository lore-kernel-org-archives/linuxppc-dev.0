Message-Id: <sc18bbdf.069@mail.frequentis.com>
Date: Thu, 13 Dec 2001 14:31:32 +0100
From: "Gerhard TAEUBL" <Gerhard.TAEUBL@frequentis.com>
To: <linuxppc-embedded@lists.linuxppc.org>,
	<Frederic.Goddeeris@siemens.atea.be>
Subject: Re: RE: RE: Password for embedded Linux
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


The problem is, that the line

Password:

after login dosen't comes up! Also after calling passwd, only

#passwd
Changing password for root
Bad password: too short.

Warning: weak password (continuing).
Password changed.
#

appears. I think something necessary isn't on the filesystem, but I don't know what!

>>> Goddeeris Frederic <Frederic.Goddeeris@siemens.atea.be> 12/13/01 13:57 PM >>>
I suppose you now have a /etc/passwd that does not specify any password for
root. So it is normal it does not ask for one when logging in, telnet to it
or change the pw.

"root" as pw is too small, take something different but when you insist and
enter it a second time it should accept it...

telnet otncllf
Trying 193.210.198.203...
Connected to otncllf.atea.be.
Escape character is '^]'.

target login: root
Password:
Linux target 2.4.2_hhl20 #44 Wed Dec 12 14:21:21 CET 2001 ppc unknown

Welcome to MontaVista Software's Hard Hat Linux.



BusyBox v0.60.2 (2001.11.28-10:02+0000) Built-in shell (ash)
Enter 'help' for a list of built-in commands.

# passwd
Changing password for root
Enter the new password (minimum of 5, maximum of 8 characters)

                         Please use a combination of upper and lower case
letters and numbers.
Enter new password:
Bad password: too short.

Warning: weak password (continuing).
Re-enter new password:
Password changed.
#

-----Original Message-----
From: Gerhard TAEUBL
To: linuxppc-embedded@lists.linuxppc.org; Frederic.Goddeeris@siemens.atea.be
Sent: 12/13/01 1:18 PM
Subject: Re: RE: Password for embedded Linux


I load the tinylogin and compile it (wow it works without any
modification expect the path for corss compile),  could still login!
But when I try passwd and enter for example root I get the error message
to short. It didn't ask me for any old or new password, only it is to
shoort. Also if I do telnet, it won't ask for any password only login I
enter root, thats it! So what do I need?

jffs2: I didn't make tests with heavy load, I only copy some files to
the disk and start it there. This I will do in January.

Gerhard

>>> Goddeeris Frederic <Frederic.Goddeeris@siemens.atea.be> 12/13/01
11:07 AM >>>
 My experience is that you need to include a lot of things for the
login.
I used TinyLogin. This will provide everything you need (I also used
Busybox)
In /etc/inittab I added
	ttyS0::respawn:/sbin/getty -L ttyS0 9600 vt100
/sbin/getty points to TinyLogin
getty -> ../bin/tinylogin

You have good experience with JFFS2? What version do you use?

Fred

-----Original Message-----
From: Gerhard TAEUBL
To: linuxppc-embedded@lists.linuxppc.org
Sent: 12/13/01 10:49 AM
Subject: Password for embedded Linux


Hi!

We use HHL1.2 filesystem for a MPC860. Meanwhile everthing works fine
:-) (serial port, jffs2 and so on). I've made a initrd to boot the
system and mount 4MB Flash where the project related data and programs
will be copied. So we could use for nearly every project the same image,
and store the data afterwards via ftp. O.K. but we want to use a
password to login, and I didn't find any hint to do that! So if you have
any ideas...
Thanks in advance
Gerhard


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
