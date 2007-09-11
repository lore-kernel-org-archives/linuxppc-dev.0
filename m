Return-Path: <hs@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 80B83DDE2F
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Sep 2007 19:40:41 +1000 (EST)
Subject: SYSFS: need a noncaching read
From: Heiko Schocher <hs@denx.de>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Tue, 11 Sep 2007 11:43:17 +0200
Message-Id: <1189503798.6674.46.camel@Zeus.EmbLux>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Detlev Zundel <dzu@denx.de>
Reply-To: hs@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello,

I have developed a device driver and use the sysFS to export some
registers to userspace. I opened the sysFS File for one register and did
some reads from this File, but I alwas becoming the same value from the
register, whats not OK, because they are changing. So I found out that
the sysFS caches the reads ... :-(

Is there a way to retrigger the reads (in that way, that the sysFS
rereads the values from the driver), without closing and opening the
sysFS Files? Or must I better use the ioctl () Driver-interface for
exporting these registers?

I am asking this, because I must read every 10 ms 2 registers, so
doing a open/read/close for reading one registers is a little bit too
much overhead.

I made a sysFS seek function, which retriggers the read, and that works
fine, but I have again 2 syscalls, whats also is not optimal.

Or can we make a open () with a (new?)Flag, that informs the sysFS to
always reread the values from the underlying driver?

Or a new flag in the "struct attribute_group" in include/linux/sysfs.h,
which let the sysfs rereading the values?

suggestions are welcome

thanks
Heiko
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
