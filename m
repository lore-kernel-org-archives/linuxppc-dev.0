Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 28A792C0092
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Jan 2014 23:30:07 +1100 (EST)
Message-ID: <1388665786.4373.48.camel@pasglop>
Subject: Re: [PATCH -V2] powerpc: thp: Fix crash on mremap
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Thu, 02 Jan 2014 23:29:46 +1100
In-Reply-To: <87zjneodtw.fsf@linux.vnet.ibm.com>
References: <1388654266-5195-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20140102094124.04D76E0090@blue.fi.intel.com>
 <87zjneodtw.fsf@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: aarcange@redhat.com, linuxppc-dev@lists.ozlabs.org, paulus@samba.org,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, linux-mm@kvack.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2014-01-02 at 16:22 +0530, Aneesh Kumar K.V wrote:
> > Just use config option directly:
> >
> >       if (new_ptl != old_ptl ||
> >               IS_ENABLED(CONFIG_ARCH_THP_MOVE_PMD_ALWAYS_WITHDRAW))
> 
> 
> I didn't like that. I found the earlier one easier for reading.
> If you and others strongly feel about this, I can redo the patch.
> Please let me know

Yes, use IS_ENABLED, no need to have two indirections of #define's

Another option is to have

	if (pmd_move_must_withdraw(new,old)) {
	}

With in a generic header:

#ifndef pmd_move_must_withdraw
static inline bool pmd_move_must_withdraw(spinlock_t *new_ptl, ...)
{
	return new_ptl != old_ptl;
}
#endif

And in powerpc:

static inline bool pmd_move_must_withdraw(spinlock_t *new_ptl, ...)
{
	return true;
}
#define pmd_move_must_withdraw pmd_move_must_withdraw

Cheers,
Ben.
