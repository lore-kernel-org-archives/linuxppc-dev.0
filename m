Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41V3RX4X5PzF35g
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jul 2018 12:01:28 +1000 (AEST)
Date: Tue, 17 Jul 2018 12:01:19 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org
Subject: Re: [PATCH kernel] KVM: PPC: Expose userspace mm context id via
 debugfs
Message-ID: <20180717020119.GA11424@fergus>
References: <20180712073026.19463-1-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180712073026.19463-1-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jul 12, 2018 at 05:30:26PM +1000, Alexey Kardashevskiy wrote:
> This adds a debugfs entry with mm context id of a process which is using
> KVM. This id is an index in the process table so the userspace can dump
> that tree provided it is granted access to /dev/mem.

Is the main intention here to be able to look at the PTEs for the
process that owns the VM?  If so, that doesn't seem particularly
KVM-specific, so perhaps something under powerpc/ in debugfs would be
more appropriate.

Is the information in /proc/<pid>/pagemap sufficient for what you
need?

Also, this doesn't seem very useful if /dev/mem is unavailable or
restricted, as it is in most distros these days.

How about a file under debugfs where you can just read out the PTEs
for a given process?

Paul.
