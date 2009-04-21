Return-Path: <sunijsur@cisco.com>
Received: from sj-iport-6.cisco.com (sj-iport-6.cisco.com [171.71.176.117])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "sj-iport-6.cisco.com", Issuer "Cisco SSCA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 6E980DDE1F
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Apr 2009 02:08:53 +1000 (EST)
Received: from sj-core-2.cisco.com (sj-core-2.cisco.com [171.71.177.254])
	by sj-dkim-2.cisco.com (8.12.11/8.12.11) with ESMTP id n3LFua2J011686
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Apr 2009 08:56:36 -0700
Received: from sj-webmail-9.cisco.com (sj-webmail-9.cisco.com [171.71.183.158])
	by sj-core-2.cisco.com (8.13.8/8.13.8) with ESMTP id n3LFua4W003002
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Apr 2009 15:56:36 GMT
Received: from sj-webmail-9.cisco.com (localhost.localdomain [127.0.0.1])
	by sj-webmail-9.cisco.com (8.13.1/8.13.1) with ESMTP id n3LFuZPs027457
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Apr 2009 08:56:35 -0700
Received: from sj-webmail-9 (root@localhost)
	by sj-webmail-9.cisco.com (8.13.1/8.13.1/Submit) with ESMTP id
	n3LFuZ7T027456
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Apr 2009 08:56:35 -0700
Date: Tue, 21 Apr 2009 08:56:35 -0700
From: Subodh Nijsure <sunijsur@cisco.com>
To: <linuxppc-dev@ozlabs.org>
Message-ID: <000001c9c299$bf50d3e0$f272150a@cisco.com>
Subject: Performance differences with IRQ_ALL_CPUS
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,


I have board with MPC8572E (dual core PPC). I have one board running kernel
with IRQ_ALL_CPUS set to Y and another with that option turned off.  Kernel
version #2.6.26


With IRQ_ALL_CPUS turned off
( Here interrupts all go to CPU0 )

hdparm -tT /dev/hda
/dev/hda:
 Timing cached reads:   3048 MB in  2.00 seconds = 1523.79 MB/sec
 Timing buffered disk reads:   10 MB in  3.07 seconds =   3.25 MB/sec

cat /proc/interrupts
           CPU0       CPU1
 18:    1394100          0   OpenPIC   Edge      ide0

With IRQ_ALL_CPUS turned on I see
(Here interrupts go to CPU0 and CPU1 )

hdparm -tT /dev/hda

/dev/hda:
 Timing cached reads:   1076 MB in  2.00 seconds = 538.01 MB/sec
 Timing buffered disk reads:   10 MB in  3.08 seconds =   3.25 MB/sec

cat /proc/interrupts
           CPU0       CPU1
 18:      44951      54765   OpenPIC   Edge      ide0

I "expected" that with IRQ_ALL_CPUS -- interrupt sharing I would be able to
get higher througput but I see things otherway around. 

Would someone care to enlighten me as to why when I set IRQ_ALL_CPUS disk
I/O performance goes down so much?  Under what circumstances should one then
turn on IRQ_ALL_CPUS option on PPC platform? 

Regards,
/Subodh
