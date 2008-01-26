Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18330.35819.738293.742989@cargo.ozlabs.ibm.com>
Date: Sat, 26 Jan 2008 12:24:59 +1100
From: Paul Mackerras <paulus@samba.org>
To: Badari Pulavarty <pbadari@us.ibm.com>
Subject: Re: [RFC][PATCH] remove section mappinng
In-Reply-To: <1201277105.26929.36.camel@dyn9047017100.beaverton.ibm.com>
References: <1201277105.26929.36.camel@dyn9047017100.beaverton.ibm.com>
Cc: linux-mm <linux-mm@kvack.org>, linuxppc-dev@ozlabs.org, anton@au1.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Badari Pulavarty writes:

> Here is the code I cooked up, it seems to be working fine.
> But I have concerns where I need your help.
> 
> In order to invalidate htab entries, we need to find the "slot".
> But I can only find the hpte group. Is it okay to invalidate the
> first entry in the group ? Do I need to invalidate the entire group ?

You do need to find the correct slot.  (I suppose you could invalidate
the entire group, but that would be pretty gross.)

Note that in the CONFIG_DEBUG_PAGEALLOC case we use 4k pages and keep
a map of the slot numbers in linear_map_hash_slots[].  But in that
case I assume that the generic code would have already unmapped all
the pages of the LMB that you're trying to hot-unplug.

In the non-DEBUG_PAGEALLOC case on a System p machine, the hash table
will be big enough that the linear mapping entries should always be in
slot 0.  So just invalidating slot 0 would probably work in practice,
but it seems pretty fragile.  We might want to use your new
htab_remove_mapping() function on a bare-metal system with a smaller
hash table in future, for instance.

Have a look at pSeries_lpar_hpte_updateboltedpp.  It calls
pSeries_lpar_hpte_find to find the slot for a bolted HPTE.  You could
do something similar.  In fact maybe the best approach is to do a
pSeries_lpar_hpte_remove_bolted() and not try to solve the more
general problem.

Paul.
