Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qRjSW2R3bzDq6V
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Mar 2016 11:21:31 +1100 (AEDT)
Date: Sat, 19 Mar 2016 11:21:22 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: Shreyas B Prabhu <shreyas@linux.vnet.ibm.com>
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, benh@kernel.crashing.org,
 mahesh@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com
Subject: Re: [PATCH 2/3] powerpc/powernv: Encapsulate idle preparation steps
 in a macro
Message-ID: <20160319002122.GA27126@fergus.ozlabs.ibm.com>
References: <1456748580-10519-1-git-send-email-shreyas@linux.vnet.ibm.com>
 <1456748580-10519-3-git-send-email-shreyas@linux.vnet.ibm.com>
 <20160317111534.GD28728@fergus.ozlabs.ibm.com>
 <56EC1664.8020905@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <56EC1664.8020905@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Mar 18, 2016 at 08:23:24PM +0530, Shreyas B Prabhu wrote:
> Hi Paul,
> 
> On 03/17/2016 04:45 PM, Paul Mackerras wrote:
> > On Mon, Feb 29, 2016 at 05:52:59PM +0530, Shreyas B. Prabhu wrote:
> >> Before entering any idle state which can result in a state loss
> >> we currently save the context in the stack before entering idle.
> >> Encapsulate these steps in a macro IDLE_STATE_PREP. Move this
> >> and other macros to commonly accessible location.
> > 
> > There are two problems with this.  First, your new macro does much
> > more than create a stack frame and save some registers.  It also
> > messes with interrupts and potentially executes a blr instruction.
> > That is not what people would expect from the name of the macro or the
> > comments around it.  It also means that it would be hard to reuse the
> > macro in another place.
> > 
> > Secondly, I don't think this change helps readability.  Since the
> > macro is only used in one place, it doesn't reduce the total number of
> > lines of code, in fact it increases it slightly. 
> 
> This patch was in preparation for support for new POWER ISA v3 idle
> states. The idea was to have the common idle preparation steps in a
> macro which be reused while adding support for the new idle states. With
> this context do you think this macro with better comments make sense?

No, it still does too many disparate things.  In particular it's a bad
idea to embed a blr inside a macro unless the name makes it very clear
that the macro can cause a return (e.g. the macro name is
RETURN_IF_<something>).  Yours would need to be called
MAKE_STACK_FRAME_AND_SAVE_SPRS_AND_HARD_DISABLE_AND_RETURN_IF_IRQ_OCCURRED
or something. :)

Paul.
