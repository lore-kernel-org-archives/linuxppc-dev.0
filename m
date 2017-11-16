Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yd1mF2QzWzDqyQ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Nov 2017 00:09:16 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vAGD6OtW058755
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Nov 2017 08:09:13 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2e9ah02htp-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Nov 2017 08:09:12 -0500
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Thu, 16 Nov 2017 13:09:08 -0000
Date: Thu, 16 Nov 2017 18:39:03 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH v4 2/3] powerpc/modules: Don't try to restore r2 after a
 sibling call
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Balbir Singh <bsingharora@gmail.com>, Kamalesh Babulal
 <kamalesh@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 live-patching@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>
References: <20171114092910.20399-1-kamalesh@linux.vnet.ibm.com>
 <20171114092910.20399-3-kamalesh@linux.vnet.ibm.com>
 <1510654928.8xrjtkjm8m.naveen@linux.ibm.com>
 <20171114155323.3sjxx3eykinnl2ea@treble>
 <1510737417.g8rnjuztlf.naveen@linux.ibm.com>
 <20171116012628.6ajxlychto365sf6@treble>
In-Reply-To: <20171116012628.6ajxlychto365sf6@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <1510837263.5d3ac8knzo.naveen@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Josh Poimboeuf wrote:
> On Wed, Nov 15, 2017 at 02:58:33PM +0530, Naveen N. Rao wrote:
>> > +int instr_is_link_branch(unsigned int instr)
>> > +{
>> > +	return (instr_is_branch_iform(instr) || instr_is_branch_bform(instr)=
) &&
>> > +	       (instr & BRANCH_SET_LINK);
>> > +}
>> > +
>>=20
>> Nitpicking here, but since we're not considering the other branch forms,
>> perhaps this can be renamed to instr_is_link_relative_branch() (or maybe
>> instr_is_relative_branch_link()), just so we're clear :)
>=20
> My understanding is that the absolute/relative bit isn't a "form", but
> rather a bit that can be set for either the b-form (conditional) or the
> i-form (unconditional).  And the above function isn't checking the
> absolute bit, so it isn't necessarily a relative branch.  Or did I miss
> something?

Ah, good point. I was coming from the fact that we are only considering=20
the i-form and b-form branches and not the lr/ctr/tar based branches,=20
which are always absolute branches, but can also set the link register.

Thinking about this more, aren't we only interested in relative branches
here (for relocations), so can we actually filter out the absolute=20
branches? Something like this?

int instr_is_relative_branch_link(unsigned int instr)
{
	return ((instr_is_branch_iform(instr) || instr_is_branch_bform(instr)) &&
	       !(instr & BRANCH_ABSOLUTE) && (instr & BRANCH_SET_LINK));
}


- Naveen

=
