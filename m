Date: Fri, 24 Mar 2000 09:26:42 +0200 (EET)
From: Kostas Gewrgiou <gewrgiou@imbc.gr>
To: Ani Joshi <ajoshi@shell.unixbox.com>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Rage128 Xfree 4.0 speedup/fix patch...
In-Reply-To: <Pine.LNX.4.10.10003231730190.10447-200000@shell.unixbox.com>
Message-ID: <Pine.LNX.4.21.0003240812520.15226-100000@idd-01.imbc.gr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 23 Mar 2000, Ani Joshi wrote:

> The rage128 xfree 4.0 driver uses improper load/store instructions,
> and I believe I have fixed it and also fixed the slowdown of the driver
> compared to x86 r128.
>

 Seems fine, but note that the macros in the r128 driver
are going away, they were only there because the default
MMIO_xxx macros that we had on ppc didn't do any byteswapping.
 Me and Michel Danzer are working on it and in fact the macros
that we are using now are more or less the same with what you posted.


> Could any others with rage128 and xfree4.0 test teh patch?  please do some
> x11perf test *before* and after and email them to me, thanks.
>
>
> here are the 2 tests which jack howarth has done:
>
> before:		Dot		4910000.0/sec
> 		100x100rect	29000.0/sec
>
> after:		Dot		9130000.0/sec
> 		100x100rect	57300.0/sec
>
>
>
> it seems with my patch, rage128 on a g4/450 is faster then my Xpert 128
> on celeron450...
>

  Yes with xfree86 4.0 we should be getting similar speeds with the x86
side there are still some cases in cfb (and in some other places) that
are slower in big endian but since cfb is going away in favor of fb thats
not a big deal.

>
> please test as I don't have a rage128 on my ppc...
>
> ani
>

  Kostas

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
