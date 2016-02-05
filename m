Return-Path: <gregkh@linuxfoundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 376DA1A0193
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Feb 2016 09:29:38 +1100 (AEDT)
Date: Fri, 5 Feb 2016 14:29:36 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Phil Turmel <philip@turmel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, LKML <linux-kernel@vger.kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org
Subject: Re: Bisected Regression 4.3.5 => 4.4.1 booting HP ZBook in EFI mode
Message-ID: <20160205222936.GA7139@kroah.com>
References: <56B518C4.8030007@turmel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <56B518C4.8030007@turmel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Feb 05, 2016 at 04:48:52PM -0500, Phil Turmel wrote:
> Hello all,
> 
> I tried to get off of v4.3.x today by moving to v4.4.1.
> My laptop failed to boot -- stuck with the BIOS boot logo still
> showing.  I'm direct-booting a merged kernel & initramfs in
> EFI mode.
> 
> I bisected to badc688 "powerpc: Make {cmp}xchg* and their atomic_ versions fully ordered"
> which is upstream commit 81d7a329.
> 
> I'm stumped as to how that powerpc patch can affect my x86 laptop, an
> HP ZBook 17 w/ i7 processor & nouveau graphics, but it certainly
> does.  The bisect was stable and I confirmed by reverting it on
> top of the intended v4.4.1.

That's crazy, nothing should even be rebuilt if you revert that patch,
so I don't see how that could affect things here.

Can you verify that nothing does get rebuilt when you do this?

thanks,

greg k-h
