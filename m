To: Alan Cox <alan@cymru.net>
Cc: Geert.Uytterhoeven@cs.kuleuven.ac.be, davem@dm.cobaltmicro.com,
        Paul.Mackerras@cs.anu.edu.au, linuxppc-dev@lists.linuxppc.org,
        linux-m68k@lists.linux-m68k.org, VANDROVE@vc.cvut.cz
Subject: Re: TCPv4 checksum errors
References: <199812281304.NAA04349@snowcrash.cymru.net>
From: Andreas Schwab <schwab@issan.informatik.uni-dortmund.de>
Date: 28 Dec 1998 14:12:27 +0100
In-Reply-To: Alan Cox's message of "Mon, 28 Dec 1998 13:04:17 +0000 (GMT)"
Message-Id: <vyz1zlkif5w.fsf@issan.cs.uni-dortmund.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Alan Cox <alan@cymru.net> writes:

|> > Alan Cox <alan@cymru.net> writes:
|> > 
|> > |> The classic bad packet error is a frame that ends up with
|> > |> 
|> > |> checksum =FFFF end around carry left =1
|> > 
|> > There can never be a carry if the sum is FFFF.  A sum of two 16 bit values
|> > is never be bigger than 1FFFE.
|> 
|> (2 previous + previous carry)

You can only get in this situation if you start off with a carry in the
first place, and all other values are FFFF.  Also remember that an IP
packet is <= 65535 octets, or <= 32768 16 bit words (hexets?).  Thus you
can never get more than 32767 carries, which you can collect in a single
16 bit word, which is one of the values in the final folding round.

Andreas.

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
