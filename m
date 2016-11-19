Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tLMDX634CzDvy9
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Nov 2016 15:23:24 +1100 (AEDT)
Date: Sat, 19 Nov 2016 15:02:32 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: kvm@vger.kernel.org, kvm-ppc@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 07/13] KVM: PPC: Book3S HV: Adjust host/guest context
 switch for POWER9
Message-ID: <20161119040232.GB29462@fergus.ozlabs.ibm.com>
References: <1479454122-26994-1-git-send-email-paulus@ozlabs.org>
 <1479454122-26994-8-git-send-email-paulus@ozlabs.org>
 <8737ioony4.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <8737ioony4.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Nov 18, 2016 at 08:05:47PM +0530, Aneesh Kumar K.V wrote:
> Paul Mackerras <paulus@ozlabs.org> writes:
> 
> > Some special-purpose registers that were present and accessible
> > by guests on POWER8 no longer exist on POWER9, so this adds
> > feature sections to ensure that we don't try to context-switch
> > them when going into or out of a guest on POWER9.  These are
> > all relatively obscure, rarely-used registers, but we had to
> > context-switch them on POWER8 to avoid creating a covert channel.
> > They are: SPMC1, SPMC2, MMCRS, CSIGR, TACR, TCSCR, and ACOP.
> 
> We don't need to context-switch them even when running a power8 compat
> guest ?

They physically don't exist on the P9 chip, so how could we
context-switch them?  They certainly can't be used as a covert
channel.

Accesses to them will be a no-op for the guest in privileged
(supervisor) mode (i.e., mfspr won't modify the destination
register), which could be confusing for the guest if it was expecting
to use them.  SPMC1/2 and MMCRS are part of the "supervisor" PMU,
which we have never used.  I think CSIGR, TACR and TCSCR are part of a
facility that was never completely implemented or usable on P8, so
nothing uses them.  ACOP is used in arch/powerpc/mm/icswx.c in
conjunction with accelerators.  There might be a problem there, but in
any case, with no physical ACOP register present there's no way to
save/restore it.

Paul.
