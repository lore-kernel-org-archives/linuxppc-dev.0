From: benh@kernel.crashing.org
To: Ani Joshi <ajoshi@shell.unixbox.com>, Olaf Hering <olh@suse.de>
Cc: Stefan Jeglinski <jeglin@4pi.com>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: ATI 7000 and dual-monitor X? (was Re: 9600 maturity?)
Date: Wed, 17 Apr 2002 02:57:38 +0100
Message-Id: <20020417015738.27668@mailhost.mipsys.com>
In-Reply-To: <Pine.BSF.4.44.0204162227560.49666-100000@shell.unixbox.com>
References: <Pine.BSF.4.44.0204162227560.49666-100000@shell.unixbox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>> It is a VE, but I have one report where it fails on a 9600, after
>> loading vgahw.a or something like that. Maybe it must go into another
>> slot or the guy has to boot without video=ofonly.
>> More details later..
>
>
>This is most likely the perennial multiple PCI bus ISA IO problem in
>userland that plagues many Macs.  I won't go into the discussion again of
>why this is a problem, as this has been discussed here many times (see old
>posts about this problem on G4's), but a quick solution may be to put the
>card in the 1st slot, or whichever slot corresponds to the io_base
>syscall.  I have never used a 9600 so ask around which slot this is.
>
>Also, have you tried radeonfb?

Note that the issue can be worse on older Macs. Newer ones can actually
issue low-addresses IOs on each bus, older ones (dual Bandit ones), afaik,
can't. The second bus is physically mapped after the first one on these.

The PCI domain patch should, ultimately, fix the problem for machine that
can issue those IOs (that is mostly uninorth based machines).

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
