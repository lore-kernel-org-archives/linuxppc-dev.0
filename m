Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Subject: Re: loading the kernel and root FS separately from flash?
From: David Woodhouse <dwmw2@infradead.org>
To: Wolfgang Denk <wd@denx.de>
Cc: "Robert P. J. Day" <rpjday@mindspring.com>,
	Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <20040628070916.706A6C109F@atlas.denx.de>
References: <20040628070916.706A6C109F@atlas.denx.de>
Content-Type: text/plain
Message-Id: <1088415754.6992.1.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
Date: Mon, 28 Jun 2004 10:42:34 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, 2004-06-28 at 09:09 +0200, Wolfgang Denk wrote:
> >    is this possible?  anyone done it this way, and can tell me what
> > pitfalls i have to watch for?  thanks.
>
> This is a pretty standard setup. Although I don't really recommend to
> use JFFS2 for root filesystem (for example, because with a  big  root
> filesystem  the boot time may deteriorate). Instead, we usually split
> the stuff in a read-only partition (for example cramfs),  a  volatile
> part (tmpfs), and a persistent storage partition (JFFS2).

I think it should be OK when it's 4MiB in size. Mount time was far more
of a problem in JFFS2 many years ago when people were using the 2.4
kernel. It's a lot faster in 2.6.

There's people looking at making it even faster now, too.

--
dwmw2


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
