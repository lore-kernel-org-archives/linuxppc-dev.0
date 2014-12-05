Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0107.outbound.protection.outlook.com [207.46.100.107])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5AD461A020A
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Dec 2014 05:52:59 +1100 (AEDT)
Message-ID: <1417805565.334.15.camel@freescale.com>
Subject: Re: [PATCH 2 1/4] powerpc: drop the ability to tweak SMT mode at
 boot time
From: Scott Wood <scottwood@freescale.com>
To: Greg Kurz <gkurz@linux.vnet.ibm.com>
Date: Fri, 5 Dec 2014 12:52:45 -0600
In-Reply-To: <20141205151341.11028.47570.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
References: <20141205150405.11028.27445.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
 <20141205151341.11028.47570.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2014-12-05 at 16:14 +0100, Greg Kurz wrote:
> The smt-enabled kernel parameter basically leaves unwanted cpus executing
> in firmware or wherever they happen to be. The very same applies to the
> ibm,smt-enabled DT property which is no more used by anything known. These
> are hacks that shoudn't be used in a production environment.
> 
> Quoting mpe, "there are better ways for firmware to disable SMT".

Those "better ways" don't apply to Freescale chips, where the OS enables
(or not) SMT without any interaction with firmware.  I don't care about
the ibm,smt-enabled property, but can we please keep the smt-enabled
boot option?

> It also has an evil side effect on the split-core feature for powernv. The
> code needs all the cpus to participate to the split mode update: it relies
> on smp_send_reschedule() to get offline ones to do so. This doesn't work with
> cpus that haven't come up... The consequence is a kernel hang on powernv when
> trying to limit the number of hw threads at boot time (e.g. smt-enabled to
> anything but 8 on POWER8).

In that case could you disable the option only on that hardware?

> This patch simply removes both the smt-enabled kernel parameter and the
> ibm,smt-enabled property for all platforms. The new default is to start
> all hw threads. That leaves /sys the only supported API to change SMT
> settings.

How would you use /sys for this?  Are you talking about CPU hotplug?

-Scott
