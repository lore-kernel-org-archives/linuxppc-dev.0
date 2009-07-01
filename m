Return-Path: <glppd-linuxppc64-dev@m.gmane.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 59841B7104
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  1 Jul 2009 22:37:41 +1000 (EST)
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by ozlabs.org (Postfix) with ESMTP id E3051DDD04
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Jul 2009 22:37:40 +1000 (EST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1MLz4B-0002mY-CC
	for linuxppc-dev@ozlabs.org; Wed, 01 Jul 2009 12:37:36 +0000
Received: from p4ff07fa4.dip.t-dialin.net ([79.240.127.164])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-dev@ozlabs.org>; Wed, 01 Jul 2009 12:37:35 +0000
Received: from dzu by p4ff07fa4.dip.t-dialin.net with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <linuxppc-dev@ozlabs.org>; Wed, 01 Jul 2009 12:37:35 +0000
To: linuxppc-dev@ozlabs.org
From: Detlev Zundel <dzu@denx.de>
Subject: Re: ppc405ex + gigabit ethernet
Date: Wed, 01 Jul 2009 14:37:24 +0200
Message-ID: <m2ws6stw8r.fsf@ohwell.denx.de>
References: <e35801cc0906300658q45d5ea00ub939ba73185efd72@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: news <news@ger.gmane.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Lada,

> Hi,
>
> I benchmarked performance of my network, which contains ppc405EX (Kilauea
> board, kernel 2.6.30 from Denx) connected with a linux desktop via gigabit
> ethernet. I used the netperf tool:
>
> netperf -t UDP_STREAM -H 192.168.1.1 -- -m 32768
>
> So I was sending UDP packets to the desktop. The resulting speed was about 370
> Kb/s. I tried to send the packets to several different computers - with the
> same result. So the ppc board is the bottleneck in this case.
>
> Is there any possibility to improve the gigabit capabilities of the ppc405EX?
> Is there anyone who achieved a better performance with ppc4xx boards?

On our kilauea in the lab:

-bash-3.2# src/netperf -t UDP_STREAM -p 7776 -H 192.168.1.1 -fK -- -m 32768
UDP UNIDIRECTIONAL SEND TEST from 0.0.0.0 (0.0.0.0) port 0 AF_INET to 192.168.1.1 (192.168.1.1) port 0 AF_INET
Socket  Message  Elapsed      Messages                
Size    Size     Time         Okay Errors   Throughput
bytes   bytes    secs            #      #   KBytes/sec

106496   32768   10.00        3601      0    11519.64
124928           10.00        3601           11519.64

-bash-3.2# grep cpu /proc/cpuinfo 
cpu             : 405EX
-bash-3.2# cat /proc/version
Linux version 2.6.29.4 (dzu@pollux.denx.de) (gcc version 4.2.2) #9 Wed Jun 17 11:18:46 CEST 2009
-bash-3.2# 

I can send you the kernel+dtb that I used for testing offlist.

Cheers
  Detlev

--
DENX Software Engineering GmbH,      MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich,  Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-40 Fax: (+49)-8142-66989-80 Email: dzu@denx.de
