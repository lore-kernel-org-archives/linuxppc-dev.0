Date: Thu, 20 Jun 2002 08:50:26 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Armin Kuster <akuster@mvista.com>,
	linuxppc-embedded@lists.linuxppc.org,
	David Gibson <david@gibson.dropbear.id.au>
Subject: Re: Trivial cleanup in ocp_uart.c
Message-ID: <20020620155026.GE16052@opus.bloom.county>
References: <20020620073440.GC20689@zax>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020620073440.GC20689@zax>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Jun 20, 2002 at 05:34:40PM +1000, David Gibson wrote:

> ocp_uart.c allocates private space with ocp_alloc_dev, but never uses
> it.

Er...  So you pass 0 to ocp_alloc_dev() ?  Which will allocate
(sizeof(*ocp_dev) + 0 + 31), so we don't actually break out of this
loop which I take it was your intent.

And I think it can be used, once it gets registered to the ocp_list (and
something later accesses it).

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
