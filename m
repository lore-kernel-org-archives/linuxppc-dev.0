Message-ID: <008201c07eec$52fd7da0$4a1f76d8@washington>
From: "Navin Boppuri" <nboppuri@trinetcommunication.com>
To: "Linux PPC embedded" <linuxppc-embedded@lists.linuxppc.org>
References: <003b01bfbc02$88afc3c0$4a1f76d8@washington> <3A5FBDC0.6785393F@brainlink.com>
Subject: Re: UART configuration problems
Date: Mon, 15 Jan 2001 12:11:43 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello Ormund,

>From your mail, I can make out that you worked on the MAX3100 uart before.
Can you please tell me how I can do a read from the buffer? I am confused as
to how to read the buffer without overwriting it with the following data.
How much delay is the right delay? Please help, I am kinda stuck here.

Thank you,
Navin Boppuri

----- Original Message -----
From: "Ormund Williams" <ormundw@brainlink.com>
To: "Linux PPC embedded" <linuxppc-embedded@lists.linuxppc.org>
Sent: Saturday, January 13, 2001 2:30 AM
Subject: Re: UART configuration problems


>
> Navin Boppuri wrote:
> >
> > Hello everyone,
> >
> > I am trying to interface a MAX3100 uart to an SPI controller on the
MPC823.
> > I have a functional SPI driver running. The transmit part of the UART
works
> > just fine. I am able to transmit characters at 9600 8N1 baud. The
problem
> > arises when I do a receive. The uart documentation says that the
internal
> > fifo is 8 word long. But I notice that the FIFO is able to store only 8
> > characters. For example, if I transmit the characters
> >             abcdefghijklmnopqrstuvwxyz
> >
> > The uart shows only "yz" in its buffers. The other 24 characters are
lost. I
> > noticed that 8 charaters are written in the buffer. It first writes
> > "abcdefgh" and then overwrites that with "ijklmnop" and so on. The uart
> > generates an irq interrupt whenever there is incoming data. I do not see
why
> > the buffer is not big enough.
> >
> The MAX3100 is working as designed, the 8 word fifo can only hold 8
> characters the other bits in the word hold the parity, framing error,
> etc.  If the fifo overflows all characters are lost.  The following is
> from page 5 and 7 of the datasheet.
>
> "Read data from a 16-bit register that holds the oldest
> data from the receive FIFO, the received parity data,
> and the logic level at the CTS input pin. This register
> also contains a bit that is the framing error in normal
> operation and a receive-activity indicator in shutdown."
>
> "Receive data is stored in an 8-word FIFO. The FIFO is
> cleared if it overflows."
>
> > Can someone give me some insight into this problem? What do I need to do
to
> > correct this?
> >
> Read the data before the fifo overflows.
>
>
> --
> Ormund
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
