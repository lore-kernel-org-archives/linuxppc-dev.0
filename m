Return-Path: <zhong@linux.vnet.ibm.com>
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0A9881A062A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Nov 2014 17:17:23 +1100 (AEDT)
Received: from /spool/local
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <zhong@linux.vnet.ibm.com>;
 Tue, 18 Nov 2014 06:17:19 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com
 (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 728AD1B08049
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Nov 2014 06:17:28 +0000 (GMT)
Received: from d06av01.portsmouth.uk.ibm.com (d06av01.portsmouth.uk.ibm.com
 [9.149.37.212])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sAI6HGXY56688718
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Nov 2014 06:17:17 GMT
Received: from d06av01.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av01.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sAI6HGrQ025162
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Nov 2014 23:17:16 -0700
Message-ID: <1416291158.2327.11.camel@TP420>
Subject: Re: [powerpc] init nvram_pstore_info's buf_lock
From: Li Zhong <zhong@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Date: Tue, 18 Nov 2014 14:12:38 +0800
In-Reply-To: <20141118043314.4517C14011D@ozlabs.org>
References: <20141118043314.4517C14011D@ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Paul Mackerras <paulus@samba.org>,
 PowerPC email list <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 二, 2014-11-18 at 15:33 +1100, Michael Ellerman wrote:
> On Mon, 2014-17-11 at 02:52:30 UTC, Li Zhong wrote:
> > It seems nvram_pstore_info's buf_lock is not initialized before
> > registering, which causes some strange behavior when trying to obtain
> > the lock during kdump process.
> 
> What kind of strange behaviour? Does it still work and just print a warning?
> 
> It's static, so I'd expect it to be unlocked by default.

Yes, you are right. It still works. 

I saw it on a UP configuration, noticed the console stopped for a couple
of seconds, then "lockup suspected" warning printed out, but then it
continued to run. 

After some further checking, it seems working as designed for the UP
spinlock debug, from the comments in spinlock_up.h

 * In the debug case, 1 means unlocked, 0 means locked. (the values
 * are inverted, to catch initialization bugs)

So try lock fails, and lockup reported, but then arch_spin_lock()
passes. 

Thanks, Zhong

> 
> cheers
> 
