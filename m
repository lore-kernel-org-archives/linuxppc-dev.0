From: Benjamin Herrenschmidt <bh40@calva.net>
To: Gabriel Paubert <paubert@iram.es>,
        linuxppc-dev
 <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Platform configuration (was: Re: CONFIG_PPC != Mac)
Date: Thu, 31 Aug 2000 18:22:09 +0200
Message-Id: <20000831162209.31786@mailhost.mipsys.com>
In-Reply-To: <Pine.HPX.4.10.10008311753590.15978-100000@gra-ux1.iram.es>
References: <Pine.HPX.4.10.10008311753590.15978-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>First, kernel compile times are only fairly large after a big update, when
>I do `make dep clean zImage'. Second, the proportion of time spend in the
>specific PPC code (mostly arch/ppc and drivers/macintosh) is rather small.
>Third, building a minimal kernel image for each machine would involve a
>ton (and that's an undrestatement) of kernel options: CONFIG_INTC_8259,
>CONFIG_INTC_POWERMAC, CONFIG_INTC_OPENPIC and others for the interrupt
>controllers, half a dozen or so CONFIG_RTC types, same for CONFIG_NVRAM
>and a few other things I surely forget. The only reasonable solution is to
>aim for the smallest runtime kernel image.

Well, an easy first step is to have those per-machine cumulative compile
options so you can choose pmac only, pmac+chrp, etc...

That's only a few more config stuffs (CONFIG_PPC_PMAC, CONFIG_PPC_PREP,
etc...), the core code wouldn't need to change. We can even optimize the
various if (_machine == xxxx) using maros that get resolved to a constant
when only one machine type is compiled in.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
