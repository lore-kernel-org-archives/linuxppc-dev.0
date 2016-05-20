Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r9tTk56m9zDqCT
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 May 2016 13:19:54 +1000 (AEST)
Date: Fri, 20 May 2016 11:45:45 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, mikey@neuling.org
Subject: Re: [PATCH v2 2/9] powerpc/kvm: make hypervisor state restore a
 function
Message-ID: <20160520014545.GA27460@oak.ozlabs.ibm.com>
References: <1462263878-25237-1-git-send-email-shreyas@linux.vnet.ibm.com>
 <1462263878-25237-3-git-send-email-shreyas@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1462263878-25237-3-git-send-email-shreyas@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, May 03, 2016 at 01:54:31PM +0530, Shreyas B. Prabhu wrote:
> In the current code, when the thread wakes up in reset vector, some
> of the state restore code and check for whether a thread needs to
> branch to kvm is duplicated. Reorder the code such that this
> duplication is avoided.

This is a nice cleanup.  The one minor comment I have is that since
power7_restore_hyp_resource has some unusual entry requirements (such
as requiring cr3 to be set a certain way), those requirements should
be documented in the comment just about the function entry point.  I
didn't see any unusual exit conditions, but if there are any they
should be documented too.

Reviewed-by: Paul Mackerras <paulus@samba.org>
