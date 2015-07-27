Return-Path: <vbabka@suse.cz>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id ACD5A1A098F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jul 2015 19:08:26 +1000 (AEST)
Subject: Re: [PATCH V5 0/7] Allow user to request memory to be locked on page
 fault
To: Eric B Munson <emunson@akamai.com>,
 Andrew Morton <akpm@linux-foundation.org>
References: <1437773325-8623-1-git-send-email-emunson@akamai.com>
Cc: Shuah Khan <shuahkh@osg.samsung.com>, Michal Hocko <mhocko@suse.cz>,
 Michael Kerrisk <mtk.manpages@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
 Ralf Baechle <ralf@linux-mips.org>, linux-alpha@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
 linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org
From: Vlastimil Babka <vbabka@suse.cz>
Message-ID: <55B5F4FF.9070604@suse.cz>
Date: Mon, 27 Jul 2015 11:08:15 +0200
MIME-Version: 1.0
In-Reply-To: <1437773325-8623-1-git-send-email-emunson@akamai.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/24/2015 11:28 PM, Eric B Munson wrote:

...

> Changes from V4:
> Drop all architectures for new sys call entries except x86[_64] and MIPS
> Drop munlock2 and munlockall2
> Make VM_LOCKONFAULT a modifier to VM_LOCKED only to simplify book keeping
> Adjust tests to match

Hi, thanks for considering my suggestions. Well, I do hope there were 
correct as API's are hard and I'm no API expert. But since API's are 
also impossible to change after merging, I'm sorry but I'll keep 
pestering for one last thing. Thanks again for persisting, I do believe 
it's for the good thing!

The thing is that I still don't like that one has to call 
mlock2(MLOCK_LOCKED) to get the equivalent of the old mlock(). Why is 
that flag needed? We have two modes of locking now, and v5 no longer 
treats them separately in vma flags. But having two flags gives us four 
possible combinations, so two of them would serve nothing but to confuse 
the programmer IMHO. What will mlock2() without flags do? What will 
mlock2(MLOCK_LOCKED | MLOCK_ONFAULT) do? (Note I haven't studied the 
code yet, as having agreed on the API should come first. But I did 
suggest documenting these things more thoroughly too...)
OK I checked now and both cases above seem to return EINVAL.

So about the only point I see in MLOCK_LOCKED flag is parity with 
MAP_LOCKED for mmap(). But as Kirill said (and me before as well) 
MAP_LOCKED is broken anyway so we shouldn't twist the rest just of the 
API to keep the poor thing happier in its misery.

Also note that AFAICS you don't have MCL_LOCKED for mlockall() so 
there's no full parity anyway. But please don't fix that by adding 
MCL_LOCKED :)

Thanks!
