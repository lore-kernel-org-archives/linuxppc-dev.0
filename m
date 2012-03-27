Return-Path: <B07421@freescale.com>
Message-ID: <4F720A90.1040600@freescale.com>
Date: Tue, 27 Mar 2012 13:44:32 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Stuart Yoder <b08248@gmail.com>
Subject: Re: [PATCH 2/4] powerpc/mpic: Use the MPIC_LARGE_VECTORS flag for
 FSL MPIC.
References: <1332850557-23557-1-git-send-email-Varun.Sethi@freescale.com>
 <295B3D3A-F038-4176-90EF-423A6BB84F62@kernel.crashing.org>
 <CALRxmdDhHpxDoemWj6u_NUJtOfmAWo9U0YgO0xNzpqOt4EXD9w@mail.gmail.com>
In-Reply-To: <CALRxmdDhHpxDoemWj6u_NUJtOfmAWo9U0YgO0xNzpqOt4EXD9w@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: Varun Sethi <Varun.Sethi@freescale.com>, Linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/27/2012 10:21 AM, Stuart Yoder wrote:
> On Tue, Mar 27, 2012 at 8:30 AM, Kumar Gala <galak@kernel.crashing.org> wrote:
>>
>> On Mar 27, 2012, at 7:15 AM, Varun Sethi wrote:
>>
>>> FSL MPIC supports 16 bit vectors so our vector number space isn't
>>> restricted to 256 vectors. We should use the MPIC_LARG_VECTORS flag
>>> while intializing the MPIC. This also prevents us from eating in to
>>> hardware vector number space (MSIs) while setting up internal sources.
>>
>> What is driving this change?
> 
> Whats driving the change is proper handling of error interrupts.   Right
> now error interrupts (muxed on int 16) are treated as a shared
> interrupt source.   We want each to be handled as a individual interrupt
> source...thus the desire to support more than 256 interrupts.

We don't actually need more than 256 interrupts for this (the individual
error interrupts are not counted against this).  But unless we change
how vectors are allocated, we need vectors >= 256, since we have MSIs
close enough to 256 that under the current scheme the IPIs, timers, and
such collide with the third MSI bank.

-Scott
