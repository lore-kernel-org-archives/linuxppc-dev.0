Return-Path: <jikos@kernel.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 421011A0060
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Feb 2016 07:39:25 +1100 (AEDT)
Date: Tue, 2 Feb 2016 21:39:21 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Petr Mladek <pmladek@suse.com>
cc: Torsten Duwe <duwe@lst.de>, Miroslav Benes <mbenes@suse.cz>,
 Steven Rostedt <rostedt@goodmis.org>,
 Michael Ellerman <mpe@ellerman.id.au>, anton@samba.org,
 linuxppc-dev@lists.ozlabs.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 live-patching@vger.kernel.org
Subject: Re: [PATCH v6 8/9] Implement kernel live patching for ppc64le (ABIv2)
In-Reply-To: <20160202164714.GU3305@pathway.suse.cz>
Message-ID: <alpine.LNX.2.00.1602022135290.22727@cbobk.fhfr.pm>
References: <20160125170459.14DB7692CE@newverein.lst.de>
 <20160125170804.A11DB692DD@newverein.lst.de>
 <alpine.LNX.2.00.1601261142190.24510@pobox.suse.cz>
 <20160126124853.GL3305@pathway.suse.cz>
 <20160202121224.GS3305@pathway.suse.cz> <20160202154523.GF32095@lst.de>
 <20160202164714.GU3305@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2 Feb 2016, Petr Mladek wrote:

> Note that TOC is not set only when the problematic functions are 
> compiled with --mprofile-kernel. I still see the TOC stuff when 
> compiling only with -pg.

I don't see how this wouldn't be a gcc bug.

No matter whether it's plain profiling call (-pg) or kernel profiling call 
(-mprofile-kernel), gcc must always assume that global function (that will 
typically have just one instance for the whole address space) will be 
called.

-- 
Jiri Kosina
SUSE Labs
