Return-Path: <ananth@in.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 897541A0163
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Sep 2015 20:51:37 +1000 (AEST)
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id AB5D71401AF
 for <linuxppc-dev@ozlabs.org>; Tue,  8 Sep 2015 20:51:36 +1000 (AEST)
Received: from /spool/local
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <ananth@in.ibm.com>;
 Tue, 8 Sep 2015 04:51:34 -0600
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 2BA373E4003F
 for <linuxppc-dev@ozlabs.org>; Tue,  8 Sep 2015 04:51:32 -0600 (MDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t88AoiUS41549848
 for <linuxppc-dev@ozlabs.org>; Tue, 8 Sep 2015 03:50:44 -0700
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t88ApV6N005910
 for <linuxppc-dev@ozlabs.org>; Tue, 8 Sep 2015 04:51:31 -0600
Date: Tue, 8 Sep 2015 16:21:27 +0530
From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
 Paul Mackerras <paulus@samba.org>, ego@linux.vnet.ibm.com, mingo@kernel.org
Subject: Re: powerpc: Add user-return-notifier support
Message-ID: <20150908105127.GB12028@in.ibm.com>
Reply-To: ananth@in.ibm.com
References: <20150825054110.GD3815@in.ibm.com>
 <20150831103517.96D1A1401E7@ozlabs.org>
 <20150901064113.GA1196@in.ibm.com>
 <1441152192.4966.103.camel@freescale.com>
 <20150902023713.GB1196@in.ibm.com>
 <1441164552.4966.153.camel@freescale.com>
 <20150902050958.GC1196@in.ibm.com>
 <1441704279.7601.6.camel@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1441704279.7601.6.camel@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Sep 08, 2015 at 07:24:39PM +1000, Michael Ellerman wrote:
> On Wed, 2015-09-02 at 10:39 +0530, Ananth N Mavinakayanahalli wrote:
> > On Tue, Sep 01, 2015 at 10:29:12PM -0500, Scott Wood wrote:
> > 
> > > Why is this selected by KVM on PPC if KVM on PPC doesn't use it?  What is the 
> > > user you're trying to enable?
> > 
> > I copied Paul and Gautham to get their thoughts on whether it is
> > something they could use on Power. At this time, apart from enabling the
> > feature, I do not have a specific usecase for it. We can park this patch
> > pending a real user on powerpc.
> 
> OK, thanks for hashing that out guys. I think parking it is the best solution
> for now, we could merge it and disable it somehow, but that would be ugly and
> prone to breaking.
> 
> Do we want to do something like this?

Yes. This looks fine -- folks who want it down the line know where to look.

Thanks,
Ananth

> 
> cheers
> 
> diff --git a/Documentation/features/arch-support.txt b/Documentation/features/arch-support.txt
> index d22a1095e661..3e2cf6161cf4 100644
> --- a/Documentation/features/arch-support.txt
> +++ b/Documentation/features/arch-support.txt
> @@ -8,4 +8,5 @@ The meaning of entries in the tables is:
>      | ok |  # feature supported by the architecture
>      |TODO|  # feature not yet supported by the architecture
>      | .. |  # feature cannot be supported by the hardware
> +    |n/a |  # feature is not needed/wanted/meaningful for the architecture
> 
> diff --git a/Documentation/features/debug/user-ret-profiler/arch-support.txt b/Documentation/features/debug/user-ret-profiler/arch-support.txt
> index 44cc1ff3f603..669813180dc5 100644
> --- a/Documentation/features/debug/user-ret-profiler/arch-support.txt
> +++ b/Documentation/features/debug/user-ret-profiler/arch-support.txt
> @@ -27,7 +27,7 @@
>      |       nios2: | TODO |
>      |    openrisc: | TODO |
>      |      parisc: | TODO |
> -    |     powerpc: | TODO |
> +    |     powerpc: | n/a  |    # http://lkml.kernel.org/r/20150825054110.GD3815@in.ibm.com
>      |        s390: | TODO |
>      |       score: | TODO |
>      |          sh: | TODO |
> 
> 
