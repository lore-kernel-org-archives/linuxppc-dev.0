Return-Path: <sam@ravnborg.org>
Received: from pfepb.post.tele.dk (pfepb.post.tele.dk [195.41.46.236])
	by ozlabs.org (Postfix) with ESMTP id A07ABDDDF3
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Apr 2009 18:33:22 +1000 (EST)
Date: Tue, 28 Apr 2009 10:35:28 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: Please revert edada399 and 9203fc9c
Message-ID: <20090428083528.GA17622@uranus.ravnborg.org>
References: <18934.35969.872225.70725@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <18934.35969.872225.70725@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, Tim Abbott <tabbott@MIT.EDU>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Apr 28, 2009 at 02:56:33PM +1000, Paul Mackerras wrote:
> Linus,
> 
> Please revert commits edada399 ("powerpc: Use TEXT_TEXT macro in
> linker script.") and 9203fc9c ("powerpc: Use __REF macro instead of
> old .text.init.refok."), which depends on edada399.
> 
> Commit edada399 breaks the build because it moves the __ftr_alt_*
> sections of a file away from the .text section, causing link failures
> due to relative conditional branch targets being too far away from the
> branch instructions.  This happens on pretty much all 64-bit powerpc
> configs.
> 
> Clearly these patches were never even build-tested.  They were never
> acked by the powerpc maintainer (Ben) - because he was on vacation -
> and they weren't sent to the deputy maintainer (me) or the relevant
> mailing list (linuxppc-dev).

This is partly my fault :-(
I acked them as I did not see the issue with conditional branches.
Could I ask you to add a comment to the lds file about this.

	Sam
