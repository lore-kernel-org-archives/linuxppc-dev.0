Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wqG113ymhzDqMS
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Jun 2017 08:55:17 +1000 (AEST)
Message-ID: <1497653684.2897.104.camel@kernel.crashing.org>
Subject: Re: [RFC PATCH 7/7 v1]powerpc: Deliver SEGV signal on protection
 key violation.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ram Pai <linuxram@us.ibm.com>
Cc: Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 dave.hansen@intel.com, paulus@samba.org, aneesh.kumar@linux.vnet.ibm.com
Date: Sat, 17 Jun 2017 08:54:44 +1000
In-Reply-To: <20170616191537.GB17588@ram.oc3035372033.ibm.com>
References: <1496711109-4968-1-git-send-email-linuxram@us.ibm.com>
 <1496711109-4968-8-git-send-email-linuxram@us.ibm.com>
 <622d7abf-3d99-8897-5afb-ef8c4f950fc0@linux.vnet.ibm.com>
 <1497609181.2897.100.camel@kernel.crashing.org>
 <20170616191537.GB17588@ram.oc3035372033.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2017-06-16 at 12:15 -0700, Ram Pai wrote:
> gp_regs size is not changed, nor is the layout. A unused field in
> the gp_regs is used to fill in the AMR contents. Old binaries will not
> be knowing about this unused field, and hence should not break.
> 
> New binaries can leverage this already existing but newly defined
> field; to read the contents of AMR.
> 
> Is it still a concern?

Calls to sys_swapcontext with a made-up context will end up with a crap
AMR if done by code who didn't know about that register.

Ben.
