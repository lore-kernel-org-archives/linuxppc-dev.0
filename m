From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Kevin B. Hendricks" <kevin.hendricks@sympatico.ca>,
	<yellowdog-devel@lists.terrasoftsolutions.com>,
	<linuxppc-dev@lists.linuxppc.org>
Cc: <paulus@samba.org>
Subject: Re: funny kernel death with ksoftirqd_CPUX taking up almost 100% of
 cpu?
Date: Wed, 10 Jul 2002 18:11:26 +0200
Message-Id: <20020710161126.5349@192.168.4.1>
In-Reply-To: <200207101236.43005.kevin.hendricks@sympatico.ca>
References: <200207101236.43005.kevin.hendricks@sympatico.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>I just experienced an alarming form of kernel death running a self compiled
>SMP kernel with HIGHMEM enabled on my dual G4 -1gig machine.
>
>The kernel tree used is Ben's 2.4.19-pre10 one rebuilt for SMP support, aec
>IDE driver and otherwise basically stock.
>
>I was debugging in gdb a large program and noticed typing got slower and
>slower.  I quick check of top showed that ksoftirqd_CPU was taking up
>almost 100% of the cpu.  I exited out of gdb and killed every process I
>could think of but the usage of that kernel demaon stayed at near 100%.
>
>It became so bad I could barely perform a straight shutdown (I had to hit
>return numerous times to allow the other cpu to get some time to handle
>the shutdown.
>
>There were lots of messages like the following as I tried to shutdown:
>
> ../..
>
>Jul 10 11:57:36 localhost kernel: wait_on_irq, CPU 0:
>Jul 10 11:57:36 localhost kernel: irq:  -1 [0 0]
>Jul 10 11:57:36 localhost kernel: bh:   0 [0 0]
>Jul 10 11:57:37 localhost kernel:

Hrm... looks bad. global_irq_count got negative !

So either somebody is doing a mismatched hardirq_enter/leave
pair, which I seriously doubt, or our atomics are broken on
those machines (ugh !!!)

Paul, any good idea at hand ?

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
