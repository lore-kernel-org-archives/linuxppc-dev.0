Return-Path: <jwboyer@gmail.com>
Received: from ti-out-0910.google.com (ti-out-0910.google.com [209.85.142.184])
	by ozlabs.org (Postfix) with ESMTP id 0AE97DDFAB
	for <linuxppc-dev@ozlabs.org>; Sat, 23 Feb 2008 07:52:14 +1100 (EST)
Received: by ti-out-0910.google.com with SMTP id y6so427546tia.13
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Feb 2008 12:52:12 -0800 (PST)
Date: Fri, 22 Feb 2008 14:51:48 -0600
From: Josh Boyer <jwboyer@gmail.com>
To: Valentine Barshak <vbarshak@ru.mvista.com>
Subject: Re: [RFC][PATCH] PowerPC 4xx: ibm_newemac 440GX phy clock workaround.
Message-ID: <20080222145148.6fd418d7@weaponx>
In-Reply-To: <47BF1F6E.8050805@ru.mvista.com>
References: <20080221144617.GA19465@ru.mvista.com>
	<1203634340.10422.203.camel@pasglop>
	<47BF1F6E.8050805@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 22 Feb 2008 22:15:58 +0300
Valentine Barshak <vbarshak@ru.mvista.com> wrote:

> Benjamin Herrenschmidt wrote:
> > On Thu, 2008-02-21 at 17:46 +0300, Valentine Barshak wrote:
> >> The PowerPC 440GX Taishan board fails to reset EMAC3 (reset timeout error)
> >> and because of that it can't find PHY chip. The older ibm_emac driver had
> >> a workaround for that: the EMAC_CLK_INTERNAL/EMAC_CLK_EXTERNAL macros which
> >> toggle the Ethernet Clock Select bit in the SDR0_MFR register. This patch
> >> does the same for "ibm,emac-440gx" compatible chips.
> > 
> > The main problem is that will force clock on -all- EMACs ... which can
> > be a problem as they can be in probe at the same time. Might be worth
> > also adding a global mutex around that block.
> 
> I've tried to move clock selection inside the global emac_phy_map_lock 
> block. That works fine for 440GX.
> 
> > 
> > Also, would you mind having a look at the other workaround for the
> > similar bug?
> 
> OK, I'll add 440EP/440GR workaround, but I'm not sure if we need it for
> the currently supported boards. The older ibm_emac driver also has a 
> workaround for it on 405ep. This part uses CPC0 dcr registers. So, looks 
> like we'll have to search device tree for the CPC0 entry in ibm_newemac 
> driver, map dcr registers and select clock with dcr_read/write calls. 
> I've omitted the 405ep part, since there's currently no board supported.

I'll be doing a 405EP port for .26.

josh
