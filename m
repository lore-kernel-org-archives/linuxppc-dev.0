Return-Path: <ntl@pobox.com>
Received: from sasl.smtp.pobox.com (a-sasl-quonix.sasl.smtp.pobox.com
	[208.72.237.25]) by ozlabs.org (Postfix) with ESMTP id 42AEFDDEE9
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jul 2008 05:35:27 +1000 (EST)
Date: Thu, 17 Jul 2008 14:35:16 -0500
From: Nathan Lynch <ntl@pobox.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] elf loader support for auxvec base platform string
Message-ID: <20080717193516.GH9594@localdomain>
References: <1216166331-14810-1-git-send-email-ntl@pobox.com>
	<1216166331-14810-2-git-send-email-ntl@pobox.com>
	<1216276539.7740.309.camel@pasglop>
	<alpine.LFD.1.10.0807170908060.2959@woody.linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.LFD.1.10.0807170908060.2959@woody.linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	roland@redhat.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Linus Torvalds wrote:
> 
> 
> On Thu, 17 Jul 2008, Benjamin Herrenschmidt wrote:
> > 
> > Should I seek somebody's ack before merging a patch like the one below ?
> > 
> > I'm a bit reluctant to merge via the powerpc.git tree some changes to
> > generic files without at least an ack from somebody else :-)
> 
> Gaah. Generally we don't, but you're right to ask. The ELF loading keeps 
> on accumulating these things, and I'm not sure we have the right process 
> for things like this. They're all individually small and insignificant, 
> and they are all individually never going away and making the ELF loader 
> messier and messier.

FWIW, I was initially reluctant to do it this way, but the ELF aux
vector seems to be the only reasonable mechanism for getting this
information to all interested users.  And the only reason the patch
touches the generic code is because we have to copy a string to
userspace (just like AT_PLATFORM).  Otherwise it could be done in
powerpc's ARCH_DLINFO.
