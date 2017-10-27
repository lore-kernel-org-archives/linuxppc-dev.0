Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yNXmz6k8dzDrbl
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Oct 2017 16:41:39 +1100 (AEDT)
Date: Fri, 27 Oct 2017 16:41:36 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 00/16] Remove hash page table slot tracking from linux PTE
Message-ID: <20171027054136.GC27483@fergus.ozlabs.ibm.com>
References: <20171027040833.3644-1-aneesh.kumar@linux.vnet.ibm.com>
 <20171027043430.GA27483@fergus.ozlabs.ibm.com>
 <adf2d270-29df-701f-206e-0d8a35084e47@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <adf2d270-29df-701f-206e-0d8a35084e47@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Oct 27, 2017 at 10:57:13AM +0530, Aneesh Kumar K.V wrote:
> 
> 
> On 10/27/2017 10:04 AM, Paul Mackerras wrote:
> >How do we interpret these numbers?  Are they times, or speed?  Is
> >larger better or worse?
> 
> Sorry for not including the details. They are time in seconds. Test case is
> a modified mmap_bench included in powerpc/selftest.
> 
> >
> >Can you give us the mean and standard deviation for each set of 5
> >please?
> >
> 
> powernv without patch
> median= 51.432255
> stdev = 0.370835
> 
> with patch
> median = 50.739922
> stdev = 0.06419662
> 
> pseries without patch
> median = 116.617884
> stdev = 3.04531023
> 
> with patch no hcall
> median = 119.42494
> stdev = 0.85874552
> 
> with patch and hcall
> median = 117.735808
> stdev = 2.7624151

So on powernv, the patch set *improves* performance by about 1.3%
(almost 2 standard deviations).  Do we know why that is?

On pseries, performance is about 2.4% worse without new hcalls, but
that is less than 1 standard deviation.  With new hcalls, performance
is 0.95% worse, only a third of a standard deviation.  I think we need
to do more measurements to try to get a more accurate picture here.

Were the pseries numbers done on KVM or PowerVM?  Could you do a set
of measurements on the other one too please?  (I assume the numbers
with the new hcall were done on KVM, and can't be done on PowerVM.)

Paul.
