Return-Path: <ego@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A71241A0148
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Aug 2015 16:54:11 +1000 (AEST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Wed, 5 Aug 2015 00:54:08 -0600
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 25EE219D803E
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Aug 2015 00:45:03 -0600 (MDT)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t756rBDq47120606
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 4 Aug 2015 23:53:11 -0700
Received: from d03av01.boulder.ibm.com (localhost [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t756s4PI025492
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Aug 2015 00:54:05 -0600
Date: Wed, 5 Aug 2015 12:24:00 +0530
From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, mikey@neuling.org
Subject: Re: powerpc: Add an inline function to update HID0
Message-ID: <20150805065400.GA14701@in.ibm.com>
Reply-To: ego@linux.vnet.ibm.com
References: <1438677058-12883-1-git-send-email-ego@linux.vnet.ibm.com>
 <20150804100858.1F272140306@ozlabs.org>
 <20150805023057.GT11083@gate.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150805023057.GT11083@gate.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Segher,

Thanks for the suggestions. I will rename the function to
update_power8_hid0() and use asm volatile.


On Tue, Aug 04, 2015 at 09:30:57PM -0500, Segher Boessenkool wrote:
> On Tue, Aug 04, 2015 at 08:08:58PM +1000, Michael Ellerman wrote:
> > > +static inline void update_hid0(unsigned long hid0)
> > > +{
> > > +	/*
> > > +	 *  The HID0 update should at the very least be preceded by a
> > > +	 *  a SYNC instruction followed by an ISYNC instruction
> > > +	 */
> > > +	mb();
> > > +	mtspr(SPRN_HID0, hid0);
> > > +	isync();
> > 
> > That's going to turn into three separate inline asm blocks, which is maybe a
> > bit unfortunate. Have you checked the generated code is what we want, ie. just
> > sync, mtspr, isync ?
> 
> The "mb()" is not such a great name anyway: you don't want a memory
> barrier, you want an actual sync instruction ("sync 0", "hwsync",
> whatever the currently preferred spelling is).
> 
> The function name should also say this is for POWER8 (the required
> sequences are different for some other processors; and some others
> might not even _have_ a HID0, or not at 1008).  power8_write_hid0
> or such?
> 
> For writing it as one asm, why not just
> 
>   asm volatile("sync ; mtspr %0,%1 ; isync" : : "i"(SPRN_HID0), "r"(hid0));
> 
> instead of the stringify stuff?
> 
> 
> Segher
> 

--
Thanks and Regards
gautham.
