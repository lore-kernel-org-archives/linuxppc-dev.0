Return-Path: <Bruce_Leonard@selinc.com>
Received: from duster.selinc.com (duster.selinc.com [74.117.214.140])
	by ozlabs.org (Postfix) with ESMTP id BA7B6B7C48
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 30 Mar 2010 17:25:00 +1100 (EST)
Received: from edison.ad.selinc.com (edison.ad.selinc.com [10.100.0.15])
	by duster.selinc.com (8.14.3/8.14.3) with ESMTP id o2U6OwfO014378
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Mar 2010 23:24:58 -0700
To: linuxppc-dev@lists.ozlabs.org
MIME-Version: 1.0
Subject: Question regarding the DTLB Miss exceptions
Message-ID: <OF788A7534.456B03AA-ON882576F6.00228BC4-882576F6.00233EC1@selinc.com>
From: Bruce_Leonard@selinc.com
Date: Mon, 29 Mar 2010 23:24:58 -0700
Content-Type: text/plain; charset="US-ASCII"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I'm tracking a problem that's leading me through DSI and DTLB miss 
exceptions on an MPC8347 (e300c1 core), and I've come across an oddity 
that I'm hoping someone can explain.

When a DTLB Miss exception can't find a PTE for the virtual address being 
written/read, it dummies up the SPRs for a DSI exception and then calls 
directly into the DSI exception code.  Just before the DTLB miss code 
stores a value into DSISR it sets bit 2, which for a DSI exception is a 
reserved bit and should be cleared.  There's no comment on the code 
(.../arch/powerpc/kernel/head_32.S line 619 of the 2.6.33-rc1 kernel). Can 
anyone tell me why this bit is getting set?

Thanks.

Bruce
