From: Cort Dougan <cort@fsmlabs.com>
Date: Thu, 25 Jul 2002 11:55:40 -0600
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Matthew Locke <mlocke@mvista.com>,
	akuster <akuster@dslextreme.com>,
	linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: [RFC/Patch] 4xx idle loop
Message-ID: <20020725115540.L2276@host110.fsmlabs.com>
References: <20020725105336.F2276@host110.fsmlabs.com> <20020725162026.19919@192.168.4.1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020725162026.19919@192.168.4.1>; from benh@kernel.crashing.org on Thu, Jul 25, 2002 at 06:20:26PM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


That can be implemented within the arch_idle() for the given chip type.  If
6xx chips want to do some pmac specific idle it can have a table of its
own or look int ppc_md.board_specific_power_save.  On 4xx there may not
be a need for that so there's no need for the indirection.

The chip idle is invariant after the compile but the board specific idle
may or may not be so push that into the chip specific function.  That way
no indirection is forced on configurations that don't need it.

} Well, while I tend to agree with you on this, experience proved that
} slightly abusing the ppc_md. indirection somewhat helped make the
} code cleaner (read: more self-contained, less cruft, ...)
}
} Also, in this specific case, we might well want to have an machine
} specific power saving feature: I've had various tweaks in mind for
} powermac laptops that I never ended up implementing...

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
