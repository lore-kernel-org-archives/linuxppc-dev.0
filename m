Return-Path: <dan@embeddedalley.com>
Received: from easi.embeddedalley.com (easi.embeddedalley.com [71.6.201.124])
	by ozlabs.org (Postfix) with SMTP id 6A7B1B7B6B
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Oct 2009 09:08:08 +1100 (EST)
In-Reply-To: <1255033705.2146.17.camel@pasglop>
References: <1254948364-30074-1-git-send-email-Joakim.Tjernlund@transmode.se>
	<1254948364-30074-2-git-send-email-Joakim.Tjernlund@transmode.se>
	<1254948364-30074-3-git-send-email-Joakim.Tjernlund@transmode.se>
	<1254948364-30074-4-git-send-email-Joakim.Tjernlund@transmode.se>
	<1254950285.2409.10.camel@pasglop>
	<OF44C1983F.1C42E290-ONC1257649.0069CAF3-C1257649.006A78D1@transmode.se>
	<7A3C6D4C-E92B-434D-AF68-7AEEDE6DAD45@embeddedalley.com>
	<1255033705.2146.17.camel@pasglop>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <34A4641D-8121-4EBC-9880-26CB70DD3339@embeddedalley.com>
From: Dan Malek <dan@embeddedalley.com>
Subject: Re: [PATCH 3/6] 8xx: invalidate non present TLBs
Date: Thu, 8 Oct 2009 15:08:29 -0700
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Scott Wood <scottwood@freescale.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Rex Feany <RFeany@mrv.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi Ben.

On Oct 8, 2009, at 1:28 PM, Benjamin Herrenschmidt wrote:

> While you are around ... I have a question :-)

I'll try.  Many brain cells have been replaced or lost
over the years :-)

> Do you happen to remember what the story is with the invalidation of
> "unpopulated" (aka invalid) entries ?
>
> IE. We create those in the 8xx TLB miss when the PTE is !present  
> (or the
> PMD is absent). Those then cause a TLB error on the next access which
> allows us to process the page fault. But when/how are those invalid
> entries supposed to be invalidated ?

I thought we did a tlbie() (or whatever the equivalent is today)
when the PTE was updated in the table.  An optimization was to
load the TLB with the entry at that time to avoid a subsequent miss.
In any case, the TLB entry has to be modified by the software.

> The doco seems to hint that at least in the case of an entry with the
> wrong C bit (store to an entry with C=0), the HW automatically
> invalidates it before taking the TLB Error but that's all I found.

I don't remember how C was used in the past, but I suspect
it just mirrored the Linux VM state.  I'm quite certain the MMU
HW would never change a TLB entry.  Where did you read this?
For most of the 8xx "early days," I used to just mark all write
pages as dirty.   For some reason I just overloaded the write/changed
into one bit, it avoided TLB Error overhead and I think even some
silicon bugs.  Since they were tiny and fairly static embedded
systems, it didn't have any effect on the way VM was managed.

> Is there a general HW policy on 8xx to invalidate TLB entries that  
> cause
> TLB errors ? Or is the kernel expected to do it most of the time ?

The MMU HW on the 8xx is just a translator.  I'm now really
certain it won't ever change a TLB entry.  It's completely up to
software to make all TLB changes.

Just make it simple :-)

Thanks.

	-- Dan
