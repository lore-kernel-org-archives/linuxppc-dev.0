Return-Path: <peterz@infradead.org>
Received: from merlin.infradead.org (merlin.infradead.org
	[IPv6:2001:4978:20e::2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2641CB6F00
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 19 Jul 2011 21:10:50 +1000 (EST)
Subject: Re: [RFC/PATCH] mm/futex: Fix futex writes on archs with SW
	tracking of dirty & young
From: Peter Zijlstra <peterz@infradead.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1311049762.25044.392.camel@pasglop>
References: <1310717238-13857-1-git-send-email-haishan.bai@gmail.com>
	<1310717238-13857-2-git-send-email-haishan.bai@gmail.com>
	<1310725418.2586.309.camel@twins> <4E21A526.8010904@gmail.com>
	<1310860194.25044.17.camel@pasglop>
	<4b337921-d430-4b63-bc36-ad31753cf800@email.android.com>
	<1310912990.25044.203.camel@pasglop>
	<1310944453.25044.262.camel@pasglop>
	<1310961691.25044.274.camel@pasglop>  <4E23D728.7090406@gmail.com>
	<1310972462.25044.292.camel@pasglop>  <4E23E02C.8090401@gmail.com>
	<1310974591.25044.298.camel@pasglop>  <4E24FA51.70602@gmail.com>
	<1311049762.25044.392.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 19 Jul 2011 13:10:24 +0200
Message-ID: <1311073824.13765.195.camel@twins>
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

On Tue, 2011-07-19 at 14:29 +1000, Benjamin Herrenschmidt wrote:
> The futex code currently attempts to write to user memory within
> a pagefault disabled section, and if that fails, tries to fix it
> up using get_user_pages().
>=20
> This doesn't work on archs where the dirty and young bits are
> maintained by software, since they will gate access permission
> in the TLB, and will not be updated by gup().
>=20
> In addition, there's an expectation on some archs that a
> spurious write fault triggers a local TLB flush, and that is
> missing from the picture as well.
>=20
> I decided that adding those "features" to gup() would be too much
> for this already too complex function, and instead added a new
> simpler fixup_user_fault() which is essentially a wrapper around
> handle_mm_fault() which the futex code can call.
>=20
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>=20

Acked-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
