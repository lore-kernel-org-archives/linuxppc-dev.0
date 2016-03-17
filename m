Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qR1bR1rMpzDq6T
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Mar 2016 08:25:07 +1100 (AEDT)
Date: Thu, 17 Mar 2016 22:15:34 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, benh@kernel.crashing.org,
 mahesh@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com
Subject: Re: [PATCH 2/3] powerpc/powernv: Encapsulate idle preparation steps
 in a macro
Message-ID: <20160317111534.GD28728@fergus.ozlabs.ibm.com>
References: <1456748580-10519-1-git-send-email-shreyas@linux.vnet.ibm.com>
 <1456748580-10519-3-git-send-email-shreyas@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1456748580-10519-3-git-send-email-shreyas@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Feb 29, 2016 at 05:52:59PM +0530, Shreyas B. Prabhu wrote:
> Before entering any idle state which can result in a state loss
> we currently save the context in the stack before entering idle.
> Encapsulate these steps in a macro IDLE_STATE_PREP. Move this
> and other macros to commonly accessible location.

There are two problems with this.  First, your new macro does much
more than create a stack frame and save some registers.  It also
messes with interrupts and potentially executes a blr instruction.
That is not what people would expect from the name of the macro or the
comments around it.  It also means that it would be hard to reuse the
macro in another place.

Secondly, I don't think this change helps readability.  Since the
macro is only used in one place, it doesn't reduce the total number of
lines of code, in fact it increases it slightly.  Having the macro
just means that someone reading the code has to look in two places to
see what power7_powersave_common is actually doing, rather than having
all the code in one place.  If what your macro did was a single thing
conceptually that took several instructions, then it might be helpful,
but as it is, it doesn't help readability.

Paul.
