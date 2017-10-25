Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yMNym0GFCzDqlT
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Oct 2017 19:46:08 +1100 (AEDT)
Date: Wed, 25 Oct 2017 19:46:02 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: Matthew Wilcox <mawilcox@microsoft.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 linux-kernel@vger.kernel.org,
 "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
 "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>
Subject: Re: [PATCH] bitmap: Fix optimization of bitmap_set/clear for
 big-endian machines
Message-ID: <20171025084602.GC25140@fergus.ozlabs.ibm.com>
References: <20171025065726.GA25140@fergus.ozlabs.ibm.com>
 <MWHPR21MB08455F1374F717DBA20B7798CB440@MWHPR21MB0845.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <MWHPR21MB08455F1374F717DBA20B7798CB440@MWHPR21MB0845.namprd21.prod.outlook.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Oct 25, 2017 at 07:39:48AM +0000, Matthew Wilcox wrote:
> Hang on, don't tell me you found this by inspection.  Are you not running the bitmap testcase, enabled by CONFIG_TEST_BITMAP?  Either that should be producing an error, or there's a missing test case, or your inspection is wrong ...

I did find it by inspection.  I was looking for a version of the
bitmap_* API that does little-endian style bitmaps on all systems, and
the inline bitmap_set() does that in the case where it calls memset,
but not in the case where it calls __bitmap_set.

I'll fire up a big-endian system tomorrow when I get to work to run
the test case.  (PPC64 is almost entirely little-endian these days as
far as the IBM POWER systems are concerned.)

In any case, it's pretty clearly wrong as it is.  On a big-endian
64-bit system, bitmap_set(p, 56, 16) should set bytes 0 and 15 to
0xff, and there's no way a single memset can do that.

Paul.

(and yes, I stuffed up the address for lkml)
