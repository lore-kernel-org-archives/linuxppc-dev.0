Return-Path: <peterz@infradead.org>
Received: from merlin.infradead.org (merlin.infradead.org
	[IPv6:2001:4978:20e::2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 22903B6F8F
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 27 Jul 2011 19:00:22 +1000 (EST)
Subject: Re: [RFC/PATCH] mm/futex: Fix futex writes on archs with SW
	tracking of dirty & young
From: Peter Zijlstra <peterz@infradead.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1311753513.25044.663.camel@pasglop>
References: <1310717238-13857-1-git-send-email-haishan.bai@gmail.com>
	<1310717238-13857-2-git-send-email-haishan.bai@gmail.com>
	<1310725418.2586.309.camel@twins> <4E21A526.8010904@gmail.com>
	<1310860194.25044.17.camel@pasglop>
	<4b337921-d430-4b63-bc36-ad31753cf800@email.android.com>
	<1310912990.25044.203.camel@pasglop>
	<1310944453.25044.262.camel@pasglop>
	<1310961691.25044.274.camel@pasglop> <4E23D728.7090406@gmail.com>
	<1310972462.25044.292.camel@pasglop> <4E23E02C.8090401@gmail.com>
	<1310974591.25044.298.camel@pasglop> <4E24FA51.70602@gmail.com>
	<1311049762.25044.392.camel@pasglop>
	<CAMjpGUdxpaYBFfKjBEPFOJohnKoXfagLUHvhrst+NembeabxcA@mail.gmail.com>
	<1311753513.25044.663.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 27 Jul 2011 10:59:50 +0200
Message-ID: <1311757190.24752.406.camel@twins>
Mime-Version: 1.0
Cc: tony.luck@intel.com, Mike Frysinger <vapier.adi@gmail.com>,
	Shan Hai <haishan.bai@gmail.com>, linux-kernel@vger.kernel.org,
	cmetcalf@tilera.com, dhowells@redhat.com, paulus@samba.org,
	uclinux-dist-devel@blackfin.uclinux.org, tglx@linutronix.de,
	walken@google.com, linuxppc-dev@lists.ozlabs.org, akpm@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2011-07-27 at 17:58 +1000, Benjamin Herrenschmidt wrote:

> What should nommu do anyways ? it's not like there's much it can do
> right ? It should never even hit the fault path to start with ...

Something like the below makes a nommu arm config build.. David, is this
indeed the correct thing to do for nommu?

---
Index: linux-2.6/mm/nommu.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.orig/mm/nommu.c
+++ linux-2.6/mm/nommu.c
@@ -190,6 +190,12 @@ int get_user_pages(struct task_struct *t
 }
 EXPORT_SYMBOL(get_user_pages);
=20
+int fixup_user_fault(struct task_struct *tsk, struct mm_struct *mm,
+		     unsigned long address, unsigned int fault_flags)
+{
+	BUG(); /* nommu should never call this */
+}
+
 /**
  * follow_pfn - look up PFN at a user virtual address
  * @vma: memory mapping
