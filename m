Content-Type: text/plain;
  charset="iso-8859-1"
From: "Kevin B. Hendricks" <kevin.hendricks@sympatico.ca>
To: yellowdog-devel@lists.terrasoftsolutions.com,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: funny kernel death with ksoftirqd_CPUX taking up almost 100% of cpu?
Date: Wed, 10 Jul 2002 13:20:43 -0400
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <200207101236.43005.kevin.hendricks@sympatico.ca>
In-Reply-To: <200207101236.43005.kevin.hendricks@sympatico.ca>
MIME-Version: 1.0
Message-Id: <200207101320.43818.kevin.hendricks@sympatico.ca>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

If it matters at all the kernel was compiled with Franz's gcc 3.1-1a rpm
from his site on PenguinPPC.org

I have been tracking a problem with how structures that are inheritied
seemed to be aligned differntly then under gcc 2.95.4.

Kevin

On July 10, 2002 12:36, Kevin B. Hendricks wrote:
> Hi,
>
> I just experienced an alarming form of kernel death running a self
> compiled SMP kernel with HIGHMEM enabled on my dual G4 -1gig machine.
>
> The kernel tree used is Ben's 2.4.19-pre10 one rebuilt for SMP support,
> aec IDE driver and otherwise basically stock.
>
> I was debugging in gdb a large program and noticed typing got slower and
> slower.  I quick check of top showed that ksoftirqd_CPU was taking up
> almost 100% of the cpu.  I exited out of gdb and killed every process I
> could think of but the usage of that kernel demaon stayed at near 100%.
>
> It became so bad I could barely perform a straight shutdown (I had to
> hit return numerous times to allow the other cpu to get some time to
> handle the shutdown.
>
> There were lots of messages like the following as I tried to shutdown:
>
> Jul 10 11:56:24 localhost kernel: Serial port locked ON by debugger !
> Jul 10 11:56:24 localhost kernel:
> Jul 10 11:56:24 localhost kernel: wait_on_irq, CPU 0:
> Jul 10 11:56:24 localhost kernel: irq:  -1 [0 0]
> Jul 10 11:56:24 localhost kernel: bh:   0 [0 0]
> Jul 10 11:57:13 localhost kernel:
> Jul 10 11:57:13 localhost kernel: wait_on_irq, CPU 0:
> Jul 10 11:57:13 localhost kernel: irq:  -1 [0 0]
> Jul 10 11:57:13 localhost kernel: bh:   0 [0 0]
> Jul 10 11:57:31 localhost kernel:
> Jul 10 11:57:31 localhost kernel: wait_on_irq, CPU 0:
> Jul 10 11:57:31 localhost kernel: irq:  -1 [0 0]
> Jul 10 11:57:31 localhost kernel: bh:   0 [0 0]
> Jul 10 11:57:36 localhost kernel:
> Jul 10 11:57:36 localhost kernel: wait_on_irq, CPU 0:
> Jul 10 11:57:36 localhost kernel: irq:  -1 [0 0]
> Jul 10 11:57:36 localhost kernel: bh:   0 [0 0]
> Jul 10 11:57:37 localhost kernel:
> ...
>
> But I was able to finally get it to shutdown properly and it seems to
> have rebooted fine.
>
> Anyone with any ideas of what just hit me?  Anything I should do next
> time it happens (the were no relevant message in the /var/log/messages/
> that might indicate a problem excpet for the lines I quoted above.
>
> Any help would be greatly appreciated.
>
> Thanks,
>
> Kevin
>
>
> _______________________________________________
> yellowdog-devel mailing list
> yellowdog-devel@lists.terrasoftsolutions.com
> http://lists.terrasoftsolutions.com/mailman/listinfo/yellowdog-devel


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
