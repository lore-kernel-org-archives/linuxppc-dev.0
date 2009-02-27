Return-Path: <daniel.ng1234@gmail.com>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.230])
	by ozlabs.org (Postfix) with ESMTP id 19F6DDDD1C
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Feb 2009 17:42:00 +1100 (EST)
Received: by rv-out-0506.google.com with SMTP id l9so922668rvb.9
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Feb 2009 22:41:59 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <49A50EA7.8040008@consentry.com>
References: <mailman.5.1233190802.9523.linuxppc-dev@ozlabs.org>
	<49810367.5000904@consentry.com>
	<547eba1b0902182247g66c8b83se0855ff048413c01@mail.gmail.com>
	<20090219184410.GB4180@ld0162-tx32.am.freescale.net>
	<547eba1b0902192101n323f51ceuf39b9d954b696225@mail.gmail.com>
	<547eba1b0902242309o2086dce2p49c59a9ea1b85b53@mail.gmail.com>
	<49A50EA7.8040008@consentry.com>
Date: Fri, 27 Feb 2009 17:41:59 +1100
Message-ID: <547eba1b0902262241k622a7act569a850a3fce15f3@mail.gmail.com>
Subject: Re: How to bring up fs_enet on 2.6.27?
From: Daniel Ng <daniel.ng1234@gmail.com>
To: Mike Ditto <mditto@consentry.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Feb 25, 2009 at 8:25 PM, Mike Ditto <mditto@consentry.com> wrote:
> Daniel Ng wrote:
>>> f0010d40:00 not found
>>> eth0: Could not attach to PHY

> These messages are typical of having the wrong GPIO pins in the mdio
> node or the wrong MDIO address (reg property) in the ethernet-phy node.
>
>>> Currently, our PHY
>>> attributes eg. 'auto-negotiate' are not changeable, so we aren't
>>> actually using MDC+MDIO even though the MDC+MDIO lines exist.
>
> The driver definitely tries to talk to the PHY using the GPIO pins
> and address specified and if it doesn't respond, it won't attach.
>

Thanks Mike. I pulled out the PHY-dependancies in the fs-enet code and
I'm *almost* there!

Here's the relevant boot output with some additional debug:

fs_init(): start
fs_enet_probe() start
fs_enet_get_stats() start
eth0: fs_enet: 7e:13:12:53:a1:75
fs_enet_probe(): registered. dev: eth0
...
dev_open(): calling dev_activate for dev: lo
dev_open(): finishing for dev: lo
fs_enet_open(): start. dev: eth0
dev_open(): calling dev_activate for dev: eth0
dev_open(): finishing for dev: eth0
fs_enet_get_stats()
IP-Config: Complete:
     device=eth0, addr=192.168.1.75, mask=255.255.255.0, gw=255.255.255.255,
     host=xxx, domain=, nis-domain=(none),
     bootserver=192.168.1.133, rootserver=192.168.1.133, rootpath=
Looking up port of RPC 100003/2 on 192.168.1.133
dev_hard_start_xmit(): start. dev: lo
dev_hard_start_xmit(): about to call c015baa0
dev_hard_start_xmit(): start. dev: lo
dev_hard_start_xmit(): about to call c015baa0
rpcbind: server 192.168.1.133 not responding, timed out

As you can see from the above, the NFS client tries to contact the
server on the lo interface rather than eth0.

This is despite IP-Config reporting 'Complete' for eth0.

If I set the Gateway parameter for the NFS client to 192.168.1.133 I get this:

fs_init(): start
fs_enet_probe() start
fs_enet_get_stats() start
eth0: fs_enet: 7e:13:12:53:a1:75
fs_enet_probe(): registered. dev: eth0
...
dev_open(): calling dev_activate for dev: lo
dev_open(): finishing for dev: lo
fs_enet_open(): start. dev: eth0
dev_open(): calling dev_activate for dev: eth0
dev_open(): finishing for dev: eth0
fs_enet_get_stats()
IP-Config: Gateway not on directly connected network.
Looking up port of RPC 100003/2 on 192.168.1.133
dev_hard_start_xmit(): start. dev: lo
dev_hard_start_xmit(): about to call c015baa0
dev_hard_start_xmit(): start. dev: lo
dev_hard_start_xmit(): about to call c015baa0
rpcbind: server 192.168.1.133 not responding, timed out

-IP-Config complains the Gateway (192.168.1.133) is not on a
directly-connected network, even though the IP address of eth0 is
192.168.1.75/24.

So this implies eth0 is not 100% up.

Would someone be able to suggest why this is so? What else could I do
to check the state of eth0?

Cheers,
Daniel
