Return-Path: <bounces@nabble.com>
Received: from talk.nabble.com (www.nabble.com [72.21.53.35])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 66ED3DDEBB
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  5 May 2007 01:04:34 +1000 (EST)
Received: from [72.21.53.38] (helo=jubjub.nabble.com)
	by talk.nabble.com with esmtp (Exim 4.50) id 1HjzKg-000654-8p
	for linuxppc-embedded@ozlabs.org; Fri, 04 May 2007 08:04:30 -0700
Message-ID: <10323147.post@talk.nabble.com>
Date: Fri, 4 May 2007 08:04:29 -0700 (PDT)
From: Mirek23 <miroslaw.dach@psi.ch>
To: linuxppc-embedded@ozlabs.org
Subject: RE: zImage.elf loads but does not start
In-Reply-To: <10165159.post@talk.nabble.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <10079346.post@talk.nabble.com> <10142161.post@talk.nabble.com>
	<406A31B117F2734987636D6CCC93EE3C0159BAAE@ehost011-3.exch011.intermedia.net>
	<10165159.post@talk.nabble.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


I came to the point with my kernel 2.6 (patched by Grant)  struggle on ml403
that it reaches the 
stage to mount nfs root file system from the computer which is on another
segment  of the network:

[    2.565946] eth%d: XTemac: PHY detected at address 3.
[    2.629348] eth0: Xilinx TEMAC #0 at 0x81200000 mapped to 0xC5020000,rq=1
[    2.713113] eth0: XTemac id 1.0f, block id 5, type 8
[    2.774335] mice: PS/2 mouse device common for all mice
[    2.837152] TCP cubic registered
[    2.876220] NET: Registered protocol family 1
[    2.928569] NET: Registered protocol family 17
[    3.485990] eth0: XTemac: Options: 0xb8f2
[    7.517827] eth0: XTemac: We renegotiated the speed to: 100
[    7.584504] eth0: XTemac: speed set to 100Mb/s
[    8.652764] IP-Config: Unable to set interface netmask (-22).
[    8.724733] Looking up port of RPC 100003/2 on 129.129.130.106

It cannot however go through the gateway because the macaddress is not
properly set (ie. it is set to 00:00:00:00).
My command line argument looks like:

CONFIG_CMDLINE="console=ttyUL0,9600 root=/dev/nfs rw
nfsroot=129.129.130.106:/opt/eldk41/ppc_4xx,tcp macaddr=00:50:c2:46:d8:01
ip=129.129.129.29:129.129.130.106:129.129.129.1:255.255.255.0:ML403:eth0:off
panic=1"

Does somebody know why the macaddress is not taken into account.

Mirek

-- 
View this message in context: http://www.nabble.com/zImage.elf-loads-but-not-starts-tf3607582.html#a10323147
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
