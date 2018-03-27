Return-Path: <npiggin@gmail.com>
Received: from mail-pl0-x241.google.com (mail-pl0-x241.google.com
 [IPv6:2607:f8b0:400e:c01::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 409N1T466WzF24J
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Mar 2018 18:29:16 +1100 (AEDT)
Received: by mail-pl0-x241.google.com with SMTP id 9-v6so13588171ple.11
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Mar 2018 00:29:16 -0700 (PDT)
Date: Tue, 27 Mar 2018 17:28:56 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Stewart Smith
 <stewart@linux.vnet.ibm.com>, Mahesh Jagannath Salgaonkar
 <mahesh@linux.vnet.ibm.com>, Ananth N Mavinakayanahalli <ananth@in.ibm.com>
Subject: Re: [RFC PATCH] powerpc/xmon: Use OPAL_DEBUG to debug srest in OPAL
Message-ID: <20180327172856.252ec56b@roar.ozlabs.ibm.com>
In-Reply-To: <25588979-81cd-2a63-59f8-728686855117@linux.vnet.ibm.com>
References: <20180326150946.23555-1-npiggin@gmail.com>
 <25588979-81cd-2a63-59f8-728686855117@linux.vnet.ibm.com>
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

On Tue, 27 Mar 2018 12:42:32 +0530
Vasant Hegde <hegdevasant@linux.vnet.ibm.com> wrote:

> On 03/26/2018 08:39 PM, Nicholas Piggin wrote:
> > xmon can be entered via sreset NMI (from a management sreset, or an
> > NMI IPI), which can interrupt OPAL. Add checks to xmon to see if pc
> > or sp are within OPAL memory, and if so, then use OPAL_DEBUG to
> > print the opal stack and return the Linux stack, which can then be
> > dumped by xmon  
> 
> Nick,
> 
> 
> OPAL uses FSP/cronus interface for many of debug interface (like OPAL assert, 
> getting opal console, triggering FSP R/R etc). May be in future we may add new 
> debug capability.

It would be good to ensure an API could accommodate them, or at least
not get in the way.

> Once secureboot is enabled none of these interface work and we have limited debug
> capability.
> 
> Here you are using very generic API name (OPAL_DEBUG). May be we should have generic
> interface (exported via debugfs?) here rather than SRESET specific one.

OPAL_DEBUG here actually uses the sub-function OPAL_DEBUG_DUMP_STACK (1),
but I didn't bring that constant across from skiboot which I should have.

But I don't think this is SRESET specific. If Linux has any way to get
an r1 for a CPU in OPAL, then it can use this function. If it does not,
then it simply can't use it.

I haven't really followed what's happening with secure boot, but presumably
we can still get NMIs (at least machine check, even if all system reset
sources are suppressed).

> > 
> > The OPAL side of this, with sample xmon output is here:
> > 
> > https://lists.ozlabs.org/pipermail/skiboot/2018-March/010856.html
> > 
> > This could be plumed into the oops printing code as well.

Thanks,
Nick
