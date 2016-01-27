Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 933091A0174
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jan 2016 15:10:31 +1100 (AEDT)
Message-ID: <1453867831.12023.0.camel@ellerman.id.au>
Subject: Re: [PATCH]  powerpc/perf: Remove PPMU_HAS_SSLOT flag for Power8
From: Michael Ellerman <mpe@ellerman.id.au>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Date: Wed, 27 Jan 2016 15:10:31 +1100
In-Reply-To: <1453710826-3160-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1453710826-3160-1-git-send-email-maddy@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2016-01-25 at 14:03 +0530, Madhavan Srinivasan wrote:

>  Commit: 7a7868326d77 introduced PPMU_HAS_SSLOT flag to
>  remove assumption of MMCRA[SLOT] with respect to
>  PPMU_ALT_SIPR flag. Commit 7a7868326d77's message also
>  specifies that Power8 does not support MMCRA[SLOT].
>  But still PPMU_HAS_SSLOT flag managed to get into
>  Power8 code. Patch to remove the same from Power8 flags.
>
> Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>

Thanks.

I cleaned up and expanded the change log:

  powerpc/perf: Remove PPMU_HAS_SSLOT flag for Power8

  Commit 7a7868326d77 ("powerpc/perf: Add an explict flag indicating
  presence of SLOT field") introduced the PPMU_HAS_SSLOT flag to remove
  the assumption that MMCRA[SLOT] was present when PPMU_ALT_SIPR was not
  set.

  That commit's changelog also mentions that Power8 does not support
  MMCRA[SLOT]. However when the Power8 PMU support was merged, it
  errnoeously included the PPMU_HAS_SSLOT flag.

  So remove PPMU_HAS_SSLOT from the Power8 flags.

  mpe: On systems where MMCRA[SLOT] exists, the field occupies bits 37:39
  (IBM numbering). On Power8 bit 37 is reserved, and 38:39 overlap with
  the high bits of the Threshold Event Counter Mantissa. I am not aware of
  any published events which use the thereshold counting mechanism, which
  would cause the mantissa bits to be set. So in practice this bug is
  unlikely to trigger in practice.

  Fixes: e05b9b9e5c10 ("powerpc/perf: Power8 PMU support")
  Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
  Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>


cheers
