Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A6163B70A6
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 20 Oct 2010 21:36:33 +1100 (EST)
Subject: Re: PROBLEM: memory corrupting bug, bisected to 6dda9d55
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: pacman@kosh.dhis.org
In-Reply-To: <20101020032345.5240.qmail@kosh.dhis.org>
References: <20101020032345.5240.qmail@kosh.dhis.org>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 20 Oct 2010 21:32:16 +1100
Message-ID: <1287570736.2198.19.camel@pasglop>
Mime-Version: 1.0
Cc: Mel Gorman <mel@csn.ul.ie>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2010-10-19 at 22:23 -0500, pacman@kosh.dhis.org wrote:
> The diff fragment above applied inside prom_close_stdin, but there are
> some
> prom_printf calls after prom_close_stdin. Calling prom_printf after
> closing
> stdout sounds like it could be bad. If I moved it down below all the
> prom_printf's, it would be after the "quiesce" call. Would that be
> acceptable
> (or even interesting as an experiment)? Does a close need a quiesce
> after it?

Just try :-) "quiesce" is something that afaik only apple ever
implemented anyways. It uses hooks inside their OF to shut down all
drivers that do bus master (among other HW sanitization tasks).

Cheers,
Ben.
