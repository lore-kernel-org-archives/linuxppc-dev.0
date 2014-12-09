Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AE6BC1A01E2
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Dec 2014 21:11:17 +1100 (AEDT)
In-Reply-To: <1418020212-4303-1-git-send-email-khandual@linux.vnet.ibm.com>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [1/5] powerpc: Fix handling of DSCR related facility unavailable
 exception
Message-Id: <20141209101117.1CEC9140100@ozlabs.org>
Date: Tue,  9 Dec 2014 21:11:16 +1100 (AEDT)
Cc: mikey@neuling.org, anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2014-08-12 at 06:30:08 UTC, Anshuman Khandual wrote:
> Currently DSCR (Data Stream Control Register) can be accessed with
> mfspr or mtspr instructions inside a thread via two different SPR
> numbers. One being the user accessible problem state SPR number 0x03
> and the other being the privilege state SPR number 0x11. All access
> through the privilege state SPR number get emulated through illegal
> instruction exception. Any access through the problem state SPR number
> raises one facility unavailable exception which sets the thread based
> dscr_inherit bit and enables DSCR facility through FSCR register thus
> allowing direct access to DSCR without going through this exception in
> the future. We set the thread.dscr_inherit bit whether the access was
> with mfspr or mtspr instruction which is neither correct nor does it
> match the behaviour through the instruction emulation code path driven
> from privilege state SPR number. User currently observes two different
> kind of behaviour when accessing the DSCR through these two SPR numbers.
> This problem can be observed through these two test cases by replacing
> the privilege state SPR number with the problem state SPR number.
> 
> 	(1) http://ozlabs.org/~anton/junkcode/dscr_default_test.c
> 	(2) http://ozlabs.org/~anton/junkcode/dscr_explicit_test.c

Can you convert those into a selftest please?

cheers
