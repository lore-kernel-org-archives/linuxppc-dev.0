Return-Path: <tony.luck@intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by ozlabs.org (Postfix) with ESMTP id BF929DE19E
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Jan 2008 08:17:06 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: x86/non-x86: percpu, node ids, apic ids x86.git fixup
Date: Wed, 30 Jan 2008 13:15:21 -0800
Message-ID: <1FE6DD409037234FAB833C420AA843EC758076@orsmsx424.amr.corp.intel.com>
In-Reply-To: <20080130205915.GA4562@elte.hu>
References: <20080130161036.GA12293@elte.hu>
	<1FE6DD409037234FAB833C420AA843EC757C72@orsmsx424.amr.corp.intel.com>
	<20080130180623.GA24881@elte.hu>
	<1FE6DD409037234FAB833C420AA843EC757DEA@orsmsx424.amr.corp.intel.com>
	<47A0CD4B.5040706@sgi.com>
	<1FE6DD409037234FAB833C420AA843EC757F12@orsmsx424.amr.corp.intel.com>
	<20080130194616.GA19426@elte.hu>
	<1FE6DD409037234FAB833C420AA843EC757F7C@orsmsx424.amr.corp.intel.com>
	<20080130200221.GA28073@elte.hu>
	<1FE6DD409037234FAB833C420AA843EC757FC2@orsmsx424.amr.corp.intel.com>
	<20080130205915.GA4562@elte.hu>
From: "Luck, Tony" <tony.luck@intel.com>
To: "Ingo Molnar" <mingo@elte.hu>
Cc: sparclinux@vger.kernel.org, linux-ia64@vger.kernel.org,
	Linux Kernel Development <linux-kernel@vger.kernel.org>,
	Mike Travis <travis@sgi.com>,
	Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Linus Torvalds <torvalds@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> this i believe builds an implicit dependency between the mca_asm.o=20
> position within the image and the ia64_mca_data percpu variable it=20
> accesses - it relies on the immediate 22 addressing mode that has 4MB =
of=20
> scope. Per chance, the .config you sent creates a 14MB image, and the=20
> percpu variables moved too far away for the linker to be able to =
fulfill=20
> this constraint.

Sounds very plausible.

> The workaround is to define PER_CPU_ATTRIBUTES to link percpu =
variables=20
> back into the .percpu section on UP too - which ia64 links specially=20
> into its vmlinux.lds. But ultimately i think the better solution would =

> be to remove this dependency between arch/ia64/kernel/mca_asm.S and =
the=20
> position of the percpu data.

Yup.  That fixes the build ... the resulting binary doesn't boot though =
:-(
I just realized that it has been a while since I tried booting a UP
kernel ... so the problem may be unrelated bitrot elsewhere.

Overall you are right that the mca_asm.S code should not be dependent on
the relative location of the data objects.

I'll start digging on why this doesn't boot ... but you might as well
send the fixes so far upstream to Linus so that the SMP fix is available
(which is all anyone really cares about ... there are very, very few
UP ia64 systems in existence).

Acked-by: Tony Luck <tony.luck@intel.com>


-Tony
