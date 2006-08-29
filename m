Return-Path: <ralf@linux-mips.org>
Received: from ftp.linux-mips.org (ftp.linux-mips.org [194.74.144.162])
	by ozlabs.org (Postfix) with ESMTP id B3E2B679E1
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 30 Aug 2006 02:47:27 +1000 (EST)
Received: from localhost.localdomain ([127.0.0.1]:15061 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20039457AbWH2QRZ (ORCPT <rfc822;linuxppc-embedded@ozlabs.org>);
	Tue, 29 Aug 2006 17:17:25 +0100
Date: Tue, 29 Aug 2006 17:17:48 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: linux-ia64@vger.kernel.org, linux-mips@linux-mips.org,
	linuxppc-embedded@ozlabs.org, paulkf@microgate.com,
	takata@linux-m32r.org, linux-kernel@vger.kernel.org
Subject: Re: [CFT:PATCH] Removing possible wrong asm/serial.h inclusions
Message-ID: <20060829161748.GF29289@linux-mips.org>
References: <20060828085244.GA13544@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060828085244.GA13544@flint.arm.linux.org.uk>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon, Aug 28, 2006 at 09:52:44AM +0100, Russell King wrote:

> asm/serial.h is supposed to contain the definitions for the architecture
> specific 8250 ports for the 8250 driver.  It may also define BASE_BAUD,
> but this is the base baud for the architecture specific ports _only_.
> 
> Therefore, nothing other than the 8250 driver should be including this
> header file.  In order to move towards this goal, here is a patch which
> removes some of the more obvious incorrect includes of the file.
> 
> MIPS and PPC has rather a lot of stuff in asm/serial.h, some of it looks
> related to non-8250 ports.  Hence, it's not trivial to conclude that
> these includes are indeed unnecessary, so can mips and ppc people please
> test this patch carefully.

The MIPS bits were just unused leftovers from the days when the arch
code did did register serials & consoles.  So for the MIPS bits:

Acked-by: Ralf Baechle <ralf@linux-mips.org>

  Ralf
