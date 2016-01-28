Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5BC031A0054
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jan 2016 14:31:58 +1100 (AEDT)
Message-ID: <1453951918.4108.1.camel@ellerman.id.au>
Subject: Re: [PATCH v6 0/9] ftrace with regs + live patching for ppc64 LE
 (ABI v2)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Balbir Singh <bsingharora@gmail.com>, Torsten Duwe <duwe@lst.de>
Cc: Steven Rostedt <rostedt@goodmis.org>, Jiri Kosina <jkosina@suse.cz>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 live-patching@vger.kernel.org
Date: Thu, 28 Jan 2016 14:31:58 +1100
In-Reply-To: <20160128134157.1ac3d344@cotter.ozlabs.ibm.com>
References: <20160125170459.14DB7692CE@newverein.lst.de>
 <20160127215112.080eec56@cotter.ozlabs.ibm.com>
 <20160127121904.GB32095@lst.de>
 <20160128134157.1ac3d344@cotter.ozlabs.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-01-28 at 13:41 +1100, Balbir Singh wrote:
> On Wed, 27 Jan 2016 13:19:04 +0100
> Torsten Duwe <duwe@lst.de> wrote:
>
> > Thanks! Make sure you use a compiler that can disable -mprofile-kernel with "notrace".
> 
> gcc-6? I have gcc-5.2.1

That should work.

But that's a good point.

We need to have some Makefile logic to only enable -mprofile-kernel when it's
known to work, ie. for versions where the notrace fix is in.

Looking at GCC history it looks like the fix is in 4.9.0 and anything later.

But a version check doesn't work with patched distro/vendor toolchains. So we
probably need some sort of runtime check.

cheers
