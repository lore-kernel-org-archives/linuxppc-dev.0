Return-Path: <agraf@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id CF33DB7D1A
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Jun 2010 19:19:31 +1000 (EST)
Subject: Re: [PATCH] KVM: PPC: elide struct thread_struct instances from stack
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <m3r5krrvy2.fsf@hase.home>
Date: Tue, 1 Jun 2010 11:19:17 +0200
Message-Id: <C9ECD11F-CF09-4C56-A028-3625266E2807@suse.de>
References: <m26323onam.fsf@igel.home>
	<20100531224040.GA22927@brick.ozlabs.ibm.com>
	<m3r5krrvy2.fsf@hase.home>
To: Andreas Schwab <schwab@linux-m68k.org>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 01.06.2010, at 10:36, Andreas Schwab wrote:

> Paul Mackerras <paulus@samba.org> writes:
>=20
>> I re-read the relevant part of the PowerPC architecture spec
>> yesterday, and it seems pretty clear that the FPSCR doesn't affect =
the
>> behaviour of lfs and stfs, and is not affected by them.  So in fact 4
>> out of the 7 instructions in each of those procedures are unnecessary
>> (and similarly for the cvt_fd/df used in the alignment fixup code).
>=20
> I'd prefer to have this deferred to a separate patch.

I agree. Andreas' patch takes the current logic and moves it to be KVM =
contained, so we don't clutter the stack. The fact that the old code was =
inefficient is a separate story.

Avi / Marcelo, please apply the patch nevertheless.


Alex
