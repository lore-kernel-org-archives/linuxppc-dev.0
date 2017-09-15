Return-Path: <pasha.tatashin@oracle.com>
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xtdDM1gFvzDrWF
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Sep 2017 11:32:02 +1000 (AEST)
Subject: Re: [PATCH v8 10/11] arm64/kasan: explicitly zero kasan shadow memory
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 x86@kernel.org, kasan-dev@googlegroups.com, borntraeger@de.ibm.com,
 heiko.carstens@de.ibm.com, davem@davemloft.net, willy@infradead.org,
 mhocko@kernel.org, ard.biesheuvel@linaro.org, will.deacon@arm.com,
 catalin.marinas@arm.com, sam@ravnborg.org, mgorman@techsingularity.net,
 Steven.Sistare@oracle.com, daniel.m.jordan@oracle.com, bob.picco@oracle.com
References: <20170914223517.8242-1-pasha.tatashin@oracle.com>
 <20170914223517.8242-11-pasha.tatashin@oracle.com>
 <20170915011035.GA6936@remoulade>
From: Pavel Tatashin <pasha.tatashin@oracle.com>
Message-ID: <c76f72fc-21ed-62d0-014e-8509c0374f96@oracle.com>
Date: Thu, 14 Sep 2017 21:30:28 -0400
MIME-Version: 1.0
In-Reply-To: <20170915011035.GA6936@remoulade>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Mark,

Thank you for looking at this. We can't do this because page table is 
not set until cpu_replace_ttbr1() is called. So, we can't do memset() on 
this memory until then.

Pasha
