Return-Path: <stewart@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BC45A1A0015
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Feb 2015 08:52:09 +1100 (AEDT)
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id D70E4140082
 for <linuxppc-dev@ozlabs.org>; Thu, 26 Feb 2015 08:52:08 +1100 (AEDT)
Received: from /spool/local
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Wed, 25 Feb 2015 14:52:06 -0700
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 125F019D803E
 for <linuxppc-dev@ozlabs.org>; Wed, 25 Feb 2015 14:43:12 -0700 (MST)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t1PLptBk35389498
 for <linuxppc-dev@ozlabs.org>; Wed, 25 Feb 2015 14:52:03 -0700
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1PLpUa5030875
 for <linuxppc-dev@ozlabs.org>; Wed, 25 Feb 2015 14:51:30 -0700
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] powerpc/smp: Wait until secondaries are active & online
In-Reply-To: <1424761082-29938-1-git-send-email-mpe@ellerman.id.au>
References: <1424761082-29938-1-git-send-email-mpe@ellerman.id.au>
Date: Thu, 26 Feb 2015 08:51:10 +1100
Message-ID: <m3sidtek35.fsf@oc8180480414.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@kernel.org,
 Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Ellerman <mpe@ellerman.id.au> writes:
> Anton has a busy ppc64le KVM box where guests sometimes hit the infamous
> "kernel BUG at kernel/smpboot.c:134!" issue during boot:
>
>   BUG_ON(td->cpu != smp_processor_id());
>
> Basically a per CPU hotplug thread scheduled on the wrong CPU. The oops
> output confirms it:
>
>   CPU: 0
>   Comm: watchdog/130

Has anyone seen this on powernv before?

I seem to be able to very reliably get such crashes with my
(experimental) gcov enabled skiboot on P7 (and P8, but I've had more
time on P7 than P8).

Hoping to try the patch later today.
