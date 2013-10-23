Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by ozlabs.org (Postfix) with ESMTP id 0E2472C0331
 for <linuxppc-dev@ozlabs.org>; Thu, 24 Oct 2013 02:07:46 +1100 (EST)
References: <20131023084002.GA8325@iris.ozlabs.ibm.com>
 <20131023102045.GA23685@SnaresPenguin>
In-Reply-To: <20131023102045.GA23685@SnaresPenguin>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
	charset=us-ascii
Message-Id: <0309F92A-B914-47E4-B467-41F9188700D9@suse.de>
From: Alexander Graf <agraf@suse.de>
Subject: Re: powerpc: Don't corrupt user registers on 32-bit
Date: Wed, 23 Oct 2013 16:07:38 +0100
To: Scott Wood <scottwood@freescale.com>
Cc: Paul Mackerras <paulus@samba.org>,
 "<linuxppc-dev@ozlabs.org>" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Am 23.10.2013 um 11:20 schrieb Scott Wood <scottwood@freescale.com>:

> On Wed, Oct 23, 2013 at 09:40:02AM +0100, Paul Mackerras wrote:
>> Commit de79f7b9f6 ("powerpc: Put FP/VSX and VR state into structures")
>> modified load_up_fpu() and load_up_altivec() in such a way that they
>> now use r7 and r8.  Unfortunately, the callers of these functions on
>> 32-bit machines then return to userspace via fast_exception_return,
>> which doesn't restore all of the volatile GPRs, but only r1, r3 -- r6
>> and r9 -- r12.  This was causing userspace segfaults and other
>> userspace misbehaviour on 32-bit machines.
>> 
>> This fixes the problem by changing the register usage of load_up_fpu()
>> and load_up_altivec() to avoid using r7 and r8 and instead use r6 and
>> r10.  This also adds comments to those functions saying which registers
>> may be used.
>> 
>> Signed-off-by: Paul Mackerras <paulus@samba.org>
>> 
>> ---
>> arch/powerpc/kernel/fpu.S    | 14 ++++++++------
>> arch/powerpc/kernel/vector.S | 15 +++++++++------
>> 2 files changed, 17 insertions(+), 12 deletions(-)
> 
> Tested-by: Scott Wood <scottwood@freescale.com> (on e500mc, so no altivec)

Tested-by: Alexander Graf <agraf@suse.de> (on a G4 iBook and 970)

> 
> -Scott
> 
