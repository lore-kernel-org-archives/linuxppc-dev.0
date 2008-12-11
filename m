Return-Path: <timur.tabi@gmail.com>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.31])
	by ozlabs.org (Postfix) with ESMTP id 8302CDDF85
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Dec 2008 02:12:56 +1100 (EST)
Received: by yw-out-2324.google.com with SMTP id 5so435186ywh.39
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Dec 2008 07:12:54 -0800 (PST)
Message-ID: <ed82fe3e0812110712r4baeea60ied52937aa434f48e@mail.gmail.com>
Date: Thu, 11 Dec 2008 09:12:54 -0600
From: "Timur Tabi" <timur@freescale.com>
Sender: timur.tabi@gmail.com
To: "Peter Czanik" <pczanik@fang.fa.gau.hu>
Subject: Re: MPC8610HPCD sound as module
In-Reply-To: <49411308.1050008@fang.fa.gau.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <49411308.1050008@fang.fa.gau.hu>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Dec 11, 2008 at 7:18 AM, Peter Czanik <pczanik@fang.fa.gau.hu> wrote:
> Hello,
>
> I have an MPC8610HPCD system. The latest stable kernel (2.6.27.8) runs
> fine on this, with a catch: sound only works, when compiled in the
> kernel

That's because the driver doesn't support being compiled as a module.
The Kconfig, as *I* wrote it, only allows for in-kernel compilation.

The only way you could have gotten my drivers to compile as a module
is if you hacked the Kconfig.

> As far as I can see from comments in the sources, it should work also as
> a module. Any hints how to achieve that?

The ASoC V2 version of the driver supports loading as a module.  ASoC
V1 does not support loading sound drivers as modules, which is why I
didn't implement that support in the V1 drivers.  The 2.6.27 kernel
has ASoC V1.  ASoC V2 won't be integrated into the mainline until at
least 2.6.29, and maybe even 2.6.30.  The ASoC V2 repository is
available at http://opensource.wolfsonmicro.com/cgi-bin/gitweb.cgi?p=linux-2.6-asoc.git
under the asoc-v2-dev branch.

-- 
Timur Tabi
Linux kernel developer at Freescale
