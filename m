Message-Id: <6.0.0.22.0.20031223142940.01e57ae0@192.168.2.1>
Date: Tue, 23 Dec 2003 14:36:45 +0100
To: "yhxing" <xyuhua_telecom@hotmail.com>
From: llandre <r&d@wawnet.biz>
Subject: Re: How to control RTS signal ?
Cc: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <Sea1-DAV34kO1dJFUuS0000e1ba@hotmail.com>
References: <Sea1-DAV34kO1dJFUuS0000e1ba@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>
>Hi,
>
>    Now we are using a mpc823 embedded system, and there is some trouble.
>We need to use SCC3 UART to control RS485 tranceiver. TXD3 is connected
>to RS485 tranceiver's D pin, RXD3 is connected to RS485 tranceiver's R
>pin, and RTS3 is connected to RS485 tranceiver's RE# and DE pin. Then
>when transmitting data, we hope RTS3 signal can keep low to enble D.
>When receiving data, we hope RTS3 signal can keep high to enble R.
>    So my question is, how can I program to control RTS3 signal in ppclinux.

Hi,

the simplest solution I found so far is to control the RTS signal in the
application, like this:

                 int mcs = TIOCM_RTS;
                 /* clear RTS */
                 ioctl(fd, TIOCMBIC, &mcs);
                 ...

                 /* Before starting a transmission, we must set the RTS
signal */
                 ioctl(fd, TIOCMBIS, &mcs);


                 /* Now we can safely transmit the message with the usual
write system call */
                 write(fd, buf, strlen(buf));

                 /* Before switching back to receiving mode, we must
ascertain the trasmission is actually completed by reading the Line Status
Register */
                 do {
                         ioctl (fd, TIOCSERGETLSR, &lsr);
                 } while (!(lsr & TIOCSER_TEMT));

                 /* clear RTS */
                 ioctl(fd, TIOCMBIC, &mcs);

Otherwise you can modify the serial driver in order to manage the direction
pin internally inside it. Even if this technique is discouraged by kernel
maintainers, there are several examples available (I think the CRIS
architecture serial driver implements this solution).





Hope this helps,

llandre


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
