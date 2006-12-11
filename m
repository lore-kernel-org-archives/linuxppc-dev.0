Return-Path: <wg@grandegger.com>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id F26D167BB2
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 11 Dec 2006 19:08:12 +1100 (EST)
Message-ID: <457D12B0.3010701@grandegger.com>
Date: Mon, 11 Dec 2006 09:11:28 +0100
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Is in_le32 and out_le32 atomic?
References: <4579C586.5040809@grandegger.com>	<200612082115.38812.arnd@arndb.de>
	<1165819718.7260.40.camel@localhost.localdomain>
In-Reply-To: <1165819718.7260.40.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Arnd Bergmann <arnd@arndb.de>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> On Fri, 2006-12-08 at 21:15 +0100, Arnd Bergmann wrote:
>> On Friday 08 December 2006 21:05, Wolfgang Grandegger wrote:
>>> Can anybody tell me why the spin_* protection is needed? I thought that 
>>> 32-bit read and write operations are atomic.
>>>
>> The spinlocks are needed to guarantee ordering between the completion of
>> the i/o access and other code. A typical problem is that a store is
>> still on its way to the I/O device while the CPU has already left the
>> function that initiated it, and might call code that relies on the
>> value having arrived there.
> 
> That will not help much with the spinlock, especially not seeing how
> they are used in the code.
> 
> I think the lock is totally spurrious in that case.

I just realized that there is also a mv64x60_modify function:

/* Define I/O routines for accessing registers on the 64x60 bridge. */
extern inline void
mv64x60_write(struct mv64x60_handle *bh, u32 offset, u32 val) {
         ulong   flags;

         spin_lock_irqsave(&mv64x60_lock, flags);
         out_le32(bh->v_base + offset, val);
         spin_unlock_irqrestore(&mv64x60_lock, flags);
}

extern inline u32
mv64x60_read(struct mv64x60_handle *bh, u32 offset) {
         ulong   flags;
         u32     reg;

         spin_lock_irqsave(&mv64x60_lock, flags);
         reg = in_le32(bh->v_base + offset);
         spin_unlock_irqrestore(&mv64x60_lock, flags);
         return reg;
}

extern inline void
mv64x60_modify(struct mv64x60_handle *bh, u32 offs, u32 data, u32 mask)
{
         u32     reg;
         ulong   flags;

         spin_lock_irqsave(&mv64x60_lock, flags);
         reg = in_le32(bh->v_base + offs) & (~mask);
         reg |= data & mask;
         out_le32(bh->v_base + offs, reg);
         spin_unlock_irqrestore(&mv64x60_lock, flags);
}

Then the spinlock makes sense avoiding the interruption of the 
subsequent read write accesses.

Sorry for the noise.

Wolfgang.
