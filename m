Return-Path: <jeffm@suse.de>
Received: from locomotive.unixthugs.org (locomotive.csh.rit.edu
	[129.21.60.149]) by ozlabs.org (Postfix) with ESMTP id 40CC968550
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Oct 2005 11:20:02 +1000 (EST)
Message-ID: <434F0710.50607@suse.de>
Date: Thu, 13 Oct 2005 21:17:04 -0400
From: Jeff Mahoney <jeffm@suse.de>
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
References: <20050426211019.GA11579@suse.de>	<426F9646.3000407@namesys.com>	<20051011190133.GA31348@suse.de>
	<20051013162734.615bba34.akpm@osdl.org>
In-Reply-To: <20051013162734.615bba34.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, reiserfs-dev@namesys.com, reiser@namesys.com,
	Olaf Hering <olh@suse.de>
Subject: Re: [PATCH] make gcc -O1 in fs/reiserfs optional
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Andrew Morton wrote:
> Are you sure it's due to inline functions?  I thought the problem was that
> certain versions of gcc did automatic inlining of non-inlined functions and
> we get excessive stack windup due to that.  And iirc we put in global
> compiler options to defeat that behaviour.  Andi would recall.
> 
> Furthermore, we do have infrastructure for detecting the gcc version at
> build time.  It would be better to use that for disabling `-O2', rather
> than a config option.

Andrew -

This "fix" has been in the kernel since I developed the endian safe
patches for ReiserFS in the 2.4 days; This patch just makes it optional
rather than required.

You could be correct regarding the behavior. I noticed it was related to
inline functions and stack usage. Since this was quite a few years ago
now, I don't recall the exact details, just that -O1 worked around it. I
was content blaming gcc and moving on with development. I seem to recall
thinking that was overaggressive aliasing avoidance between temporary
variables in static inline functions. The endian safe code frequently
uses static inlines for conversion of disk order bitfields (like key
type and offset). balance_leaf() is a beast of a function at around 1400
lines or so. When compiled with -O2, it wanted to allocate 6k of stack
space. With -O1, it ended up allocating about 230 bytes. It seemed to be
the only function really affected by the bug, but I wanted to be certain.

I do agree that using the kbuild infrastructure to determine the need
for this option would work quite a bit better.

-Jeff

-- 
Jeff Mahoney
SUSE Labs
