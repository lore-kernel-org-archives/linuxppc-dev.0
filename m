Return-Path: <joern@wohnheim.fh-wedel.de>
Date: Wed, 19 Jan 2005 16:14:56 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Sachin P <sachinpc@gmail.com>
Message-ID: <20050119151456.GA26711@wohnheim.fh-wedel.de>
References: <66164fbc0501190353265167b0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <66164fbc0501190353265167b0@mail.gmail.com>
Cc: Linuxppc-embedded@ozlabs.org
Subject: Re: consistent_alloc() on PPC
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, 19 January 2005 17:23:42 +0530, Sachin P wrote:
> 
> I am facing some problems porting my drivers to the PPC platform . Am
> currently using consistent_alloc() and consistent_free() to
> allocate/free (non-cached) DMA ble memory.
> Is there any function/patch/macro, equivalent to
> phy_to_virt()/virt_to_phy() for memory returned by consistent_alloc()?

Imo not.  I ended up writing a private version of it, along these
lines:

static inline unsigned long private_io_to_bus(void *addr)
{
        return iopa((unsigned long)addr) + offset;
}

Wouldn't hurt if you could generalize it somehow.

Jörn

-- 
Everything should be made as simple as possible, but not simpler.
-- Albert Einstein
