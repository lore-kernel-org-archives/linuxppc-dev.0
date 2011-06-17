Return-Path: <lists@gate-nine.de>
Received: from csmtp3.one.com (csmtp3.one.com [91.198.169.23])
	by ozlabs.org (Postfix) with ESMTP id 92F20B6FD6
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 17 Jun 2011 23:03:22 +1000 (EST)
Message-ID: <4DFB4F51.1090509@gate-nine.de>
Date: Fri, 17 Jun 2011 14:57:53 +0200
From: Philipp Ittershagen <lists@gate-nine.de>
MIME-Version: 1.0
To: Guillaume Dargaud <dargaud@lpsc.in2p3.fr>
Subject: Re: Changes to of_device ?
References: <201106171119.48178.dargaud@lpsc.in2p3.fr>
	<4DFB329A.7010104@gate-nine.de>
	<201106171322.19067.dargaud@lpsc.in2p3.fr>
In-Reply-To: <201106171322.19067.dargaud@lpsc.in2p3.fr>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/17/2011 01:22 PM, Guillaume Dargaud wrote:
>> Not answering your primary question here, but in order to print the most
>> recent tag (along with a uniqe suffix, see man page) that is reachable
>> from your current branch, you can use "git describe". It will print out
>> the kernel version on your latest Xilinx tree.
> 
> $ git describe
> v2.6.37-719-gecf08a4
> 
> $ cat ./include/linux/version.h
> #define LINUX_VERSION_CODE 132645
> #define KERNEL_VERSION(a,b,c) (((a) << 16) + ((b) << 8) + (c))
> 
> $ printf "%x\n" 132645
> 20625
> Something doesn't quite match here... 

It is hexadecimal. 0x25 = 37.

> But my original question about how do you declare a probe function in
> the latest kernels still stand...

The struct device_node was moved to struct device in order to make the
CONFIG_OF more generic. See

commit d706c1b050274b3bf97d7cb0542c0d070c9ccb8b
Author: Grant Likely <grant.likely@secretlab.ca>
Date:   Tue Apr 13 16:12:28 2010 -0700

    driver-core: Add device node pointer to struct device


Hope this helps,

  Philipp
