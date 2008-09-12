Return-Path: <dgibson@ozlabs.org>
Date: Fri, 12 Sep 2008 13:50:06 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Ilya Yanok <yanok@emcraft.com>
Subject: Re: [PATCH] mm: fix ENTRIES_PER_PAGEPAGE overflow with 256KB pages
Message-ID: <20080912035006.GF22288@yookeroo.seuss>
References: <1221083587-8091-1-git-send-email-yanok@emcraft.com>
	<1221083587-8091-3-git-send-email-yanok@emcraft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1221083587-8091-3-git-send-email-yanok@emcraft.com>
Cc: linuxppc-dev@ozlabs.org, wd@denx.de, dzu@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Sep 11, 2008 at 01:53:07AM +0400, Ilya Yanok wrote:
> ENTRIES_PER_PAGEPAGE define in mm/shmem.c becomes zero if page size is
> 256KB. This patch fixes this.

This looks.. dubious.  You're making a change to generic code for a
powerpc feature.  Plus it's not entirely clear that simply increasing
the variable size is a good fix here.  Again, I think since this is a
256k page special case it will simplify things to get the <=64k stuff
first, then handle this in another patch.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
