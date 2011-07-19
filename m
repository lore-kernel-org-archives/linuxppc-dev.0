Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
	by ozlabs.org (Postfix) with SMTP id 2C748B6F80
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 19 Jul 2011 18:28:58 +1000 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
	by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new,
	port 10024) with SMTP
	id 07060-05 for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 19 Jul 2011 09:28:55 +0100 (BST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [RFC/PATCH] mm/futex: Fix futex writes on archs with SW
	trackingof dirty & young
Date: Tue, 19 Jul 2011 09:26:35 +0100
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6D8ADFF@saturn3.aculab.com>
In-Reply-To: <4E253F40.2010104@gmail.com>
From: "David Laight" <David.Laight@ACULAB.COM>
To: "Shan Hai" <haishan.bai@gmail.com>,
	"Benjamin Herrenschmidt" <benh@kernel.crashing.org>
Cc: tony.luck@intel.com, Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Peter Zijlstra <peterz@infradead.org>,
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

=20
> Got it, if the fault_in_user_writeable() is designed to catch the
> exact same write permission fault problem we discuss here, so
> your patch fixed that very nicely, we should fixup it by directly
> calling handle_mm_fault like what you did because we are for sure
> to know what just happened(permission violation), its not necessary
> to check what's happened by calling gup-->follow_page, and
> further the follow_page failed to report the fault :-)

One thought I've had - and I don't know enough about the data
area in use to know if it is a problem - is what happens if
a different cpu faults on the same user page and has already
marked it 'valid' between the fault happening and the fault
handler looking at the page tables to find out why.
If any of the memory areas are shared, it might be that the
PTE (etc) might already show the page a writable by the
time the fault handler is looking at them - this might confuse it!

	David
