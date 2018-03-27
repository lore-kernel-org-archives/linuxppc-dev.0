Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x22b.google.com (mail-pf0-x22b.google.com
 [IPv6:2607:f8b0:400e:c00::22b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 409VfP3vxKzF221
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Mar 2018 23:28:13 +1100 (AEDT)
Received: by mail-pf0-x22b.google.com with SMTP id l27so8775641pfk.12
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Mar 2018 05:28:13 -0700 (PDT)
Date: Tue, 27 Mar 2018 22:27:56 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/powernv/nvram: opal_nvram_write handle unknown
 OPAL errors
Message-ID: <20180327222756.5bb5b44e@roar.ozlabs.ibm.com>
In-Reply-To: <877epxk983.fsf@concordia.ellerman.id.au>
References: <20180326150233.23089-1-npiggin@gmail.com>
 <877epxk983.fsf@concordia.ellerman.id.au>
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

On Tue, 27 Mar 2018 23:13:00 +1100
Michael Ellerman <mpe@ellerman.id.au> wrote:

> Nicholas Piggin <npiggin@gmail.com> writes:
> 
> > opal_nvram_write currently just assumes success if it encounters an
> > error other than OPAL_BUSY or OPAL_BUSY_EVENT. Have it return -EIO
> > on other errors instead.  
> 
> Does that ever happen with current skiboot?

I can now even using the mambo fake flash driver that never returns
failure, because skiboot will return OPAL_INTERNAL_ERROR if we try
to re-enter it. So I hit it when testing sreset-in-opal cases (the
crash path wants to write something to nvram).

Not sure about the skiboot flash layer. Aside from programming
errors, it looks like perhaps ECC and BMC failure or unresponsive
could cause errors to come back here.

> Even if it doesn't I think I'm inclined to tag this for stable.

It's turning some relatively minor types of errors into a system
hang, so it seems like it could go in stable. I've hit the -EIO case
in these basic tests and it hasn't had obvious bugs.

Thanks,
Nick
