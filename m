Return-Path: <cfriesen@nortel.com>
Message-ID: <437A5049.9090308@nortel.com>
Date: Tue, 15 Nov 2005 15:16:57 -0600
From: "Christopher Friesen" <cfriesen@nortel.com>
MIME-Version: 1.0
To: linuxppc64-dev@ozlabs.org, linuxppc-embedded@ozlabs.org
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: modify the cache-inhibit and guard bits from userspace?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


We're running a dual-970 blade, based on a modified 2.6.10.

We have an application that does lots of random data fetches over a 
fairly large data set (a few GB) contained entirely in RAM, and the 
performance guys think that we may be spending time in unnecessary 
hardware prefetches and would like me to provide them a mechanism to 
individually specify the cache-inhibited and guard bits from userspace 
so that they can try to fine-tune their performance.

What's the most logical way for me to do this?  Do I extend mprotect() 
to support additional flags?

Has anyone done this before?  I didn't find anything in google. 
Currently the guard bit seems to only be used for ioremap() and in 
__pci_mmap_set_pgprot() if the memory doesn't support write combining.

Thanks,

Chris
