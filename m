Subject: Re: [PATCH] Take two of the new serial uart driver.
From: David Woodhouse <dwmw2@infradead.org>
To: Pantelis Antoniou <panto@intracom.gr>
Cc: Tom Rini <trini@kernel.crashing.org>,
	Kumar Gala <kumar.gala@motorola.com>,
	Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <40BF3206.8030705@intracom.gr>
References: <40BF3206.8030705@intracom.gr>
Content-Type: text/plain
Message-Id: <1086426744.4588.121.camel@imladris.demon.co.uk>
Mime-Version: 1.0
Date: Sat, 05 Jun 2004 10:12:24 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, 2004-06-03 at 17:13 +0300, Pantelis Antoniou wrote:
> Hi
>
> The following patch updates the new CPM1/CPM2 uart driver.

It seems to lose queued characters from the kernel output when userspace
/dev/console is first opened. Should you drain the FIFO before resetting
the hardware on open? Or indeed refrain from resetting the hardware if
you're not actually changing anything?

This is with console on ttyCPM0 == SMC1. SysRq is also non-functional.

--
dwmw2


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
