Return-Path: <gkurz@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rQsyv1t5bzDqPC
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jun 2016 16:41:43 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5A6cZ66027815
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jun 2016 02:41:40 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23fm51cvem-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jun 2016 02:41:40 -0400
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gkurz@linux.vnet.ibm.com>;
 Fri, 10 Jun 2016 07:41:37 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 63E5417D805A
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jun 2016 07:42:47 +0100 (BST)
Received: from d06av02.portsmouth.uk.ibm.com (d06av02.portsmouth.uk.ibm.com
 [9.149.37.228])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5A6favb23265442
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jun 2016 06:41:36 GMT
Received: from d06av02.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av02.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5A6fZ5u030419
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jun 2016 00:41:35 -0600
Date: Fri, 10 Jun 2016 08:41:32 +0200
From: Greg Kurz <gkurz@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 qemu-ppc@nongnu.org, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
Subject: Re: powerpc/pseries: start rtasd before PCI probing
In-Reply-To: <3rQr6w4ck4z9sBf@ozlabs.org>
References: <146399210850.26372.5857516772891352049.stgit@bahia.huguette.org>
 <3rQr6w4ck4z9sBf@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Message-Id: <20160610084132.380bfba6@bahia.huguette.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 10 Jun 2016 15:18:32 +1000 (AEST)
Michael Ellerman <mpe@ellerman.id.au> wrote:

> On Mon, 2016-23-05 at 08:28:28 UTC, Greg Kurz wrote:
> > A strange behaviour is observed when comparing PCI hotplug in QEMU, between
> > x86 and pseries. If you consider the following steps:
> > - start a VM
> > - add a PCI device via the QEMU monitor before the rtasd has started (for
> >   example starting the VM in paused state, or hotplug during FW or boot
> >   loader)
> > - resume the VM execution
> > 
> > The x86 kernel detects the PCI device, but the pseries one does not.
> > 
> > This happens because the rtasd kernel worker is currently started under
> > device_initcall, while PCI probing happens earlier under subsys_initcall.
> > 
> > As a consequence, if we have a pending RTAS event at boot time, a message
> > is printed and the event is dropped.
> > 
> > This patch moves all the initialization of rtasd to arch_initcall, which is
> > run before subsys_call: this way, logging_enabled is true when the RTAS
> > event pops up and it is not lost anymore.
> > 
> > The proc fs bits stay at device_initcall because they cannot be run before
> > fs_initcall.
> > 
> > Signed-off-by: Greg Kurz <gkurz@linux.vnet.ibm.com>
> > Tested-by: Thomas Huth <thuth@redhat.com>  
> 
> Has this been tested on PowerVM ?
> 
> cheers
> 

No but I shall do it.

Thanks for pointing this out.

--
Greg
