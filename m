Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41j7dt4xQczF3GC
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  4 Aug 2018 12:48:50 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Pingfan Liu <kernelfans@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: Pingfan Liu <kernelfans@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>, linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/2] powerpc/cpu: post the event cpux add/remove instead
 of online/offline during hotplug
In-Reply-To: <1533217359-11420-2-git-send-email-kernelfans@gmail.com>
References: <1533217359-11420-1-git-send-email-kernelfans@gmail.com>
 <1533217359-11420-2-git-send-email-kernelfans@gmail.com>
Date: Sat, 04 Aug 2018 12:48:46 +1000
Message-ID: <87tvoag835.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Pingfan,

Pingfan Liu <kernelfans@gmail.com> writes:
> Technically speaking, echo 1/0 > cpuX/online is only a subset of cpu
> hotplug/unplug, i.e. add/remove. The latter one includes the physical
> adding/removing of a cpu device. Some user space tools such as kexec-tools
> resort to the event add/remove to automatically rebuild dtb.
> If the dtb is not rebuilt correctly, we may hang on 2nd kernel due to
> lack the info of boot-cpu-hwid in dtb.

I notice you also sent a patch for ppc64_cpu to deal with CPUs being
removed rather than just offlined.

If I apply this patch then existing ppc64_cpu (without your other patch)
will break. Is that right?

cheers
