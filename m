Return-Path: <anton@samba.org>
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rHwn46w3HzDqPD
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 May 2016 09:24:08 +1000 (AEST)
Date: Mon, 30 May 2016 09:23:40 +1000
From: Anton Blanchard <anton@samba.org>
To: Michael Neuling <mikey@neuling.org>
Cc: Anton Blanchard <anton@ozlabs.org>, mpe@ellerman.id.au,
 benh@kernel.crashing.org, paulus@samba.org,
 aneesh.kumar@linux.vnet.ibm.com, acsawdey@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/3] powerpc: Avoid load hit store in setup_sigcontext()
Message-ID: <20160530092340.4244948c@kryten>
In-Reply-To: <1464563663.27056.74.camel@neuling.org>
References: <1464523432-12605-1-git-send-email-anton@ozlabs.org>
 <1464523432-12605-2-git-send-email-anton@ozlabs.org>
 <1464563663.27056.74.camel@neuling.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

> On Sun, 2016-05-29 at 22:03 +1000, Anton Blanchard wrote:
> > From: Anton Blanchard <anton@samba.org>
> > 
> > In setup_sigcontext(), we set current->thread.vrsave then use it
> > straight after. Since current is hidden from the compiler via inline
> > assembly, it cannot optimise this and we end up with a load hit
> > store.  
> 
> Is setup_sigcontext() really a fast path we need to optimise?

setup_sigcontext() is called for every signal we deliver. I'd like
userspace to use less signals, but we still stumble across workloads
with quite heavy use of them.

Anton
