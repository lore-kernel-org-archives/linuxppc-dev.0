Return-Path: <luto@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40g3q30Q8HzF1jq
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 May 2018 12:49:15 +1000 (AEST)
Received: from mail-wm0-f43.google.com (mail-wm0-f43.google.com [74.125.82.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 56A4F21747
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 May 2018 02:49:13 +0000 (UTC)
Received: by mail-wm0-f43.google.com with SMTP id l1-v6so18723386wmb.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 May 2018 19:49:13 -0700 (PDT)
MIME-Version: 1.0
References: <20180502132751.05B9F401F3041@oldenburg.str.redhat.com>
 <248faadb-e484-806f-1485-c34a72a9ca0b@intel.com>
 <822a28c9-5405-68c2-11bf-0c282887466d@redhat.com>
 <57459C6F-C8BA-4E2D-99BA-64F35C11FC05@amacapital.net>
 <6286ba0a-7e09-b4ec-e31f-bd091f5940ff@redhat.com>
 <CALCETrVrm6yGiv6_z7RqdeB-324RoeMmjpf1EHsrGOh+iKb7+A@mail.gmail.com>
 <b2df1386-9df9-2db8-0a25-51bf5ff63592@redhat.com>
 <CALCETrW_Dt-HoG4keFJd8DSD=tvyR+bBCFrBDYdym4GQbfng4A@mail.gmail.com>
 <20180503021058.GA5670@ram.oc3035372033.ibm.com>
 <CALCETrXRQF08exQVZqtTLOKbC8Ywq5x4EYH_1D7r5v9bdOSwbg@mail.gmail.com>
 <927c8325-4c98-d7af-b921-6aafcf8fe992@redhat.com>
In-Reply-To: <927c8325-4c98-d7af-b921-6aafcf8fe992@redhat.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Tue, 08 May 2018 02:49:01 +0000
Message-ID: <CALCETrX46wR_MDW=m9SVm=ejQmPAmD3+2oC3iapf75bPhnEAWQ@mail.gmail.com>
Subject: Re: [PATCH] pkeys: Introduce PKEY_ALLOC_SIGNALINHERIT and change
 signal semantics
To: Florian Weimer <fweimer@redhat.com>
Cc: Andrew Lutomirski <luto@kernel.org>, linuxram@us.ibm.com,
 Dave Hansen <dave.hansen@intel.com>, Linux-MM <linux-mm@kvack.org>,
 Linux API <linux-api@vger.kernel.org>, linux-x86_64@vger.kernel.org,
 linux-arch <linux-arch@vger.kernel.org>, X86 ML <x86@kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, May 7, 2018 at 2:48 AM Florian Weimer <fweimer@redhat.com> wrote:

> On 05/03/2018 06:05 AM, Andy Lutomirski wrote:
> > On Wed, May 2, 2018 at 7:11 PM Ram Pai <linuxram@us.ibm.com> wrote:
> >
> >> On Wed, May 02, 2018 at 09:23:49PM +0000, Andy Lutomirski wrote:
> >>>
> >>>> If I recall correctly, the POWER maintainer did express a strong
> > desire
> >>>> back then for (what is, I believe) their current semantics, which my
> >>>> PKEY_ALLOC_SIGNALINHERIT patch implements for x86, too.
> >>>
> >>> Ram, I really really don't like the POWER semantics.  Can you give
some
> >>> justification for them?  Does POWER at least have an atomic way for
> >>> userspace to modify just the key it wants to modify or, even better,
> >>> special load and store instructions to use alternate keys?
> >
> >> I wouldn't call it POWER semantics. The way I implemented it on power
> >> lead to the semantics, given that nothing was explicitly stated
> >> about how the semantics should work within a signal handler.
> >
> > I think that this is further evidence that we should introduce a new
> > pkey_alloc() mode and deprecate the old.  To the extent possible, this
> > thing should work the same way on x86 and POWER.

> Do you propose to change POWER or to change x86?

Sorry for being slow to reply.  I propose to introduce a new
PKEY_ALLOC_something variant on x86 and POWER and to make the behavior
match on both.  It should at least update the values loaded when a signal
is delivered and it should probably also update it for new threads.

For glibc, for example, I assume that you want signals to be delivered with
write access disabled to the GOT.  Otherwise you would fail to protect
against exploits that occur in signal context.  Glibc controls thread
creation, so the initial state on thread startup doesn't really matter, but
there will be more users than just glibc.

--Andy
