Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id 4F32CDE073
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Dec 2007 02:48:46 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] IB/ehca: Serialize HCA-related hCalls on POWER5
Date: Thu, 6 Dec 2007 16:48:23 +0100
References: <200712061607.20004.fenkes@de.ibm.com>
In-Reply-To: <200712061607.20004.fenkes@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200712061648.24806.arnd@arndb.de>
Cc: Joachim Fenkes <fenkes@de.ibm.com>, LKML <linux-kernel@vger.kernel.org>,
	OF-EWG <ewg@lists.openfabrics.org>, Christoph Raisch <raisch@de.ibm.com>,
	Marcus Eder <meder@de.ibm.com>, OF-General <general@lists.openfabrics.org>,
	Stefan Roscher <stefan.roscher@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 06 December 2007, Joachim Fenkes wrote:
> =A0=A0=A0=A0=A0=A0=A0=A0printk(KERN_INFO "eHCA Infiniband Device Driver "
> =A0=A0=A0=A0=A0=A0=A0=A0 =A0 =A0 =A0 "(Version " HCAD_VERSION ")\n");
> =A0
> +=A0=A0=A0=A0=A0=A0=A0/* Autodetect hCall locking -- we can't read the fi=
rmware version
> +=A0=A0=A0=A0=A0=A0=A0 * directly, but we know that starting with POWER6,=
 all firmware
> +=A0=A0=A0=A0=A0=A0=A0 * versions are good.
> +=A0=A0=A0=A0=A0=A0=A0 */
> +=A0=A0=A0=A0=A0=A0=A0if (ehca_lock_hcalls =3D=3D -1)
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0ehca_lock_hcalls =3D !(cur_=
cpu_spec->cpu_user_features
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 =A0 =A0 & PPC_FEATURE_ARCH_2_05);
> +
> =A0=A0=A0=A0=A0=A0=A0=A0ret =3D ehca_create_comp_pool();
> =A0=A0=A0=A0=A0=A0=A0=A0if (ret) {
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0ehca_gen_err("Cannot crea=
te comp pool.");

We already talked about this yesterday, but I still feel that checking the
instruction set of the CPU should not be used to determine whether a
specific device driver implementation is used int hypervisor.

At the very least, I think you should change this to read the hypervisor
version number from the device tree, though the ideal solution would be
to have the absence of this bug encoded in the device node for the ehca
device itself.

Regarding the performance problem, have you checked whether converting all
your spin_lock_irqsave to spin_lock/spin_lock_irq improves your performance
on the older machines? Maybe it's already fast enough that way.

	Arnd <><
