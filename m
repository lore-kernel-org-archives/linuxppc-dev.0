Return-Path: <Geoffrey.Levand@am.sony.com>
Message-ID: <4612D8FE.1070400@am.sony.com>
Date: Tue, 03 Apr 2007 15:45:18 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [Cbe-oss-dev] [PATCH] Ignore memory listed in PS3 device tree
References: <1175208237.3122.78.camel@pmac.infradead.org>	
	<26babf7b7398794f08e7417377b3facc@kernel.crashing.org>	
	<1175473220.3144.1.camel@concordia.ozlabs.ibm.com>	
	<432af8a0f928491e7d376923829f40a0@kernel.crashing.org>	
	<1175568133.16182.15.camel@concordia <4612C48F.9080805@am.sony.com>
	<1175636904.10567.8.camel@shinybook.infradead.org>
In-Reply-To: <1175636904.10567.8.camel@shinybook.infradead.org>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, nhorman@redhat.com,
	cbe-oss-dev <cbe-oss-dev@ozlabs.org>, Ben Collins <ben.collins@ubuntu.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Woodhouse wrote:
> On Tue, 2007-04-03 at 14:18 -0700, Geoff Levand wrote:
>> I'm in the middle of implementing the zImage and kexec support for the
>> 2.6.21 kernel, but haven't pushed all of it out to ps3-linux.git yet.
>> Once that is done, there is little need for a 2.6.16 based bootloader,
>> since it would be just as well to use a recent kernel.

> But to go back to the unanswered question.... why _did_ we change from
> having the memory in the device-tree, to dynamically querying for it?

There are several points here I feel need explanation.  One is that memory
is a dynamic resource allocated by the HV, so it needs to be managed as a
dynamic resource by the guest OS.  Another point is that the HV has two
types of memory; boot memory, and virtual memory.  Boot memory is what will
be in is in the DT when I finish the zImage implementation.  Virtual memory
is what I currently have as hotplug memory.

So there are really two answers, one is that having the boot memory in the
DT hasn't changed, I just haven't finished that part yet.  The other is that
we get the amount of memory at runtime because it is a dynamic resource, and
cannot be known at DT compile time.  It is just by some luck that the 2.6.16
kernel continues to work correctly on the PS3, but it is not guaranteed to,
and has a good chance of failing on non-ps3 systems that use the lv1 hypervisor.

-Geoff
