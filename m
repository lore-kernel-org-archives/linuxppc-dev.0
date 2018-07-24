Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Zg3K0WzqzDr2m
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jul 2018 23:59:57 +1000 (AEST)
In-Reply-To: <1531835470-32691-2-git-send-email-linuxram@us.ibm.com>
To: Ram Pai <linuxram@us.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: fweimer@redhat.com, Ulrich.Weigand@de.ibm.com, linuxram@us.ibm.com,
 mhocko@kernel.org, bauerman@linux.vnet.ibm.com, msuchanek@suse.de,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [v3,
 1/9] powerpc/pkeys: Give all threads control of their key permissions
Message-Id: <41Zg3J08RLz9s3N@ozlabs.org>
Date: Tue, 24 Jul 2018 23:59:55 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2018-07-17 at 13:51:02 UTC, Ram Pai wrote:
> Currently in a multithreaded application, a key allocated by one
> thread is not usable by other threads. By "not usable" we mean that
> other threads are unable to change the access permissions for that
> key for themselves.
> 
> When a new key is allocated in one thread, the corresponding UAMOR
> bits for that thread get enabled, however the UAMOR bits for that key
> for all other threads remain disabled.
> 
> Other threads have no way to set permissions on the key, and the
> current default permissions are that read/write is enabled for all
> keys, which means the key has no effect for other threads. Although
> that may be the desired behaviour in some circumstances, having all
> threads able to control their permissions for the key is more
> flexible.
> 
> The current behaviour also differs from the x86 behaviour, which is
> problematic for users.
> 
> To fix this, enable the UAMOR bits for all keys, at process
> creation (in start_thread(), ie exec time). Since the contents of
> UAMOR are inherited at fork, all threads are capable of modifying the
> permissions on any key.
> 
> This is technically an ABI break on powerpc, but pkey support is fairly
> new on powerpc and not widely used, and this brings us into
> line with x86.
> 
> Fixes: cf43d3b26452 ("powerpc: Enable pkey subsystem")
> Cc: stable@vger.kernel.org # v4.16+
> Tested-by: Florian Weimer <fweimer@redhat.com>
> Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> [mpe: Reword some of the changelog]
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/a57a04c76e06822e4377831611364c

cheers
