In-Reply-To: <1084462045.4683.68.camel@lucy.pep-kaufbeuren.de>
References: <1084462045.4683.68.camel@lucy.pep-kaufbeuren.de>
Mime-Version: 1.0 (Apple Message framework v613)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <AA210AA0-A530-11D8-8C0F-000393DBC2E8@freescale.com>
Cc: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
From: Kumar Gala <kumar.gala@freescale.com>
Subject: Re: Stability of network/io on MPC8540ADS?
Date: Thu, 13 May 2004 17:55:43 -0500
To: Stefan Nickl <Stefan.Nickl@kontron.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Stefan,

We have found an issue with the TSEC driver that I'm working on pushing
a fix out for.  It is possible that might be causing your problem.  It
shows itself as a memory leak.  (this may at least explain #1 & #2)

- kumar

On May 13, 2004, at 10:27 AM, Stefan Nickl wrote:

> Hello,
> since the linuxppc-2.4 port to our custom 8540 board
> has made some progress now, I went back to the ADS
> board for some cross-checking.
> I've experienced several reproducible lockups that
> are triggered by heavy IO and/or networking.
> Kernel is vanilla linuxppc-2.4.27-pre2, gcc 3.2.3,
> root=/dev/nfs (Gentoo -Os -mcpu=603e)
> 1) Using netcat to write data over tcp:
>    cat /dev/zero | nc lucy 3000
>    "lucy" is running "nc -l -p 3000 |pipeworks > /dev/null"
>    This freezes the ADS after a few seconds.
> 2) Writing to the nfsroot server:
>    cat /dev/urandom > /test
>    The same. Reading seems ok.
> 3) Writing to a USB2.0 HDD connected via PCI
>    interface board (OHCI compatible).
>    Lockup after ~70MB of writing
> I haven't tested explicitly, but the kernel that
> was shipped with the board (some 2.4.20?) didn't
> seem to have such problems.
> Any ideas?
> --
> Stefan Nickl
> Kontron Modular Computers
>
> <.config>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
