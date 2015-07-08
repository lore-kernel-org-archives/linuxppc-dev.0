Return-Path: <stewart@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 749FB1A18F1
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Jul 2015 16:14:48 +1000 (AEST)
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id B54F51402BA
 for <linuxppc-dev@ozlabs.org>; Wed,  8 Jul 2015 16:14:47 +1000 (AEST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Wed, 8 Jul 2015 00:14:45 -0600
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 8C920C90043
 for <linuxppc-dev@ozlabs.org>; Wed,  8 Jul 2015 02:05:48 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t686EfMZ66977956
 for <linuxppc-dev@ozlabs.org>; Wed, 8 Jul 2015 06:14:41 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t686EfQv020668
 for <linuxppc-dev@ozlabs.org>; Wed, 8 Jul 2015 02:14:41 -0400
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: Samuel Mendoza-Jonas <sam.mj@au1.ibm.com>, linuxppc-dev@ozlabs.org
Cc: Samuel Mendoza-Jonas <sam.mj@au1.ibm.com>
Subject: Re: [PATCH 2/2] powerpc/kexec: Reset HILE before kexec_sequence
In-Reply-To: <1436318605-13031-2-git-send-email-sam.mj@au1.ibm.com>
References: <1436318605-13031-1-git-send-email-sam.mj@au1.ibm.com>
 <1436318605-13031-2-git-send-email-sam.mj@au1.ibm.com>
Date: Wed, 08 Jul 2015 16:14:22 +1000
Message-ID: <m3io9v18ht.fsf@oc8180480414.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Samuel Mendoza-Jonas <sam.mj@au1.ibm.com> writes:
> On powernv secondary cpus are returned to OPAL, and will then enter the
> target kernel in big-endian. However if it is set the HILE bit will persist,
> causing the first exception in the target kernel to be delivered in
> litte-endian regardless of the kernel endianess.
> Make sure that the HILE bit is switched off before entering
> kexec_sequence.
>
> Signed-off-by: Samuel Mendoza-Jonas <sam.mj@au1.ibm.com>

Discussed with Sam on IRC, this makes kexec environment the same (or at
least closer to) booting the initial payload, which is a Good Thing(TM).

The ignoring of any error from opal_reinit_cpus() (as done in this
patch) is probably a good idea as we're either running on old firmware
which doesn't have the call (in which case we'd explode no matter what)
or we're on some crazy theoretical chip that doesn't do HILE=0, in which
case this gives us the best chance for compatibility.

Reviewed-by: Stewart Smith <stewart@linux.vnet.ibm.com>
