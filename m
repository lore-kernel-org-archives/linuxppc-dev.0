Return-Path: <vijay.t.nikam@gmail.com>
Received: from mail-fx0-f42.google.com (mail-fx0-f42.google.com
	[209.85.161.42]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 797FBB700B
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Jun 2011 20:51:08 +1000 (EST)
Received: by fxm1 with SMTP id 1so288510fxm.15
	for <linuxppc-dev@ozlabs.org>; Wed, 08 Jun 2011 03:51:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20110607142213.2851f92e@schlenkerla.am.freescale.net>
References: <BANLkTi=TVsXiWR1qS5upnM31kVk9qqXTmw@mail.gmail.com>
	<20110607142213.2851f92e@schlenkerla.am.freescale.net>
Date: Wed, 8 Jun 2011 16:21:03 +0530
Message-ID: <BANLkTino1HgB2SL=S6ZeZ-z3o1MczWJ+8w@mail.gmail.com>
Subject: Re: [gianfar]bandwidth management problem on mpc8313 based board
From: Vijay Nikam <vijay.t.nikam@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Scott,

Thanks for the prompt reply.

> What's your CPU utilization?  The CPU may just not be able to keep up wit=
h
> that much traffic, with the software you're running.
The software I am using to check bandwidth is 'iperf'. Without running iper=
f the
CPU utilization varies around 30-50% and with iperf running it shoots
upto 99.9%.

> What packet size are you using?
The packet size is - 1518 + VLAN_Tag (4Bytes) =3D 1522 Bytes

Another point which I would like to clear is that mpc8313 has eth0 (eTsec1)=
 of
1Gbps, if more than 50% of CPU Time is available then why the total bandwid=
th
should limit to less than 100 Mbps?  At least 400Mbps should be expected, p=
lease
correct if I am wrong!

Please acknowledge, thanks.

Kind Regards,
Vijay Nikam


On Wed, Jun 8, 2011 at 12:52 AM, Scott Wood <scottwood@freescale.com> wrote=
:
> On Tue, 7 Jun 2011 18:32:37 +0530
> Vijay Nikam <vijay.t.nikam@gmail.com> wrote:
>
>> Dear All,
>>
>> I have mpc8313 powerpc based board with silicon revision 2.1. the
>> processor has two ETH ports (eTsec1 and eTsec2) i.e. eth0 and eth1.
>> eth0 is 1Gbps port and eth1 is 100Mbps port. On board there is L2
>> switch from TANTOS2G (psb6972) supports one port 1Gbps,
>> and from switch there are 4 more eth ports derived which are 100Mbps
>> ports and port based VLAN is configured for this purpose.
>>
>> The interface between switch and eth0 (port of processor) is RGMII. So
>> the processor port and switch port are connected on 1Gbps Link.
>> The other 4 derived ports (100Mbps) are used to connect to external worl=
d.
>> On this board Embedded Linux is running of kernel version 2.6.23 with HR=
T patch.
>
> That's rather old.
>
>> The ethernet controller driver in use is "gianfar" version 1.3
>> The driver is configured properly as it determines both links 1000Mbps
>> (eth0) and 100Mbps (eth1) also verified with ethtool.
>>
>> After this I started to perform bandwidth test using iperf tool.
>> When I performed this test on one port out of 4 derived ports I am
>> getting bandwidth in the range of 80-85Mbps
>> but when the same test is performed on 2 ports simultaneously then the
>> per port bandwidth is reduced to 40-45Mbps.
>>
>> But my understanding is all of the 4 ports should support 100Mbps
>> bandwidth simultaneously (as base port is 1Gbps).
>> Then why bandwidth gets reduced when more than one port are
>> communicating simultaneously?
>> Any reason or suggestion I should check for this problem?
>
> What's your CPU utilization? =A0The CPU may just not be able to keep up w=
ith
> that much traffic, with the software you're running.
>
> What packet size are you using?
>
> -Scott
>
>
