Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id AF0471007D4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Nov 2011 07:34:44 +1100 (EST)
Subject: Re: [RFC PATCH 08/17] powerpc/e500: Remove conditional "lwsync"
 substitution
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <4567A1A9-51D2-4D21-9080-BD3D78901C1D@boeing.com>
Date: Thu, 10 Nov 2011 14:34:32 -0600
Message-Id: <FCE81732-AD2B-4EF2-BC31-E24D0F9D41A9@kernel.crashing.org>
References: <4E42AB6F.1050900@freescale.com>
 <1320883635-17194-9-git-send-email-Kyle.D.Moffett@boeing.com>
 <3937191C-A735-4668-8E80-9FB4B35E2F63@kernel.crashing.org>
 <20111110163100.GA11983@schlenkerla.am.freescale.net>
 <AC287A9B-0C8B-494E-95CD-A33014AECE22@kernel.crashing.org>
 <20111110170334.GF11983@schlenkerla.am.freescale.net>
 <4567A1A9-51D2-4D21-9080-BD3D78901C1D@boeing.com>
To: "Moffett, Kyle D" <Kyle.D.Moffett@boeing.com>
Cc: Baruch Siach <baruch@tkos.co.il>, Timur Tabi <B04825@freescale.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Paul Gortmaker <paul.gortmaker@windriver.com>,
 Paul Mackerras <paulus@samba.org>, Scott Wood <scottwood@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Nov 10, 2011, at 2:27 PM, Moffett, Kyle D wrote:

> On Nov 10, 2011, at 12:03, Scott Wood wrote:
>> On Thu, Nov 10, 2011 at 10:42:25AM -0600, Kumar Gala wrote:
>>>=20
>>> On Nov 10, 2011, at 10:31 AM, Scott Wood wrote:
>>>=20
>>>> On Thu, Nov 10, 2011 at 07:40:04AM -0600, Kumar Gala wrote:
>>>>> Nak, we can run an e500mc in a mode that is compatible with =
e500v1/v2.
>>>>> I see no reason to change the support we have there.
>>>>=20
>>>> What "mode" do you mean?  DCBZ32?  We don't support using that =
currently,
>>>> and I'd imagine the performance implication would be such that =
you'd
>>>> never want to do it unless it's the only way to make some piece of =
legacy
>>>> software work.
>>>=20
>>> Correct, DCBZ32, we've had customers that go down this path.
>>=20
>> For running legacy software, or for multiplatform Linux kernels?
>>=20
>> And if you're willing to toss performance away for this goal, why do =
you
>> need lwsync? :-)
>>=20
>> DCBZ32 is not a "mode that is compatible with v1/v2", BTW.  It only
>> affects cache block size (for dcbz/dcba only), not SPE versus FP, not
>> changes in power management, not changes in machine check handling, =
etc.
>>=20
>> Using DCBZ32 for the kernel would also complicate switching the =
kernel to
>> dcbzl, to support enabling DCBZ32 for certain userspace apps (a more
>> likely use case) without making it systemwide.
>=20
> So, as far as I can tell the kernel doesn't even try to touch DCBZ32.

Correct, it was my thinking I'd get there an add this one day, that day =
never came.

> Even if it did, if you are building a new kernel that includes this =
patch,
> surely you can actually build a proper e500mc kernel instead of trying =
to
> build a new kernel to run on hardware it wasn't designed to run on, =
right?
>=20
> I think the bigger issue is the fact that building a PPC_BOOK3E_64 =
kernel
> with both e5500 and PowerPC A2 support turned on will not actually run =
on
> both.  Before my v1-patch-series, machine-check handling is messed up =
for
> PowerPC A2, and afterwards cacheline sizes are messed up for e5500.

That might be, but who is asking or wanting to run a BOOK3E_64 kernel on =
both.  I'm guessing there are a number of issues with this.

> Does this mean that PPC_BOOK3E_64 needs to be split into two separate
> Book 3-III families the same way that 32-bit has been split?  Is there
> another way around it?

No idea, we have to ask Ben how much he cares.  I don't see any FSL =
customers pushing us to run the same kernel on A2 and P5020 (or future =
FSL devices).

- k=
