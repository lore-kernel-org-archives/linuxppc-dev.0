Return-Path: <jpoimboe@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yck9M1SnQzDqpb
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Nov 2017 12:26:31 +1100 (AEDT)
Date: Wed, 15 Nov 2017 19:26:28 -0600
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Balbir Singh <bsingharora@gmail.com>,
 Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 live-patching@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v4 2/3] powerpc/modules: Don't try to restore r2 after a
 sibling call
Message-ID: <20171116012628.6ajxlychto365sf6@treble>
References: <20171114092910.20399-1-kamalesh@linux.vnet.ibm.com>
 <20171114092910.20399-3-kamalesh@linux.vnet.ibm.com>
 <1510654928.8xrjtkjm8m.naveen@linux.ibm.com>
 <20171114155323.3sjxx3eykinnl2ea@treble>
 <1510737417.g8rnjuztlf.naveen@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1510737417.g8rnjuztlf.naveen@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Nov 15, 2017 at 02:58:33PM +0530, Naveen N. Rao wrote:
> > +int instr_is_link_branch(unsigned int instr)
> > +{
> > +	return (instr_is_branch_iform(instr) || instr_is_branch_bform(instr)) &&
> > +	       (instr & BRANCH_SET_LINK);
> > +}
> > +
> 
> Nitpicking here, but since we're not considering the other branch forms,
> perhaps this can be renamed to instr_is_link_relative_branch() (or maybe
> instr_is_relative_branch_link()), just so we're clear :)

My understanding is that the absolute/relative bit isn't a "form", but
rather a bit that can be set for either the b-form (conditional) or the
i-form (unconditional).  And the above function isn't checking the
absolute bit, so it isn't necessarily a relative branch.  Or did I miss
something?

-- 
Josh
