Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de [212.227.17.10])
	by ozlabs.org (Postfix) with ESMTP id B7A7CB6F10
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Dec 2009 08:35:56 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: Floating point in the kernel
Date: Thu, 10 Dec 2009 22:35:47 +0100
References: <20091210131311.78cab78c@lappy.seanm.ca>
	<1260476379.16132.224.camel@pasglop>
	<20091210153359.3a480488@lappy.seanm.ca>
In-Reply-To: <20091210153359.3a480488@lappy.seanm.ca>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <200912102235.47985.arnd@arndb.de>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
	Sean MacLennan <smaclennan@pikatech.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thursday 10 December 2009, Sean MacLennan wrote:
> To be honest, I can't find why we are scheduling :( They only way we
> give up the CPU is with locking... and none of the locks where hit
> during the problem. We also never get near our timeslice... the longest
> run I saw when the problem happened was 670us. 
> 
> Is there a way to disable scheduling? We currently do not have preempt
> enabled... but may in the future.

If you do preempt_disable(), it should give you a nice oops with a backtrace
at the point where an actual schedule happens.

The sequence should be something like

preempt_disable();
enable_kernel_fp();
/* use FP here */
preempt_enable();
/* may schedule again */

	Arnd <><
