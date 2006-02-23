Return-Path: <olh@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 3399267A01
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Feb 2006 10:24:29 +1100 (EST)
Received: from Relay1.suse.de (mail2.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 5BBD51D944
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Feb 2006 00:24:24 +0100 (CET)
Date: Fri, 24 Feb 2006 00:24:24 +0100
From: Olaf Hering <olh@suse.de>
To: linuxppc-dev@ozlabs.org
Subject: ibook1 hangs during boot, atyfb broken
Message-ID: <20060223232423.GA29454@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


My iBook1 did not work with recent kernels (2.6.15+), 2.6.13 was always ok.
Today I did some more testing, with 2.6.16-rc4-git3.
If I boot with 'quiet panic=1 root=/dev/blah', it will hang in 75% of the boots 
before displaying the penguin.
Adding video=atyfb:off did fix it, tried it a few times. Then I removed
the quiet and video= option, and it did boot again. Then I reverted the
atyfb to 2.6.15 status and did a reboot loop.
Unfortunately, after 13 reboots with just 'panic=1 root=/x' it was stuck, after 
time_init: processor frequency = 300MHz.

"panic=1 root=/dev/blah video=atyfb:off" works better, 27 reboots and
still going.
