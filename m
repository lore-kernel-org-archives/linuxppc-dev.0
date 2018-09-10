Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 428QzK6knlzF38b
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Sep 2018 10:39:41 +1000 (AEST)
Date: Tue, 11 Sep 2018 08:38:06 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: Michael Neuling <mikey@neuling.org>
Cc: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>,
 mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 Haren Myneni <haren@linux.vnet.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] powerpc: Avoid code patching freed init sections
Message-ID: <20180910223806.GA25158@fergus>
References: <20180910054405.32422-1-mikey@neuling.org>
 <20180910115457.60366160@naga.suse.cz>
 <794308ed6aa6dcccf96e10bb0e3fa8d2dab9adff.camel@neuling.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <794308ed6aa6dcccf96e10bb0e3fa8d2dab9adff.camel@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Sep 10, 2018 at 08:05:38PM +1000, Michael Neuling wrote:
> 
> > > +	/* Make sure we aren't patching a freed init section */
> > > +	if (in_init_section(patch_addr) && init_freed())
> > > +		return 0;
> > > +
> > 
> > Do we even need the init_freed() check?
> 
> Maybe not.  If userspace isn't up, then maybe it's ok to skip.

Isn't this same function used for patching asm feature sections?  It's
not OK to skip patching them in init code.

> > What user input can we process in init-only code?
> 
> See the stack trace in the commit message. It's a weird case for KVM guests in
> KVM PR mode. 

The fault_in_pages_readable (formerly __get_user) there isn't actually
reading userspace, it's just a way of doing a load with a convenient
way to handle it if it traps.

Paul.
