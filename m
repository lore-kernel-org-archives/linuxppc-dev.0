Return-Path: <linus971@gmail.com>
Received: from mail-ig0-x235.google.com (mail-ig0-x235.google.com
 [IPv6:2607:f8b0:4001:c05::235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0373A1A09FD
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Mar 2015 05:09:20 +1100 (AEDT)
Received: by igbqf9 with SMTP id qf9so30904644igb.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Mar 2015 11:09:15 -0700 (PDT)
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <20150319141022.GD3087@suse.de>
References: <20150312131045.GE3406@suse.de>
 <CA+55aFx=81BGnQFNhnAGu6CetL7yifPsnD-+v7Y6QRqwgH47gQ@mail.gmail.com>
 <20150312184925.GH3406@suse.de> <20150317070655.GB10105@dastard>
 <CA+55aFzdLnFdku-gnm3mGbeS=QauYBNkFQKYXJAGkrMd2jKXhw@mail.gmail.com>
 <20150317205104.GA28621@dastard>
 <CA+55aFzSPcNgxw4GC7aAV1r0P5LniyVVC66COz=3cgMcx73Nag@mail.gmail.com>
 <20150317220840.GC28621@dastard>
 <CA+55aFwne-fe_Gg-_GTUo+iOAbbNpLBa264JqSFkH79EULyAqw@mail.gmail.com>
 <CA+55aFy-Mw74rAdLMMMUgnsG3ZttMWVNGz7CXZJY7q9fqyRYfg@mail.gmail.com>
 <20150319141022.GD3087@suse.de>
Date: Thu, 19 Mar 2015 11:09:15 -0700
Message-ID: <CA+55aFwTcw2rTjPM_EOjPeKNWwdfNVazx+O=YAFXPWw1h==Tgw@mail.gmail.com>
Subject: Re: [PATCH 4/4] mm: numa: Slow PTE scan rate if migration failures
 occur
From: Linus Torvalds <torvalds@linux-foundation.org>
To: Mel Gorman <mgorman@suse.de>
Content-Type: text/plain; charset=UTF-8
Cc: Dave Chinner <david@fromorbit.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, xfs@oss.sgi.com,
 Linux-MM <linux-mm@kvack.org>, Aneesh Kumar <aneesh.kumar@linux.vnet.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 ppc-dev <linuxppc-dev@lists.ozlabs.org>, Ingo Molnar <mingo@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Mar 19, 2015 at 7:10 AM, Mel Gorman <mgorman@suse.de> wrote:
> -       if (!pmd_dirty(pmd))
> +       /* See similar comment in do_numa_page for explanation */
> +       if (!(vma->vm_flags & VM_WRITE))

Yeah, that would certainly be a whole lot more obvious than all the
"if this particular pte/pmd looks like X" tests.

So that, together with scanning rate improvements (this *does* seem to
be somewhat chaotic, so it's quite possible that the current scanning
rate thing is just fairly unstable) is likely the right thing. I'd
just like to _understand_ why that write/dirty bit makes such a
difference. I thought I understood what was going on, and was happy,
and then Dave come with his crazy numbers.

Damn you Dave, and damn your numbers and "facts" and stuff. Sometimes
I much prefer ignorant bliss.

                           Linus
