Date: Mon, 21 Jun 2004 16:29:21 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Kumar Gala <kumar.gala@freescale.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: WindRiver PowerQUICC III SBC8560 support.
Message-ID: <20040621232921.GD8561@smtp.west.cox.net>
References: <1087563278.19489.3156.camel@hades.cambridge.redhat.com> <205EB944-C12D-11D8-ACD7-000393DBC2E8@freescale.com> <1087827285.18627.66.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1087827285.18627.66.camel@hades.cambridge.redhat.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, Jun 21, 2004 at 03:14:46PM +0100, David Woodhouse wrote:

[snip]
> On SBC8560 we use external 16550s, and it matters.
>
> Actually, I think we should leave SERIAL_PORT_DFNS empty and use
> early_serial_setup() exclusively. I'd have done that but gen550_dbg.c
> doesn't use baud_base when gen550_init() is called; it uses whatever's
> in its own copy of rs_table.

That sounds like a bug.  Since we can't use a uart_port internally to
gen550_* (I believe at least, I haven't looked hard since late 2.5.x
days I suspect), we have to just know what fields might change.  Patch
happily reviewed. :)

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
