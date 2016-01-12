Return-Path: <peterz@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2001:1868:205::9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 155881A0D83
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jan 2016 20:27:43 +1100 (AEDT)
Date: Tue, 12 Jan 2016 10:27:11 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
 Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
 Andrew Cooper <andrew.cooper3@citrix.com>,
 Russell King - ARM Linux <linux@arm.linux.org.uk>,
 virtualization@lists.linux-foundation.org,
 Stefano Stabellini <stefano.stabellini@eu.citrix.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
 "H. Peter Anvin" <hpa@zytor.com>, Joe Perches <joe@perches.com>,
 David Miller <davem@davemloft.net>, linux-ia64@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-metag@vger.kernel.org, linux-mips@linux-mips.org,
 x86@kernel.org, user-mode-linux-devel@lists.sourceforge.net,
 adi-buildroot-devel@lists.sourceforge.net, linux-sh@vger.kernel.org,
 linux-xtensa@linux-xtensa.org, xen-devel@lists.xenproject.org,
 Ralf Baechle <ralf@linux-mips.org>, Ingo Molnar <mingo@kernel.org>,
 ddaney.cavm@gmail.com, will.deacon@arm.com, james.hogan@imgtec.com
Subject: Re: [v3,11/41] mips: reuse asm-generic/barrier.h
Message-ID: <20160112092711.GP6344@twins.programming.kicks-ass.net>
References: <1452426622-4471-12-git-send-email-mst@redhat.com>
 <56945366.2090504@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <56945366.2090504@imgtec.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jan 11, 2016 at 05:14:14PM -0800, Leonid Yegoshin wrote:

> This statement doesn't fit MIPS barriers variations. Moreover, there is a
> reason to extend that even more specific, at least for smp_store_release and
> smp_load_acquire, look into
> 
>     http://patchwork.linux-mips.org/patch/10506/

Dude, that's one horrible patch.

1) you do not make such things selectable; either the hardware needs
them or it doesn't. If it does you _must_ use them, however unlikely.

2) the changelog _completely_ fails to explain the sync 0x11 and sync
0x12 semantics nor does it provide a publicly accessible link to
documentation that does.

3) it really should have explained what you did with
smp_llsc_mb/smp_mb__before_llsc() in _detail_.

And I agree that ideally it should be split into parts.

Seriously, this is _NOT_ OK.
