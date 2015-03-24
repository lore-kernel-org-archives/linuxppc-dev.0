Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D4D621A0151
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2015 00:17:07 +1100 (AEDT)
Message-ID: <1427203025.1125.1.camel@ellerman.id.au>
Subject: Re: [PATCH v1 0/2] perf/kvm: perf-kvm-stat on powerpc
From: Michael Ellerman <mpe@ellerman.id.au>
To: Hemant Kumar <hemant@linux.vnet.ibm.com>
Date: Wed, 25 Mar 2015 00:17:05 +1100
In-Reply-To: <551108D6.7090805@linux.vnet.ibm.com>
References: <20150227093649.6367.15679.stgit@localhost.localdomain>
 <551108D6.7090805@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: maddy@linux.vnet.ibm.com, srikar@linux.vnet.ibm.com, anton@au1.ibm.com,
 agraf@suse.de, linux-kernel@vger.kernel.org, paulus@samba.org,
 warrier@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-03-24 at 12:18 +0530, Hemant Kumar wrote:
> Hi Michael,
> 
> These patches were posted a month back. We don't have any review 
> comments to handle at this time. Can you pull these patches to your tree?
> Please, do let me know if you want me to rebase these patches to a 
> different tree (like Arnaldo's/tip etc).

I can't pull them unless they are ACKed by someone from perf. It doesn't look
like you CC'ed any of the perf maintainers.

To make it easier you should split them into patches that touch powerpc and
patches that touch perf.

eg:

> On 02/27/2015 03:13 PM, Hemant Kumar wrote:
> >   arch/powerpc/include/asm/hvcall.h            |  120 -------------------------
> >   arch/powerpc/include/uapi/asm/hcall_codes.h  |  123 ++++++++++++++++++++++++++
> >   arch/powerpc/include/uapi/asm/kvm_perf.h     |   19 ++++
> >   arch/powerpc/include/uapi/asm/trace_book3s.h |   33 +++++++
> >   arch/powerpc/include/uapi/asm/trace_hcall.h  |  122 ++++++++++++++++++++++++++
> >   arch/powerpc/kvm/trace_book3s.h              |   32 -------
> >   arch/powerpc/kvm/trace_hv.h                  |  119 -------------------------
> >   arch/powerpc/kvm/trace_pr.h                  |    2

Patch 1 ^

> >   tools/perf/arch/powerpc/Makefile             |    1
> >   tools/perf/arch/powerpc/util/Build           |    1
> >   tools/perf/arch/powerpc/util/kvm-stat.c      |   94 ++++++++++++++++++++

Patch 2 ^

Then I can merge patch 1, and the perf maintainers can merge patch 2.

Similar comments for patch 2 of your original series.

cheers
