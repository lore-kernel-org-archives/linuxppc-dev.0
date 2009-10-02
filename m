Return-Path: <whitebox@nefkom.net>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 960D0B7BBD
	for <linuxppc-dev@ozlabs.org>; Sat,  3 Oct 2009 05:24:12 +1000 (EST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Anton Blanchard <anton@samba.org>
Subject: Re: [patch 1/3] powerpc: Move 64bit VDSO to improve context switch
	performance
References: <20090714065350.659537380@samba.org>
	<20090714065425.301516312@samba.org>
Date: Fri, 02 Oct 2009 21:14:37 +0200
In-Reply-To: <20090714065425.301516312@samba.org> (Anton Blanchard's message
	of "Tue, 14 Jul 2009 16:53:51 +1000")
Message-ID: <m2ocophale.fsf@igel.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Anton Blanchard <anton@samba.org> writes:

> On 64bit applications the VDSO is the only thing in segment 0. Since the VDSO
> is position independent we can remove the hint and let get_unmapped_area pick
> an area.

This breaks gdb.  The section table in the VDSO image when mapped into
the process no longer contains meaningful values, and gdb rejects it.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
