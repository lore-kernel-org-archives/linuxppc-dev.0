Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de [212.227.17.8])
	by ozlabs.org (Postfix) with ESMTP id A7E3FB6F04
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 24 Nov 2009 06:04:21 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: "Chris Friesen" <cfriesen@nortel.com>
Subject: Re: RFC: Put printk buffer in video ram
Date: Mon, 23 Nov 2009 20:03:31 +0100
References: <1258855506.3153.1.camel@maxim-laptop>
	<20091123183220.GB24482@elte.hu> <4B0ADA84.5050300@nortel.com>
In-Reply-To: <4B0ADA84.5050300@nortel.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <200911232003.31482.arnd@arndb.de>
Cc: Maxim Levitsky <maximlevitsky@gmail.com>,
	Frederic Weisbecker <fweisbec@gmail.com>, linuxppc-dev@lists.ozlabs.org,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Dave Jones <davej@redhat.com>, Ingo Molnar <mingo@elte.hu>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Arjan van de Ven <arjan@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Monday 23 November 2009, Chris Friesen wrote:
> We've had a mechanism sort of like this for quite a while.  Hasn't been
> pushed to mainline because it used board-specific hardware and we're
> usually multiple kernel versions behind mainline.
> 
> Anyways, a couple things that we've found to be useful are:
> 1) The ability to allocate a chunk of this persistent memory area for a
> special purpose.  This allows things like memory-mapped circular buffers
> for per-cpu binary data.
> 2) An API to log just to this persistent area and bypass the normal
> console completely.  This can be useful when debugging issues where the
> normal logging paths result in a hang.

Some powerpc machines have a memory-mapped nvram, in which the kernel
can install persistant 'partitions'. Not all of them are memory mapped,
but for those that are (e.g. IBM QS22), your approach sounds perfect.

	Arnd <><
