Return-Path: <thenzl@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4212C1A1E43
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Oct 2015 01:01:43 +1100 (AEDT)
Subject: Re: [PATCH v6 33/37] cxlflash: Fix to avoid leaving dangling
 interrupt resources
To: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>, linux-scsi@vger.kernel.org,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 "Nicholas A. Bellinger" <nab@linux-iscsi.org>,
 Brian King <brking@linux.vnet.ibm.com>, Ian Munsie <imunsie@au1.ibm.com>,
 Daniel Axtens <dja@ozlabs.au.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 David Laight <David.Laight@ACULAB.COM>
References: <1445458134-63197-1-git-send-email-mrochs@linux.vnet.ibm.com>
 <1445458560-61693-1-git-send-email-mrochs@linux.vnet.ibm.com>
Cc: Michael Neuling <mikey@neuling.org>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
From: Tomas Henzl <thenzl@redhat.com>
Message-ID: <562A3DC2.9030807@redhat.com>
Date: Fri, 23 Oct 2015 16:01:38 +0200
MIME-Version: 1.0
In-Reply-To: <1445458560-61693-1-git-send-email-mrochs@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 21.10.2015 22:16, Matthew R. Ochs wrote:
> When running with an unsupported AFU, the cxlflash driver fails
> the probe. When the driver is removed, the following Oops is
> encountered on a show_interrupts() thread:
>
> Call Trace:
> [c000001fba5a7a10] [0000000000000003] 0x3 (unreliable)
> [c000001fba5a7a60] [c00000000053dcf4] vsnprintf+0x204/0x4c0
> [c000001fba5a7ae0] [c00000000030045c] seq_vprintf+0x5c/0xd0
> [c000001fba5a7b20] [c00000000030051c] seq_printf+0x4c/0x60
> [c000001fba5a7b50] [c00000000013e140] show_interrupts+0x370/0x4f0
> [c000001fba5a7c10] [c0000000002ff898] seq_read+0xe8/0x530
> [c000001fba5a7ca0] [c00000000035d5c0] proc_reg_read+0xb0/0x110
> [c000001fba5a7cf0] [c0000000002ca74c] __vfs_read+0x6c/0x180
> [c000001fba5a7d90] [c0000000002cb464] vfs_read+0xa4/0x1c0
> [c000001fba5a7de0] [c0000000002cc51c] SyS_read+0x6c/0x110
> [c000001fba5a7e30] [c000000000009204] system_call+0x38/0xb4
>
> The Oops is due to not cleaning up correctly on the unsupported
> AFU error path, leaving various allocated and registered resources.
> In this case, interrupts are in a semi-allocated/registered state,
> which the show_interrupts() thread attempts to use.
>
> To fix, the cleanup logic in init_afu() is consolidated to error
> gates at the bottom of the function and the appropriate goto is
> added to each error path. As a mini side fix while refactoring
> in this routine, the else statement following the AFU version
> evaluation is eliminated as it is not needed.
>
> Signed-off-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
> Acked-by: Manoj Kumar <manoj@linux.vnet.ibm.com>
> Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

Reviewed-by: Tomas Henzl <thenzl@redhat.com>

Tomas
