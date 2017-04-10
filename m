Return-Path: <rashmicy@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w1ddh6JXyzDq7Z
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Apr 2017 15:14:16 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id i5so4986133pfc.3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 09 Apr 2017 22:14:16 -0700 (PDT)
Subject: Re: [PATCH] powerpc/mm: Dump hash table
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 Rashmica Gupta <rashmica.g@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 mpe@ellerman.id.au
References: <20170410020404.11375-1-rashmica.g@gmail.com>
 <3b8a7252-dc80-8c04-2df8-4dca17348f8f@linux.vnet.ibm.com>
From: RashmicaGupta <rashmicy@gmail.com>
Message-ID: <2ce28fb7-9dce-c35d-d0a7-f09b2f147195@gmail.com>
Date: Mon, 10 Apr 2017 15:14:11 +1000
MIME-Version: 1.0
In-Reply-To: <3b8a7252-dc80-8c04-2df8-4dca17348f8f@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 10/04/17 14:02, Anshuman Khandual wrote:
> On 04/10/2017 07:34 AM, Rashmica Gupta wrote:
>> Current behaviour assumes that memory in RAM is contiguous and
>> iterates from the start of RAM to (start + size of memory). When the
>> memory isn't physically contiguous, this approach doesn't work.
> In dis contiguous platform, we just finish up walking linear
> mapping prematurely before the end of the RAM ?
Yes, that is what the following example explains.
>
>> If memory exists at 0-5 GB and 6-10 GB then the current approach will
>> check if entries exist in the hash table from 0GB to 9GB. This patch
>> changes the behaviour to iterate up to the end of RAM.
> So it fixes the commit which added memblock_phys_mem_size().
> Hence needs "Fixes: " tag as well.
>
Woops, will add that!
