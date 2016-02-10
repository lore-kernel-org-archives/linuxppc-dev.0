Return-Path: <duwe@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9BC8A1A0923
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Feb 2016 04:50:20 +1100 (AEDT)
Date: Wed, 10 Feb 2016 18:50:17 +0100
From: Torsten Duwe <duwe@lst.de>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Jiri Kosina <jkosina@suse.cz>, Miroslav Benes <mbenes@suse.cz>,
 Petr Mladek <pmladek@suse.com>, Jessica Yu <jeyu@redhat.com>,
 Steven Rostedt <rostedt@goodmis.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, live-patching@vger.kernel.org
Subject: Re: [PATCH v7 07/10] ppc64 ftrace: disable profiling for some files
Message-ID: <20160210175017.GA19199@lst.de>
References: <20160204161527.5F3AC692CD@newverein.lst.de>
 <20160204162114.09AD4692E0@newverein.lst.de>
 <1455064413.7576.3.camel@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1455064413.7576.3.camel@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Feb 10, 2016 at 11:33:33AM +1100, Michael Ellerman wrote:
> On Mon, 2016-01-25 at 16:31 +0100, Torsten Duwe wrote:
> 
> > This patch complements the "notrace" attribute for selected functions.
> > It adds -mprofile-kernel to the cc flags to be stripped from the command
> > line for code-patching.o and feature-fixups.o, in addition to "-pg"
> 
> This could probably be folded into patch 5, and the combined patch would be
> "remove -mprofile-kernel in all the same places we remove -pg and for the same
> reasons".

That's right. It has shrunk a lot...

> I can't think of anywhere we would want to disable -pg but not disable
> -mprofile-kernel? Or vice versa.

On patch creation, I had handled them literally, individually. Now they're
blended into CC_FLAGS_FTRACE, which greatly simplified things.

Done.
	Torsten
