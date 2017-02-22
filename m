Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vT9TQ3Df7zDqGc
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Feb 2017 08:28:26 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc/mm/hash: Always clear UPRT and Host Radix bits
 when setting up CPU
In-Reply-To: <1487740322-17755-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1487740322-17755-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Date: Thu, 23 Feb 2017 08:28:25 +1100
Message-ID: <87ino1zzie.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> writes:

> We will set LPCR with correct value for radix during int. This make sure we
> start with a sanitized value of LPCR. In case of kexec, cpus can have LPCR
> value based on the previous translation mode we were running.
>
> Fixes: fe036a0605d60 ("powerpc/64/kexec: Fix MMU cleanup on radix")
> Cc: stable@vger.kernel.org # v4.9+
> Acked-by: Michael Neuling <mikey@neuling.org>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

I can merge this, but the proper fix is to set a sensible value on the
kexec down path.

That way you can kexec into an older kernel, which doesn't have this
fix. For this specific case maybe that's not really an issue, because
this is Power9 only and there aren't any old kernels that are expected
to work.

cheers
