In-Reply-To: <20040605002915.GA17603@gate.ebshome.net>
References: <20040605002915.GA17603@gate.ebshome.net>
Mime-Version: 1.0 (Apple Message framework v618)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <2E7C06A3-B893-11D8-92B4-000393DBC2E8@freescale.com>
Cc: <linuxppc-dev@lists.linuxppc.org>
From: Kumar Gala <kumar.gala@freescale.com>
Subject: Re: [RFC] Simple ioremap cache
Date: Mon, 7 Jun 2004 09:58:48 -0500
To: Eugene Surovegin <ebs@ebshome.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> I have several questions on how we can enhance my simple hack so it
> can be
> acceptable into mainline:
>
> 0) Do we really need such stuff in mainline :) ?

I see no reason, its helpful for a number of embedded archs (4xx, 8xx,
e500)

> 1) Should this feature be enabled for all ppc32 archs or only for 4xx?
> I
> made ioremap profile for 2.6.6 kernel running on my G4 Powerbook and
> haven't noticed a lot of ioremap regions overlap (there was one
> instance where
> my patch would have helped if I've increased cache size to 32 entries).

This may be due to use of BATs on PPC Classic.

> 2) Should we cache allocation bigger than 4K? From Ebony and tipb
> profiles it
> doesn't seem advantogeous. Maybe other CPUs can benefit from the
> bigger sizes.

I think 4K is reasonable, I think this optimization is mainly for PPCs
w/ integrated periphs.

> 3) Should cache size (currently hardcoded to 10 entries) be made
> configurable?

Seems pointless to make it proper kernel config param.  If someone
wants to change it they can always change the code themselves for there
purposes.

- kumar


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
