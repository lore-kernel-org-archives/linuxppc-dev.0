Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-Id: <4.2.2.20040519091201.05090ce0@bhawley.mailhost.luminex.com>
Date: Wed, 19 May 2004 09:13:59 -0700
To: Gerhard Jaeger <g.jaeger@sysgo.com>,
	<linuxppc-embedded@lists.linuxppc.org>
From: Brian Hawley <bhawley@luminex.com>
Subject: Re: Ebony Board, PPC440GP and NFS panics
In-Reply-To: <200405190923.29890.g.jaeger@sysgo.com>
References: <4.2.2.20040518092928.05070d90@bhawley.mailhost.luminex.com>
 <4.2.2.20040518092928.05070d90@bhawley.mailhost.luminex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Thanks for the reply.

I looked at the .config, and DHCP is not set, although BOOTP is.

The reason there aren't any BOOTP requests is that we changed the default
bootargs from ip=on
to putting the ip=ourip:serverip: ... directly....because we were never
seeing any bootp/dhcp responses
come out.  We think that is because linux is thinking the MAC address is
ff:ff:ff:ff:ff:ff instead of what
it really is.  u-boot doesn't seem to have a problem getting the MAC
address out of the ebony board, but
this linux kernel seems to.

At 09:23 AM 5/19/04 +0200, Gerhard Jaeger wrote:
>Hi,
>
>sorry if this is too obvious, but could it be, that you missed to set the
>following kernel option:
>CONFIG_IP_PNP_DHCP=y
>Also setting bootarg to ip=auto will be a good idea. What made me suspicious
>from your logs is, that I do not see any output from the kernel sayin'
>something about received IP-addresses etc...
>
>Correct me if I'm wrong (I use bootp and tftp here), but at least you should
>get something like this even for DHCP:
>
>Sending BOOTP requests .. OK
>IP-Config: Got BOOTP answer from 172.40.1.130, my address is 172.40.1.131
>IP-Config: Complete:
>       device=eth0, addr=192.168.1.131, mask=255.255.255.0,
> gw=255.255.255.255,
>      host=pappnase, domain=, nis-domain=(none),
>      bootserver=192.168.1.130, rootserver=192.168.130,
> rootpath=/tftpboot/pappnase
>
>Hope this helps,
>   Gerhard
>
>
>On Tuesday 18 May 2004 18:32, Brian Hawley wrote:
> >  > We've been trying to get linux-2.5-ocp up and running on the ebony
> >  > board. Thanks to those who have helped, but we are still stuck, and have
> >  > figured out a
> >  > few things, but need some advice on others.
> >  >
> >  > Using the default ebony config (ebony_defconfig) we found that the
> >  > default bootargs (ip=on) always overrode whatever we passed from the
> >  > bootargs in u-boot. This always ended up with retries and NFS
> >  > timeouts...
>[SNIPSNAP]


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
