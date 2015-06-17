Return-Path: <dsahern@gmail.com>
Received: from mail-ie0-x22c.google.com (mail-ie0-x22c.google.com
 [IPv6:2607:f8b0:4001:c03::22c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2F28C1A0764
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jun 2015 12:27:12 +1000 (AEST)
Received: by iecrd14 with SMTP id rd14so25176899iec.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jun 2015 19:27:09 -0700 (PDT)
Message-ID: <5580DAFB.4080304@gmail.com>
Date: Tue, 16 Jun 2015 20:27:07 -0600
From: David Ahern <dsahern@gmail.com>
MIME-Version: 1.0
To: Hemant Kumar <hemant@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
CC: linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org,
 acme@kernel.org, mingo@kernel.org, sukadev@linux.vnet.ibm.com,
 maddy@linux.vnet.ibm.com, srikar@linux.vnet.ibm.com, paulus@samba.org,
 namhyung@kernel.org, jolsa@kernel.org, peterz@infradead.org
Subject: Re: [RFC PATCH] perf/kvm: Guest Symbol Resolution for powerpc
References: <1434423053-2173-1-git-send-email-hemant@linux.vnet.ibm.com>
 <55803883.50504@gmail.com> <5580CC69.2090200@linux.vnet.ibm.com>
In-Reply-To: <5580CC69.2090200@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 6/16/15 7:24 PM, Hemant Kumar wrote:
> Because, this depends on the kernel tracepoint "kvm_hv:kvm_guest_exit".
> perf_prepare_sample() in the kernel side sets the event->header.misc
> field to
> PERF_RECORD_MISC_KERNEL through perf_misc_flags(pt_regs). In case of
> tracepoints which always get hit in the host kernel context, the
> perf_misc_flags() will always return PERF_RECORD_MISC_KERNEL.
>
> IMHO we will rather have to set the cpumode in the user space for this
> tracepoint
> and we can't depend on the event->header.misc field for this case.
>
> What would you suggest?
>

oh, right you are using a tracepoint for this. It does not have the 
hooks to specify cpumode. Never mind.
