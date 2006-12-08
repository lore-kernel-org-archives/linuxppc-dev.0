Return-Path: <wg@grandegger.com>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 777E167BDD
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  9 Dec 2006 07:02:23 +1100 (EST)
Received: from mail01.m-online.net (svr21.m-online.net [192.168.3.149])
	by mail-out.m-online.net (Postfix) with ESMTP id 8604298116
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  8 Dec 2006 21:02:21 +0100 (CET)
Received: from [172.16.0.100] (p5497DE02.dip.t-dialin.net [84.151.222.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp-auth.mnet-online.de (Postfix) with ESMTP id 64EC393E9D
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  8 Dec 2006 21:02:21 +0100 (CET)
Message-ID: <4579C586.5040809@grandegger.com>
Date: Fri, 08 Dec 2006 21:05:26 +0100
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Is in_le32 and out_le32 atomic?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello,

I'm puzzled about the following read and write funtions in 
include/asm-ppc/mv64x60.h:


/* Define I/O routines for accessing registers on the 64x60 bridge. */
extern inline void
mv64x60_write(struct mv64x60_handle *bh, u32 offset, u32 val) {
         ulong   flags;

         spin_lock_irqsave(&mv64x60_lock, flags);
         out_le32(bh->v_base + offset, val);
         spin_unlock_irqrestore(&mv64x60_lock, flags);
}

extern inline u32
mv64x60_read(struct mv64x60_handle *bh, u32 offset) {
         ulong   flags;
         u32     reg;

         spin_lock_irqsave(&mv64x60_lock, flags);
         reg = in_le32(bh->v_base + offset);
         spin_unlock_irqrestore(&mv64x60_lock, flags);
         return reg;
}

Can anybody tell me why the spin_* protection is needed? I thought that 
32-bit read and write operations are atomic.

TIA.

Wolfgang.
