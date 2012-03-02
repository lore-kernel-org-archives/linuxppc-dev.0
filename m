Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id BC75AB6EEA
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Mar 2012 02:11:37 +1100 (EST)
Subject: Re: [PATCH] powerpc/srio: Fix the compile errors when building with
 64bit
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1330672127-22172-1-git-send-email-Gang.Liu@freescale.com>
Date: Fri, 2 Mar 2012 09:11:00 -0600
Message-Id: <6BFCD6C7-7675-4A99-9C4C-4E86FA5642A4@kernel.crashing.org>
References: <1330672127-22172-1-git-send-email-Gang.Liu@freescale.com>
To: Liu Gang <Gang.Liu@freescale.com>
Cc: r58472@freescale.com, Paul Gortmaker <paul.gortmaker@windriver.com>,
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


On Mar 2, 2012, at 1:08 AM, Liu Gang wrote:

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
> 		   but argument 5 has type 'size_t'
> .../fsl_rmu.c:985: error: cast from pointer to integer of different =
size
> .../fsl_rmu.c:997: error: cast to pointer from integer of different =
size
>=20
> Rewrote the corresponding code with the support of 64bit building.
>=20
> Signed-off-by: Liu Gang <Gang.Liu@freescale.com>
> Signed-off-by: Shaohui Xie <Shaohui.Xie@freescale.com>
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> ---
> arch/powerpc/sysdev/fsl_rmu.c |   11 ++++++-----
> 1 files changed, 6 insertions(+), 5 deletions(-)
>=20
> diff --git a/arch/powerpc/sysdev/fsl_rmu.c =
b/arch/powerpc/sysdev/fsl_rmu.c
> index 1548578..468011e 100644
> --- a/arch/powerpc/sysdev/fsl_rmu.c
> +++ b/arch/powerpc/sysdev/fsl_rmu.c
> @@ -311,8 +311,8 @@ fsl_rio_dbell_handler(int irq, void *dev_instance)
>=20
> 	/* XXX Need to check/dispatch until queue empty */
> 	if (dsr & DOORBELL_DSR_DIQI) {
> -		u32 dmsg =3D
> -			(u32) fsl_dbell->dbell_ring.virt +
> +		unsigned long dmsg =3D
> +			(unsigned long) fsl_dbell->dbell_ring.virt +
> 			(in_be32(&fsl_dbell->dbell_regs->dqdpar) & =
0xfff);
> 		struct rio_dbell *dbell;
> 		int found =3D 0;
> @@ -657,7 +657,8 @@ fsl_add_outb_message(struct rio_mport *mport, =
struct rio_dev *rdev, int mbox,
> 	int ret =3D 0;
>=20
> 	pr_debug("RIO: fsl_add_outb_message(): destid %4.4x mbox %d =
buffer " \
> -		 "%8.8x len %8.8x\n", rdev->destid, mbox, (int)buffer, =
len);
> +		 "%8.8lx len %8.8zx\n", rdev->destid, mbox,
> +		(unsigned long)buffer, len);
> 	if ((len < 8) || (len > RIO_MAX_MSG_SIZE)) {
> 		ret =3D -EINVAL;
> 		goto out;

For this case it seems as if some cast should be added to DBELL_* macros

> @@ -972,7 +973,7 @@ out:
> void *fsl_get_inb_message(struct rio_mport *mport, int mbox)
> {
> 	struct fsl_rmu *rmu =3D GET_RMM_HANDLE(mport);
> -	u32 phys_buf, virt_buf;
> +	unsigned long phys_buf, virt_buf;

Do you really want to change phys_buf to an 'unsigned long'?

Should virt_buf really be void * here?

> 	void *buf =3D NULL;
> 	int buf_idx;
>=20
> @@ -982,7 +983,7 @@ void *fsl_get_inb_message(struct rio_mport *mport, =
int mbox)
> 	if (phys_buf =3D=3D in_be32(&rmu->msg_regs->ifqepar))
> 		goto out2;
>=20
> -	virt_buf =3D (u32) rmu->msg_rx_ring.virt + (phys_buf
> +	virt_buf =3D (unsigned long) rmu->msg_rx_ring.virt + (phys_buf
> 						- =
rmu->msg_rx_ring.phys);
> 	buf_idx =3D (phys_buf - rmu->msg_rx_ring.phys) / =
RIO_MAX_MSG_SIZE;
> 	buf =3D rmu->msg_rx_ring.virt_buffer[buf_idx];

The memcpy later could remove a cast if you make virt_buf a void *.

> --=20
> 1.7.0.4
>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe =
linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
