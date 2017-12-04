Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yqpMh5l7GzDrZc
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Dec 2017 13:13:52 +1100 (AEDT)
Date: Mon, 4 Dec 2017 12:04:09 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: kvm-ppc@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] KVM: PPC: Book3S HV: check for XIVE device before
 executing the XICS hcalls
Message-ID: <20171204010409.rasszyk4rsc3bbhm@oak.ozlabs.ibm.com>
References: <20171127073017.25463-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20171127073017.25463-1-clg@kaod.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Nov 27, 2017 at 08:30:17AM +0100, Cédric Le Goater wrote:
> When QEMU is started with the option kernel_irqchip=òff, the kvm XICS
> hcalls are being used even though a kvm XICS device has not been
> created on the host, resulting quickly in a failure and a broken
> guest.
> 
> The test checking if there is a XIVE device in the VM before executing
> the XICS hcalls is missing from the recent XICS-over-XIVE glue.
> 
> Signed-off-by: Cédric Le Goater <clg@kaod.org>

I think this is fixing the same bug that commit 00bb6ae50062 ("KVM:
PPC: Book3S HV: Don't call real-mode XICS hypercall handlers if not
enabled", 2017-10-26) addresses.

Do you think this patch is needed in addition to 00bb6ae50062?

Paul.
