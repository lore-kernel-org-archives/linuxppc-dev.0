From: Gerhard Jaeger <g.jaeger@sysgo.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Ebony Board, PPC440GP and NFS panics
Date: Wed, 19 May 2004 09:23:29 +0200
References: <4.2.2.20040518092928.05070d90@bhawley.mailhost.luminex.com>
In-Reply-To: <4.2.2.20040518092928.05070d90@bhawley.mailhost.luminex.com>
Cc: Brian Hawley <bhawley@luminex.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200405190923.29890.g.jaeger@sysgo.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

sorry if this is too obvious, but could it be, that you missed to set the
following kernel option:
CONFIG_IP_PNP_DHCP=y
Also setting bootarg to ip=auto will be a good idea. What made me suspicious
from your logs is, that I do not see any output from the kernel sayin'
something about received IP-addresses etc...

Correct me if I'm wrong (I use bootp and tftp here), but at least you should
get something like this even for DHCP:

Sending BOOTP requests .. OK
IP-Config: Got BOOTP answer from 172.40.1.130, my address is 172.40.1.131
IP-Config: Complete:
      device=eth0, addr=192.168.1.131, mask=255.255.255.0, gw=255.255.255.255,
     host=pappnase, domain=, nis-domain=(none),
     bootserver=192.168.1.130, rootserver=192.168.130, rootpath=/tftpboot/pappnase

Hope this helps,
  Gerhard


On Tuesday 18 May 2004 18:32, Brian Hawley wrote:
>  > We've been trying to get linux-2.5-ocp up and running on the ebony
>  > board. Thanks to those who have helped, but we are still stuck, and have
>  > figured out a
>  > few things, but need some advice on others.
>  >
>  > Using the default ebony config (ebony_defconfig) we found that the
>  > default bootargs (ip=on) always overrode whatever we passed from the
>  > bootargs in u-boot. This always ended up with retries and NFS
>  > timeouts...
[SNIPSNAP]


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
