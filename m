Message-ID: <003201bf82be$25a8a670$0a01010a@gamma>
From: "Damjan Lampret" <damjan.lampret@arnes.si>
To: "Dan Malek" <dan@netx4.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
References: <002601bf81dc$184f9480$0a01010a@gamma> <38B9E821.1E486142@netx4.com>
Subject: Re: Data TLB error exception
Date: Tue, 29 Feb 2000 15:06:16 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> Damjan Lampret wrote:
>
> > I am playing with 2.2.13 kernel on custom MPC860 board and I have a
problem
> > with DTLB error (1400h) exception. I downloaded my kernel via BDM and it
>
> BDMs with MMU and caches are a bad combination.  With the exception of
> KGDB, there are no debuggers that understand the Linux kernel once
> the MMU is enabled.  The debugger tools normally used with BDMs trap
> MMU exceptions as a "bad thing" or at least try to invoke some monitor
> support code that is supposed to reside in the kernel.
>

I use EST's VisionICE. I use it to download code and to check which
exceptions occur. Of course I also assumed that debugger is having problems
with exceptions so I disabled detection in DER but my target still hangs. I
am quite sure that visionICE is not executing any "monitor support" code.
Like most debuggers it does not support MMU so I need to add 0xc0000000 to
all addresses when analyzing kernel code.

> The MMUs and caches work fine on the 8xx processors when running
Linux/PPC.
> I have been running them all day, every day, for years and have several
> products deployed in the field without trouble.
>

Yes, apparently there is a problem running target with BDM and caches
enabled. As I said in my original email when I disabled caches target is
much more stable (but still hangs after a couple of minutes). Perhaps this
is still because of a debugger. Although I don't understand how a debugger
can harm target when target is not in debug mode (when running "real-time").

> If you are using BDMs for downloading Linux, that is all you can do with
> them.  Once the kernel executes the first few lines of code to enable

I do use it for downloading code.

> the MMU, you are done.  If you can't disable _all_ debugging from the
> BDM tool, including show cycles, you can't use it with Linux.
>

You can disable and I did. Target still hangs. What I don't understand is
why after DTLB error exception. Everytime I get machine check in data access
exception handler. I'll backtrace it and post my results to the list.

regards, Damjan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
