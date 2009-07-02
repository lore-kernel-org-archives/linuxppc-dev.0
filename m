Return-Path: <paulus@bilbo.ozlabs.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id B395DB70EA
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  2 Jul 2009 13:40:40 +1000 (EST)
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A4FB4DDD04
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Jul 2009 13:40:40 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <19020.11313.853279.666065@cargo.ozlabs.ibm.com>
Date: Thu, 2 Jul 2009 13:40:33 +1000
From: Paul Mackerras <paulus@samba.org>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: misaligned load/store in ppc32 memcpy
In-Reply-To: <6ABDC992-9D67-4C9C-A3A7-59F408FC9E50@kernel.crashing.org>
References: <6ABDC992-9D67-4C9C-A3A7-59F408FC9E50@kernel.crashing.org>
Cc: Mark Nelson <markn@au1.ibm.com>,
	"linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Kumar Gala writes:

>    Ben pointed me to you regarding my question if we should be expecting
>    misaligned load/store operations in the ppc32 mempcy that exists in
>    copy_32.S.
>    (To be more specific, I'm seeing this behavior and wondering if we
>    really should have memcpy avoid doing word size ld/st if the addresses
>    aren't also aligned)

We align the destination to a word boundary using byte-by-byte copies,
then copy words using word loads and stores.  The loads may be
misaligned, but they are still faster than doing aligned loads and
shuffling the bits around - or at least they were when measured the
speed 10 years or so ago, which would have been on 750 or 74xx cpus.

If the penalty for unaligned loads on Freescale embedded cores is high
enough that it's faster to shuffle the bits or to copy byte-by-byte
then we can have an alternative version for them.

Paul.
