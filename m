Return-Path: <duwe@lst.de>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 456741A004C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Mar 2016 04:26:34 +1100 (AEDT)
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id C5594140328
 for <linuxppc-dev@ozlabs.org>; Thu, 10 Mar 2016 04:26:33 +1100 (AEDT)
Date: Wed, 9 Mar 2016 18:26:29 +0100
From: Torsten Duwe <duwe@lst.de>
To: Petr Mladek <pmladek@suse.com>
Cc: jeyu@redhat.com, jkosina@suse.cz, jikos@kernel.org,
 linux-kernel@vger.kernel.org, rostedt@goodmis.org,
 kamalesh@linux.vnet.ibm.com, linuxppc-dev@ozlabs.org,
 live-patching@vger.kernel.org, mbenes@suse.cz
Subject: Re: [v5][PATCH] livepatch/ppc: Enable livepatching on powerpc
Message-ID: <20160309172629.GB27913@lst.de>
References: <1457422437-3357-1-git-send-email-bsingharora@gmail.com>
 <20160308104552.GA16502@lst.de> <56DED903.2000209@gmail.com>
 <20160308153435.GA23804@lst.de> <20160309161025.GN10940@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160309161025.GN10940@pathway.suse.cz>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Mar 09, 2016 at 05:10:25PM +0100, Petr Mladek wrote:
> On Tue 2016-03-08 16:34:35, Torsten Duwe wrote:
> > /* compile using "-ffixed-r14"! */
> > register unsigned long pass_TOC asm("r14");
> 
> BTW: Is this reentrant, please? I mean, is it possible to use this
> hack for two functions? Could the functions call each other?

Yes, it is. pass_TOC isn't really a global variable. It only lives
between the caller and the real function's return. With this notation
the task can easily be shifted to any other register.

	Torsten
