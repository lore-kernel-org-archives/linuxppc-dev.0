Message-ID: <38B9E821.1E486142@netx4.com>
Date: Sun, 27 Feb 2000 22:14:41 -0500
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Damjan Lampret <damjan.lampret@arnes.si>
CC: linuxppc-embedded@lists.linuxppc.org,
        Jurkas Vasja RDSS <jurkas@iskratel.si>
Subject: Re: Data TLB error exception
References: <002601bf81dc$184f9480$0a01010a@gamma>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Damjan Lampret wrote:

> I am playing with 2.2.13 kernel on custom MPC860 board and I have a problem
> with DTLB error (1400h) exception. I downloaded my kernel via BDM and it

BDMs with MMU and caches are a bad combination.  With the exception of
KGDB, there are no debuggers that understand the Linux kernel once
the MMU is enabled.  The debugger tools normally used with BDMs trap
MMU exceptions as a "bad thing" or at least try to invoke some monitor
support code that is supposed to reside in the kernel.

The MMUs and caches work fine on the 8xx processors when running Linux/PPC.
I have been running them all day, every day, for years and have several
products deployed in the field without trouble.

If you are using BDMs for downloading Linux, that is all you can do with
them.  Once the kernel executes the first few lines of code to enable
the MMU, you are done.  If you can't disable _all_ debugging from the
BDM tool, including show cycles, you can't use it with Linux.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
