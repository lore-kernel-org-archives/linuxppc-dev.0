Message-Id: <6.0.0.22.0.20040101181920.01ef1eb8@192.168.2.1>
Date: Thu, 01 Jan 2004 18:29:39 +0100
To: xyuhua_telecom@hotmail.com
From: llandre <r&d@wawnet.biz>
Subject: Re: How to control RTS signal ?
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <Sea1-F132ugGlyAs6jn00001e72@hotmail.com>
References: <Sea1-F132ugGlyAs6jn00001e72@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>>>
>>>Hi,
>>>
>>>    Now we are using a mpc823 embedded system, and there is some trouble.
>>>We need to use SCC3 UART to control RS485 tranceiver. TXD3 is connected
>>>to RS485 tranceiver's D pin, RXD3 is connected to RS485 tranceiver's R
>>>pin, and RTS3 is connected to RS485 tranceiver's RE# and DE pin. Then
>>>when transmitting data, we hope RTS3 signal can keep low to enble D.
>>>When receiving data, we hope RTS3 signal can keep high to enble R.
>>>    So my question is, how can I program to control RTS3 signal in ppclinux.
>>
>>Hi,
>>
>>the simplest solution I found so far is to control the RTS signal in the
>>application, like this:
>>
>>                 int mcs = TIOCM_RTS;
>>                 /* clear RTS */
>>                 ioctl(fd, TIOCMBIC, &mcs);
>>                 ...
>>
>>                 /* Before starting a transmission, we must set the RTS
>>signal */
>>                 ioctl(fd, TIOCMBIS, &mcs);
>>
>>
>>                 /* Now we can safely transmit the message with the usual
>>write system call */
>>                 write(fd, buf, strlen(buf));
>>
>>                 /* Before switching back to receiving mode, we must
>>ascertain the trasmission is actually completed by reading the Line Status
>>Register */
>>                 do {
>>                         ioctl (fd, TIOCSERGETLSR, &lsr);
>>                 } while (!(lsr & TIOCSER_TEMT));
>>
>>                 /* clear RTS */
>>                 ioctl(fd, TIOCMBIC, &mcs);
>>
>>Otherwise you can modify the serial driver in order to manage the direction
>>pin internally inside it. Even if this technique is discouraged by kernel
>>maintainers, there are several examples available (I think the CRIS
>>architecture serial driver implements this solution).
>>
>>
>>
>>
>>
>>Hope this helps,
>>
>>llandre
>
>   Thank for your help, I have try these code above, but it did not
> work.   I have done "make menuconfig", select pc13 as RTS signal for
> SCC3, and none for
>CTS,CD,DTR signal. Then I use the above code in the program, I found RTS
>pin can not be controlled, it kept low level all the time.
>
>   How does this happen?
>

Hi,

I don't know the mpc823, anyway I suggest you to have a look at the serial
driver source code (I think it is arch/ppc/8xx_io/uart.c). Here you can
find how the ioctls are handled and, if not supported yet, you can easily
add the support for the TIOCMBIC, TIOCMBIS, TIOCSERGETLSR and TIOCMBIC. In
case the code already supports the necessary ioctls, my advice is to debug
the driver with an hardware interface or with the printk, in order to
understand why the RST pin is stuck (maybe, if it is a multiplexed pin, it
is not configured correctly).


Hope this helps,

llandre


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
