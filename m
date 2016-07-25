Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x230.google.com (mail-pf0-x230.google.com
 [IPv6:2607:f8b0:400e:c00::230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ryQCY1Bf9zDqVg
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jul 2016 12:28:09 +1000 (AEST)
Received: by mail-pf0-x230.google.com with SMTP id y134so58769033pfg.0
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 24 Jul 2016 19:28:09 -0700 (PDT)
Date: Mon, 25 Jul 2016 12:28:01 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Balbir Singh <bsingharora@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH] powerpc/64: implement a slice mask cache
Message-ID: <20160725122801.578622d6@roar.ozlabs.ibm.com>
In-Reply-To: <1469263746.8568.185.camel@kernel.crashing.org>
References: <1469192248-25141-1-git-send-email-npiggin@gmail.com>
 <20160723021937.GA13796@350D>
 <20160723171036.67144c5d@roar.ozlabs.ibm.com>
 <1469263746.8568.185.camel@kernel.crashing.org>
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

On Sat, 23 Jul 2016 18:49:06 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Sat, 2016-07-23 at 17:10 +1000, Nicholas Piggin wrote:
> > I wanted to avoid doing more work under slice_convert_lock, but
> > we should just make that a per-mm lock anyway shouldn't we?  
> 
> Aren't the readers under the mm sem taken for writing or has this
> changed ?


I don't think this has changed, but I look at the writers now,
which aren't synchronized by mm sem. But neither are readers
under the slice_convert_lock, so I'm looking at what the locking
actually is. Is it just using atomicity of dword stores vs loads?

Thanks,
Nick
