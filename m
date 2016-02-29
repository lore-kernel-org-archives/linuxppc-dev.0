Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C7CB21A0324
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Mar 2016 10:01:41 +1100 (AEDT)
In-Reply-To: <1456746752-9298-1-git-send-email-khandual@linux.vnet.ibm.com>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: aneesh.kumar@linux.vnet.ibm.com
Subject: Re: powerpc/lpar: Don't crash on H_PROTECT errors
Message-Id: <20160229230141.A8B4F140B99@ozlabs.org>
Date: Tue,  1 Mar 2016 10:01:41 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2016-29-02 at 11:52:32 UTC, Anshuman Khandual wrote:
> There are certain condition in which H_PROTECT can return error code
> other than H_NOT_FOUND and H_SUCCESS. One such being an attempt to
> update an hpte owned by adjunct partition. Return 0 in that case so
> that user space will retry the access. In adjunct case this mean we
> will not make much progress in the user space. But atleast we get a
> chance to kill the task and avoid taking down the entire box.

Why is it OK to do nothing and return 0?

The function's contract is that it either does the update or returns -1, you
can't change that without auditing all callers - and describing that in the
change log.

cheers
