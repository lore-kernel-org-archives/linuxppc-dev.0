Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 047831A06FA
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Jun 2014 08:52:41 +1000 (EST)
Message-ID: <1401833365.3247.36.camel@pasglop>
Subject: Re: [PATCH] powerpc, kexec: Fix "Processor X is stuck" issue during
 kexec from ST mode
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Date: Wed, 04 Jun 2014 08:09:25 +1000
In-Reply-To: <538E2FF8.8060707@linux.vnet.ibm.com>
References: <20140527105511.24309.74320.stgit@srivatsabhat.in.ibm.com>
 <20140528133143.GK14863@redhat.com> <538E2FF8.8060707@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: ego@linux.vnet.ibm.com, matt@ozlabs.org, mahesh@linux.vnet.ibm.com,
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org, suzuki@in.ibm.com,
 ebiederm@xmission.com, paulus@samba.org, linuxppc-dev@lists.ozlabs.org,
 Vivek Goyal <vgoyal@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2014-06-04 at 01:58 +0530, Srivatsa S. Bhat wrote:
> Yep, that makes sense. But unfortunately I don't have enough insight into
> why exactly powerpc has to online the CPUs before doing a kexec. I just
> know from the commit log and the comment mentioned above (and from my own
> experiments) that the CPUs will get stuck if they were offline. Perhaps
> somebody more knowledgeable can explain this in detail and suggest a proper
> long-term solution.
> 
> Matt, Ben, any thoughts on this?

The problem is with our "soft offline" which we do on some platforms. When we
offline we don't actually send the CPUs back to firmware or anything like that.

We put them into a very low low power loop inside Linux.

The new kernel has no way to extract them from that loop. So we must re-"online"
them before we kexec so they can be passed to the new kernel normally (or returned
to firmware like we do on powernv).

Cheers,
Ben.
