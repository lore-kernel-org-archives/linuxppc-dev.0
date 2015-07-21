Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E4E741A019D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2015 13:06:24 +1000 (AEST)
Message-ID: <1437447984.30722.3.camel@ellerman.id.au>
Subject: Re: [PATCH] Fix crash due to processing "memory-controller" nodes
 as "memory"
From: Michael Ellerman <mpe@ellerman.id.au>
To: Anton Blanchard <anton@samba.org>
Cc: Ian Munsie <imunsie@au1.ibm.com>, Benjamin Herrenschmidt
 <benh@au1.ibm.com>,  linuxppc-dev <linuxppc-dev@ozlabs.org>, Michael
 Neuling <michael.neuling@au1.ibm.com>, "sonal.santan"
 <sonal.santan@xilinx.com>, Jeremy Kerr <jk@ozlabs.org>, Samuel
 Mendoza-Jonas <sam.mj@au1.ibm.com>
Date: Tue, 21 Jul 2015 13:06:24 +1000
In-Reply-To: <20150721124554.332dd228@kryten>
References: <1437380450-25555-1-git-send-email-imunsie@au.ibm.com>
 <20150721124554.332dd228@kryten>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-07-21 at 12:45 +1000, Anton Blanchard wrote:
> Hi Ian,
> 
> > From: Ian Munsie <imunsie@au1.ibm.com>
> > 
> > If the system has a PCI device with a memory-controller device node,
> > kexec-lite would spew hundreds of double free warnings and eventually
> > segfault. This would result in a "kexec load failed" message from
> > petitboot.
> > 
> > This was due to kexec_memory_map() searching for "memory" nodes, but
> > actually matching any node that started with "memory", including these
> > "memory-controller" nodes. This patch changes the search to look for
> > nodes starting with "memory@", which should only match memory nodes.
> 
> Nice catch! I wonder if we should be checking for device_type
> "memory". Ben?

Yes. That's what Linux does.

cheers
