Return-Path: <linus971@gmail.com>
Received: from mail-ve0-x232.google.com (mail-ve0-x232.google.com
 [IPv6:2607:f8b0:400c:c01::232])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B31FB2C010C
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Oct 2013 06:04:37 +1000 (EST)
Received: by mail-ve0-f178.google.com with SMTP id jw12so4436296veb.23
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Sep 2013 13:04:34 -0700 (PDT)
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <5249D897.1010109@hp.com>
References: <CA+55aFwp-RAKEMVvbMG53C=kTMqS09NPXy1eP4xEUYZpvV8X5Q@mail.gmail.com>
 <5249D897.1010109@hp.com>
Date: Mon, 30 Sep 2013 13:04:34 -0700
Message-ID: <CA+55aFw6tOVMw=pKE_knj4BOwTi_JAX=4N=-5_WduykNPotdww@mail.gmail.com>
Subject: Re: Avoiding the dentry d_lock on final dput(), part deux:
 transactional memory
From: Linus Torvalds <torvalds@linux-foundation.org>
To: Waiman Long <waiman.long@hp.com>
Content-Type: text/plain; charset=UTF-8
Cc: Peter Zijlstra <peterz@infradead.org>, George Spelvin <linux@horizon.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Chandramouleeswaran,
 Aswin" <aswin@hp.com>, "Norton, Scott J" <scott.norton@hp.com>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 ppc-dev <linuxppc-dev@lists.ozlabs.org>, Ingo Molnar <mingo@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Sep 30, 2013 at 1:01 PM, Waiman Long <waiman.long@hp.com> wrote:
>
> I think this patch is worth a trial if relevant hardware is more widely
> available. The TSX code certainly need to be moved to an architecture
> specific area and should be runtime enabled using a static key. We also need
> more TSX support infrastructure in place first.

I think we can pick that up from Andi's patches, he should have that.
Although that did have very x86-specific naming (ie "xbegin"). And I
don't think he used "asm goto" to quite the same advantage as this -
and I think we do want to make sure that the overhead is minimal.

                  Linus
