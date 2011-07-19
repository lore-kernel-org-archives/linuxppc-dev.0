Return-Path: <bounces@nabble.com>
Received: from sam.nabble.com (sam.nabble.com [216.139.236.26])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id F0E53B6F74
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Jul 2011 15:39:03 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <bounces@nabble.com>) id 1Qj31J-0004AU-66
	for linuxppc-dev@ozlabs.org; Mon, 18 Jul 2011 22:39:01 -0700
Message-ID: <32088424.post@talk.nabble.com>
Date: Mon, 18 Jul 2011 22:39:01 -0700 (PDT)
From: Daniel Ng2 <daniel.ng1234@gmail.com>
To: linuxppc-dev@ozlabs.org
Subject: setbat() in udbg_init_cpm() required to avoid driver lockup
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Our USB Device Controller (UDC) driver seems to get stuck in a loop waiting
for the CPM Command Register to indicate that the CPM has finished executing
a command. (It should do this by setting the cpmcr 'Command Done' bit).

This only happens if I disable the 'Early Debug' Kernel Hacking .config
parameter. If Early Debug is enabled, then the problem goes away.

I've narrowed it down to this line in udbg_init_cpm(void):

setbat(1, 0xf0000000, 0xf0000000, 0x40000, PAGE_KERNEL_NCG);

-without this line, the driver gets stuck in the loop.

Can anyone suggest why?

Also, what undesireable effects might there be of keeping the above call to
setbat()?

System:
-MPC8272 (CPM2)
-Kernel 2.6.30.3

Cheers,
Daniel

-- 
View this message in context: http://old.nabble.com/setbat%28%29-in-udbg_init_cpm%28%29-required-to-avoid-driver-lockup-tp32088424p32088424.html
Sent from the linuxppc-dev mailing list archive at Nabble.com.
