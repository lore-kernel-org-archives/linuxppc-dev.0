Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A238FB70FF
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  3 Feb 2011 09:29:31 +1100 (EST)
Subject: Re: BootX
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: kevin diggs <diggskevin38@gmail.com>
In-Reply-To: <AANLkTin+1pENJ_CNQGoPA=Hisv4qkJWCE01uyZEXipNu@mail.gmail.com>
References: <AANLkTikAVgH9-UQfrjoAJSemet5p_PxhxCdot8cChQu3@mail.gmail.com>
	<AANLkTim6v25Sam+E8Bo9za1q0GJqWZitgqR0KBuKCoWz@mail.gmail.com>
	<AANLkTik9ejmu2vE13f_nRZZMspU-LW4y2=74iczoXGNt@mail.gmail.com>
	<AANLkTikGK-7JspQMTiqjXcvoP1FVSt2gZJ9SRqGj=7DO@mail.gmail.com>
	<1296682842.2349.730.camel@pasglop>
	<AANLkTi=xM5qt4sic-YBD87Znt0vVOyX2yOyhODhtKNqC@mail.gmail.com>
	<AANLkTin+1pENJ_CNQGoPA=Hisv4qkJWCE01uyZEXipNu@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 03 Feb 2011 09:29:22 +1100
Message-ID: <1296685762.2349.739.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2011-02-02 at 16:09 -0600, kevin diggs wrote:
> Hi,
> 
> And one more thing:  Why does an SMP kernel (mesh compiled in an SMP
> enabled kernel) work?

Could be an alignment or timing problem, depending on random things the
alignment of some DMA data structures or timing of access might end up
being subtely different.
 
> What all does SMP do? If it matters, I'm voluntary preempt.
> 
> Is the DMA hardware in this thing used in any other system (I guess I
> mean both other computers and other sub-systems in this computer -
> does the 53c94 use it? The audio uses it, right?)?

The DBDMA engine is used in various Apple chips but with more or less HW
bugs in it :-)

To get some more info about the MESH, I suggest you google for a
document called "MacTech.pdf" (Macintosh Technology in the
Common Hardware Reference Platform).

This describes the "MacIO" chip that was designed by Apple for CHRP
machines, which is a successor of the Bandit chip which I think contains
the MESH on your machine. The basic IO cells like MESH are the same (tho
it's possible that the one you have contains more bugs).

Cheers,
Ben.
