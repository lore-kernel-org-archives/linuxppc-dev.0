Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1B0F41A03CA
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Apr 2015 21:26:16 +1000 (AEST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 684B414007F
 for <linuxppc-dev@ozlabs.org>; Sat, 25 Apr 2015 21:26:15 +1000 (AEST)
Message-ID: <1429961157.16571.43.camel@kernel.crashing.org>
Subject: Re: [PATCH 2/2] pci: Use Qemu created PCI device nodes
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Sat, 25 Apr 2015 21:25:57 +1000
In-Reply-To: <553B42EB.6080803@ozlabs.ru>
References: <1429700240-32373-2-git-send-email-nikunj@linux.vnet.ibm.com>
 <20150424213058.2889af29@thh440s> <553B42EB.6080803@ozlabs.ru>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Thomas Huth <thuth@redhat.com>,
 Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2015-04-25 at 17:31 +1000, Alexey Kardashevskiy wrote:
> We need BAR setup in 2 cases: when SLOF needs to boot from a PCI device 
> (and SLOF can do BAR setup) and when we do PCI hotplug - and BARs are set 
> by the guest, otherwise we hit races here (Michael Roth can tell more). So 
> as for today there is no reason for doing this in QEMU.

Doing BAR setup in the guest is a violation of PAPR though .... we do it now
to workaround bugs I believe but normally the BARs are expected to be owned
and setup by FW on a PAPR system.

Ben.
