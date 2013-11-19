Return-Path: <zhong@linux.vnet.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [122.248.162.6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp06.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8C5F42C0109
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Nov 2013 20:24:33 +1100 (EST)
Received: from /spool/local
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <zhong@linux.vnet.ibm.com>;
 Tue, 19 Nov 2013 14:54:28 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 5CC08394005E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Nov 2013 14:54:24 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 rAJ9OJYH46202932
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Nov 2013 14:54:19 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 rAJ9OMt6020545
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Nov 2013 14:54:23 +0530
Message-ID: <1384853059.2511.25.camel@ThinkPad-T5421>
Subject: Re: [RFC PATCH powerpc] Fix compiling error in powernv/rng.c
From: Li Zhong <zhong@linux.vnet.ibm.com>
To: Michael Ellerman <michael@ellerman.id.au>
Date: Tue, 19 Nov 2013 17:24:19 +0800
In-Reply-To: <20131119040455.GB27740@concordia>
References: <1384500964.2491.11.camel@ThinkPad-T5421>
 <20131119040455.GB27740@concordia>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: PowerPC email list <linuxppc-dev@lists.ozlabs.org>,
 Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2013-11-19 at 15:04 +1100, Michael Ellerman wrote:
> On Fri, Nov 15, 2013 at 03:36:04PM +0800, Li Zhong wrote:
> > This is seen when CONFIG_SMP is not enabled:
> > 
> > arch/powerpc/platforms/powernv/rng.c: In function 'rng_init_per_cpu':
> > arch/powerpc/platforms/powernv/rng.c:74: error: implicit declaration of function 'cpu_to_chip_id'
> 
> Hi Li,
> 
> We try whenever possible to avoid adding #ifdefs in C code.
> 
> Also on a multi chip system where there are multiple RNGs, your code for
> UP will not necessarily choose the RNG on the same core as the cpu.

OK, thank you for the review, Michael.

Just try to make sure I understand it: 

So even in UP, we could have multiple rng sources, and we should try to
use the source which has the same chip_id as the logical cpu?

Thanks, Zhong

> I have a different fix that I will send.
> 
> cheers
> 
