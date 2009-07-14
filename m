Return-Path: <CFRIESEN@nortel.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id EFE64B707E
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 15 Jul 2009 07:18:49 +1000 (EST)
Received: from zcars04e.nortel.com (zcars04e.nortel.com [47.129.242.56])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "", Issuer "NORTEL" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 29D8DDDDA0
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Jul 2009 07:18:48 +1000 (EST)
Message-ID: <4A5CF62F.6020102@nortel.com>
Date: Tue, 14 Jul 2009 15:18:39 -0600
From: "Chris Friesen" <cfriesen@nortel.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org, Linux kernel <linux-kernel@vger.kernel.org>
Subject: proper way to reserve a chunk of memory at the top of the kernel?
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I have a powerpc board with 512BM of memory.  The BIOS has a chunk of
memory at the top end of physical memory which it does not zero out over
a reboot.

What's the proper way to tell linux that this chunk of physical memory
should be ignored (so that we can access it later without worrying that
Linux will try to allocate it)?  Should I be calling

lmb_reserve(lmb_end_of_DRAM() - size, size);

in early_reserve_mem() or is there a better mechanism?

For comparison, in an older kernel this was done in set_phys_avail(), by
calling mem_pieces_remove(&phys_avail, total_lowmem - size, size, 1);

Thanks,

Chris
