Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yBBwl28hDzDqlv
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Oct 2017 20:42:30 +1100 (AEDT)
Received: by mail-pf0-x243.google.com with SMTP id b85so13967591pfj.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Oct 2017 02:42:30 -0700 (PDT)
Date: Tue, 10 Oct 2017 19:42:14 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: kvm-ppc@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH] powerpc/pseries/cpuidle: add polling idle for shared
 processor guests
Message-ID: <20171010194140.5aec88d9@roar.ozlabs.ibm.com>
In-Reply-To: <20171010071109.31207-1-npiggin@gmail.com>
References: <20171010071109.31207-1-npiggin@gmail.com>
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

On Tue, 10 Oct 2017 17:11:09 +1000
Nicholas Piggin <npiggin@gmail.com> wrote:

> For shared processor guests (e.g., KVM), add an idle polling mode rather
> than immediately returning to the hypervisor when the guest CPU goes
> idle.
> 
> Test setup is a 2 socket POWER9 with 4 guests running, each with vCPUs
> equal to 1/2 of real of CPUs. Saturated each guest with tbench. Using
> polling idle gives about 1.4x throughput.

Actually it's even more noticeable when the host is not over subscribed
by the looks. 2.5x-3x increase in throughput for just a single guest.

Thanks,
Nick
