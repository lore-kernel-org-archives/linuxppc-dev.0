Date: Tue, 4 Mar 2003 23:47:43 -0800
From: Chris Zimman <chris@cryptoapps.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: 824x EUMB/UART move problem
Message-ID: <20030305074743.GA7814@mail.cryptoapps.com>
Reply-To: Chris Zimman <chris@cryptoapps.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I'm looking at the EUMB move/UART problem right now.  I don't see
that there's currently a clean way to deal with the fact that the EUMB
has moved and ppc_md.progress() is supposed to be called right after
the fact.

There are some obvious hacks that can be used to get around this, but
I'm looking for a clean method.

A callback could be added right after the EUMB move to update the base
addresses in serial_state.  machdep_calls doesn't have a callback for
this right now.  feature_call() could be used, but maybe this deserves
a callback of its own?

In mpc10x_common.c, something like:

	/* Set base addr of the 8240/107 EUMB.  */
	early_write_config_dword(hose,
				 0,
				 PCI_DEVFN(0,0),
				 MPC10X_CFG_EUMBBAR,
				 phys_eumb_base);

	if (ppc_md.eumb_uart_update)
		ppc_md.eumb_uart_update(phys_eumb_base);

Has someone already dealt with this and I've somehow missed it?

--Chris

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
