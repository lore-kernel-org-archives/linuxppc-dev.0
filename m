Return-Path: <timur.tabi@gmail.com>
Received: from qw-out-2122.google.com (qw-out-2122.google.com [74.125.92.26])
	by ozlabs.org (Postfix) with ESMTP id AFB7DB7D08
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Mar 2010 13:31:28 +1100 (EST)
Received: by qw-out-2122.google.com with SMTP id 8so905314qwh.15
	for <linuxppc-dev@ozlabs.org>; Sun, 21 Mar 2010 19:31:26 -0700 (PDT)
MIME-Version: 1.0
Sender: timur.tabi@gmail.com
In-Reply-To: <1268923993-26689-1-git-send-email-galak@kernel.crashing.org>
References: <1268923993-26689-1-git-send-email-galak@kernel.crashing.org>
From: Timur Tabi <timur@freescale.com>
Date: Sun, 21 Mar 2010 21:31:06 -0500
Message-ID: <ed82fe3e1003211931m359b8a10m60e91d66df31554e@mail.gmail.com>
Subject: Re: [PATCH] powerpc/fsl: Add multiple MSI bank support
To: Kumar Gala <galak@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Lan Chunhe-B25806 <B25806@freescale.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Mar 18, 2010 at 9:53 AM, Kumar Gala <galak@kernel.crashing.org> wro=
te:
> + =A0 =A0 =A0 /* The multiple setting ppc_md.setup_msi_irqs will not harm=
 things */
> + =A0 =A0 =A0 if (!ppc_md.setup_msi_irqs) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ppc_md.setup_msi_irqs =3D fsl_setup_msi_irq=
s;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ppc_md.teardown_msi_irqs =3D fsl_teardown_m=
si_irqs;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ppc_md.msi_check_device =3D fsl_msi_check_d=
evice;
> + =A0 =A0 =A0 } else if (ppc_md.setup_msi_irqs !=3D fsl_setup_msi_irqs) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&dev->dev, "Different MSI driver al=
ready installed!\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D -EBUSY; /* or some other error code=
 */

The comment is inappropriate.  I put it there as a reminder that maybe
EBUSY is not the best choice.  But if it is, then the comment should
be removed.

--=20
Timur Tabi
Linux kernel developer at Freescale
