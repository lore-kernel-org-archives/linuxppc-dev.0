Return-Path: <machida@sm.sony.co.jp>
Received: from ns5.sony.co.jp (NS5.Sony.CO.JP [137.153.0.45])
	by ozlabs.org (Postfix) with ESMTP id 6E09967C6B
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 17 Jul 2005 17:24:50 +1000 (EST)
Received: from mail6.sony.co.jp (localhost [127.0.0.1])
	by mail6.sony.co.jp (R8/Sony) with ESMTP id j6H7Bqrc021087
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 17 Jul 2005 16:11:52 +0900 (JST)
Received: from smail1.sm.sony.co.jp (smail1.sm.sony.co.jp [43.11.253.1])
	by mail6.sony.co.jp (R8/Sony) with ESMTP id j6H7Bq2u021083
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 17 Jul 2005 16:11:52 +0900 (JST)
Received: from imail.sm.sony.co.jp (imail.sm.sony.co.jp [43.4.191.32]) by
	smail1.sm.sony.co.jp (8.11.6p2/8.11.6) with ESMTP id
	j6H7Bpt28367 for <linuxppc-embedded@ozlabs.org>;
	Sun, 17 Jul 2005 16:11:51 +0900 (JST)
Received: from mach0.sm.sony.co.jp (mach0.sm.sony.co.jp [43.4.196.128])
	by imail.sm.sony.co.jp (8.12.11/3.7W) with ESMTP id j6H7Bp4L009106
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 17 Jul 2005 16:11:51 +0900 (JST)
Message-ID: <42DA04B4.5090108@sm.sony.co.jp>
Date: Sun, 17 Jul 2005 16:11:48 +0900
From: Hiroyuki Machida <machida@sm.sony.co.jp>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain; charset=ISO-2022-JP
Subject: swsusp for ppc440
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Today I worked for enabling swsusp for ppc440, at 2.6.12.
I wrote changes for arch/ppc/kernel/swsusp.S, however
kernel is stopped, before hibernation is taken place
with following messages.

	# echo disk > state
	PM: prepare: Attempting to freeze processes.
	Stopping tasks: ===|
	Freeing memory... done (0 pages freed)
	PM: prepare: OK.
	ide-disk 0.0: suspending
	serial8250 serial8250: suspending
	
	 .. nothing happen
	
It seems to be stopped at console device.
Do anyone point out where and how to exclude system devices
like console and swap from device suspend procedure as 
preparation of swsusp?

Thanks,
Hiroyuki Machida
