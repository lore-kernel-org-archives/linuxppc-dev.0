Return-Path: <cyrilbur@gmail.com>
Received: from mail-pg0-x22e.google.com (mail-pg0-x22e.google.com
 [IPv6:2607:f8b0:400e:c05::22e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yVX7H4GwQzDrCy
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Nov 2017 10:33:15 +1100 (AEDT)
Received: by mail-pg0-x22e.google.com with SMTP id s2so6792655pge.10
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Nov 2017 15:33:14 -0800 (PST)
Message-ID: <1509924786.1579.2.camel@gmail.com>
Subject: Re: [PATCH] selftests/powerpc: Check FP/VEC on exception in TM
From: Cyril Bur <cyrilbur@gmail.com>
To: Gustavo Romero <gromero@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: leitao@debian.org
Date: Mon, 06 Nov 2017 10:33:06 +1100
In-Reply-To: <59FC60DA.6060100@linux.vnet.ibm.com>
References: <1509564221-7049-1-git-send-email-gromero@linux.vnet.ibm.com>
 <1509574233.1667.4.camel@gmail.com> <59FC60DA.6060100@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2017-11-03 at 10:28 -0200, Gustavo Romero wrote:
> Hi Cyril!
> 
> On 01-11-2017 20:10, Cyril Bur wrote:
> > Thanks Gustavo,
> > 
> > I do have one more thought on an improvement for this test which is
> > that:
> > +	/* Counter for busy wait *
> > +	uint64_t counter = 0x1ff000000;
> > is a bit fragile, what we should do is have the test work out long it
> > should spin until it reliably gets a TM_CAUSE_FAC_UNAV failure and then
> > use that for these tests.
> > 
> > This will only become a problem if we were to change kernel heuristics
> > which is fine for now. I'll try to get that added soon but for now this
> > test has proven too useful to delay adding as is.
> 
> I see. Yup, 'counter' value was indeed determined experimentally under many
> different scenarios (VM and BM, different CPU loads, etc). At least if the
> heuristics changes hurting the test it will catch that pointing out that
> the expected failure did not happen, like:
> 
> Checking if FP/VEC registers are sane after a FP unavailable exception...
> If MSR.FP=0 MSR.VEC=0:
>     Expecting the transaction to fail, but it didn't
>     FP ok VEC ok
> ...
> 
> So it won't let the hurting change pass fine silently :-)
> 

Yeah, all for merging as is.

It would be nice so that when someone does  make a heuristic change
they don't also have to go fix tests - there is nothing more annoying
than a fragile test suite.

> 
> > > Signed-off-by: Gustavo Romero <gromero@linux.vnet.ibm.com>
> > > Signed-off-by: Breno Leitao <leitao@debian.org>
> > > Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
> 
> Thanks a lot for reviewing it.
> 
> Cheers,
> Gustavo
> 
