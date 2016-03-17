Return-Path: <duwe@lst.de>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qQtMn1wVrzDq6W
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Mar 2016 02:59:33 +1100 (AEDT)
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3qQtMm4yjlz9sD3
 for <linuxppc-dev@ozlabs.org>; Fri, 18 Mar 2016 02:59:32 +1100 (AEDT)
Date: Thu, 17 Mar 2016 16:59:28 +0100
From: Torsten Duwe <duwe@lst.de>
To: Balbir Singh <bsingharora@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@ozlabs.org, pmladek@suse.com, jeyu@redhat.com,
 linux-kernel@vger.kernel.org, rostedt@goodmis.org,
 kamalesh@linux.vnet.ibm.com, live-patching@vger.kernel.org, mbenes@suse.cz
Subject: Re: [v3,1/8] powerpc: Create a helper for getting the kernel toc value
Message-ID: <20160317155928.GB32575@lst.de>
References: <3qNsms00H7z9snl@ozlabs.org>
 <alpine.LNX.2.00.1603150220231.3656@cbobk.fhfr.pm>
 <56E9F332.1070206@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <56E9F332.1070206@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Mar 17, 2016 at 10:58:42AM +1100, Balbir Singh wrote:
> 
> To be honest I think my v6 works well, but I don't have complete confidence
> due to the lack of proper testing. livepatch samples plus some others I wrote
> and I one Petr wrote all work (calling patched from within patched),

I have outlined a failure scenario for you as a reply to v6 ;)

Question to all: would it be feasible to limit the size of a single module's
.text + TOC to let's say 8MB, and place modules at 10MB granularity? Then it
would be unambiguous: exactly iff the high 40 bits of (TOC-LR) are zero, both
belong to the same module.

	Torsten
