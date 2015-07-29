Return-Path: <vbabka@suse.cz>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5E1071A1A45
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jul 2015 20:50:06 +1000 (AEST)
Subject: Re: [PATCH V5 0/7] Allow user to request memory to be locked on page
 fault
To: Michal Hocko <mhocko@kernel.org>, Eric B Munson <emunson@akamai.com>
References: <1437773325-8623-1-git-send-email-emunson@akamai.com>
 <55B5F4FF.9070604@suse.cz> <20150727133555.GA17133@akamai.com>
 <55B63D37.20303@suse.cz> <20150727145409.GB21664@akamai.com>
 <20150728111725.GG24972@dhcp22.suse.cz> <20150728134942.GB2407@akamai.com>
 <20150729104532.GE15801@dhcp22.suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Shuah Khan <shuahkh@osg.samsung.com>,
 Michael Kerrisk <mtk.manpages@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
 Ralf Baechle <ralf@linux-mips.org>, linux-alpha@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
 linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org
From: Vlastimil Babka <vbabka@suse.cz>
Message-ID: <55B8AFD5.3030902@suse.cz>
Date: Wed, 29 Jul 2015 12:49:57 +0200
MIME-Version: 1.0
In-Reply-To: <20150729104532.GE15801@dhcp22.suse.cz>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/29/2015 12:45 PM, Michal Hocko wrote:
>> In a much less
>> likely corner case, it is not possible in the current setup to request
>> all current VMAs be VM_LOCKONFAULT and all future be VM_LOCKED.
> 
> Vlastimil has already pointed that out. MCL_FUTURE doesn't clear
> MCL_CURRENT. I was quite surprised in the beginning but it makes a
> perfect sense. mlockall call shouldn't lead into munlocking, that would
> be just weird. Clearing MCL_FUTURE on MCL_CURRENT makes sense on the
> other hand because the request is explicit about _current_ memory and it
> doesn't lead to any munlocking.

Yeah after more thinking it does make some sense despite the perceived
inconsistency, but it's definitely worth documenting properly. It also already
covers the usecase for munlockall2(MCL_FUTURE) which IIRC you had in the earlier
revisions...
