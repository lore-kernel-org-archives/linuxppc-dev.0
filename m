Message-ID: <B895EFF5AF34724880036BDB5B5B81481356BA@amer22.avnet.com>
From: "Kerl, John" <John.Kerl@Avnet.com>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: /dev/console writes blocking until read
Date: Thu, 5 Jun 2003 17:00:07 -0700 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello all,

I have a strange puzzler for which I hope someone can offer
advice.

I have two very similar, but not quite identical, systems.  One
is our MPC857T evaluation board, running Linux 2.4.4 with ELDK
RAM disk.  The other is our Virtex-II Pro development board,
running Linux 2.4.20 with ELDK RAM disk.  (Despite the version
differences, the ppc_8xx and ppc_4xx stuff were all downloaded
on the same day a month or two ago.)

Here is the scenario (it seems artificial but it isolates the
problem):

*	A shell script contains:

	for x in 1 2 3
	do
		echo PID=$$ Here is my default message
		echo PID=$$ Here is my tty message > /dev/tty
		echo PID=$$ Here is my console message > /dev/console
	done

*	If I execute this from the console window on the 8xx
	board, I see (of course)

	# sh ttycon
	PID=00153 Here is my default message
	PID=00153 Here is my tty message
	PID=00153 Here is my console message
	PID=00153 Here is my default message
	PID=00153 Here is my tty message
	PID=00153 Here is my console message
	PID=00153 Here is my default message
	PID=00153 Here is my tty message
	PID=00153 Here is my console message

*	If I execute this from a telnet session into the 8xx
	board, I see the following at the console (also as
	expected):

	login(pam_unix)[165]: session opened for user root by (uid=0)
	-- root[165]: ROOT LOGIN ON ttyp0 FROM neldoreth
	PID=00167 Here is my console message
	PID=00167 Here is my console message
	PID=00167 Here is my console message

	and in the telnet client's window I see:

	# sh ttycon
	PID=00167 Here is my default message
	PID=00167 Here is my tty message
	PID=00167 Here is my default message
	PID=00167 Here is my tty message
	PID=00167 Here is my default message
	PID=00167 Here is my tty message

*	If I execute the script from the console window on the
	4xx board, I see

	# sh ttycon
	PID=00020 Here is my default message
	PID=00020 Here is my tty message
		(Here is a pause *until* I hit return)
	PID=00020 Here is my console message
		(Here is a pause *until* I hit return)
	PID=00020 Here is my tty message
		(Here is a pause *until* I hit return)
	PID=00020 Here is my console message
		(Here is a pause *until* I hit return)
	PID=00020 Here is my tty message
		(Here is a pause *until* I hit return)
	PID=00020 Here is my console message

		(Then the BusyBox shell restarts)

	Note that some of the lines are missing (all but the
	first "default message"), and also note that the console
	is blocking until I hit return or any other character.

*	If I execute this from a telnet session into the 4xx
	board, I see the following at the console (also as
	expected):

	PID=00020 Here is my console message

	and the following at the telnet client window:

	# sh ttycon
	PID=00020 Here is my default message
	PID=00020 Here is my tty message
	PID=00020 Here is my default message
	PID=00020 Here is my tty message

	Then a pause till I hit a key at the console window, at
	which point this appears in the telnet window:

	PID=00020 Here is my default message
	PID=00020 Here is my tty message

	and this appears in the console window:

	PID=00020 Here is my console message

	Then I hit another key at the console window, at which
	point I see there:

	PID=00020 Here is my console message

	and I get my prompt back at the telnet window.

I said this seems artificial:  The deeper problem is that when
one telnets in, /bin/login, whose stdin, stdout and stderr have
been redirected to a socket by telnetd, nonetheless wants to do
a console write (the "ROOT LOGIN ON ttyp0 FROM otherhost"
stuff).  So, when I telnet in, the telnet client can't proceed
until I hit a return for each line that /bin/login wants to
write to the console.  But worse, after the telnet session is
over, the console is then unrecoverable (when I type at it,
nothing happens) until I telnet in again and kill the console
shell.  But as soon as I log off that telnet session, the
console is again blocked by the logoff message.

So, the above shell script is just a simpler way of
demonstrating the more serious problem that I'm having with
/bin/login writing to the console.

Now, these two systems have several differences:  Different
processors, different kernel revs, different UART device
drivers; the RAM disks are all but identical (at least the same
file names; of course, the executables for 4xx and 8xx aren't
bit-for-bit identical).  So, I could start trying to eliminate
differences between the two boards.  But, some differences are
unresolvable, e.g. the fact that there is different UART
hardware, necessitating different drivers.

The kernel mods I did were very few (someone else had already
done the hard work of porting to the 8xx and 4xx) -- my mods
were mainly in the device drivers.  The one exception, for what
it's worth, is that the Virtex-II Pro board has SDRAM at address
0x80000000, not 0x00000000.  (Don't ask why ... the hardware
guys assure me that this isn't going to change.) I made about a
half-dozen mods for that, in various places (mainly the boot
wrapper).  I can't imagine why the SDRAM base address would have
anything to do with /dev/console blocking, but I thought I'd
mention all the differences between the two systems.  Also, I
see no other issues with the 4xx board -- once past the initial
step, telnet sessions work fine; Web service is fine; TFTP
service is fine; etc.  No, wait:  the other oddity is that
when the 4xx system boots, I see BusyBox printing its "serial
console detected, disabling virtual terminals" message, but
I don't see the BusyBox banner or prompt until I hit return.
Whereas on the 8xx board, BusyBox does not say "serial console
detected, disabling virtual terminals", and I immediately
get a "# " prompt.

Before I start moving the 8xx board to 2.4.20, or the 4xx board
to 2.4.4, does anyone have any pointers as to where to start
looking?

Any advice is appreciated ... thanks.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
