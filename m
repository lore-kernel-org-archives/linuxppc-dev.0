Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id BA356DDEDF
	for <linuxppc-dev@ozlabs.org>; Mon,  9 Mar 2009 21:38:48 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e3.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n29AZwTU005524
	for <linuxppc-dev@ozlabs.org>; Mon, 9 Mar 2009 06:35:58 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n29Acgme174064
	for <linuxppc-dev@ozlabs.org>; Mon, 9 Mar 2009 06:38:42 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n29AcgB8020484
	for <linuxppc-dev@ozlabs.org>; Mon, 9 Mar 2009 06:38:42 -0400
Date: Mon, 9 Mar 2009 06:38:20 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Felix Radensky <felix@embedded-sol.com>
Subject: Re: Machine check in 4xx ethernet driver
Message-ID: <20090309103820.GA17943@zod.rchland.ibm.com>
References: <22408005.post@talk.nabble.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <22408005.post@talk.nabble.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Mar 09, 2009 at 12:47:02AM -0700, Felix Radensky wrote:
>
>Hi,
>
>I'm getting machine check exception when trying to dump
>emac registers on 405EX Kilauea board. The kernel is 2.6.29-rc7
>The problem seems not new, I can reproduce it on 2.6.25 Denx kernel

I've not looked at what that code path does, but the EMAC regs are
in DCR space, not MMIO.  Using memcpy_fromio there seems odd.

josh
