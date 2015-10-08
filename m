Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8D4C71A018F
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Oct 2015 00:47:00 +1100 (AEDT)
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 65450140D9C
 for <linuxppc-dev@ozlabs.org>; Fri,  9 Oct 2015 00:47:00 +1100 (AEDT)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Thu, 8 Oct 2015 23:46:59 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id B80FD2BB0052
 for <linuxppc-dev@ozlabs.org>; Fri,  9 Oct 2015 00:46:53 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t98DkYSL42074132
 for <linuxppc-dev@ozlabs.org>; Fri, 9 Oct 2015 00:46:42 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t98DkJjK022703
 for <linuxppc-dev@ozlabs.org>; Fri, 9 Oct 2015 00:46:21 +1100
Message-ID: <56167395.8010703@linux.vnet.ibm.com>
Date: Thu, 08 Oct 2015 19:15:57 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
CC: shuahkh@osg.samsung.com, mikey@neuling.org, james.hogan@imgtec.com,
 avagin@openvz.org, Paul.Clothier@imgtec.com, peterz@infradead.org,
 palves@redhat.com, nacc@linux.vnet.ibm.com,
 emachado@linux.vnet.ibm.com, oleg@redhat.com, davem@davemloft.net,
 dhowells@redhat.com, Ulrich.Weigand@de.ibm.com, kirjanov@gmail.com,
 davej@redhat.com, akpm@linux-foundation.org,
 sukadev@linux.vnet.ibm.com, tglx@linutronix.de, sam.bobroff@au1.ibm.com
Subject: Re: [PATCH V8 00/28] Add new powerpc specific ELF core notes
References: <1432048104-4695-1-git-send-email-khandual@linux.vnet.ibm.com>
In-Reply-To: <1432048104-4695-1-git-send-email-khandual@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/19/2015 08:37 PM, Anshuman Khandual wrote:
> Test Result
> -----------
> ptrace-ebb		PASS
> ptrace-gpr		PASS
> ptrace-tm-gpr		PASS
> ptrace-tm-spd-gpr	PASS
> ptrace-tar		FAIL
> ptrace-tm-tar		FAIL
> ptrace-tm-spd-tar	FAIL
> ptrace-vsx		PASS
> ptrace-tm-vsx		PASS
> ptrace-tm-spd-vsx	PASS
> ptrace-tm-spr		PASS
> 
> NOTE: The above three test case failures are due to PPR context save/restore
> in various paths. Still continue to debug the issue.

This was an false alarm. The tracee process executed system calls with
shmdt() and printf() after writing the new PPR value.
