Return-Path: <rdreier@cisco.com>
Received: from test-iport-3.cisco.com (test-iport-3.cisco.com [171.71.176.78])
	by ozlabs.org (Postfix) with ESMTP id 25BB167A6F
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 10 Apr 2006 11:52:18 +1000 (EST)
To: Andre Draszik <kernel@andred.net>
Subject: Re: Slab errors on 4xx (STB04)
References: <44398BD4.60904@andred.net>
From: Roland Dreier <rdreier@cisco.com>
Date: Sun, 09 Apr 2006 18:42:17 -0700
In-Reply-To: <44398BD4.60904@andred.net> (Andre Draszik's message of "Mon,
	10 Apr 2006 00:33:56 +0200")
Message-ID: <adairpi5hqe.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

    Andre> Since it _seems_ to work nevertheless - is
    Andre> CONFIG_DEBUG_SLAB known to be broken on this platform?
    Andre> (Although such stack traces are only printed when doing sth
    Andre> with the USB). Or is this caused by some other (memory
    Andre> initialization?) error?

Last time I looked, I think CONFIG_DEBUG_SLAB was broken on
non-cache-coherent architectures (such as PPC 4xx).  The reason is
that the slab poisoning breaks the cacheline alignment of slabs, and
then invalidating the cache can trash stuff that slab debugging ends
up thinking is overwritten.

 - R.
