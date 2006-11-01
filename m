Return-Path: <dgibson@ozlabs.org>
Date: Wed, 1 Nov 2006 14:42:00 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Hugh Dickins <hugh@veritas.com>
Subject: Re: [PATCH 2/5] ppc64: make high hugepage areas preempt safe
Message-ID: <20061101034200.GC7220@localhost.localdomain>
References: <Pine.LNX.4.64.0610311834580.26470@blonde.wat.veritas.com>
	<Pine.LNX.4.64.0610311839480.26470@blonde.wat.veritas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.64.0610311839480.26470@blonde.wat.veritas.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Oct 31, 2006 at 06:40:39PM +0000, Hugh Dickins wrote:
> Checking source for other get_paca()->field preemption dangers found that
> open_high_hpage_areas does a structure copy into its paca while preemption
> is enabled: unsafe however gcc accomplishes it.  Just remove that copy:
> it's done safely afterwards by on_each_cpu, as in open_low_hpage_areas.

Oops, when I fixed the other problems with the PACA loading here, I
guess I missed this redundant assignment.

> Signed-off-by: Hugh Dickins <hugh@veritas.com>
Acked-by: David Gibson <dwg@au1.ibm.com>

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
