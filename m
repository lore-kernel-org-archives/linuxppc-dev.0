Return-Path: <prasad@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 577CDB70B6
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 10 Jun 2009 19:07:35 +1000 (EST)
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp09.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2755BDDD04
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Jun 2009 19:07:35 +1000 (EST)
Received: from d23relay01.au.ibm.com (d23relay01.au.ibm.com [202.81.31.243])
	by e23smtp09.au.ibm.com (8.13.1/8.13.1) with ESMTP id n5AJ32Cx019507
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Jun 2009 05:03:02 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay01.au.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n5A97WSS483460
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Jun 2009 19:07:32 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n5A97W8b012011
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Jun 2009 19:07:32 +1000
Date: Wed, 10 Jun 2009 14:37:25 +0530
From: "K.Prasad" <prasad@linux.vnet.ibm.com>
To: David Gibson <dwg@au1.ibm.com>, linuxppc-dev@ozlabs.org
Subject: [Patch 0/6] PPC64-HWBKPT: Hardware Breakpoint interfaces - ver VI
Message-ID: <20090610090725.GA14478@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: paulus@samba.org, Michael Neuling <mikey@neuling.org>,
	Benjamin Herrenschmidt <benh@au1.ibm.com>,
	Alan Stern <stern@rowland.harvard.edu>, Roland McGrath <roland@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi David,
	Please find a new set of patches that implement the changes described below.

Changelog - ver VI
-------------------
(Ver I: http://ozlabs.org/pipermail/linuxppc-dev/2009-May/071942.html) 
(Ver II: http://ozlabs.org/pipermail/linuxppc-dev/2009-May/072106.html)
(Ver III: http://ozlabs.org/pipermail/linuxppc-dev/2009-May/072387.html
(Ver IV: http://ozlabs.org/pipermail/linuxppc-dev/2009-May/072518.html
(Ver V: http://lists.ozlabs.org/pipermail/linuxppc-dev/2009-June/072749.html)
9th June June 2009
-------------------

Changelog - ver VI
------------------
The task of identifying 'genuine' breakpoint exceptions from those caused by
'out-of-range' accesses turned out to be more tricky than originally thought.
Some changes to this effect were made in version IV of this patchset, but they
were not sufficient for user-space. Basically the breakpoint address received
through ptrace is always aligned to 8-bytes since ptrace receives an encoded
'data' (consisting of address | translation_enable | bkpt_type), and the size of
the symbol is not known. However for kernel-space addresses, the symbol-size can
be determined using kallsyms_lookup_size_offset() and this is used to check if
DAR (in the exception context) is
'bkpt_address <= DAR <= (bkpt_address + symbol_size)', failing which we conclude
it as a stray exception.

The following changes are made to enable check:
- Addition of a symbolsize field in 'struct arch_hw_breakpoint' field.
- Store the size of the 'watched' kernel symbol into 'symbolsize' field in
  arch_store_info(0 routine.
- Verify if the above described condition is true when is_one_shot is FALSE in
  hw_breakpoint_handler().

Kindly let me know your comments on the same.

Thanks,
K.Prasad
