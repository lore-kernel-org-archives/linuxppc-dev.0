MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <16150.4659.856525.824351@cargo.ozlabs.ibm.com>
Date: Thu, 17 Jul 2003 13:04:19 +1000
From: Paul Mackerras <paulus@samba.org>
To: "Peter Dennett" <pdennett@padsoft.com>
Cc: <linuxppc-dev@lists.linuxppc.org>
Subject: Re: IBM PPC750L vs Motorola MPC7410
In-Reply-To: <0b8e01c34ba7$41fb8490$8202a8c0@pit>
References: <0b8e01c34ba7$41fb8490$8202a8c0@pit>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Peter Dennett writes:

> Is there someone on this list that can be so kind as to give
> me a technical summary of the differences between the
> PPC750L (G3) and Motorola MPC7410 (G4) so far as
> LINUX operation.

The biggest difference is that the 7410 has Altivec and the 750
doesn't.  Altivec is an extension to the instruction set that adds 32
128-bit registers plus a set of SIMD-style operations on those
registers.

Beyond that there will be differences in the special-purpose registers
(SPRs) accessible in kernel mode.  I don't think there would be
enormous difference but there would be some.

The kernel should detect which CPU you have and do the right thing
automatically.  Neither chip has an on-chip memory controller or
serial port; both have on-chip L1 I and D cache and on-chip L2 cache
controller and tag RAM (if I recall correctly).  So I don't know why
the kernel would hang when booting the G3.

Paul.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
