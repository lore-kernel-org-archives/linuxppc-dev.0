Return-Path: <drow@false.org>
Received: from nan.false.org (NaN.false.org [208.75.86.248])
	by ozlabs.org (Postfix) with ESMTP id 4842ADDE0A
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 17 Jul 2007 02:26:59 +1000 (EST)
Date: Mon, 16 Jul 2007 11:53:48 -0400
From: Daniel Jacobowitz <drow@false.org>
To: Bill Gatliff <bgat@billgatliff.com>
Subject: Re: Gdbserver syscall clobber
Message-ID: <20070716155348.GA5281@caradoc.them.org>
References: <469B922D.3050701@billgatliff.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <469B922D.3050701@billgatliff.com>
Cc: gdb@sourceware.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon, Jul 16, 2007 at 10:43:41AM -0500, Bill Gatliff wrote:
> recv(4, 0x7ffffd60, 1, 0)               = ? ERESTARTSYS (To be restarted)
> --- SIGIO (I/O possible) @ 0 (0) ---
> syscall_4294966784(0xa, 0x7ffffd34, 0x1, 0, 0x1008a3c7, 0x1008b5a3, 0x1008b5a4, 

That's -512, a.k.a. the errno value used by syscall restarting.  I'd
say your glibc does not obey the restartable syscall convention used
by your kernel, and when it tries to restart the syscall the errno
value is not being replaced by the syscall number.  Check the assembly
for recv.

-- 
Daniel Jacobowitz
CodeSourcery
