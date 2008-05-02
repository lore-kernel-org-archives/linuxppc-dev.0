Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18458.55542.977597.204532@cargo.ozlabs.ibm.com>
Date: Fri, 2 May 2008 19:03:50 +1000
From: Paul Mackerras <paulus@samba.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [POWERPC][v2] Bolt in SLB entry for kernel stack on secondary cpus
In-Reply-To: <20080502055648.GA28378@yookeroo.seuss>
References: <18458.39064.783013.268948@cargo.ozlabs.ibm.com>
	<20080502055648.GA28378@yookeroo.seuss>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Gibson writes:

> Do you even need the processor ID test at all?  The boot processor
> should always have its stack covered by SLB entry 0 when we come
> through here, shouldn't it?

I was concerned that get_paca()->kstack wouldn't have been initialized
by the time the boot cpu calls slb_initialize().  If that fear is
unfounded then the check could go.

Paul.
