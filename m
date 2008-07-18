Return-Path: <ntl@pobox.com>
Received: from sasl.smtp.pobox.com (a-sasl-fastnet.sasl.smtp.pobox.com
	[207.106.133.19]) by ozlabs.org (Postfix) with ESMTP id 94392DDEED
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Jul 2008 04:29:09 +1000 (EST)
Date: Fri, 18 Jul 2008 13:28:50 -0500
From: Nathan Lynch <ntl@pobox.com>
To: John Reiser <jreiser@BitWagon.com>
Subject: Re: [PATCH v3] elf loader support for auxvec base platform string
Message-ID: <20080718182850.GO9594@localdomain>
References: <1216166331-14810-1-git-send-email-ntl@pobox.com>
	<1216166331-14810-2-git-send-email-ntl@pobox.com>
	<1216276539.7740.309.camel@pasglop>
	<20080717000951.5f8cab37.akpm@linux-foundation.org>
	<20080717221932.GL9594@localdomain>
	<20080717154218.8981035c.akpm@linux-foundation.org>
	<487FD74C.4080603@BitWagon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <487FD74C.4080603@BitWagon.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Andrew Morton <akpm@linux-foundation.org>,
	torvalds@linux-foundation.org, roland@redhat.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

John Reiser wrote:
> Andrew Morton wrote:
> > On Thu, 17 Jul 2008 17:19:32 -0500
> > Nathan Lynch <ntl@pobox.com> wrote:
> > 
> > 
> >> [snip]
> >> A new aux vector entry, AT_BASE_PLATFORM, will denote the actual hardware.
> [snip]
> 
> > OK.
> > 
> > But it conflicts directly with the already-queued
> > execve-filename-document-and-export-via-auxiliary-vector.patch

Okay, I can rebase on -mm.


> It seems to me that most of the patch conflicts are mechanical
> and could be merged mechanically.
> 
> However I believe that the documentation change to this comment is important:
> -----
> >  #ifdef __KERNEL__
> > -#define AT_VECTOR_SIZE_BASE (14 + 2) /* NEW_AUX_ENT entries in auxiliary table */
> > +#define AT_VECTOR_SIZE_BASE 17 /* NEW_AUX_ENT entries in auxiliary table */
> > +  /* number of "#define AT_.*" above, minus {AT_NULL, AT_IGNORE, AT_NOTELF} */
> >  #endif
> -----
> I scratched my head for a while to figure out that AT_NOTELF also was
> a subtraction as far as AT_VECTOR_SIZE_BASE was concerned.

John, from your patch:

+#define AT_EXECFN  31	/* filename of program */

How did you arrive at 31 for the value of AT_EXECFN?  I haven't been
able to find out how AT_* values are "allocated", or what the reason
is for the gap between AT_SECURE and AT_SYSINFO.
