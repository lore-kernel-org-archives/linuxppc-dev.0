Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id EEF3DB6FF8
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Mar 2012 02:13:31 +1100 (EST)
Subject: Re: [PATCH v3] powerpc/srio: Fix the compile errors when building
 with 64bit
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1331280638-23525-1-git-send-email-Gang.Liu@freescale.com>
Date: Fri, 16 Mar 2012 10:13:00 -0500
Message-Id: <5C09B1ED-D607-4924-AB13-4CCB48036133@kernel.crashing.org>
References: <1331280638-23525-1-git-send-email-Gang.Liu@freescale.com>
To: Liu Gang <Gang.Liu@freescale.com>
Cc: r58472@freescale.com, paul.gortmaker@windriver.com,
 linux-kernel@vger.kernel.org, r61911@freescale.com, Alexandre.Bounine@idt.com,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 Shaohui Xie <Shaohui.Xie@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Mar 9, 2012, at 2:10 AM, Liu Gang wrote:

> For the file "arch/powerpc/sysdev/fsl_rmu.c", there will be some =
compile
> errors while using the corenet64_smp_defconfig:
>=20
> .../fsl_rmu.c:315: error: cast from pointer to integer of different =
size
> .../fsl_rmu.c:320: error: cast to pointer from integer of different =
size
> .../fsl_rmu.c:320: error: cast to pointer from integer of different =
size
> .../fsl_rmu.c:320: error: cast to pointer from integer of different =
size
> .../fsl_rmu.c:330: error: cast to pointer from integer of different =
size
> .../fsl_rmu.c:332: error: cast to pointer from integer of different =
size
> .../fsl_rmu.c:339: error: cast to pointer from integer of different =
size
> .../fsl_rmu.c:340: error: cast to pointer from integer of different =
size
> .../fsl_rmu.c:341: error: cast to pointer from integer of different =
size
> .../fsl_rmu.c:348: error: cast to pointer from integer of different =
size
> .../fsl_rmu.c:348: error: cast to pointer from integer of different =
size
> .../fsl_rmu.c:348: error: cast to pointer from integer of different =
size
> .../fsl_rmu.c:659: error: cast from pointer to integer of different =
size
> .../fsl_rmu.c:659: error: format '%8.8x' expects type 'unsigned int',
>                   but argument 5 has type 'size_t'
> .../fsl_rmu.c:985: error: cast from pointer to integer of different =
size
> .../fsl_rmu.c:997: error: cast to pointer from integer of different =
size
>=20
> Rewrote the corresponding code with the support of 64bit building.
>=20
> Signed-off-by: Liu Gang <Gang.Liu@freescale.com>
> Signed-off-by: Shaohui Xie <Shaohui.Xie@freescale.com>
> Reported-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> ---
> Changes in v2:
> - Add the struct "rio_dbell_msg" to instead of some DBELL_* macros.
> - Change the "virt_buf" to be "void *" type.
> - Change "Signed-off-by" to "Reported-by" for Paul.
>=20
> Changes in v3:
> - Change the "%8.8lx" to be "%p" and remove the cast of the "buffer"
>=20
> arch/powerpc/sysdev/fsl_rmu.c |   42 =
+++++++++++++++++++++-------------------
> 1 files changed, 22 insertions(+), 20 deletions(-)

applied

- k=
