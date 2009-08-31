Return-Path: <jeff.hane@maxim-ic.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id C4562B7B79
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  1 Sep 2009 08:15:52 +1000 (EST)
Received: from antispam02.maxim-ic.com (antispam02.maxim-ic.com
	[205.153.101.183]) by ozlabs.org (Postfix) with ESMTP id 65F44DDD01
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Sep 2009 08:15:52 +1000 (EST)
Received: from mailhost.mobilygen.com (localhost [127.0.0.1])
	by antispam02.maxim-ic.com (Spam & Virus Firewall) with ESMTP id
	C02D880BED3
	for <linuxppc-dev@ozlabs.org>; Mon, 31 Aug 2009 16:50:05 -0500 (CDT)
Received: from mailhost.mobilygen.com ([10.32.80.116]) by
	antispam02.maxim-ic.com with ESMTP id rcUR5suuJmMAAknG for
	<linuxppc-dev@ozlabs.org>; Mon, 31 Aug 2009 16:50:05 -0500 (CDT)
Received: from [10.32.80.202] (qu102 [10.32.80.202]) (authenticated bits=0)
	by mailhost.mobilygen.com (8.13.8/8.13.8) with ESMTP id n7VM0Qd0014467
	for <linuxppc-dev@ozlabs.org>; Mon, 31 Aug 2009 15:00:27 -0700
Subject: GPIOs 49-63 on 460EX
From: Jeff Hane <jeff.hane@maxim-ic.com>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Date: Mon, 31 Aug 2009 15:01:20 -0700
Message-Id: <1251756080.19346.44.camel@qu102.quarc.com>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hello,

 We are having a problem trying to use gpio 49-63 on our amcc
canyonlands board.  I'm aware these pins are shared with the trace port,
so wrote 0x7ff to SDR0_PFC0 register to make sure they were all in gpio
mode. 

 I set the gpio to output and then try to drive a 1 out but I can never
see it.  I doubled checked the pin with the value reported by the SW and
it never toggles.  If I set the value to 1, I can see a 1 in the gpio OR
register, but the IR stays 0(IR is what is read by get_value)
 
 I can change the direction and value the first 16 gpios in gpio
controller 1 but not the upper 16 bits.  So this means that gpio 48
doesn't work either; thus 16 of the gpio don't work(for out, I haven't
tried in)

 I am running 2.6.30.  Has anybody seen this?  Am I missing a register
somewhere?

thanks,
jeff
