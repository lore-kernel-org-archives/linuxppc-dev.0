Subject: Re: set_rtc_time() cleanup / normalization
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gabriel Paubert <paubert@iram.es>
Cc: Wolfgang Denk <wd@denx.de>, Dan Malek <dan@embeddededge.com>,
	Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20030515184412.GA22327@iram.es>
References: <20030515180427.GB20958@iram.es>
	 <20030515182129.270C0C6092@atlas.denx.de>  <20030515184412.GA22327@iram.es>
Content-Type: text/plain
Message-Id: <1053027458.2978.60.camel@gaston>
Mime-Version: 1.0
Date: 15 May 2003 21:37:39 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 2003-05-15 at 20:44, Gabriel Paubert wrote:

> Hmm, in this case. My current plan is to implement the documented
> behaviour, whatever it takes (time, among other things), since
> I am deeply convinced that it is the correct behaviour.
>
> So far, all the arguments that I've seen in favor of removing
> thos code boil down to the fact that developers are too lazy
> to implement it correctly.

Ok, so here are my concerns, if you can address them cleanly, I'm
ok with that ;)

I want things like PMU or Cuda based RTC (or i2c based one) to
be able to schedule in get/set_rtc_time(), thus those shouldn't be
called at interrupt time. Maybe a flag "rtc_irq_safe" in ppc_md that
when clear would cause you to defer processing to a work queue ? Or
maybe we can simply unconditionally defer ?

We need also to move the initial reading of the RTC a bit later
in the boot process, I'm not too sure what would happen if we
schedule that early, and we may want to wait for things like i2c
to be available.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
