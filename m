From: "Joakim Tjernlund" <Joakim.Tjernlund@lumentis.se>
To: "Dan Malek" <dan@embeddededge.com>
Cc: "Linuxppc-Embedded@Lists. Linuxppc. Org" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Serial port text corruption
Date: Wed, 19 May 2004 17:49:15 +0200
Message-ID: <BCEFJBPJCGFCNMMMIDBHGEBICGAA.Joakim.Tjernlund@lumentis.se>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <BCEFJBPJCGFCNMMMIDBHMEBDCGAA.Joakim.Tjernlund@lumentis.se>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> I am using agetty and I have just read that agetty tries to figure
> out parity settings during login and sets the tty accordinly. So
> maybe agetty gets confused and changes the parity? Would
> that affect the Password line but not the previous line where the username
> is entered?
>
> Relevant line of my inittab is:
>   con:2345:respawn:/sbin/getty -L console 115200 vt100

After some research and testing, I have found that agetty enables
parity checking if a character with the msb set while entering the
username. The parity setting(even or odd, based on the number of one's in the
char) becomes active during the password phase and that messes up the display.

I don't think that such a character was entered in my case, but perhaps a
random character was generated when connecting the cable?

Agettys auto parity algorithm is not very suited for todays keyboards. There
are plenty of computers with national characters on their keyboards. A user
could easily enter a national character and end up with garbled display.

Any ideas for a replacement getty?

 Jocke


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
