Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id AD9A0DDE00
	for <linuxppc-dev@ozlabs.org>; Fri, 16 May 2008 02:49:09 +1000 (EST)
Date: Thu, 15 May 2008 11:48:02 -0500
From: Scott Wood <scottwood@freescale.com>
To: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 2/2] ftrace: support for PowerPC
Message-ID: <20080515164802.GA2664@loki.buserror.net>
References: <20080515034942.109223655@goodmis.org>
	<20080515035918.896765954@goodmis.org>
	<20080514.222857.246967279.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080514.222857.246967279.davem@davemloft.net>
Cc: proski@gnu.org, a.p.zijlstra@chello.nl, sandmann@redhat.com, pq@iki.fi,
	linux-kernel@vger.kernel.org, rostedt@goodmis.org,
	linuxppc-dev@ozlabs.org, srostedt@redhat.com, paulus@samba.org,
	mingo@elte.hu
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, May 14, 2008 at 10:28:57PM -0700, David Miller wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
> Date: Wed, 14 May 2008 23:49:44 -0400
> 
> > +#ifdef CONFIG_FTRACE
> > +#ifdef CONFIG_DYNAMIC_FTRACE
> > +_GLOBAL(mcount)
> > +_GLOBAL(_mcount)
> > +	stwu	r1,-48(r1)
> > +	stw	r3, 12(r1)
> > +	stw	r4, 16(r1)
> > +	stw	r5, 20(r1)
> > +	stw	r6, 24(r1)
> > +	mflr	r3
> > +	stw	r7, 28(r1)
> > +	mfcr	r5
> > +	stw	r8, 32(r1)
> > +	stw	r9, 36(r1)
> > +	stw	r10,40(r1)
> > +	stw	r3, 44(r1)
> > +	stw	r5, 8(r1)
> 
> Yikes, that's really expensive.
> 
> Can't you do a tail call and let the function you end
> up calling do all the callee-saved register pops onto
> the stack?

The PPC32 ABI seems to (unfortunately) suggest that, with mcount, all
registers are callee-saved (except for the modifiable-during-function-linkage
registers like r0, r11, and r12) -- so mcount has to save the registers that
the callee won't (because they're normally volatile).

-Scott
