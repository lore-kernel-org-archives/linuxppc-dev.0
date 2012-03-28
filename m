Return-Path: <galak@kernel.crashing.org>
Subject: Re: [PATCH 2/4] powerpc/mpic: Use the MPIC_LARGE_VECTORS flag for FSL
 MPIC.
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <4F721209.5030706@freescale.com>
Date: Wed, 28 Mar 2012 09:52:20 -0500
Message-Id: <E5B344BA-0209-4F8D-8C0E-19D5B6AFA411@kernel.crashing.org>
References: <1332850557-23557-1-git-send-email-Varun.Sethi@freescale.com>
 <295B3D3A-F038-4176-90EF-423A6BB84F62@kernel.crashing.org>
 <CALRxmdDhHpxDoemWj6u_NUJtOfmAWo9U0YgO0xNzpqOt4EXD9w@mail.gmail.com>
 <4F720A90.1040600@freescale.com> <4F721209.5030706@freescale.com>
To: Scott Wood <scottwood@freescale.com>
Cc: Varun Sethi <Varun.Sethi@freescale.com>, Linuxppc-dev@lists.ozlabs.org,
 Stuart Yoder <b08248@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Mar 27, 2012, at 2:16 PM, Scott Wood wrote:

> On 03/27/2012 01:44 PM, Scott Wood wrote:
>> On 03/27/2012 10:21 AM, Stuart Yoder wrote:
>>> On Tue, Mar 27, 2012 at 8:30 AM, Kumar Gala =
<galak@kernel.crashing.org> wrote:
>>>>=20
>>>> On Mar 27, 2012, at 7:15 AM, Varun Sethi wrote:
>>>>=20
>>>>> FSL MPIC supports 16 bit vectors so our vector number space isn't
>>>>> restricted to 256 vectors. We should use the MPIC_LARG_VECTORS =
flag
>>>>> while intializing the MPIC. This also prevents us from eating in =
to
>>>>> hardware vector number space (MSIs) while setting up internal =
sources.
>>>>=20
>>>> What is driving this change?
>>>=20
>>> Whats driving the change is proper handling of error interrupts.   =
Right
>>> now error interrupts (muxed on int 16) are treated as a shared
>>> interrupt source.   We want each to be handled as a individual =
interrupt
>>> source...thus the desire to support more than 256 interrupts.
>>=20
>> We don't actually need more than 256 interrupts for this (the =
individual
>> error interrupts are not counted against this).  But unless we change
>> how vectors are allocated, we need vectors >=3D 256, since we have =
MSIs
>> close enough to 256 that under the current scheme the IPIs, timers, =
and
>> such collide with the third MSI bank.
>=20
> Note that this is the case today even without the error interrupt =
stuff
> -- the highest vector used by MSIs on MPIC 4.1 is 0xf7, and we have 13
> special vectors (4 IPIs, 8 timers, and spurious).

This all makes sense, what I ask is that the commit message be updated =
to convey this.

- k=
