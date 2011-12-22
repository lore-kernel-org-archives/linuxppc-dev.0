Return-Path: <prasad@linux.vnet.ibm.com>
Received: from e24smtp05.br.ibm.com (e24smtp05.br.ibm.com [32.104.18.26])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e24smtp05.br.ibm.com", Issuer "GeoTrust SSL CA" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 9D179B714E
 for <linuxppc-dev@ozlabs.org>; Thu, 22 Dec 2011 20:35:12 +1100 (EST)
Received: from /spool/local
 by e24smtp05.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <prasad@linux.vnet.ibm.com>;
 Thu, 22 Dec 2011 07:35:04 -0200
Received: from d24av04.br.ibm.com (d24av04.br.ibm.com [9.8.31.97])
 by mailhub1.br.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id pBM9Zxi82003216
 for <linuxppc-dev@ozlabs.org>; Thu, 22 Dec 2011 07:35:59 -0200
Received: from d24av04.br.ibm.com (loopback [127.0.0.1])
 by d24av04.br.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 pBM9YlUS026458
 for <linuxppc-dev@ozlabs.org>; Thu, 22 Dec 2011 07:34:47 -0200
Date: Thu, 22 Dec 2011 15:04:47 +0530
From: "K.Prasad" <prasad@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org, Thiago Jung Bauermann <bauerman@br.ibm.com>,
 Edjunior Barbosa Machado <emachado@linux.vnet.ibm.com>, dwg@au1.ibm.com
Subject: Re: [PATCH 2/2] [PowerPC Book3E] Introduce new ptrace debug feature
 flag
Message-ID: <20111222093447.GD26407@in.ibm.com>
References: <20111208111212.GB3720@in.ibm.com>
 <20111208112330.GB24484@in.ibm.com>
 <20111221005502.GE5188@truffala.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20111221005502.GE5188@truffala.fritz.box>
Reply-To: prasad@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Dec 21, 2011 at 11:55:02AM +1100, David Gibson wrote:
> On Thu, Dec 08, 2011 at 04:53:30PM +0530, K.Prasad wrote:
> > While PPC_PTRACE_SETHWDEBUG ptrace flag in PowerPC accepts
> > PPC_BREAKPOINT_MODE_EXACT mode of breakpoint, the same is not intimated to the
> > user-space debuggers (like GDB) who may want to use it. Hence we introduce a
> > new PPC_DEBUG_FEATURE_DATA_BP_EXACT flag which will be populated on the
> > "features" member of "struct ppc_debug_info" to advertise support for the
> > same on Book3E PowerPC processors.
> 
> Hrm.  I had assumed the reason there wasn't a feature bit for EXACT
> originally was that EXACT breakpoints were *always* supposed to be
> supported by the new interface.
>

Okay. Although BookS doesn't support EXACT breakpoints, it is possible
(after the introduction of new hw-breakpoint interfaces) to request for
a breakpoint of length 1 Byte.

The hw-breakpoint infrastructure would take care of filtering the
extraneous interrupts arising out of accesses in the neighbourhood, in
such a case.

David,
	Can you Ack this patch too, if you find the changes acceptable?

Thanks,
K.Prasad
 
