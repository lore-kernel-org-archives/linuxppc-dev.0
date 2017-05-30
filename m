Return-Path: <pasha.tatashin@oracle.com>
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wcgJg2ZD7zDq5x
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 May 2017 03:17:06 +1000 (AEST)
Subject: Re: [v3 0/9] parallelized "struct page" zeroing
To: Michal Hocko <mhocko@kernel.org>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
 heiko.carstens@de.ibm.com, davem@davemloft.net
References: <1494003796-748672-1-git-send-email-pasha.tatashin@oracle.com>
 <20170509181234.GA4397@dhcp22.suse.cz>
 <e19b241d-be27-3c9a-8984-2fb20211e2e1@oracle.com>
 <20170515193817.GC7551@dhcp22.suse.cz>
 <9b3d68aa-d2b6-2b02-4e75-f8372cbeb041@oracle.com>
 <20170516083601.GB2481@dhcp22.suse.cz>
 <07a6772b-711d-4fdc-f688-db76f1ec4c45@oracle.com>
 <20170529115358.GJ19725@dhcp22.suse.cz>
From: Pasha Tatashin <pasha.tatashin@oracle.com>
Message-ID: <ae992f21-3edf-1ae7-41db-641052e411c7@oracle.com>
Date: Tue, 30 May 2017 13:16:50 -0400
MIME-Version: 1.0
In-Reply-To: <20170529115358.GJ19725@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> Could you be more specific? E.g. how are other stores done in
> __init_single_page safe then? I am sorry to be dense here but how does
> the full 64B store differ from other stores done in the same function.

Hi Michal,

It is safe to do regular 8-byte and smaller stores (stx, st, sth, stb) 
without membar, but they are slower compared to STBI which require a 
membar before memory can be accessed. So when on SPARC we zero a larger 
span of memory it is faster to use STBI, and do one membar at the end. 
This is why for single thread it is faster to zero multiple pages of 
memory and than initialize only fields that are needed in "struct page". 
I believe the same is true for ppc64, as they clear the whole cacheline 
128-bytes at a time with larger memsets.

Pasha
