Return-Path: <linuxram@us.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40mR5x2sjGzF13h
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 May 2018 06:35:48 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4GKTaXa003645
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 May 2018 16:35:45 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2j0t93mbx3-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 May 2018 16:35:45 -0400
Received: from localhost
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <linuxram@us.ibm.com>;
 Wed, 16 May 2018 21:35:43 +0100
Date: Wed, 16 May 2018 13:35:34 -0700
From: Ram Pai <linuxram@us.ibm.com>
To: Florian Weimer <fweimer@redhat.com>
Cc: Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@intel.com>,
 Linux-MM <linux-mm@kvack.org>, Linux API <linux-api@vger.kernel.org>,
 linux-x86_64@vger.kernel.org, linux-arch <linux-arch@vger.kernel.org>,
 X86 ML <x86@kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] pkeys: Introduce PKEY_ALLOC_SIGNALINHERIT and change
 signal semantics
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <57459C6F-C8BA-4E2D-99BA-64F35C11FC05@amacapital.net>
 <6286ba0a-7e09-b4ec-e31f-bd091f5940ff@redhat.com>
 <CALCETrVrm6yGiv6_z7RqdeB-324RoeMmjpf1EHsrGOh+iKb7+A@mail.gmail.com>
 <b2df1386-9df9-2db8-0a25-51bf5ff63592@redhat.com>
 <CALCETrW_Dt-HoG4keFJd8DSD=tvyR+bBCFrBDYdym4GQbfng4A@mail.gmail.com>
 <20180503021058.GA5670@ram.oc3035372033.ibm.com>
 <CALCETrXRQF08exQVZqtTLOKbC8Ywq5x4EYH_1D7r5v9bdOSwbg@mail.gmail.com>
 <927c8325-4c98-d7af-b921-6aafcf8fe992@redhat.com>
 <CALCETrX46wR_MDW=m9SVm=ejQmPAmD3+2oC3iapf75bPhnEAWQ@mail.gmail.com>
 <314e1a48-db94-9b37-8793-a95a2082c9e2@redhat.com>
MIME-Version: 1.0
In-Reply-To: <314e1a48-db94-9b37-8793-a95a2082c9e2@redhat.com>
Message-Id: <20180516203534.GA5479@ram.oc3035372033.ibm.com>
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, May 08, 2018 at 02:40:46PM +0200, Florian Weimer wrote:
> On 05/08/2018 04:49 AM, Andy Lutomirski wrote:
> >On Mon, May 7, 2018 at 2:48 AM Florian Weimer <fweimer@redhat.com> wrote:
> >
> >>On 05/03/2018 06:05 AM, Andy Lutomirski wrote:
> >>>On Wed, May 2, 2018 at 7:11 PM Ram Pai <linuxram@us.ibm.com> wrote:
> >>>
> >>>>On Wed, May 02, 2018 at 09:23:49PM +0000, Andy Lutomirski wrote:
> >>>>>
> >>>>>>If I recall correctly, the POWER maintainer did express a strong
> >>>desire
> >>>>>>back then for (what is, I believe) their current semantics, which my
> >>>>>>PKEY_ALLOC_SIGNALINHERIT patch implements for x86, too.
> >>>>>
> >>>>>Ram, I really really don't like the POWER semantics.  Can you give
> >some
> >>>>>justification for them?  Does POWER at least have an atomic way for
> >>>>>userspace to modify just the key it wants to modify or, even better,
> >>>>>special load and store instructions to use alternate keys?
> >>>
> >>>>I wouldn't call it POWER semantics. The way I implemented it on power
> >>>>lead to the semantics, given that nothing was explicitly stated
> >>>>about how the semantics should work within a signal handler.
> >>>
> >>>I think that this is further evidence that we should introduce a new
> >>>pkey_alloc() mode and deprecate the old.  To the extent possible, this
> >>>thing should work the same way on x86 and POWER.
> >
> >>Do you propose to change POWER or to change x86?
> >
> >Sorry for being slow to reply.  I propose to introduce a new
> >PKEY_ALLOC_something variant on x86 and POWER and to make the behavior
> >match on both.
> 
> So basically implement PKEY_ALLOC_SETSIGNAL for POWER, and keep the
> existing (different) behavior without the flag?
> 
> Ram, would you be okay with that?  Could you give me a hand if
> necessary?  (I assume we have silicon in-house because it's a
> long-standing feature of the POWER platform which was simply dormant
> on Linux until now.)

Yes. I can help you with that.

So let me see if I understand the overall idea.

Application can allocate new keys through a new syscall
sys_pkey_alloc_1(flags, init_val, sig_init_val) 

'sig_init_val' is the permission-state of the key in signal context.

The kernel will set the permission of each keys to their
corresponding values when entering the signal handler and revert
on return from the signal handler.

just like init_val, sig_init_val also percolates to children threads.

Is this a correct understanding?
RP
