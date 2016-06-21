Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rYTRV5JSSzDq66
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jun 2016 10:40:54 +1000 (AEST)
In-Reply-To: <1462928252-11195-1-git-send-email-sjitindarsingh@gmail.com>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: paulus@samba.org, Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Subject: Re: powerpc: Add array bounds checking to crash_shutdown_handlers
Message-Id: <3rYTRV1k4nz9t0y@ozlabs.org>
Date: Tue, 21 Jun 2016 10:40:54 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-11-05 at 00:57:32 UTC, Suraj Jitindar Singh wrote:
> The array crash_shutdown_handles is an array of size CRASH_HANDLER_MAX+1
> containing up to CRASH_HANDLER_MAX shutdown_handlers. It is assumed to
> be NULL terminated, which it is under normal circumstances. Array
> accesses in the functions crash_shutdown_unregister() and
> default_machine_crash_shutdown() rely on this NULL termination property
> when traversing this list and don't protect again out of bounds accesses.
> If the NULL terminator were somehow overwritten these functions could
> potentially access out of the bounds of the array.
> 
> Shrink the array to size CRASH_HANDLER_MAX and implement explicit array
> bounds checking when accessing the elements of the
> crash_shutdown_handles[] array in crash_shutdown_unregister() and
> default_machine_crash_shutdown().
> 
> Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/1d1451655bad9a6a5fd7a42de6

cheers
