To: "Young-Han, Kim" <yhkim@da-san.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: MPC 8xx as SPI slave... 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 26 Mar 2003 11:50:51 +0900."
             <000b01c2f342$8347d830$337ceccb@dasan.com>
Date: Wed, 26 Mar 2003 08:03:17 +0100
Message-Id: <20030326070322.93F25C58BA@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <000b01c2f342$8347d830$337ceccb@dasan.com> you wrote:
>
>   I will use the MPC 8xx as SPI slave, the SPI master is not MPC 8xx.
>   Currently, using the SPI interrupt for RX/TX on MPC 8xx.
>   The SPI write operation on SPI master is run very well.
>   But, SPI read operation on SPI master is not so good.
>   When SPI read operation on SPI master, the CPM of MPC 8xx
> report the SPI TX interrupt as TX done.
>   But, the MPC 8xx SPI not transmit that data on SPI bus,
> just transmit old TX data.
>   In second SPI read operation on SPI master, the MPC 8xx SPI
> transmit previous data of TX BD.

This could be a cache issue. Which source is your SPI driver based on?

>   It means that the MPC 8xx SPI not transmit the data on time.
>   I was checked with oscilloscope.

Does the 8xx transfer data at all? You know, SPI has a very, very low
priority onthe CPM, so it will be starved  by  any  other  I/O  (like
ethernet and especially USB).

Motorola writes:

        Note that the SPI is of lower priority internally than the
        SCCs, thus, the SPI will be the first device to be "starved".
        Snce it has no FIFO, it is especially sensitive to underruns.
        The best way to prevent this is to use a buffer size of 1
        "character" (of size programmed in the mode register).
...
        The physical clocking speed of the SPI can be up to 12 MHz.
        However, it only has a 16-bit holding register. Thus, the 12
        Mbit/sec rate can only be sustained for 16 bits. If you need
        to transmit more than 2-bytes of data at that clocking rate,
        you must put the data into separate BDs and set the data
        length to 2 and set the L bit in each BD. If you are using a
        character length of 16-bits, the maximum clocking rate is 3.1
        Mbit/sec. If you are using a character length of 8 bits, the
        maximum is 500 Kbits/sec. Note that 500 Kbits/sec is the
        maximum throughput when no other peripherals (SCCs, SMCs) are
        being used. Load on those peripherals will further reduce the
        maximum data rate through the SPI.

[This calculation is based on a 25 MHz clock.]



Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
People seldom know what they want until you give them what  they  ask
for.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
