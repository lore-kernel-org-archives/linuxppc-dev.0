Return-Path: <srivatsa.bhat@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 609711A0008
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Jun 2014 22:38:44 +1000 (EST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
 Fri, 6 Jun 2014 22:38:43 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 0FF7B3578048
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Jun 2014 22:38:41 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s56CMf9c17367226
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 6 Jun 2014 22:22:41 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s56CceRh010005
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 6 Jun 2014 22:38:40 +1000
Message-ID: <5391B5FE.2090508@linux.vnet.ibm.com>
Date: Fri, 06 Jun 2014 18:07:18 +0530
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc, kexec: Fix "Processor X is stuck" issue during
 kexec from ST mode
References: <20140527105511.24309.74320.stgit@srivatsabhat.in.ibm.com>
 <20140528133143.GK14863@redhat.com> <538E2FF8.8060707@linux.vnet.ibm.com>
 <1401833365.3247.36.camel@pasglop> <5391B413.100@linux.vnet.ibm.com>
In-Reply-To: <5391B413.100@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: ego@linux.vnet.ibm.com, matt@ozlabs.org, mahesh@linux.vnet.ibm.com,
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org, suzuki@in.ibm.com,
 ebiederm@xmission.com, paulus@samba.org, linuxppc-dev@lists.ozlabs.org,
 Vivek Goyal <vgoyal@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/06/2014 05:59 PM, Srivatsa S. Bhat wrote:
 
> +bool kexec_cpu_wake(void)
> +{
> +	kexec_smp_down(NULL);
> +
> +	/* NOTREACHED */
> +	return true;
> +}
> +

This function doesn't have to return anything, so we can define it as void.
The bool is a remnant of my previous attempt at making this work. (But these
patches compile fine as they are, though).

Regards,
Srivatsa S. Bhat
