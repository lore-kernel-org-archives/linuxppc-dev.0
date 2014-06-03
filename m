Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CE2211A0041
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Jun 2014 15:54:19 +1000 (EST)
Date: Tue, 3 Jun 2014 15:54:15 +1000
From: Paul Mackerras <paulus@samba.org>
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 4/4] powerpc/eeh: Avoid event on passed PE
Message-ID: <20140603055415.GA24370@iris.ozlabs.ibm.com>
References: <1400574612-19411-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1400574612-19411-5-git-send-email-gwshan@linux.vnet.ibm.com>
 <537B3B97.3020100@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <537B3B97.3020100@suse.de>
Cc: aik@ozlabs.ru, Gavin Shan <gwshan@linux.vnet.ibm.com>,
 kvm-ppc@vger.kernel.org, alex.williamson@redhat.com,
 qiudayu@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, May 20, 2014 at 01:25:11PM +0200, Alexander Graf wrote:
> 
> On 20.05.14 10:30, Gavin Shan wrote:
> >If we detects frozen state on PE that has been passed to guest, we
> >needn't handle it. Instead, we rely on the guest to detect and recover
> >it. The patch avoid EEH event on the frozen passed PE so that the guest
> >can have chance to handle that.
> >
> >Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> 
> How does the guest learn about this failure? We'd need to inject an error
> into it, no?
> 
> I think what you want is an irqfd that the in-kernel eeh code notifies when
> it sees a failure. When such an fd exists, the kernel skips its own error
> handling.

Well... we don't have irqfd support for book3s HV upstream yet.  The
way the current code is, we have to turn on GSI routing, which puts a
hard and relatively small limit on the hardware IRQ numbers we can use
as it uses a flat array indexed by hardware IRQ number.  Which is a
problem that I need to solve somehow, but it makes using an irqfd
unattractive in the short term.

Paul.
