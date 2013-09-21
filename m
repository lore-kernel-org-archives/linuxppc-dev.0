Return-Path: <eranian@google.com>
Received: from mail-ob0-x236.google.com (mail-ob0-x236.google.com
 [IPv6:2607:f8b0:4003:c01::236])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id BC2882C019E
 for <linuxppc-dev@ozlabs.org>; Sat, 21 Sep 2013 16:55:41 +1000 (EST)
Received: by mail-ob0-f182.google.com with SMTP id wo20so1657460obc.13
 for <linuxppc-dev@ozlabs.org>; Fri, 20 Sep 2013 23:55:38 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1378778772.25578.1.camel@concordia>
References: <1377836690-32710-1-git-send-email-khandual@linux.vnet.ibm.com>
 <1378778772.25578.1.camel@concordia>
Date: Sat, 21 Sep 2013 08:55:37 +0200
Message-ID: <CABPqkBREXH5VUkULAsWvmpCer-s4SCxuof6LdqRO0i-iBOG8pA@mail.gmail.com>
Subject: Re: [PATCH V2 0/6] perf: New conditional branch filter
From: Stephane Eranian <eranian@google.com>
To: Michael Ellerman <michael@ellerman.id.au>
Content-Type: text/plain; charset=UTF-8
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 LKML <linux-kernel@vger.kernel.org>,
 Arnaldo Carvalho de Melo <acme@redhat.com>,
 Linux PPC dev <linuxppc-dev@ozlabs.org>,
 Michael Neuling <michael.neuling@au1.ibm.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Sep 10, 2013 at 4:06 AM, Michael Ellerman
<michael@ellerman.id.au> wrote:
>
> On Fri, 2013-08-30 at 09:54 +0530, Anshuman Khandual wrote:
> >       This patchset is the re-spin of the original branch stack sampling
> > patchset which introduced new PERF_SAMPLE_BRANCH_COND filter. This patchset
> > also enables SW based branch filtering support for PPC64 platforms which have
> > branch stack sampling support. With this new enablement, the branch filter support
> > for PPC64 platforms have been extended to include all these combinations discussed
> > below with a sample test application program.
>
> ...
>
> > Mixed filters
> > -------------
> > (6) perf record -e branch-misses:u -j any_call,any_ret ./cprog
> > Error:
> > The perf.data file has no samples!
> >
> > NOTE: As expected. The HW filters all the branches which are calls and SW tries to find return
> > branches in that given set. Both the filters are mutually exclussive, so obviously no samples
> > found in the end profile.
>
> The semantics of multiple filters is not clear to me. It could be an OR,
> or an AND. You have implemented AND, does that match existing behaviour
> on x86 for example?
>
The semantic on the API is OR. AND does not make sense: CALL & RETURN?
On x86, the HW filter is an OR (default: ALL, set bit to disable a
type). I suspect
it is similar on PPC.

>
> cheers
>
>
