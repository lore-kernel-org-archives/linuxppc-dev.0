Return-Path: <pasha.tatashin@oracle.com>
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xTVHZ0hD1zDrDd
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Aug 2017 02:06:33 +1000 (AEST)
Subject: Re: [v6 09/15] sparc64: optimized struct page zeroing
To: Michal Hocko <mhocko@kernel.org>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 x86@kernel.org, kasan-dev@googlegroups.com, borntraeger@de.ibm.com,
 heiko.carstens@de.ibm.com, davem@davemloft.net, willy@infradead.org,
 ard.biesheuvel@linaro.org, will.deacon@arm.com,
 catalin.marinas@arm.com, sam@ravnborg.org
References: <1502138329-123460-1-git-send-email-pasha.tatashin@oracle.com>
 <1502138329-123460-10-git-send-email-pasha.tatashin@oracle.com>
 <20170811125326.GK30811@dhcp22.suse.cz>
From: Pasha Tatashin <pasha.tatashin@oracle.com>
Message-ID: <3830e513-cb35-e52e-341c-25eaecc51d43@oracle.com>
Date: Fri, 11 Aug 2017 12:04:51 -0400
MIME-Version: 1.0
In-Reply-To: <20170811125326.GK30811@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>> Add an optimized mm_zero_struct_page(), so struct page's are zeroed without
>> calling memset(). We do eight to tent regular stores based on the size of
>> struct page. Compiler optimizes out the conditions of switch() statement.
> 
> Again, this doesn't explain why we need this. You have mentioned those
> reasons in some previous emails but be explicit here please.
> 

I will add performance data to this patch as well.

Thank you,
Pasha
