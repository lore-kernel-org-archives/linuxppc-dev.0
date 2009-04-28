Return-Path: <paulus@bilbo.ozlabs.org>
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 817CBDDDA0
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Apr 2009 14:56:40 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18934.35969.872225.70725@cargo.ozlabs.ibm.com>
Date: Tue, 28 Apr 2009 14:56:33 +1000
From: Paul Mackerras <paulus@samba.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Please revert edada399 and 9203fc9c
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	Tim Abbott <tabbott@MIT.EDU>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Linus,

Please revert commits edada399 ("powerpc: Use TEXT_TEXT macro in
linker script.") and 9203fc9c ("powerpc: Use __REF macro instead of
old .text.init.refok."), which depends on edada399.

Commit edada399 breaks the build because it moves the __ftr_alt_*
sections of a file away from the .text section, causing link failures
due to relative conditional branch targets being too far away from the
branch instructions.  This happens on pretty much all 64-bit powerpc
configs.

Clearly these patches were never even build-tested.  They were never
acked by the powerpc maintainer (Ben) - because he was on vacation -
and they weren't sent to the deputy maintainer (me) or the relevant
mailing list (linuxppc-dev).

And they are clearly not fixes for regressions or serious bugs, so why
are these patches going in after -rc3 anyway?

Paul.
