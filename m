Return-Path: <a.p.zijlstra@chello.nl>
Received: from bombadil.infradead.org (bombadil.infradead.org [18.85.46.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0F4F1B7080
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 25 Feb 2011 08:26:42 +1100 (EST)
Received: from canuck.infradead.org ([2001:4978:20e::1])
	by bombadil.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1Psihr-0002jB-9F
	for linuxppc-dev@lists.ozlabs.org; Thu, 24 Feb 2011 21:26:39 +0000
Received: from j77219.upc-j.chello.nl ([24.132.77.219]
	helo=dyad.programming.kicks-ass.net)
	by canuck.infradead.org with esmtpsa (Exim 4.72 #1 (Red Hat Linux))
	id 1Psiho-00073x-Hc
	for linuxppc-dev@lists.ozlabs.org; Thu, 24 Feb 2011 21:26:36 +0000
Subject: Re: PowerPC BUG: using smp_processor_id() in preemptible code
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1298582606.8833.509.camel@pasglop>
References: <alpine.LSU.2.00.1012291413360.22939@sister.anvils>
	<1293705910.17779.60.camel@pasglop>
	<alpine.LSU.2.00.1102241216420.1708@sister.anvils>
	<1298581675.5226.840.camel@laptop> <1298582606.8833.509.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 24 Feb 2011 22:27:55 +0100
Message-ID: <1298582875.5226.844.camel@laptop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Jeremy Fitzhardinge <jeremy@goop.org>,
	Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2011-02-25 at 08:23 +1100, Benjamin Herrenschmidt wrote:
> 
> I don't think that's needed here as there shall be no batching happening
> on the vmalloc space, but it can't hurt to merge it regardless :-)

Ah, due to the !batch->active thing? OK, then yeah Hugh's bit is
sufficient.
