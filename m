Message-ID: <01C1B880.271F6C60.svacca@valcom.com>
From: Steven Vacca <svacca@valcom.com>
Reply-To: "svacca@valcom.com" <svacca@valcom.com>
To: "'Steven Vacca'" <svacca@valcom.com>,
	"LinuxEmbeddedMailList (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Unbuffered char reads from App from stdin (keyboard)
Date: Mon, 18 Feb 2002 13:28:28 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


FYI (For Y'all's Info):

Here's what I've done.

I wanted to check if 1 or more keys have been pressed, and if so,
get just the next available key in the buffer.
I then wanted to process that key before echoing it to the
terminal, if at all, for nth-degree of control.

- I used termios to disable console Cannonical mode and Echoes.
- I used fcntl() to make stdin Non_Blocking, since, if there's no
  key in the buffer, read() will block.
- I then use:

	read(0,&key,1);

to read just the next key, without blocking when there is no key
in the buffer.


ShutEyeThinkin




-----Original Message-----
From:	Steven Vacca [SMTP:svacca@valcom.com]
Sent:	Friday, February 15, 2002 10:10 AM
To:	LinuxEmbeddedMailList (E-mail)
Subject:	Unbuffered char reads from App from stdin (keyboard)

App and Linux kernel 2.2.13 running on mpc860T.

I would like to know the best way, from inside my GNU C App,
to sense if there's a keyboard key pressed.  Something
similar to kbhit() in Microsoft C.  I would like to have a particular
thread execute a loop continuously and only when a key
is present, do a getc() or getchar(), or gets(), and the like.

What is the best way to accomplish this?
Is there a way to make stdin unbuffered?

Thanks,

ShutEyeThinkin

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
