Return-Path: <timur@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 8A680DDE4A
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Feb 2007 06:29:14 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l1FJTArR014571
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Feb 2007 12:29:11 -0700 (MST)
Received: from [10.82.19.119] (ld0169-tx32.am.freescale.net [10.82.19.119])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l1FJTATM010150
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Feb 2007 13:29:10 -0600 (CST)
Message-ID: <45D4B486.7030409@freescale.com>
Date: Thu, 15 Feb 2007 13:29:10 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: Why do the rh_alloc functions return a pointer?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The rh_alloc functions (rh_alloc, rh_alloc_fixed, rh_alloc_align) all return a 
"void *".  However, the actual value passed is an offset into a block of memory. 
  In most cases, the first time rh_alloc is called, it returns zero.

There are several wrapper functions for rh_alloc, and all of them cast the 
return value to an unsigned integer.

So my question is, why do the rh_alloc functions return a pointer?  Shouldn't 
they all return a u32 or uint?

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
