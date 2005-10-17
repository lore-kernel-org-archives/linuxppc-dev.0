Return-Path: <SRS0+edbbf47766ee5d8b3fab+785+infradead.org+dwmw2@baythorne.srs.infradead.org>
Received: from baythorne.infradead.org (baythorne.infradead.org [81.187.2.161])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7431C68585
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 17 Oct 2005 22:38:00 +1000 (EST)
From: David Woodhouse <dwmw2@infradead.org>
To: David Jander <david.jander@protonic.nl>
In-Reply-To: <200510141135.47186.david.jander@protonic.nl>
References: <200510141135.47186.david.jander@protonic.nl>
Content-Type: text/plain
Date: Mon, 17 Oct 2005 13:37:52 +0100
Message-Id: <1129552672.3830.249.camel@baythorne.infradead.org>
Mime-Version: 1.0
Cc: linux-mtd@lists.infradead.org, linuxppc-embedded@ozlabs.org
Subject: Re: jffs2 robustness against powerfailure
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, 2005-10-14 at 11:35 +0200, David Jander wrote:
> We have a custom embedded linux board, based on a MPC852T processor, running 
> 2.4.25 kernel from denx. Jffs2 has certain backported patches after cvs from 
> 03/2005.

That sounds like a recipe for pain. March 2005 wasn't a good time to
take a snapshot from CVS; that just happens to be the time that we
stopped bothering to make it build in obsolete kernels.

If you want _stable_ JFFS2 code, you should use the code which is in the
2.4.31 kernel, or use the code which is in the 2.6 kernel (perhaps
updated from current CVS). 

> How comes I get a to see a valid file containing a mix of old and new
> data if it was written with a single write() call?????

Linux doesn't guarantee atomicity of writes larger than a single page,
but since your case is smaller than a page, it should have been atomic.

> Shouldn't jffs2 throw away the new incomplete node and keep the old
> version of the file?

Yes, it should. It's acceptable that there are extra data in the file
after 0x300 bytes, because the test program first does a write() call
and then a subsequent truncate() call. But it's not expected that the
0x300-byte write was not atomic; except in certain circumstances (like
reaching the end of an eraseblock and writing a smaller node there) you
should have seen all of it, or none. 

Please could you reproduce on a sane kernel and show the output of the
checkfs program during your test just before the power down, and also if
possible take an image of the contents of the flash _before_ mounting it
again after the power cycle. I'd like to see precisely the log nodes
which were present on the flash. If it's difficult to take a snapshot
before remounting, then running with CONFIG_JFFS2_FS_DEBUG=1 and
capturing all the KERN_DEBUG output via a serial console would suffice.

-- 
dwmw2
