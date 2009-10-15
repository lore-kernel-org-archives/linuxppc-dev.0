Return-Path: <tabbott@MIT.EDU>
Received: from biscayne-one-station.mit.edu (BISCAYNE-ONE-STATION.MIT.EDU
	[18.7.7.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C8195B7B7C
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 16 Oct 2009 03:45:12 +1100 (EST)
Date: Thu, 15 Oct 2009 12:37:20 -0400 (EDT)
From: Tim Abbott <tabbott@ksplice.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: powerpc problem with .data.page_aligned -> __page_aligned_data
	conversion
In-Reply-To: <1255584772.2347.86.camel@pasglop>
Message-ID: <alpine.DEB.1.10.0910151229340.25434@dr-wily.mit.edu>
References: <1255584772.2347.86.camel@pasglop>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>, sam@ravnborg.org,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 15 Oct 2009, Benjamin Herrenschmidt wrote:

> For some weird reason, our gcc until 4.3 (fixed in 4.3) had the weird
> idea that the alignment attribute should not be allowed to force an
> alignment greater than 32k. If attempted, it would warn -and- crop the
> alignment to 32k.
[...]
> This has a few issues for us:
> 
> 	- The patch that converted bits of powerpc to the new macro break since
> it now hits that bug

Hi Ben,

Just to make sure I understand the nature of the problem, is the current 
breakage that gcc < 4.3 will _warn_ on any compilation units on ppc64 that 
use __page_aligned data, or something worse?

The cropping is clearly a potential problem, but I read the rest of your 
email as saying that the cropping of the alignment isn't actually a 
problem with the current kernel because the kernel is currently only using 
the macro with things whose size is divisible by PAGE_SIZE.  However, I am 
not sure how to reconcile that with using the word "break" above...

	-Tim Abbott
