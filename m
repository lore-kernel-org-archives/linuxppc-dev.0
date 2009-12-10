Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de [212.227.17.9])
	by ozlabs.org (Postfix) with ESMTP id D7E37B6EFE
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 11 Dec 2009 07:32:43 +1100 (EST)
From: arnd@arndb.de
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: Floating point in the kernel
Date: Thu, 10 Dec 2009 20:32:36 +0000
References: <20091210131311.78cab78c@lappy.seanm.ca>
In-Reply-To: <20091210131311.78cab78c@lappy.seanm.ca>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <200912102032.36489.arnd@arndb.de>
Cc: Sean MacLennan <smaclennan@pikatech.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thursday 10 December 2009 18:13:11 Sean MacLennan wrote:
> One of our drivers has code that was originally running on a DSP. The
> code makes heavy use of floating point. We have isolated all the
> floating point to one kthread in the driver. Using enable_kernel_fp()
> this has worked well.
> 
> But under a specific heavy RTP load, we started getting kernel panics.
> To make a long story short, the scheduler disables FP when you are
> context switched out. When you come back and access a FP instruction,
> you trap and call load_up_fpu() and everything is fine..... unless you
> are in the kernel. If you are in the kernel, like our kthread is, you
> get a "kernel FP unavailable exception".

I think the rule here is that you have to disable preemption and must not
call any potentially blocking functions like kmalloc when enable_kernel_fp
is set. The kernel has good control over whether a thread get context switched
or not, so it should be able to prevent these problems.

	Arnd <><
