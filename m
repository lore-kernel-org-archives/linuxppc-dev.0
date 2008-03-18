Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 464DCDE054
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Mar 2008 11:29:07 +1100 (EST)
Date: Mon, 17 Mar 2008 19:36:19 -0500
From: Olof Johansson <olof@lixom.net>
To: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH] Fix PMU + soft interrupt disable bug
Message-ID: <20080318003619.GB671@lixom.net>
References: <20080317042709.GA10594@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080317042709.GA10594@kryten>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Mar 16, 2008 at 11:27:09PM -0500, Anton Blanchard wrote:
> 
> Since the PMU is an NMI now, it can come at any time we are only soft
> disabled. We must hard disable around the two places we allow the kernel
> stack SLB and r1 to go out of sync. Otherwise the PMU exception can
> force a kernel stack SLB into another slot.
> 
> Signed-off-by: Anton Blanchard <anton@samba.org>

Acked-by: Olof Johansson <olof@lixom.net>

This fixes some problems we've seen with multi-slb hits when running
oprofile.
