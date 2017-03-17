Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vktp94CZzzDqkp
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Mar 2017 16:15:29 +1100 (AEDT)
Received: by mail-pg0-x241.google.com with SMTP id b5so8467967pgg.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 22:15:29 -0700 (PDT)
Date: Fri, 17 Mar 2017 15:15:13 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Gautham R Shenoy <ego@linux.vnet.ibm.com>
Subject: Re: [PATCH 4/8] powerpc/64s: fix POWER9 machine check handler from
 stop state
Message-ID: <20170317151513.00efd8de@roar.ozlabs.ibm.com>
In-Reply-To: <20170317124927.2a628998@roar.ozlabs.ibm.com>
References: <20170314092349.10981-1-npiggin@gmail.com>
 <20170314092349.10981-5-npiggin@gmail.com>
 <67bd0a9f-ebaa-acdb-cfbf-8a4acba256a3@linux.vnet.ibm.com>
 <20170317124927.2a628998@roar.ozlabs.ibm.com>
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

On Fri, 17 Mar 2017 12:49:27 +1000
Nicholas Piggin <npiggin@gmail.com> wrote:

> On Thu, 16 Mar 2017 18:10:48 +0530
> Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com> wrote:
> 
> > On 03/14/2017 02:53 PM, Nicholas Piggin wrote:  

> > Looks like we are not winding up.. Shouldn't we ? What if we may end up
> > in pnv_wakeup_noloss() which assumes that no GPRs are lost. Am I missing
> > anything ?  
> 
> Hmm, on second look, I don't think any non-volatile GPRs are overwritten
> in this path. But this MCE is a slow path, and it is a much longer path
> than the system reset idle wakeup... So I'll add the napstatelost with
> a comment.

On third look, I'll just add the comment. The windup does not restore
non-volatile GPRs either, and in general we're careful not to use them
in exception handlers. So I think it's okay.

Thanks,
Nick
