Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1021C1A0926
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Dec 2014 09:40:17 +1100 (AEDT)
In-Reply-To: <20141211164454.4641.71441.stgit@localhost.localdomain>
To: Hari Bathini <hbathini@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: powerpc/kdump: skip enabling big endian exception during crash
Message-Id: <20141211224016.86E111400F1@ozlabs.org>
Date: Fri, 12 Dec 2014 09:40:16 +1100 (AEDT)
Cc: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2014-11-12 at 16:44:54 UTC, Hari Bathini wrote:
> In LE kernel, we currently have a hack for kexec that resets the exception endian
> before starting a new kernel as the kernel that is loaded could be a big endian
> or a little endian kernel. In kdump case, resetting exception endian fails when
> one or more cpus is disabled. But in case of kdump, we can conveniently ignore
> resetting endianess as crashkernel is always of same endianess as primary kernel.

No, it's not guaranteed to be the same endianess.

That tends to be what people do in practice, but it's not an assumption you can
hard code.

cheers
