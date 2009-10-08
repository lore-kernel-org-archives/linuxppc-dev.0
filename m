Return-Path: <a.p.zijlstra@chello.nl>
Received: from viefep12-int.chello.at (viefep12-int.chello.at [62.179.121.32])
	by ozlabs.org (Postfix) with ESMTP id 7C9F0B7B65
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  8 Oct 2009 21:37:24 +1100 (EST)
Subject: Re: [v8 PATCH 2/8]: cpuidle: implement a list based approach to
	register a set of idle routines.
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: arun@linux.vnet.ibm.com
In-Reply-To: <20091008095027.GC20595@linux.vnet.ibm.com>
References: <20091008094828.GA20595@linux.vnet.ibm.com>
	<20091008095027.GC20595@linux.vnet.ibm.com>
Content-Type: text/plain
Date: Thu, 08 Oct 2009 12:36:02 +0200
Message-Id: <1254998162.26976.270.camel@twins>
Mime-Version: 1.0
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
	linuxppc-dev@lists.ozlabs.org, Arjan van de Ven <arjan@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2009-10-08 at 15:20 +0530, Arun R Bharadwaj wrote:
> * Arun R Bharadwaj <arun@linux.vnet.ibm.com> [2009-10-08 15:18:28]:
> 
> Implement a list based registering mechanism for architectures which
> have multiple sets of idle routines which are to be registered.
> 
> Currently, in x86 it is done by merely setting pm_idle = idle_routine
> and managing this pm_idle pointer is messy.
> 
> To give an example of how this mechanism works:
> In x86, initially, idle routine is selected from the set of poll/mwait/
> c1e/default idle loops. So the selected idle loop is registered in cpuidle
> as one idle state cpuidle devices. Once ACPI comes up, it registers
> another set of idle states on top of this state. Again, suppose a module
> registers another set of idle loops, it is added to this list.
> 
> This provides a clean way of registering and unregistering idle state
> routines.

So cpuidle didn't already have a list of idle functions it takes an
appropriate one from?

Then what does this governor do?

Also, does this imply the governor doesn't consider these idle routines?
