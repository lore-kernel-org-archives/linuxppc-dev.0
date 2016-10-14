Return-Path: <sam.bobroff@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3swCkK6Xv0zDt6t
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Oct 2016 14:28:57 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u9E3OZm6092743
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Oct 2016 23:28:55 -0400
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 by mx0b-001b2d01.pphosted.com with ESMTP id 262max5wjp-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Oct 2016 23:28:55 -0400
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sam.bobroff@au1.ibm.com>;
 Fri, 14 Oct 2016 13:28:52 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 8BDDE2BB005A
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Oct 2016 14:28:49 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u9E3SnSO37617840
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Oct 2016 14:28:49 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u9E3Smhh030535
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Oct 2016 14:28:49 +1100
Date: Fri, 14 Oct 2016 14:28:47 +1100
From: Sam Bobroff <sam.bobroff@au1.ibm.com>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Cc: pbonzini@redhat.com, rkrcmar@redhat.com, agraf@suse.com, corbet@lwn.net,
 paulus@samba.org, mpe@ellerman.id.au, kvm@vger.kernel.org,
 kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 benh@kernel.crashing.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 0/6] kvm: powerpc halt polling updates
References: <1476406404-32752-1-git-send-email-sjitindarsingh@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1476406404-32752-1-git-send-email-sjitindarsingh@gmail.com>
Message-Id: <20161014032847.GA27267@tungsten.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Oct 14, 2016 at 11:53:18AM +1100, Suraj Jitindar Singh wrote:
> This patch series makes some updates and bug fixes to the powerpc kvm-hv
> halt polling code.
> 
> The first two patches are concerned with exporting the generic kvm module
> parameter variables and accessing these from the powerpc specific code.
> 
> The third patch fixes a bug where changing the global max halt polling
> interval module parameter can sometimes have no effect.
> 
> The fourth patch decreases the default global max halt polling interval
> to something more sensible.
> 
> The fifth patch contains generic fixups with no functional effect.
> 
> The last patch adds halt polling documentation.
> 
> Suraj Jitindar Singh (6):
>   kvm: export kvm module parameter variables
>   powerpc/kvm: Use generic kvm module parameters in kvm-hv
>   powerpc/kvm: Add check for module parameter halt_poll_ns
>   powerpc/kvm: Decrease the powerpc default halt poll max value
>   powerpc/kvm: Comment style and print format fixups
>   doc/kvm: Add halt polling documentation
> 
>  Documentation/virtual/kvm/00-INDEX         |   2 +
>  Documentation/virtual/kvm/halt-polling.txt | 127 +++++++++++++++++++++++++++++
>  arch/powerpc/include/asm/kvm_host.h        |   2 +-
>  arch/powerpc/kvm/book3s_hv.c               |  33 ++------
>  arch/powerpc/kvm/trace_hv.h                |   2 +-
>  include/linux/kvm_host.h                   |   4 +
>  virt/kvm/kvm_main.c                        |   9 +-
>  7 files changed, 149 insertions(+), 30 deletions(-)
>  create mode 100644 Documentation/virtual/kvm/halt-polling.txt
> 
> -- 
> 2.5.5

Hi Suraj,

I've given this set a quick test and it seems to work fine. I used a repetitive
wakeup, using a nanosleep loop in guest userspace (with real time prio), and I
was able to cause halt polling to switch on and off as I adjusted halt_poll_ns.
I think the new default value is much better: halt polling started (e.g. CPU
utilization rose to 100%) once CPU utilization had already risen to about 75%.

Cheers,
Sam.

Tested-by: Sam Bobroff <sam.bobroff@au1.ibm.com>
