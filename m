Return-Path: <ldufour@linux.vnet.ibm.com>
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 702871A0514
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Aug 2015 07:53:55 +1000 (AEST)
Received: from /spool/local
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ldufour@linux.vnet.ibm.com>;
 Wed, 19 Aug 2015 22:53:52 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 44F0A219005C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Aug 2015 22:53:23 +0100 (BST)
Received: from d06av09.portsmouth.uk.ibm.com (d06av09.portsmouth.uk.ibm.com
 [9.149.37.250])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t7JLrn3n32571494
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Aug 2015 21:53:49 GMT
Received: from d06av09.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av09.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t7JLrmtQ008437
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Aug 2015 15:53:49 -0600
Message-ID: <55D4FAE9.7000504@linux.vnet.ibm.com>
Date: Wed, 19 Aug 2015 23:53:45 +0200
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>
CC: linuxppc-dev@lists.ozlabs.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jslaby@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/hvsi: Fix endianness issues in the HVSI driver
References: <1438334990-11765-1-git-send-email-ldufour@linux.vnet.ibm.com>
 <1438649494.9418.0.camel@ellerman.id.au>
In-Reply-To: <1438649494.9418.0.camel@ellerman.id.au>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/08/2015 02:51, Michael Ellerman wrote:
> On Fri, 2015-07-31 at 11:29 +0200, Laurent Dufour wrote:
>> This patch fixes several endianness issues detected when running the HVSI
>> driver in little endian mode.
>>
>> These issues are raised in little endian mode because the data exchanged in
>> memory between the kernel and the hypervisor has to be in big endian
>> format.
> 
> Can you include the sparse output before and after?

Hi Michael,

Here is the output message displayed on the console when the bug occurred:

[    0.000517] irq: (null) didn't like hwirq-0x1000a00 to VIRQ16 mapping
(rc=-22)
[    0.000578] hvsi_console_init: couldn't create irq mapping for 0x1000a00

With the patch is applied, the hvsi driver is initializing correctly and
no message is displayed, except the one saying the number of device the
hvsi driver has configured. For instance:
[    1.535783] HVSI: registered 1 devices

Cheers,
Laurent.
