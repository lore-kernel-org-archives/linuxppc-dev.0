Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 930C8B71D3
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 18 Jul 2011 00:37:43 +1000 (EST)
Subject: Re: [PATCH 1/1] Fixup write permission of TLB on powerpc e500 core
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
In-Reply-To: <1310900561.13765.22.camel@twins>
References: <1310717238-13857-1-git-send-email-haishan.bai@gmail.com>
	<1310717238-13857-2-git-send-email-haishan.bai@gmail.com>
	<1310725418.2586.309.camel@twins>  <4E21A526.8010904@gmail.com>
	<1310860194.25044.17.camel@pasglop> <1310900561.13765.22.camel@twins>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 18 Jul 2011 00:34:24 +1000
Message-ID: <1310913264.25044.205.camel@pasglop>
Mime-Version: 1.0
Cc: tony.luck@intel.com, Shan Hai <haishan.bai@gmail.com>,
	linux-kernel@vger.kernel.org, cmetcalf@tilera.com,
	dhowells@redhat.com, paulus@samba.org, tglx@linutronix.de,
	walken@google.com, linuxppc-dev@lists.ozlabs.org, akpm@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2011-07-17 at 13:02 +0200, Peter Zijlstra wrote:
> 
> Again, _WHY_ isn't gup(.write=1) a complete write fault? Its supposed to
> be, it needs to break COW, do dirty page tracking and call page_mkwrite.
> I'm still thinking this e500 stuff is smoking crack.
> 
> ARM has no hardware dirty bit either, and yet it works for them. I can't
> exactly tell how because I got lost in there, but it does, again,
> suggest e500 is on crack. 

Because gup won't set dirty for a page that is already writable but
whose dirty bit has been "harvested" by the VM already. Same with young.

Maybe nobody sees it on ARM because nobody ever swaps on it ? :-) Or
they have some different way of handling dirty/young updates.. I don't
know.

e500 isn't the only one who will be affected. All the non-hash powerpc
subarchs will (I wrote a lot of that mm code so it's all my fault :-)
That includes 4xx and 64-bit BookE.

Cheers,
Ben.
