Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xj1Qf2HRzzDqMY
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Aug 2017 20:07:38 +1000 (AEST)
Date: Wed, 30 Aug 2017 19:45:17 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, agraf@suse.com
Subject: Re: [PATCH RFC] powerpc: Implements MMIO emulation for lvx/stvx
 instructions
Message-ID: <20170830094517.GA12592@fergus.ozlabs.ibm.com>
References: <1504045082-16178-1-git-send-email-joserz@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1504045082-16178-1-git-send-email-joserz@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Aug 29, 2017 at 07:18:01PM -0300, Jose Ricardo Ziviani wrote:
> Hello!
> 
> This patch implements MMIO emulation for two instructions: lvx and stvx. I started to implement other instructions but I'd like to have this reviewed beforehand because this is my first patch here and I'll certainly have some rework/fixes :-).
> 
> Note: stvx is only storing 8 bytes, for some reason the code "vcpu->arch.paddr_accessed += run->mmio.len;", which adds the 8-byte offset after the first write is not making any difference (interesting that it works for load operations). I'm still investigating it but any idea about it will be appreciated.

The run structure is mmapped by userspace (i.e. QEMU) and can be
written by userspace between the first and the second exits to
userspace (you have to do two exits to userspace because you can only
transfer 8 bytes on each exit).  It's possible that userspace might be
clearing run->mmio.len.  In general it's better not to rely on
anything in *run (except of course the mmio_data for a MMIO read) when
we come in from userspace to the kernel.

Paul.
