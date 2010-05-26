Return-Path: <dhowells@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id 28F6BB7D1A
	for <linuxppc-dev@ozlabs.org>; Wed, 26 May 2010 19:55:00 +1000 (EST)
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20100526065129.GA3746@in.ibm.com>
References: <20100526065129.GA3746@in.ibm.com>
	<20100525083055.342788418@linux.vnet.ibm.com>
	<20100525091356.GB29003@in.ibm.com>
	<1274787559_8162@mail4.comsite.net>
To: prasad@linux.vnet.ibm.com
Subject: Re: [Patch 1/4] Allow arch-specific cleanup before breakpoint
	unregistration
Date: Wed, 26 May 2010 10:54:41 +0100
Message-ID: <4250.1274867681@redhat.com>
Sender: dhowells@redhat.com
Cc: Michael Neuling <mikey@neuling.org>,
	Benjamin Herrenschmidt <benh@au1.ibm.com>, shaggy@linux.vnet.ibm.com,
	Frederic Weisbecker <fweisbec@gmail.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Millton Miller <miltonm@bga.com>, David Gibson <dwg@au1.ibm.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Alan Stern <stern@rowland.harvard.edu>, Paul Mackerras <paulus@samba.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Roland McGrath <roland@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

K.Prasad <prasad@linux.vnet.ibm.com> wrote:

> > My understanding is weak function definitions must appear in a different C
> > file than their call sites to work on some toolchains.
> > 
> 
> Atleast, there are quite a few precedents inside the Linux kernel for
> __weak functions being invoked from the file in which they are defined
> (arch_hwblk_init, arch_enable_nonboot_cpus_begin and hw_perf_disable to
> name a few).
> Moreover the online GCC docs haven't any such constraints mentioned.

I've seen problems in this area.  gcc sometimes inlines a weak function that's
in the same file as the call point.

David
