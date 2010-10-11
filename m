Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 20E15B70B8
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 12 Oct 2010 08:02:18 +1100 (EST)
Date: Mon, 11 Oct 2010 14:00:39 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Mel Gorman <mel@csn.ul.ie>
Subject: Re: PROBLEM: memory corrupting bug, bisected to 6dda9d55
Message-Id: <20101011140039.15a2c78d.akpm@linux-foundation.org>
In-Reply-To: <20101011143022.GD30667@csn.ul.ie>
References: <20101009095718.1775.qmail@kosh.dhis.org>
	<20101011143022.GD30667@csn.ul.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, pacman@kosh.dhis.org,
	KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
	Christoph Lameter <cl@linux.com>, Yinghai Lu <yinghai@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

(cc linuxppc-dev@lists.ozlabs.org)

On Mon, 11 Oct 2010 15:30:22 +0100
Mel Gorman <mel@csn.ul.ie> wrote:

> On Sat, Oct 09, 2010 at 04:57:18AM -0500, pacman@kosh.dhis.org wrote:
> > (What a big Cc: list... scripts/get_maintainer.pl made me do it.)
> > 
> > This will be a long story with a weak conclusion, sorry about that, but it's
> > been a long bug-hunt.
> > 
> > With recent kernels I've seen a bug that appears to corrupt random 4-byte
> > chunks of memory. It's not easy to reproduce. It seems to happen only once
> > per boot, pretty quickly after userspace has gotten started, and sometimes it
> > doesn't happen at all.
> > 
> 
> A corruption of 4 bytes could be consistent with a pointer value being
> written to an incorrect location.

It's corruption of user memory, which is unusual.  I'd be wondering if
there was a pre-existing bug which 6dda9d55bf545013597 has exposed -
previously the corruption was hitting something harmless.  Something
like a missed CPU cache writeback or invalidate operation.

How sensitive/vulnerable is PPC32 to such things?
