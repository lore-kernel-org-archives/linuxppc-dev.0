Date: Sat, 7 Sep 2002 08:29:25 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "Dayton, Dean" <deand@aiinet.com>
Cc: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Irq 0 problem
Message-ID: <20020907152925.GA917@opus.bloom.county>
References: <638AA0336D7ED411928700D0B7B0D75B0189BAFA@aimail.aiinet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <638AA0336D7ED411928700D0B7B0D75B0189BAFA@aimail.aiinet.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, Sep 06, 2002 at 01:32:12PM -0400, Dayton, Dean wrote:

> I have been trying to port Linux 2.4.18-pre2 to the MPC8266ADS board. I
> grabbed the SCC uart.c from 2.5.31.

Why did you grab a file from 2.5.31?  And is there any reason you aren't
using 2.4.18 final or 2.4.19 final instead ?

> The kernel loads and runs, the ramdisk is uncompressed and mounted. Then I
> take an interrupt with SIVEC=0. SIVEC is now 0 everytime it is read, this
> causes do_IRQ() to go into an endless loop.
[snip]
> -		if (irq >= 0)
> +		if (irq > 0)
> 			ppc_irq_dispatch_handler()
[snip]
> This appears to solve (or at least hide) my problem. Has anyone else run
> into this? I think it is occuring during the open of the console port (SCC
> 1). I ran into the same thing while trying to run on an EST8260 using an SMC
> as the console. Am I simply covering up a problem with a misconfigured
> device driver?

I think the problem is you're using a kernel which doesn't have the 8260
irq function updated to return -1 when there's nothing pending..  Can
you verify that this is a problem with 2.4.19 or 2.4.18 ?

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
