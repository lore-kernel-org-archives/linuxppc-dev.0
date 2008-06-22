Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 07E3ADDEDC
	for <linuxppc-dev@ozlabs.org>; Sun, 22 Jun 2008 10:29:15 +1000 (EST)
Subject: Re: [PATCH] powerpc: Only demote individual slices rather than
	whole process
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <18520.40232.383998.820059@cargo.ozlabs.ibm.com>
References: <18520.40232.383998.820059@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Sun, 22 Jun 2008 10:29:09 +1000
Message-Id: <1214094549.8011.196.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2008-06-18 at 15:29 +1000, Paul Mackerras wrote:
> At present, if we have a kernel with a 64kB page size, and some
> process maps something that has to be mapped with 4kB pages (such as a
> cache-inhibited mapping on POWER5+, or the eHCA infiniband queue-pair
> pages), we change the process to use 4kB pages everywhere.  This hurts
> the performance of HPC programs that access eHCA from userspace.
> 
> With this patch, the kernel will only demote the slice(s) containing
> the eHCA or cache-inhibited mappings, leaving the remaining slices
> able to use 64kB hardware pages.
> 
> This also changes the slice_get_unmapped_area code so that it is
> willing to place a 64k-page mapping into (or across) a 4k-page slice
> if there is no better alternative, i.e. if the program specified
> MAP_FIXED or if there is not sufficient space available in slices that
> are either empty or already have 64k-page mappings in them.
> 
> Signed-off-by: Paul Mackerras <paulus@samba.org>
> ---

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

(pending some torture testing of course :-)

Ben.
