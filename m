Return-Path: <johnsoncheng@qnap.com.tw>
Received: from qnap.com.tw (unknown [211.75.85.27])
	by ozlabs.org (Postfix) with SMTP id 3386268048
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 23 Aug 2005 12:38:20 +1000 (EST)
From: "JohnsonCheng" <johnsoncheng@qnap.com.tw>
To: "'JohnsonCheng'" <johnsoncheng@qnap.com.tw>,
	"'Stefan Nickl'" <Stefan.Nickl@kontron.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <20050823022508.C583967F88@ozlabs.org>
Message-Id: <20050823023820.3386268048@ozlabs.org>
Cc: linuxppc-embedded@ozlabs.org
Subject: RE: How NEC uPD720101 USB chip work well on linux2.6.12
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>
Date: Tue, 23 Aug 2005 02:38:51 -0000

Correct it. 
I only turn on OHCI in kernel configuration, not UHCI.

Thanks,
Johnson Cheng

-----Original Message-----
From: linuxppc-embedded-bounces@ozlabs.org
[mailto:linuxppc-embedded-bounces@ozlabs.org] On Behalf Of JohnsonCheng
Sent: Saturday, July 23, 2005 10:24 AM
To: 'Stefan Nickl'
Cc: linuxppc-embedded@ozlabs.org
Subject: RE: How NEC uPD720101 USB chip work well on linux2.6.12

I tried this case before, only turn on UHCI option in kernel. The conclusion
is two USB port have the same result ( Kernel Oops), and another one has no
response. Do you know if I want to set these three USB port sharing the same
IRQ, where to modify it in kernel 2.6.12?

Thanks,
Johnson Cheng

-----Original Message-----
From: linuxppc-embedded-bounces@ozlabs.org
[mailto:linuxppc-embedded-bounces@ozlabs.org] On Behalf Of Stefan Nickl
Sent: Monday, August 22, 2005 9:55 PM
To: JohnsonCheng
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: How NEC uPD720101 USB chip work well on linux2.6.12

On Fri, 2005-07-22 at 20:26 +0800, JohnsonCheng wrote:
> Dear All,
>  
> 
> I use NEC uPD720101 USB chip, 2 OHCI and 1 EHCI, I also have turn on
> the following options in kernel menuconfig:
[...]
> [*] USB Support / EHCI HCD (USB 2.0) support
[...]
>  
> 
> But when I plug-in a USB mouse, then Kernel Oops..
> 
> I use MPC8241 CPU, and there are three USB ports sharing the same IRQ
> on my borad.

I recently came across similar trouble with a chip from this series, the
uPD720113 and another one in a off-the-shelf USB hub which I tried for
reference.
It may have been even the 101, but I'm not sure.

Anyways, I've also seen hard resets with 2.6.12 to 2.6.13-rc-something,
albeit in a x86-environment. The system would reset hard when plugging
something after the hub or the hub itself, in case of the 113 it crashed
100% as soon as the hub was attached or detected during bootup. With the
off-the-shelf hub, it was somewhat more random.

In my case, disabling the EHCI controller in the BIOS helped, so you may
try to disable the USB "2.0" support in the kernel config and see what
happens.
No problems running the system with only UHCI for some weeks now.

I've deferred this problem because Hi-Speed is not an issue to me now,
but I'd be curious to hear and test things if somebody had a take on
this.

Regards,

-- 
Stefan Nickl
Kontron Modular Computers


_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded


_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded
