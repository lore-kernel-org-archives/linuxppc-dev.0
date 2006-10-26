Return-Path: <christoph@schroedinger.engr.sgi.com>
Received: from omx1.americas.sgi.com (omx1-ext.sgi.com [192.48.179.11])
	by ozlabs.org (Postfix) with ESMTP id 7AED468092
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Oct 2006 05:00:48 +1000 (EST)
Date: Thu, 26 Oct 2006 12:00:30 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 2/3] Create compat_sys_migrate_pages
In-Reply-To: <20061026133305.b0db54e6.sfr@canb.auug.org.au>
Message-ID: <Pine.LNX.4.64.0610261158130.2802@schroedinger.engr.sgi.com>
References: <20061026132659.2ff90dd1.sfr@canb.auug.org.au>
	<20061026133305.b0db54e6.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: Christoph Lameter <christoph@schroedinger.engr.sgi.com>
Cc: linux-mm@kvack.org, ppc-dev <linuxppc-dev@ozlabs.org>, paulus@samba.org,
	LKML <linux-kernel@vger.kernel.org>, ak@suse.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 26 Oct 2006, Stephen Rothwell wrote:

> This is needed on bigendian 64bit architectures. The obvious way to do
> this (taking the other compat_ routines in this file as examples) is to
> use compat_alloc_user_space and copy the bitmasks back there, however you
> cannot call compat_alloc_user_space twice for a single system call and
> this method saves two copies of the bitmasks.

Well this means also that sys_mbind and sys_set_mempolicy are also
broken because these functions also use get_nodes().

Fixing get_nodes() to do the proper thing would fix all of these 
without having to touch sys_migrate_pages or creating a compat_ function 
(which usually is placed in kernel/compat.c)
