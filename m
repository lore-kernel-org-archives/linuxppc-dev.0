Return-Path: <viro@ftp.linux.org.uk>
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [195.92.253.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 486ECB6EF1
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 May 2012 07:49:00 +1000 (EST)
Date: Fri, 25 May 2012 22:48:45 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [git pull] signals, the first series
Message-ID: <20120525214845.GQ11775@ZenIV.linux.org.uk>
References: <20120522043525.GI11775@ZenIV.linux.org.uk>
 <20120522180635.93ba83a63481b2364bd8f425@canb.auug.org.au>
 <20120523151405.f264a88ca4edf8d22c08c86c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120523151405.f264a88ca4edf8d22c08c86c@canb.auug.org.au>
Sender: Al Viro <viro@ftp.linux.org.uk>
Cc: linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, May 23, 2012 at 03:14:05PM +1000, Stephen Rothwell wrote:
> OK, it seem that most of this has been in Andrew's tree for a while,
> sorry about that.

Grr...  *Another* missing prereq for task_work_add() series, this time on
ppc64.  Could somebody familiar with that beast take a look at this and
tell if the change is sane?  What we want is
	r0 = r3 & MSR_PR ?
		_TIF_NEED_RESCHED | _TIF_NOTIFY_RESUME | _TIF_SIGPENDING :
		_TIF_NEED_RESCHED;
and when Roland re-added NOTIFY_RESUME he'd missed that hack (non-PREEMPT
variant and 32bit code all just check _TIF_USER_WORK_MASK, so updating
it had been enough in those cases).  I don't have the hardware in
question; the same instructions in userland on ppc32 box produce the
right value.  Unless NAKed I'm going to throw that one into the second
pull request from signal.git, so if anyone has objections, please yell.

I'll gladly replace that with better solution if one shows up (or, better
yet, goes via ppc tree).  AFAICS the diff below should work, but whether
it's the best variant or not... No idea.

Back to massaging VFS queue for pull...

diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index ed1718f..e4fd9bb 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -563,9 +563,10 @@ _GLOBAL(ret_from_except_lite)
 	li	r0,_TIF_NEED_RESCHED	/* bits to check */
 	ld	r3,_MSR(r1)
 	ld	r4,TI_FLAGS(r9)
-	/* Move MSR_PR bit in r3 to _TIF_SIGPENDING position in r0 */
+	/* Add MSR_PR bit in r3 in _TIF_SIGPENDING and _TIF_NOTIFY_RESUME positions in r0 */
 	rlwimi	r0,r3,32+TIF_SIGPENDING-MSR_PR_LG,_TIF_SIGPENDING
-	and.	r0,r4,r0	/* check NEED_RESCHED and maybe SIGPENDING */
+	rlwimi	r0,r3,32+TIF_NOTIFY_RESUME-MSR_PR_LG,_TIF_NOTIFY_RESUME
+	and.	r0,r4,r0	/* check NEED_RESCHED and maybe SIGPENDING/NOTIFY_RESUME */
 	bne	do_work
 
 #else /* !CONFIG_PREEMPT */
