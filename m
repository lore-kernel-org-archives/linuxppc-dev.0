Message-ID: <40A515E2.30401@pp.iij4u.or.jp>
Date: Sat, 15 May 2004 03:54:26 +0900
From: Yuji Nishimura <yujin@pp.iij4u.or.jp>
MIME-Version: 1.0
To: Stefan Nickl <Stefan.Nickl@kontron.com>
Cc: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Stability of network/io on MPC8540ADS?
References: <1084462045.4683.68.camel@lucy.pep-kaufbeuren.de>
In-Reply-To: <1084462045.4683.68.camel@lucy.pep-kaufbeuren.de>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Helo Stefan,

I evaluated MPC8540ADS and found out similar problem few weeks ago. I
made tiny patch and it works well.
I also evaluated with NEC ehci pci device. The result was fine.
I wrote 1GB data to external usb-2.0 HDD via USB-2.0(ehci), that works well.
I also try to use ftp(MPC8540=server) and transfer (R/W) 2047MB data via
TSEC(gianfar) and it also works well.
If you try to use this patch, please let me know. I think patch requires
more evaluation...

Best Regards,
Y.Nishimura - Tokyo, Japan.



Stefan Nickl wrote:

>Hello,
>
>since the linuxppc-2.4 port to our custom 8540 board
>has made some progress now, I went back to the ADS
>board for some cross-checking.
>
>I've experienced several reproducible lockups that
>are triggered by heavy IO and/or networking.
>
>Kernel is vanilla linuxppc-2.4.27-pre2, gcc 3.2.3,
>root=/dev/nfs (Gentoo -Os -mcpu=603e)
>
>1) Using netcat to write data over tcp:
>   cat /dev/zero | nc lucy 3000
>
>   "lucy" is running "nc -l -p 3000 |pipeworks > /dev/null"
>   This freezes the ADS after a few seconds.
>
>2) Writing to the nfsroot server:
>   cat /dev/urandom > /test
>
>   The same. Reading seems ok.
>
>3) Writing to a USB2.0 HDD connected via PCI
>   interface board (OHCI compatible).
>
>   Lockup after ~70MB of writing
>
>I haven't tested explicitly, but the kernel that
>was shipped with the board (some 2.4.20?) didn't
>seem to have such problems.
>
>Any ideas?
>
>--
>Stefan Nickl
>Kontron Modular Computers
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
