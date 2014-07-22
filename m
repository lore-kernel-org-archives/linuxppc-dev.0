Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F14ED1A0039
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Jul 2014 16:14:11 +1000 (EST)
Message-ID: <1406009637.22200.14.camel@pasglop>
Subject: Re: [PATCH] powerpc: Revert removing of _INIT_GLOBAL(), _STATIC()
 and _INIT_STATIC()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Steven Rostedt <rostedt@goodmis.org>
Date: Tue, 22 Jul 2014 16:13:57 +1000
In-Reply-To: <20140721145651.465db070@gandalf.local.home>
References: <20140714201204.7b6fcd8e@gandalf.local.home>
 <1405389955.9343.48.camel@pasglop>
 <20140721145651.465db070@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@lists.ozlabs.org,
 LKML <linux-kernel@vger.kernel.org>, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2014-07-21 at 14:56 -0400, Steven Rostedt wrote:
> > Weird ... what are your gcc and binutils versions ? Smells like a
> > toolchain issue to me but I need to dig a bit more. Doesn't hit any
> > of my test configs here.
> > 
> 
> Can you test the attached config with this toolchain and see if you get
> the same build bug.

Yeah ok, I hit it too, it's one of those issues with the bloody
alternate feature sections getting pushed too far away. Argh.

I'm trying to fix that trainwreck (similar issues also breaks our
allmodconfig), we have a whole mess of problems caused by our
hand crafted assembly growing beyond the reach of conditional
branches with the right set of options.

I'll see what I can do...

> https://www.kernel.org/pub/tools/crosstool/files/bin/x86_64/4.6.3/x86_64-gcc-4.6.3-nolibc_powerpc64-linux.tar.bz2
