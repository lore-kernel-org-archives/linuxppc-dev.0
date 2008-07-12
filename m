Return-Path: <zippel@linux-m68k.org>
Received: from smtp-vbr9.xs4all.nl (smtp-vbr9.xs4all.nl [194.109.24.29])
	by ozlabs.org (Postfix) with ESMTP id 856E0DDE26
	for <linuxppc-dev@ozlabs.org>; Sun, 13 Jul 2008 09:21:44 +1000 (EST)
Date: Sun, 13 Jul 2008 01:21:08 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
To: Milton Miller <miltonm@bga.com>
Subject: Re: linux-next: kbuild tree build failure
In-Reply-To: <7b8dd1f1421b1f52ebc76565986fd2a9@bga.com>
Message-ID: <Pine.LNX.4.64.0807130057490.6791@localhost.localdomain>
References: <7b8dd1f1421b1f52ebc76565986fd2a9@bga.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	ppcdev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>,
	Sam Ravnborg <sam@ravnborg.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

On Sat, 12 Jul 2008, Milton Miller wrote:

> (1) #define PAGE_OFFSET    (ASM_CONST(CONFIG_PAGE_OFFSET) << 32)
> 
> It creates unreadable code, where two defines with almost the same name (the
> only difference being
> the CONFIG_ prefix, which is often ignored when scanning) contains radically
> different values.
> 
> (2)  #define PAGE_OFFSET    ASM_CONST(CONFIG_PAGE_OFFSET)

Giving it different names is not really difficult. Any objections to 
CONFIG_PAGE_HIGH_OFFSET?

> On a seperate note,
> > > > >  config PINT3_ASSIGN
> > > > >         hex "PINT3_ASSIGN"
> > > > >         depends on PINTx_REASSIGN
> > > > > -       default 0x02020303
> > > > > +       default 0x2020303
> 
> is harder to read.   The value is a list of 4 1 byte values, but you have
> hidden the first nibble making parsing the rest of the value hard.

Sam mentioned that already, but that's a situation where the warning can 
be relaxed.

> If you are worried about users tring to set values that are too high,
> then make the types be hex8, hex16, hex32, and hex64.

It's not this, I value consistency as much as you and the values are 
sometimes used as integers, so a working range is needed. Using simple 
integers keeps things much simpler and as the ASM_CONST example shows any 
bigger values are not necessarily directly usable anyway.

bye, Roman
