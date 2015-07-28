Return-Path: <mstsxfx@gmail.com>
Received: from mail-wi0-f170.google.com (mail-wi0-f170.google.com
 [209.85.212.170])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C80781A0688
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jul 2015 21:17:30 +1000 (AEST)
Received: by wibxm9 with SMTP id xm9so152158932wib.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jul 2015 04:17:28 -0700 (PDT)
Date: Tue, 28 Jul 2015 13:17:25 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Eric B Munson <emunson@akamai.com>
Cc: Vlastimil Babka <vbabka@suse.cz>,
 Andrew Morton <akpm@linux-foundation.org>,
 Shuah Khan <shuahkh@osg.samsung.com>,
 Michael Kerrisk <mtk.manpages@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
 Ralf Baechle <ralf@linux-mips.org>, linux-alpha@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
 linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH V5 0/7] Allow user to request memory to be locked on page
 fault
Message-ID: <20150728111725.GG24972@dhcp22.suse.cz>
References: <1437773325-8623-1-git-send-email-emunson@akamai.com>
 <55B5F4FF.9070604@suse.cz> <20150727133555.GA17133@akamai.com>
 <55B63D37.20303@suse.cz> <20150727145409.GB21664@akamai.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150727145409.GB21664@akamai.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

[I am sorry but I didn't get to this sooner.]

On Mon 27-07-15 10:54:09, Eric B Munson wrote:
> Now that VM_LOCKONFAULT is a modifier to VM_LOCKED and
> cannot be specified independentally, it might make more sense to mirror
> that relationship to userspace.  Which would lead to soemthing like the
> following:

A modifier makes more sense.
 
> To lock and populate a region:
> mlock2(start, len, 0);
> 
> To lock on fault a region:
> mlock2(start, len, MLOCK_ONFAULT);
> 
> If LOCKONFAULT is seen as a modifier to mlock, then having the flags
> argument as 0 mean do mlock classic makes more sense to me.
> 
> To mlock current on fault only:
> mlockall(MCL_CURRENT | MCL_ONFAULT);
> 
> To mlock future on fault only:
> mlockall(MCL_FUTURE | MCL_ONFAULT);
> 
> To lock everything on fault:
> mlockall(MCL_CURRENT | MCL_FUTURE | MCL_ONFAULT);

Makes sense to me. The only remaining and still tricky part would be
the munlock{all}(flags) behavior. What should munlock(MLOCK_ONFAULT)
do? Keep locked and poppulate the range or simply ignore the flag an
just unlock?

I can see some sense to allow munlockall(MCL_FUTURE[|MLOCK_ONFAULT]),
munlockall(MCL_CURRENT) resp. munlockall(MCL_CURRENT|MCL_FUTURE) but
other combinations sound weird to me.

Anyway munlock with flags opens new doors of trickiness.
-- 
Michal Hocko
SUSE Labs
