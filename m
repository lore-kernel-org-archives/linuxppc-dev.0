Return-Path: <owner-linuxppc-dev@lists.linuxppc.org>
From: "XOL" <xol@mail.ru>
To: "Wolfgang Denk" <wd@denx.de>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re[2]: How to change Bus speed for MPC8xx CPU 
Mime-Version: 1.0
Date: Sun, 18 May 2003 14:35:27 +0400
In-Reply-To: <20030518102713.5A295C6162@atlas.denx.de>
Reply-To: "XOL" <xol@mail.ru>
Content-Type: text/plain; charset=koi8-r
Message-Id: <E19HLVn-000N0u-00.xol-mail-ru@f20.mail.ru>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


As far as I understand there is a bootloader provided by board
manufacturer this is something like BIOS in desktop pc.
And there should be part of the kernel running before
the kernel starts. So which one of them do the job with
clocks? Or probably both of them.
And there the kernel loader sources are located under
/usr/src/linux tree. I would like to put my patch inside and paly
with it.
Thanks.

-----Original Message-----
From: Wolfgang Denk <wd@denx.de>
To: "XOL" <xol@mail.ru>
Date: Sun, 18 May 2003 12:27:08 +0200
Subject: Re: How to change Bus speed for MPC8xx CPU

>
> In message <E19HJpf-000JCU-00.xol-mail-ru@f25.mail.ru> you wrote:
> >
> >  cpu MHz : 100
> >  bus MHz : 50
> >
> >  My board is runnig from external clock of 10M and boot monitor
> >  has parameter called mulitplier which is equal to 10.
>
> 10 * 10 MHz = 100 MHz CPU Clock.
>
> 100 MHz CPU clock / 2 (see EBDF bits in SCCR) = 50 MHz bus clock
>
> >  I need to slow bus speed to 40MHz and from 862 data sheet I see
> >  what this can be done by writing to internal registers of clock
> >  engine.
>
> Try changing the multiplicator factor to 8, so you get 80 MHz  CPU  /
> 40 MHz bus clocks.
>
> >  My question is how kernel deal with it. Where and how clock are configured
> >  and how can I change it. Is it done on the boot time by kernel boot loader ?
>
> The kkernel does not deal with this at all. It  receives  information
> about the system clocks from the boot loader.
>
> >  Maybe you can apoint me to the source in kernel where clock parameters
> >  are configured. IMHO it should be somwhere in boot.
>
> This is done in the boot loader.
>
>
> Best regards,
>
> Wolfgang Denk
>
> --
> Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
> Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
> A person with one watch knows what time it  is;  a  person  with  two
> watches is never sure.                                       Proverb
>

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
