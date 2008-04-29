Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18455.37613.709102.30668@cargo.ozlabs.ibm.com>
Date: Wed, 30 Apr 2008 07:28:13 +1000
From: Paul Mackerras <paulus@samba.org>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] [POWERPC] convert transfer_to_handler into a macro
In-Reply-To: <Pine.LNX.4.64.0804290856210.9230@blarg.am.freescale.net>
References: <Pine.LNX.4.64.0804290856210.9230@blarg.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala writes:

> We need to have unique transfer_to_handler paths for each exception level
> that is supported.  We need to use the proper xSRR0/1 depending on which
> exception level the interrupt was from.  The macro conversion lets up
> templatize this code path.

It seems to me that this implies you are assuming that you will never
ever get a synchronous normal interrupt such as a TLB miss while you
are in a critical or machine check handler.

Wouldn't it be better and safer to have the exception prolog for
critical interrupts save SRR0/1 in the stack frame, and have the
prolog for machine checks save SRR0/1 and CSRR0/1 likewise?

Paul.
