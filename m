Return-Path: <npiggin@gmail.com>
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42DKKy3dqBzF1RN
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Sep 2018 18:39:17 +1000 (AEST)
Received: by mail-pl1-x633.google.com with SMTP id ba4-v6so7074731plb.11
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Sep 2018 01:39:17 -0700 (PDT)
Date: Mon, 17 Sep 2018 18:39:10 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 03/12] powerpc/64s/hash: move POWER5 < DD2.1 slbie
 workaround where it is needed
Message-ID: <20180917183910.6d9e77bf@roar.ozlabs.ibm.com>
In-Reply-To: <877ejkiryn.fsf@linux.ibm.com>
References: <20180914153056.3644-1-npiggin@gmail.com>
 <20180914153056.3644-4-npiggin@gmail.com>
 <877ejkiryn.fsf@linux.ibm.com>
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

On Mon, 17 Sep 2018 11:30:16 +0530
"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> wrote:

> Nicholas Piggin <npiggin@gmail.com> writes:
> 
> > The POWER5 < DD2.1 issue is that slbie needs to be issued more than
> > once. It came in with this change:
> >
> > ChangeSet@1.1608, 2004-04-29 07:12:31-07:00, david@gibson.dropbear.id.au
> >   [PATCH] POWER5 erratum workaround
> >
> >   Early POWER5 revisions (<DD2.1) have a problem requiring slbie
> >   instructions to be repeated under some circumstances.  The patch below
> >   adds a workaround (patch made by Anton Blanchard).  
> 
> Thanks for extracting this. Can we add this to the code?

The comment? Sure.

> Also I am not
> sure what is repeated here? Is it that we just need one slb extra(hence
> only applicable to offset == 1) or is it that we need to make sure there
> is always one slb extra? The code does the former.

Yeah it has always done the former, so my assumption is that you just
need more than one slbie. I don't think we need to bother revisiting
that assumption unless someone can pull up something definitive.

What I did change is that slbia no longer has the additional slbie, but
I think there are strong reasons not to need that.

>  Do you a have link for
> that email patch?

I tried looking through the archives around that date but could not
find it. That came from a bitkeeper log.

Thanks,
Nick
