To: "XOL" <xol@mail.ru>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: How to change Bus speed for MPC8xx CPU 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Sun, 18 May 2003 12:47:51 +0400."
             <E19HJpf-000JCU-00.xol-mail-ru@f25.mail.ru>
Date: Sun, 18 May 2003 12:27:08 +0200
Message-Id: <20030518102713.5A295C6162@atlas.denx.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


In message <E19HJpf-000JCU-00.xol-mail-ru@f25.mail.ru> you wrote:
>
>  cpu MHz : 100
>  bus MHz : 50
>
>  My board is runnig from external clock of 10M and boot monitor
>  has parameter called mulitplier which is equal to 10.

10 * 10 MHz = 100 MHz CPU Clock.

100 MHz CPU clock / 2 (see EBDF bits in SCCR) = 50 MHz bus clock

>  I need to slow bus speed to 40MHz and from 862 data sheet I see
>  what this can be done by writing to internal registers of clock
>  engine.

Try changing the multiplicator factor to 8, so you get 80 MHz  CPU  /
40 MHz bus clocks.

>  My question is how kernel deal with it. Where and how clock are configured
>  and how can I change it. Is it done on the boot time by kernel boot loader ?

The kkernel does not deal with this at all. It  receives  information
about the system clocks from the boot loader.

>  Maybe you can apoint me to the source in kernel where clock parameters
>  are configured. IMHO it should be somwhere in boot.

This is done in the boot loader.


Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
A person with one watch knows what time it  is;  a  person  with  two
watches is never sure.                                       Proverb

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
