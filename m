Reply-To: <fabidi@ultsol.com>
From: "Fahd Abidi" <fabidi@ultsol.com>
To: "'Marco Schramel'" <Schramel.Linux@go.bartec.de>
Cc: "'PPC_LINUX'" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: BDI kernel debug
Date: Wed, 7 Jul 2004 09:07:35 -0400
Message-ID: <81C69D96BDD30640952C7A404004AA2501AA21@h0007e95d9fa7.ne.client2.attbi.com>
In-Reply-To: <81C69D96BDD30640952C7A404004AA250C2CA8@h0007e95d9fa7.ne.client2.attbi.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Ok,

Then check /linuxroot/arch/ppc/kernel/head.S, do a search for
CONFIG_BDI_SWITCH. Make sure the option is valid and that the pgtables do
indeed get updated. If the switch is valid then probably something else is
wrong.

Check to make sure that the PGTABLE base is at 0x000000f0 and that is what
you have set it to in your BDI config file. The BDI config file has to match
what you have in head.S.

You can also manually update the Page Tables by entering the address of
swapper_pg_dir into the location 0x000000f8. Do this update from the BDI
right before the instruction that causes the SIGSTOP. This should resolve
the problem.

Fahd

-----Original Message-----
From: Marco Schramel [mailto:Schramel.Linux@go.bartec.de]
Sent: Wednesday, July 07, 2004 6:53 AM
Subject: Re: BDI kernel debug

thank you for your answer

> Please look online at the Ultimate Solutions website, I documented
> this issue a little while ago, http://www.ultsol.com/faq-P305.htm.
> Wolfgang made the right suggestion, using BDI_CONFIG_SWITCH will cure
> this problem.

But my kernel has this option.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
