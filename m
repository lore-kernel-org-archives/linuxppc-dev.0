Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
	by ozlabs.org (Postfix) with SMTP id 6F5CA1007D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 15 Jul 2011 20:35:08 +1000 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
	by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new,
	port 10024) with SMTP
	id 04784-05 for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 15 Jul 2011 11:35:05 +0100 (BST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 0/1] Fixup write permission of TLB on powerpc e500 core
Date: Fri, 15 Jul 2011 11:32:49 +0100
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6D8ADFC@saturn3.aculab.com>
In-Reply-To: <4E20112C.6040307@gmail.com>
From: "David Laight" <David.Laight@ACULAB.COM>
To: "Shan Hai" <haishan.bai@gmail.com>,
	"Peter Zijlstra" <a.p.zijlstra@chello.nl>
Cc: tony.luck@intel.com, linux-kernel@vger.kernel.org, cmetcalf@tilera.com,
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

=20
> The fault causing futex_atomic_cmpxchg_inatomic() is
> protected by pagefault_disable(), so the page fault handler has
> no chance to toggle the SW dirty/young tracking.

Perhaps that is the bug!
Whatever pagefault_disable() does, it shouldn't disable the
SW dirty/young tracking - which should only needs bits moving
in the page table itself (and TLB update??) rather than any
operations on the rest of the data areas.

It looks to me as though this could happen any time a page
is marked inaccessible by the dirty/young tracking.
Not just as a result of COW.

	David
