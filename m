Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40cc9g4StlzF0ZM
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 May 2018 12:56:55 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Sam Bobroff <sbobroff@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 03/13] powerpc/eeh: Fix use-after-release of EEH driver
In-Reply-To: <e50359f9211fcdc342401806ab65aa092c63e7b9.1525242772.git.sbobroff@linux.ibm.com>
References: <cover.1525242772.git.sbobroff@linux.ibm.com>
 <e50359f9211fcdc342401806ab65aa092c63e7b9.1525242772.git.sbobroff@linux.ibm.com>
Date: Fri, 04 May 2018 12:56:55 +1000
Message-ID: <871ses9lhk.fsf@concordia.ellerman.id.au>
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

Sam Bobroff <sbobroff@linux.ibm.com> writes:

> Correct two cases where eeh_pcid_get() is used to reference the driver's
> module but the reference is dropped before the driver pointer is used.
>
> In eeh_rmv_device() also refactor a little so that only two calls to
> eeh_pcid_put() are needed, rather than three and the reference isn't
> taken at all if it wasn't needed.

This sounds like a crash or memory corruption bug?

But it doesn't have Fixes or Cc: stable. Is it not a major problem for
some reason?

cheers
