Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 952B3B6F85
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 18 Jul 2011 14:07:47 +1000 (EST)
Subject: Re: [PATCH 1/1] Fixup write permission of TLB on powerpc e500 core
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Peter Zijlstra <peterz@infradead.org>
In-Reply-To: <1310961196.25044.266.camel@pasglop>
References: <1310717238-13857-1-git-send-email-haishan.bai@gmail.com>
	<1310717238-13857-2-git-send-email-haishan.bai@gmail.com>
	<1310725418.2586.309.camel@twins> <4E21A526.8010904@gmail.com>
	<1310860194.25044.17.camel@pasglop>
	<4b337921-d430-4b63-bc36-ad31753cf800@email.android.com>
	<1310912990.25044.203.camel@pasglop>
	<1310944453.25044.262.camel@pasglop>
	<1310961196.25044.266.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 18 Jul 2011 14:02:23 +1000
Message-ID: <1310961743.25044.275.camel@pasglop>
Mime-Version: 1.0
Cc: tony.luck@intel.com, Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Shan Hai <haishan.bai@gmail.com>, linux-kernel@vger.kernel.org,
	cmetcalf@tilera.com, dhowells@redhat.com, paulus@samba.org,
	tglx@linutronix.de, walken@google.com,
	linuxppc-dev@lists.ozlabs.org, akpm@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2011-07-18 at 13:53 +1000, Benjamin Herrenschmidt wrote:
> On Mon, 2011-07-18 at 09:14 +1000, Benjamin Herrenschmidt wrote:
> 
> > In fact, with such a flag, we could probably avoid the ifdef entirely, and
> > always go toward the PTE fixup path when called in such a fixup case, my gut
> > feeling is that this is going to be seldom enough not to hurt x86 measurably
> > but we'll have to try it out.
> > 
> > That leads to that even less tested patch:
> 
>  And here's a version that builds (still not tested :-)
> 
> Shan, can you verify whether that fixes the problem for you ?
> 
> I also had a cursory glance at the ARM code and it seems to rely on the
> same stuff as embedded powerpc does for dirty/young updates, so in
> theory it should exhibit the same problem.
> 
> I suspect the scenario is rare enough in practice in embedded workloads
> that nobody noticed until now.

Ignore that bogus send, I sent a proper one immediately after (evolution
FAIL, sorry about that)

Cheers,
Ben.
