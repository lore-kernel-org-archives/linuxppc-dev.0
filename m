Return-Path: <acahalan@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.188])
	by ozlabs.org (Postfix) with ESMTP id 7756D67BE1
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Aug 2006 14:41:08 +1000 (EST)
Received: by nf-out-0910.google.com with SMTP id k27so2448117nfc
	for <linuxppc-dev@ozlabs.org>; Sun, 13 Aug 2006 21:41:06 -0700 (PDT)
Message-ID: <787b0d920608132141v729665ayac50674d5ad147f4@mail.gmail.com>
Date: Mon, 14 Aug 2006 00:41:06 -0400
From: "Albert Cahalan" <acahalan@gmail.com>
To: "Paul Mackerras" <paulus@samba.org>
Subject: Re: [PATCH] no-execute -- please test
In-Reply-To: <17631.62819.24167.555967@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <787b0d920608132020q4ad2b5c2y49e25ca7ecc33536@mail.gmail.com>
	<17631.62819.24167.555967@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org, debian-powerpc <debian-powerpc@lists.debian.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 8/14/06, Paul Mackerras <paulus@samba.org> wrote:
> Albert Cahalan writes:
>
> > This kernel patch implements no-execute protection (like x86 "NX bit")
> > for the Mac G2, Mac G3, Mac G4, and other systems running 32-bit
> > PowerPC processors in the 6xx, 7xx, and 7xxx families.
>
> I'd be interested in benchmark comparisons with/without this patch, if
> anyone cares to run lmbench, kernbench etc. with and without...  If
> the performance impact is minimal I'll be happy to apply it.  If the
> impact is noticeable then it might need to be selectable with a config
> option.

There are a couple optimizations that can be done if needed.

The first is to avoid taking the initial fault on the segment
which contains the instruction pointer.

The second is to avoid cache or TLB invalidates or flushes
in certain circumstances. OpenBSD developers report that
this type of optimization is of great benefit on sparc and ppc.
It's an optimization than is only valid when no-execute is
in use, so the performance effects go both ways.
