From: benh@kernel.crashing.org
To: <linuxppc-dev@lists.linuxppc.org>,
	Christopher Murtagh <christopher.murtagh@mcgill.ca>
Subject: Re: SUNGEM config
Date: Wed, 13 Feb 2002 11:59:51 +0100
Message-Id: <20020213105951.10807@mailhost.mipsys.com>
In-Reply-To: <Pine.LNX.4.33.0202121351140.23572-100000@blues.wcg.mcgill.ca>
References: <Pine.LNX.4.33.0202121351140.23572-100000@blues.wcg.mcgill.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
> Ben,
>
> A while back when the question was asked as to why we should use SUNGEM
>instead of BMAC or GMAC, you said something to the affect that it offers
>config options. I read through the pdf from the kernel config help and it
>mentions a ge.conf file. So, if I got this right, I simply create an
>/etc/ge.conf file and this will allow me to force XBaseT and Auto or
>forced full/half duplex?

I'm not sure what ge.conf is. All I know is that the driver can be
set to various forced speeds via the ethtool tool, the config file
thing depends on whatever software package you have I don't know
about.

> I've been trying it with my iBook2 and 2.4.18pre8 and so far it works
>very well. However, when my iBook is not connected, it keeps on try to
>negotiate an eth0 connection (/var/log/messages):
>
>Feb  7 15:42:53 shiva kernel: eth0: switching to forced 10bt
>Feb  7 15:43:14 shiva kernel: eth0: switching to forced 100bt
>Feb  7 15:43:21 shiva kernel: eth0: switching to forced 10bt
>Feb  7 15:43:41 shiva kernel: eth0: switching to forced 100bt

Yes, that's normal. Some hubs/switches won't properly work with
autoneg, so the kernel has to try forced speeds. The proper way
to turn that off is to shut down the interface using ifconfig
(or /etc/init.d/network).

I know there are some laptop specific tools that monitor the link
and do the shutdown of the interface when there is no link but I
don't have any precise pointer at hand.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
