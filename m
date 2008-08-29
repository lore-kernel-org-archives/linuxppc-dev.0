Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 4ADC4DDF79
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Aug 2008 16:34:43 +1000 (EST)
Date: Thu, 28 Aug 2008 23:34:36 -0700 (PDT)
Message-Id: <20080828.233436.142799161.davem@davemloft.net>
To: paulus@samba.org
Subject: Re: [PATCH 0/5] Relocatable 64-bit kernel using linker PIE support
From: David Miller <davem@davemloft.net>
In-Reply-To: <18615.35796.969180.162185@cargo.ozlabs.ibm.com>
References: <18594.14443.340604.693747@cargo.ozlabs.ibm.com>
	<1219925555.7107.276.camel@pmac.infradead.org>
	<18615.35796.969180.162185@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, dwmw2@infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Paul Mackerras <paulus@samba.org>
Date: Fri, 29 Aug 2008 15:40:36 +1000

> The main remaining substantial technical issue is how we detect very
> early on that we are a kdump kernel.  I think the policy should be
> that the kernel copies itself down to 0 if it's not a kdump kernel and
> runs wherever it was loaded if it's a kdump kernel.  The only way to
> tell whether we're a kdump kernel seems to be to look at the kernel
> command line, which is a little tricky to do in head_64.S when the
> command line is buried inside the DTB.

Why not put a key at a fixed location in the .text section or similar?
Then you can access it using PC relative addressing, and whatever
loads the kdump kernel can put an appropriate value there.
