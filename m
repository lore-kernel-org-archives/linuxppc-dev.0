Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rQrkJ5RhMzDqHY
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jun 2016 15:45:44 +1000 (AEST)
Message-ID: <1465537530.2948.51.camel@kernel.crashing.org>
Subject: Re: [PATCH v10 09/18] powerpc/powernv: Extend PCI bridge resources
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, Gavin Shan
 <gwshan@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
 mpe@ellerman.id.au, alistair@popple.id.au
Date: Fri, 10 Jun 2016 15:45:30 +1000
In-Reply-To: <fb22a56a-92fe-b12b-2f79-dc77e26fcc09@ozlabs.ru>
References: <1463726502-14679-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1463726502-14679-10-git-send-email-gwshan@linux.vnet.ibm.com>
 <9bd72b5a-c4c5-9ab7-7c82-cb4d7e8d51fd@ozlabs.ru>
 <20160610043349.GA17817@gwshan>
 <fb22a56a-92fe-b12b-2f79-dc77e26fcc09@ozlabs.ru>
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

On Fri, 2016-06-10 at 15:28 +1000, Alexey Kardashevskiy wrote:
> > Actually, it's likely caused by hardware defect
> > - we can't set 2GB (0x80000000 - 0xffffffff) to RC's memory window.
> > Otherwise, it *seems* the window is disabled. I tried updating the
> > window with (0x80000000 - 0xffefffff) or (0x80000000 - 0xffdffff), no
> > EEH error was seen. I already got 0x00001000 on read despite whatever
> > I wrote to 0x20 reg.
> > 
> > The hardware is broken. In order to fix this, I intend to include a
> > bitmap for every PHB device node in skiboot. Kernel uses this to apply
> > fixup accordingly. One bit is reserved on Garrison platform to avoid
> > this issue. The fix can be a patch inserted before this patch in next
> > revision
> 
> This sounds better as preserves bisectability. Thanks.

Ah yes they made those registers read-only. Look at my PHB4 code, I
implement a cache for them in SW.

Cheers,
Ben.
