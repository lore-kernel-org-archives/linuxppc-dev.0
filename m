Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wpxXt6s3dzDq88
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Jun 2017 20:33:18 +1000 (AEST)
Message-ID: <1497609181.2897.100.camel@kernel.crashing.org>
Subject: Re: [RFC PATCH 7/7 v1]powerpc: Deliver SEGV signal on protection
 key violation.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>, Ram Pai
 <linuxram@us.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Cc: dave.hansen@intel.com, paulus@samba.org, aneesh.kumar@linux.vnet.ibm.com
Date: Fri, 16 Jun 2017 20:33:01 +1000
In-Reply-To: <622d7abf-3d99-8897-5afb-ef8c4f950fc0@linux.vnet.ibm.com>
References: <1496711109-4968-1-git-send-email-linuxram@us.ibm.com>
 <1496711109-4968-8-git-send-email-linuxram@us.ibm.com>
 <622d7abf-3d99-8897-5afb-ef8c4f950fc0@linux.vnet.ibm.com>
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

On Fri, 2017-06-16 at 14:50 +0530, Anshuman Khandual wrote:
> On 06/06/2017 06:35 AM, Ram Pai wrote:
> > The value of the AMR register at the time of the exception
> > is made available in gp_regs[PT_AMR] of the siginfo.
> 
> But its already available there in uctxt->uc_mcontext.regs->amr
> while inside the signal delivery context in the user space. The
> pt_regs already got updated with new AMR register. Then why we
> need gp_regs to also contain AMR as well ?

Also changing gp_regs layout/size is a major ABI issue...

Ben.
