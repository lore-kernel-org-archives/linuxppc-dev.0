Return-Path: <prvs=8047ed68d=david.vrabel@citrix.com>
Received: from SMTP02.CITRIX.COM (smtp02.citrix.com [66.165.176.63])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A9BAD1A0174
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Jan 2016 22:43:00 +1100 (AEDT)
Message-ID: <568A5830.9000501@citrix.com>
Date: Mon, 4 Jan 2016 11:32:00 +0000
From: David Vrabel <david.vrabel@citrix.com>
MIME-Version: 1.0
To: "Michael S. Tsirkin" <mst@redhat.com>, <linux-kernel@vger.kernel.org>
CC: <linux-mips@linux-mips.org>, <linux-ia64@vger.kernel.org>,
 <linux-sh@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 <virtualization@lists.linux-foundation.org>, "H. Peter Anvin"
 <hpa@zytor.com>, <sparclinux@vger.kernel.org>, Boris Ostrovsky
 <boris.ostrovsky@oracle.com>, <linux-arch@vger.kernel.org>,
 <linux-s390@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 <x86@kernel.org>, <xen-devel@lists.xenproject.org>, Ingo Molnar
 <mingo@elte.hu>, <linux-xtensa@linux-xtensa.org>,
 <user-mode-linux-devel@lists.sourceforge.net>, Stefano Stabellini
 <stefano.stabellini@eu.citrix.com>,
 <adi-buildroot-devel@lists.sourceforge.net>, Thomas Gleixner
 <tglx@linutronix.de>, <linux-metag@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, Andrew Cooper
 <andrew.cooper3@citrix.com>, David Vrabel <david.vrabel@citrix.com>,
 <linuxppc-dev@lists.ozlabs.org>, David Miller <davem@davemloft.net>
Subject: Re: [Xen-devel] [PATCH v2 33/34] xenbus: use virt_xxx barriers
References: <1451572003-2440-1-git-send-email-mst@redhat.com>
 <1451572003-2440-34-git-send-email-mst@redhat.com>
In-Reply-To: <1451572003-2440-34-git-send-email-mst@redhat.com>
Content-Type: text/plain; charset="windows-1252"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 31/12/15 19:10, Michael S. Tsirkin wrote:
> drivers/xen/xenbus/xenbus_comms.c uses
> full memory barriers to communicate with the other side.
> 
> For guests compiled with CONFIG_SMP, smp_wmb and smp_mb
> would be sufficient, so mb() and wmb() here are only needed if
> a non-SMP guest runs on an SMP host.
> 
> Switch to virt_xxx barriers which serve this exact purpose.

Acked-by: David Vrabel <david.vrabel@citrix.com>

If you're feeling particularly keen there's a rmb() consume_one_event()
in drivers/xen/events/events_fifo.c that can be converted to virt_rmb()
as well.

David
