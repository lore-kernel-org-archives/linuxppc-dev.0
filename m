Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
	by ozlabs.org (Postfix) with SMTP id 2412EB6FDB
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Jun 2011 21:27:05 +1000 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
	by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new,
	port 10024) with SMTP id 28855-03 for <linuxppc-dev@ozlabs.org>;
	Wed,  8 Jun 2011 12:26:51 +0100 (BST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [gianfar]bandwidth management problem on mpc8313 based board
Date: Wed, 8 Jun 2011 12:25:25 +0100
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6D8AD7D@saturn3.aculab.com>
In-Reply-To: <BANLkTi=TVsXiWR1qS5upnM31kVk9qqXTmw@mail.gmail.com>
From: "David Laight" <David.Laight@ACULAB.COM>
To: "Vijay Nikam" <vijay.t.nikam@gmail.com>,
	<linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> Subject: [gianfar]bandwidth management problem on mpc8313 based board
...
> I have mpc8313 powerpc based board with silicon revision 2.1. the
> processor has two ETH ports (eTsec1 and eTsec2) i.e. eth0 and eth1.
> eth0 is 1Gbps port and eth1 is 100Mbps port. On board there is L2
> switch from TANTOS2G (psb6972) supports one port 1Gbps,
> and from switch there are 4 more eth ports derived which are 100Mbps
> ports and port based VLAN is configured for this purpose.
>=20
> The interface between switch and eth0 (port of processor) is RGMII. So
> the processor port and switch port are connected on 1Gbps Link.
...
> After this I started to perform bandwidth test using iperf tool.
> When I performed this test on one port out of 4 derived ports I am
> getting bandwidth in the range of 80-85Mbps
> but when the same test is performed on 2 ports simultaneously then the
> per port bandwidth is reduced to 40-45Mbps.

To summerise, you have a Ge port connected by RGMII (cross over) to
an on-board switch that is configured to use VLAN tagging to drive
four external 100M ports?

I see two likely reasons for the aggregate throughput being constant:
1) The switch has limited throughput/buffering
2) The host really is 100% busy
3) The remote system has limited throughput

I'd vote for the system being busy and 'top' (or whatever you are
using) lying about the cpu usage. Measuring free cpu time by counting
it in a low priority process is much more accurate than relying on
the 'code interrupted by timer tick' scheme.
(Clearly the scheduler could use a high-res timestamp on entry/exit
to the idle loop and/or process switch - but, to my knowledge, the
linux kernel only uses the timer interrupt.)

	David
