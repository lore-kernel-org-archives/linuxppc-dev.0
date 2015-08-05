Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B8A3A1A1CFF
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Aug 2015 12:31:11 +1000 (AEST)
Date: Tue, 4 Aug 2015 21:30:57 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, mikey@neuling.org
Subject: Re: powerpc: Add an inline function to update HID0
Message-ID: <20150805023057.GT11083@gate.crashing.org>
References: <1438677058-12883-1-git-send-email-ego@linux.vnet.ibm.com>
 <20150804100858.1F272140306@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150804100858.1F272140306@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Aug 04, 2015 at 08:08:58PM +1000, Michael Ellerman wrote:
> > +static inline void update_hid0(unsigned long hid0)
> > +{
> > +	/*
> > +	 *  The HID0 update should at the very least be preceded by a
> > +	 *  a SYNC instruction followed by an ISYNC instruction
> > +	 */
> > +	mb();
> > +	mtspr(SPRN_HID0, hid0);
> > +	isync();
> 
> That's going to turn into three separate inline asm blocks, which is maybe a
> bit unfortunate. Have you checked the generated code is what we want, ie. just
> sync, mtspr, isync ?

The "mb()" is not such a great name anyway: you don't want a memory
barrier, you want an actual sync instruction ("sync 0", "hwsync",
whatever the currently preferred spelling is).

The function name should also say this is for POWER8 (the required
sequences are different for some other processors; and some others
might not even _have_ a HID0, or not at 1008).  power8_write_hid0
or such?

For writing it as one asm, why not just

  asm volatile("sync ; mtspr %0,%1 ; isync" : : "i"(SPRN_HID0), "r"(hid0));

instead of the stringify stuff?


Segher
