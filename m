Message-ID: <3C235CE8.2E5E723C@chinook.com>
Date: Fri, 21 Dec 2001 11:01:44 -0500
From: Peter Desnoyers <pdesnoyers@chinook.com>
MIME-Version: 1.0
To: Rudolf Ladyzhenskii <rudolf.ladyzhenskii@act-aus.net>
Cc: "Linuxppc-Embedded (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: autoboot with initial RAM disk
References: <B164B53F5BD6D511888D009027732E1A0249CB@ntserver.act.domain>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


(this really belongs on the ppcboot list...)

You can do arbitrarily complicated things in the ppcboot 'bootcmd'
argument.  In your case:

  setenv bootcmd tftp 100000 pImage\; tftp 300000 initrd\; bootm 100000
300000

If your bootcmd variable gets too long, ppcboot will complain - then you
just have to do something like:

  setenv bootcmd run first_half\; run second_half
  setenv first_half command\; command\; ...
  setenv second_half ...

Rudolf Ladyzhenskii wrote:
>
> Hi, all
>
> I am using ppcboot to start my 8260 based card. At the moment, we load Linux
> kernel via tftp and then start it. Linux kernel maps its root file system
> over the network. This works fine qith ppcboot autoboot feature.
>
> Now, we want to put initial RAM disk into RAM as well as compressed kernel.
> Do do that, both images have to be copied into card's memory using tftp and
> them bootm command will be used with two arguments to start kernel.
>
> To continue to use ppcboot autoboot feature we have to pass two commands as
> boot command (to tftp two kernels) and then issue bootm command with two
> arguments. Is there any way of doing it without altering the ppcboot source
> code?
>
> Thanks,
> /************************/
> Rudolf Ladyzhenskii
> DSP Engineer
> Advanced Communication Technologies
> ph.  +61 3 8080 8215
> fax. +61 3 9672 8800
> Level 9, 190 Queen Street,
> Melbourne, 3000
> Australia
> /***********************/
>

--
.....................................................................
 Peter Desnoyers            (781) 457-1165   pdesnoyers@chinook.com
 Chinook Communications     (617) 661-1979   pjd@fred.cambridge.ma.us
 100 Hayden Ave, Lexington MA 02421

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
