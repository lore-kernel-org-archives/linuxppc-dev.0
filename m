Return-Path: <SRS0+a5e15608dd26525b8a20+787+infradead.org+dwmw2@baythorne.srs.infradead.org>
Received: from baythorne.infradead.org (baythorne.infradead.org [81.187.2.161])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2E68A685D3
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 19 Oct 2005 19:50:13 +1000 (EST)
From: David Woodhouse <dwmw2@infradead.org>
To: David Jander <david.jander@protonic.nl>
In-Reply-To: <200510191010.47799.david.jander@protonic.nl>
References: <200510141135.47186.david.jander@protonic.nl>
	<1129552672.3830.249.camel@baythorne.infradead.org>
	<200510191010.47799.david.jander@protonic.nl>
Content-Type: text/plain; charset=UTF-8
Date: Wed, 19 Oct 2005 10:50:06 +0100
Message-Id: <1129715406.3830.353.camel@baythorne.infradead.org>
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

On Wed, 2005-10-19 at 10:10 +0200, David Jander wrote:
> 2.6 is not an option yet for mpc8xx architecture, so I'll have to stick with 
> either what I have now or 2.4.31, but I fear the tradeoff of using vanilla 
> 2.4.31 jffs2 will be much slower fs, prohibitively long mount-times, etc... 
> am I right?

If it's all running perfectly for you and you have no work to do, then
yes, perhaps you're right. But since that's evidently _not_ the case,
then no, I would disagree.

If I were you, the first thing I'd do would be to get a current kernel
working. It should only take a week or so -- porting from 2.4 to 2.6
really isn't that difficult.

> I am still busy doing experiments, please have a little patience.
> Until now I have turned on debug info in the same kernel as before, and get 
> literally tons of log info. My monitor script had a bug, so the board was 
> reset a little to soon in several occasions (shouldn't harm, should it), so 
> now I have an image of jffs2 which on boot of the system produces a BUG() in 
> gc.c line 139.

That should never happen, regardless of when the board is reset.
Assuming it still happens with JFFS2 code I care about (either 2.4 or
2.6), please could I have a copy of this image?

The problem you first reported doesn't seem too worrying to me. Writes
aren't always atomic -- in fact the Linux VFS¹ _guarantees_ that writes
larger than a page are _not_ atomic, because it splits pages up to call
prepare_write() and commit_write() on each one.

JFFS2 will mostly write each page out in a single node, but when there
is only a small amount of space at the end of an eraseblock it will
split writes still further, filling the eraseblock with as much data as
possible before writing the remainder of the page into a new eraseblock.
I suspect that's what happened in the case you showed. 
 
-- 
dwmw2

¹ Assuming you use generic_file_write()
