Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Date: Tue,  8 Jun 2004 13:22:18 -0300
Message-Id: <HZ0056$6237825DE310949AB818EA81D16B09F0@bol.com.br>
Subject: ioctl(TIOCMGET) on Lite5200
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
From: "saurosalomoni" <saurosalomoni@bol.com.br>
To: "linuxppc-embedded" <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi there.

I'm having a problem with a specific argument of the
ioctl function, which is ioctl(TIOCMGET).
I wrote a simple routine which just reads or writes the
RTS pin.
It worked OK on my Red Hat 9, under x86, but when I try
to run it on a Lite5200 using denx kernel 2.4-25, it
keeps saying "TIOCMGET failed: Invalid argument" and
crashes out...
I think it could be due to some differences between the
two drivers, but I'm not sure about that. I wonder if
there's another argument that could provided me this
information, or if there's a way to ask for it
"manually" with ioctl...
Thanks in advance.
Here's a simple version of my code:

 int fd, status;
 fd = open("/dev/ttyS0", O_RDWR);
 if (ioctl(fd, TIOCMGET, &status) < 0)
   printf("TIOCMGET failed: %s\n", strerror(errno));
 else
   {...

 /* then, to check the status, i make this test */
 if (status & TIOCM_RTS)

 /* to set RTS */
 status &= ~TIOCM_RTS;
 ioctl(fd, TIOCMSET, &status);

 /* and to reset RTS */
 status |= TIOCM_RTS;
 ioctl(fd, TIOCMSET, &status);


__________________________________________________________________________
Acabe com aquelas janelinhas que pulam na sua tela.
AntiPop-up UOL - É grátis!
http://antipopup.uol.com.br/


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
