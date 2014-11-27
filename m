Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C3B1C1A0969
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Nov 2014 14:12:36 +1100 (AEDT)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 39458140145
 for <linuxppc-dev@ozlabs.org>; Thu, 27 Nov 2014 14:12:34 +1100 (AEDT)
Message-ID: <1417057941.5089.81.camel@kernel.crashing.org>
Subject: Right location in sysfs for dlpar file
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Greg KH <gregkh@linuxfoundation.org>
Date: Thu, 27 Nov 2014 14:12:21 +1100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Nathan Fontenot <nfont@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Greg,

So Nathan is working on a patch series to cleanup and improve our
"DLPAR" infrastructure which is basically our hotplug mechanism when
running under the PowerVM (aka pHyp) and KVM hypervisors.

I'll let Nathan give you a bit more details/background and answer
subsequent question you might have as this is really his area of
expertise.

To cut a long story short, we need a sysfs file that allows our
userspace tools to notify the kernel of hotplug events coming from
the management console (which talks to userspace daemons using a
proprietary protocol) to "initiate" the hotplug operations, which in
turn get dispatched internally in the kernel to the right subsystem
(memory, cpu, pci, ...) based on the resource type.

On IRC, Greg suggested /sys/firmware and /sys/hypervisor which both
look like a reasonable option to me, probably better than dlpar...

Cheers,
Ben.
