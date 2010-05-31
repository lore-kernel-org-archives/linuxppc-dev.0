Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by ozlabs.org (Postfix) with ESMTP id 3D529B7D1E
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Jun 2010 09:27:15 +1000 (EST)
Subject: Re: [PATCH] KVM: PPC: elide struct thread_struct instances from stack
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <20100531224040.GA22927@brick.ozlabs.ibm.com>
Date: Tue, 1 Jun 2010 01:27:11 +0200
Message-Id: <BCE5FE99-DC34-4B7A-A745-969D10BC7B63@suse.de>
References: <m26323onam.fsf@igel.home>
	<20100531224040.GA22927@brick.ozlabs.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org, Andreas Schwab <schwab@linux-m68k.org>,
	kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 01.06.2010, at 00:40, Paul Mackerras wrote:

> On Mon, May 31, 2010 at 09:59:13PM +0200, Andreas Schwab wrote:
>=20
>> Instead of instantiating a whole thread_struct on the stack use only =
the
>> required parts of it.
>=20
> ...
>=20
>> +_GLOBAL(kvm_cvt_fd)
>> +	lfd	0,0(r5)			/* load up fpscr value */
>> +	MTFSF_L(0)
>> +	lfs	0,0(r3)
>> +	stfd	0,0(r4)
>> +	mffs	0
>> +	stfd	0,0(r5)			/* save new fpscr value */
>> +	blr
>> +
>> +_GLOBAL(kvm_cvt_df)
>> +	lfd	0,0(r5)			/* load up fpscr value */
>> +	MTFSF_L(0)
>> +	lfd	0,0(r3)
>> +	stfs	0,0(r4)
>> +	mffs	0
>> +	stfd	0,0(r5)			/* save new fpscr value */
>> +	blr
>=20
> I re-read the relevant part of the PowerPC architecture spec
> yesterday, and it seems pretty clear that the FPSCR doesn't affect the
> behaviour of lfs and stfs, and is not affected by them.  So in fact 4
> out of the 7 instructions in each of those procedures are unnecessary
> (and similarly for the cvt_fd/df used in the alignment fixup code).

So the rounding control field is not used on lfs? Interesting. I =
couldn't find a reference to it being used or modified either though.

Alex
