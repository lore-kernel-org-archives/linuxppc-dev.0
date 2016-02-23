Return-Path: <linus971@gmail.com>
Received: from mail-io0-x236.google.com (mail-io0-x236.google.com
 [IPv6:2607:f8b0:4001:c06::236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DEF381A045E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Feb 2016 04:46:10 +1100 (AEDT)
Received: by mail-io0-x236.google.com with SMTP id g203so220753559iof.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Feb 2016 09:46:10 -0800 (PST)
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <20160223103221.GA1418@node.shutemov.name>
References: <20160211192223.4b517057@thinkpad>
 <20160211190942.GA10244@node.shutemov.name>
 <20160211205702.24f0d17a@thinkpad>
 <20160212154116.GA15142@node.shutemov.name>
 <56BE00E7.1010303@de.ibm.com> <20160212181640.4eabb85f@thinkpad>
 <20160223103221.GA1418@node.shutemov.name>
Date: Tue, 23 Feb 2016 09:46:08 -0800
Message-ID: <CA+55aFxh5P57Qg2xPYbTekAXzpWWON2qw76ZtC93ZQKqaqBA6A@mail.gmail.com>
Subject: Re: [BUG] random kernel crashes after THP rework on s390 (maybe also
 on PowerPC and ARM)
From: Linus Torvalds <torvalds@linux-foundation.org>
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: Gerald Schaefer <gerald.schaefer@de.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 linux-mm <linux-mm@kvack.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, ppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 linux-s390 <linux-s390@vger.kernel.org>,
 Sebastian Ott <sebott@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Feb 23, 2016 at 2:32 AM, Kirill A. Shutemov
<kirill@shutemov.name> wrote:
>
> I still worry about pmd_present(). It looks wrong to me. I wounder if
> patch below makes a difference.

Let's hope that's it, but in the meantime I do want to start the
discussion about what to do if it isn't. We're at rc5, and 4.5 is just
a few weeks away, and so far this issue hasn't gone anywhere.

So the *good* scenario is that your pmd_present() patch fixes it, and
we can all take a relieved breath.

But if not, what then? It looks like we have two options:

 (a) do a (hopefully minimal) revert.

     I say "hopefully minimal", but I suspect the revert is going to
have to undo pretty much all of the core THP changes. I'd hate to see
that, because I really liked the cleanups.

 (b) mark THP as "depends on !S390" in the 4.5 release

The (b) option is obviously much simpler, but it's a regression. I
really don't like it, even if it generally shouldn't be the kind of
regression that is actually user-noticeable (apart from performance).
I also hate the fact that while the problem only seems to happen on
s390, we don't even understand it, so maybe it's a more generic issue
that for some reason just ends up being *much* more noticeable on one
odd architecture that happens to be a bit different.

I'm inclined to think of (b) as just a "give us more time to figure it
out" thing, but I'm also worried that it will then make people not
pursue this issue.

How big is a revert patch that makes THP work on s390 again? Can we do
a revert that keeps the infrastructure intact and makes it easy to
revisit the THP cleanups later? Or is the revert inevitably going to
be all the core patches in that series?

                   Linus
