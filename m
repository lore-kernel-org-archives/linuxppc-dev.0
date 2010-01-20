Return-Path: <oakad@yahoo.com>
Received: from web37608.mail.mud.yahoo.com (web37608.mail.mud.yahoo.com
	[209.191.87.91]) by ozlabs.org (Postfix) with SMTP id A69B2B7C33
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 21 Jan 2010 01:46:54 +1100 (EST)
Message-ID: <782740.32111.qm@web37608.mail.mud.yahoo.com>
Date: Wed, 20 Jan 2010 06:46:52 -0800 (PST)
From: Alex Dubov <oakad@yahoo.com>
Subject: Freescale RapidIO controller shortcomings,
	memory access and DMA support
To: linuxppc-dev@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: zw@zh-kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Greetings.=0A=0AI'm currently involved in a project which aims to use a Rap=
idIO fabric as,=0Aessentially, a cluster interconnect. That is, our system =
contains a=0Amultitude of processing elements, rather than a host + some du=
mb=0Aperipherals.=0A=0AUnfortunately, it appears that Freescale's rapidio c=
ontroller is not well=0Asuited for this kind of use and the situation doesn=
't seem to get any=0Abetter in new chips. Just for the sake of general rant=
, I shall mention=0Athe missing functionality:=0A=0A1. Support for sending/=
receiving raw RIO packets - could be used to emulate=0Aall the necessary fe=
atures in software, if it was available.=0A=0A2. Support for indirect descr=
iptors in inbound message queue, akin to the=0Aone in outbound. It will all=
ow not to waste tons of space in the incoming=0Amessage buffer, and, even m=
ore important, will allow for Source ID based=0Amessage dispatch. Frankly, =
I don't understand what RIO core designers were=0Athinking - piling of prot=
ocol layers on top of RIO messages is not a good=0Aidea (and piling the who=
le Ethernet + friends protocol stack over there is=0Aeven worse).=0A=0A3. P=
roper IO TLB would be nice, but even without it there are accepted ways=0At=
o manage DMA from peripherals without reverting to overly complex hw=0Asche=
mes. After all, it won't be a big deal for a controller to support=0Aout-of=
-memory interrupt event, which would allow managing of DMA transfers=0Ain c=
oncurrent fashion, leading to a true zero-copy IO.=0A=0A4. Related to the p=
revious point, there's no control, nor indication about=0Awhich message siz=
es are actually used for outbound window originated=0Atransactions. Sending=
 16 bytes of actual phy data for each 4 processor=0Abytes can be a little b=
it wasteful (I hope, that there's some buffering=0Agoing on, but absence of=
 control is depressing).=0A=0A--- end of the rant ---=0A=0AI understand, th=
at Zhang Wei and Li Yang did some work in the direction=0Aof memory mapped =
RIO access. Therefore, I wonder: what is the final fate=0Aof their submissi=
on? Is there some sort of summary, what functionality=0Ahad been added and =
how was it envisaged to be used from user space?=0A=0AI'm currently working=
 on a fork of rapidio subsystem, which I intend to=0Abring to a feature com=
pleteness as far as possible (given the shortcoming=0Aabove) and use it as =
a cluster interconnect. I don't want to step on other=0Apeople's rakes and =
I would like a good cluster functionality support=0Amerged eventually into =
the mainline kernel, so any feedback is very=0Amuch appreciated.=0A=0A=0A=
=0A      __________________________________________________________________=
________________=0ASee what's on at the movies in your area. Find out now: =
http://au.movies.yahoo.com/session-times/
