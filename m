Return-Path: <mita@miraclelinux.com>
Received: from mail01.miraclelinux.com (ns.miraclelinux.com [219.118.163.66])
	by ozlabs.org (Postfix) with ESMTP id 177CA68A8D
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jan 2006 14:49:58 +1100 (EST)
Date: Thu, 26 Jan 2006 12:50:04 +0900
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Subject: Re: [PATCH 5/6] fix warning on test_ti_thread_flag()
Message-ID: <20060126035004.GA11543@miraclelinux.com>
References: <Pine.LNX.4.62.0601251814350.19174@pademelon.sonytel.be>
	<200601252002.k0PK2Mg31276@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200601252002.k0PK2Mg31276@unix-os.sc.intel.com>
From: mita@miraclelinux.com (Akinobu Mita)
Cc: linux-m68k@vger.kernel.org, linux-ia64@vger.kernel.org,
	ultralinux@vger.kernel.org,
	Linux Kernel Development <linux-kernel@vger.kernel.org>,
	Andi Kleen <ak@suse.de>, Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	'Geert Uytterhoeven' <geert@linux-m68k.org>,
	sparclinux@vger.kernel.org, linux390@de.ibm.com,
	linuxsh-dev@lists.sourceforge.net, parisc-linux@parisc-linux.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jan 25, 2006 at 12:02:21PM -0800, Chen, Kenneth W wrote:
> Geert Uytterhoeven wrote on Wednesday, January 25, 2006 9:19 AM
> > > I don't think you need to change the flags size.
> > 
> > Passing a pointer to a 32-bit entity to a function that takes a
> > pointer to a 64-bit entity is a classical endianness bug. So it's
> > better to change it, before people copy the code to a big endian
> > platform.
> 
> Well, x86-64 and linux-ia64 both use little endian.  I don't
> understand why you are barking at us with big endian issue.
> 

I can fix this without changing the flags size for those architectures.

1. Introduce *_le_bit() bit operations which takes void *addr
   (already I have these functions in the scope of
    HAVE_ARCH_EXT2_NON_ATOMIC_BITOPS in my patch)

2. Change flags to __u8 flags[4] or __u8 flags[8] for each architectures.

3. Use *_le_bit() in include/linux/thread_info.h
