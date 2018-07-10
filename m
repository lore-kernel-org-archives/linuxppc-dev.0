Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41PqVM5V3PzDrSd
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jul 2018 14:49:15 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id e13-v6so1849968pff.7
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Jul 2018 21:49:15 -0700 (PDT)
Date: Tue, 10 Jul 2018 14:49:08 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-arch <linux-arch@vger.kernel.org>, linuxppc-dev
 <linuxppc-dev@lists.ozlabs.org>
Subject: Re: Can people please check this patch out for cross-arch issues
Message-ID: <20180710144908.4a2bb2cc@roar.ozlabs.ibm.com>
In-Reply-To: <CA+55aFxWZuFNHKpE0iA+vDJHTyPofSX3BPPOt2UUB2zXSSBZHQ@mail.gmail.com>
References: <CA+55aFxWZuFNHKpE0iA+vDJHTyPofSX3BPPOt2UUB2zXSSBZHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 9 Jul 2018 16:57:46 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> We have a funny new bugzilla entry for an issue that is 12 years old,
> and not really all that critical, but one that *can* become a problem
> for people who do very specific things.
> 
> What happens is that 'fork()' will cause a re-try (with
> ERESTARTNOINTR) if a signal has come in between the point where the
> fork() started, but before we add the process to the process table.
> The reason is that the signal possibly *should* affect the new child
> process too, but it was never queued to it because we were obviously
> in the process of creating it.
> 
> That's normally entirely a non-issue, and I don't think anybody ever
> imagined it could matter in practice, but apparently there are loads
> where this becomes problematic.
> 
> See kernel bugzilla at
> 
>     https://bugzilla.kernel.org/show_bug.cgi?id=200447
> 
> which has a trial balloon patch for this issue already, to at least
> limit that retry to only signals that actually might affect the child
> (ie not any random signals sent explicitly and directly only to the
> parent process).
> 
> HOWEVER.
> 
> The very first thing I noticed while looking at this was that one of
> the more expensive parts of the fork() retry is actually marking all
> the parent page tables read-only. Now, it's one of _many_ expensive
> parts, and it's not nearly as expensive as all the reference counting
> we do for each page, but it's actually very easy to avoid. When we
> have repeated fork() calls, there's just no point in repeatedly
> marking pages read-only.
> 
> This the attached one-liner patch.
> 
> The reason I'm sending it to the arch people is that while this is a
> totally trivial patch on x86 ("pte_write()" literally tests exactly
> the same bit that "pte_wrprotect()" and "ptep_set_wrprotect()"
> clears), the same is not necessarily always true on other
> architectures.
> 
> Some other architectures make "ptep_set_wrprotect()" do more than just
> clear the one bit we test with "pte_write()".
> 
> Honestly, I don't think it could possibly matter: if "pte_write()"
> returns false, then whatever "ptep_set_writeprotect()" does can not
> really matter (at least for a COW mapping). But I thought I'd send
> this out for comments anyway, despite how trivial it looks.
> 
> So. Comments?

Looks good to me (after the huge page bits are done?)

If pte_write returns false here, surely any later write access has to
fault otherwise we've got bigger problems right? powerpc/64/radix is
pretty unsurprising so no problems there (it just modifies the pte, so
shouldn't change anything in this case). Hash will actually schedule
the hash table entry to be invalidated, but it can't be writable.

> It doesn't make a huge difference, honestly, and the real fix for the
> "retry too eagerly" is completely different, but at the same time this
> one-liner trivial fix does feel like the RightThing(tm) regardless.

Acked-by: Nicholas Piggin <npiggin@gmail.com>
