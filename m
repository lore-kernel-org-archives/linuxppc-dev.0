Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v8frs39zDzDq60
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jan 2017 11:33:01 +1100 (AEDT)
In-Reply-To: <20170119031910.2335-1-anton@ozlabs.org>
To: Anton Blanchard <anton@ozlabs.org>, benh@kernel.crashing.org,
 paulus@samba.org, mikey@neuling.org, maddy@linux.vnet.ibm.com,
 grimm@linux.vnet.ibm.com
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: powerpc: Ignore reserved field in DCSR and PVR reads and writes
Message-Id: <3v8frs23GNz9t1Q@ozlabs.org>
Date: Fri, 27 Jan 2017 11:33:01 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-01-19 at 03:19:10 UTC, Anton Blanchard wrote:
> From: Anton Blanchard <anton@samba.org>
> 
> IBM bit 31 (for the rest of us - bit 0) is a reserved field in the
> instruction definition of mtspr and mfspr. Hardware is encouraged to
> (and does) ignore it.
> 
> As a result, if userspace executes an mtspr DSCR with the reserved bit
> set, we get a DSCR facility unavailable exception. The kernel fails to
> match against the expected value/mask, and we silently return to
> userspace to try and re-execute the same mtspr DSCR instruction. We
> loop forever until the process is killed.
> 
> We should do something here, and it seems mirroring what hardware does
> is the better option vs killing the process. While here, relax the
> matching of mfspr PVR too.
> 
> Signed-off-by: Anton Blanchard <anton@samba.org>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/178f358208ceb8b38e5cff3f815e0d

cheers
