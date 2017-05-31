Return-Path: <mhocko@kernel.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wdGFq429JzDqBJ
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Jun 2017 02:31:43 +1000 (AEST)
Date: Wed, 31 May 2017 18:31:31 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Pasha Tatashin <pasha.tatashin@oracle.com>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
 heiko.carstens@de.ibm.com, davem@davemloft.net
Subject: Re: [v3 0/9] parallelized "struct page" zeroing
Message-ID: <20170531163131.GY27783@dhcp22.suse.cz>
References: <1494003796-748672-1-git-send-email-pasha.tatashin@oracle.com>
 <20170509181234.GA4397@dhcp22.suse.cz>
 <e19b241d-be27-3c9a-8984-2fb20211e2e1@oracle.com>
 <20170515193817.GC7551@dhcp22.suse.cz>
 <9b3d68aa-d2b6-2b02-4e75-f8372cbeb041@oracle.com>
 <20170516083601.GB2481@dhcp22.suse.cz>
 <07a6772b-711d-4fdc-f688-db76f1ec4c45@oracle.com>
 <20170529115358.GJ19725@dhcp22.suse.cz>
 <ae992f21-3edf-1ae7-41db-641052e411c7@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <ae992f21-3edf-1ae7-41db-641052e411c7@oracle.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue 30-05-17 13:16:50, Pasha Tatashin wrote:
> >Could you be more specific? E.g. how are other stores done in
> >__init_single_page safe then? I am sorry to be dense here but how does
> >the full 64B store differ from other stores done in the same function.
> 
> Hi Michal,
> 
> It is safe to do regular 8-byte and smaller stores (stx, st, sth, stb)
> without membar, but they are slower compared to STBI which require a membar
> before memory can be accessed.

OK, so why cannot we make zero_struct_page 8x 8B stores, other arches
would do memset. You said it would be slower but would that be
measurable? I am sorry to be so persistent here but I would be really
happier if this didn't depend on the deferred initialization. If this is
absolutely a no-go then I can live with that of course.

-- 
Michal Hocko
SUSE Labs
