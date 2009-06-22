Return-Path: <James.Bottomley@HansenPartnership.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 0B42DB7153
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 23 Jun 2009 01:16:53 +1000 (EST)
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com
	[66.63.167.143]) by ozlabs.org (Postfix) with ESMTP id BAC23DDD1C
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Jun 2009 01:16:52 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 1BB268EE0FC
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Jun 2009 08:16:46 -0700 (PDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
	by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new,
	port 10024) with ESMTP id azNPMckPz426 for <linuxppc-dev@ozlabs.org>;
	Mon, 22 Jun 2009 08:16:46 -0700 (PDT)
Received: from [192.168.10.224] (newmulgrave.ext.hansenpartnership.com
	[192.168.10.224])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 19F4C8EE0C8
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Jun 2009 08:16:44 -0700 (PDT)
Subject: Boot failure on the powerstation with 2.6.30 latest
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain
Date: Mon, 22 Jun 2009 10:16:41 -0500
Message-Id: <1245683801.6901.8.camel@mulgrave.site>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

2.6.30-rc8 worked fine ... unless this is a known problem, I suppose I
can begin bisecting.

The boot log of the hang is:

Please wait, loading kernel...
   Elf64 kernel loaded...
Loading ramdisk...
ramdisk loaded at 02500000, size: 8280 Kbytes
OF stdout device is: /ht/isa@8/serial@2f8
Preparing to boot Linux version 2.6.30 (jejb@claymoor) (gcc version 4.3.3 (Debian 4.3.3-10) ) #1 SMP Mon Jun 22 09:59:35 CDT 2009
command line: root=/dev/sda3 ro console=ttyS0,19200n1 
memory layout at init:
  alloc_bottom : 0000000002d16000
  alloc_top    : 0000000030000000
  alloc_top_hi : 0000000080000000
  rmo_top      : 0000000030000000
  ram_top      : 0000000080000000
instantiating rtas at 0x000000002fff5000... done
boot cpu hw idx 0000000000000000
starting cpu hw idx 0000000000000001... done
starting cpu hw idx 0000000000000002... done
starting cpu hw idx 0000000000000003... done
copying OF device tree...
Building dt strings...
Building dt structure...
Device tree strings 0x0000000003117000 -> 0x0000000003117640
Device tree struct  0x0000000003118000 -> 0x000000000311b000
Calling quiesce...
returning from prom_init

So it looks like some type of early boot failure or handoff in head_64

James
