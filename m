Message-ID: <3A6367E0.1D9499FE@brainlink.com>
Date: Mon, 15 Jan 2001 16:13:04 -0500
From: Ormund Williams <ormundw@brainlink.com>
MIME-Version: 1.0
To: Linux PPC embedded <linuxppc-embedded@lists.linuxppc.org>,
        Linux PPC embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: UART configuration problems
References: <003b01bfbc02$88afc3c0$4a1f76d8@washington> <3A5FBDC0.6785393F@brainlink.com> <008201c07eec$52fd7da0$4a1f76d8@washington>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Navin Boppuri wrote:
>
> Hello Ormund,
>
> >From your mail, I can make out that you worked on the MAX3100 uart before.
> Can you please tell me how I can do a read from the buffer? I am confused as
> to how to read the buffer without overwriting it with the following data.
> How much delay is the right delay? Please help, I am kinda stuck here.
>
I have no experience with the 823, my interest in PPC-Linux is for a
future project using the IBM 403GC, I am familiar with the 3100 from
another project.

I had already sent you the following steps for reading the FIFO without
loosing characters, you must read the entire FIFO to clear it.

Here are the steps to take:

        1. Read 16bit data from 3100
        2. Check R (bit 15) to see if there is data in FIFO
        3. If R is set: check Framing Error (bit 10)
           and Parity, if used (bit 8), read the character (bit 0-7)
        4. Do the above 3 three steps till R is clear
        5. Set delay for 60 x baud rate period
           (for 9600bps 8-n-1: 6250 micro seconds)

I am assuming that you are not using the interrupt pin on the 3100.

I see that you have written a driver for SPI can you send me a copy?
TIA.

--
Ormund

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
