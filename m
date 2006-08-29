Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17651.34629.132793.190742@cargo.ozlabs.ibm.com>
Date: Tue, 29 Aug 2006 10:16:05 +1000
From: Paul Mackerras <paulus@samba.org>
To: Hollis Blanchard <hollisb@us.ibm.com>
Subject: Re: copy_4K_page() doesn't use dcbtst?
In-Reply-To: <1156786523.28490.52.camel@basalt.austin.ibm.com>
References: <1156786523.28490.52.camel@basalt.austin.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
	xen-ppc-devel <xen-ppc-devel@lists.xensource.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hollis Blanchard writes:

> Hi Paul, some Xen people were just noticing that copy_4K_page
> (arch/powerpc/lib/copypage_64.S) doesn't use the dcbtst instruction. Why
> doesn't it help there?

Why would we want to read the cache lines for the destination from
memory when we're only going to overwrite them completely anyway?

A stronger argument would be for using dcbz, but IIRC it actually made
things slower (on POWER4 at least).  I suspect the hardware is
gathering the stores for the whole of each cache line automatically,
so using dcbz doesn't provide any benefit.

I did a lot of measurements of memory copy speed on POWER4 (using
different copy loops, copy sizes, alignments, cache hot/cold cases)
and the copy_4K_page loop is the fastest I could come up with for
POWER4.  If anyone can come up with a routine that is measurably
faster on current machines, I'm happy to look at it, of course.

Paul.
