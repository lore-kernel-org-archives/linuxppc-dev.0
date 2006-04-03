Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C1B4E679FF
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Apr 2006 02:16:37 +1000 (EST)
Subject: Re: _machine removal breaks kexec?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Anton Blanchard <anton@samba.org>
In-Reply-To: <20060403014044.GA4704@krispykreme>
References: <20060403014044.GA4704@krispykreme>
Content-Type: text/plain
Date: Mon, 03 Apr 2006 18:16:34 +0200
Message-Id: <1144080994.4449.10.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2006-04-03 at 11:40 +1000, Anton Blanchard wrote:
> Hi,
> 
> It looks like the _machine removal broke kexec:
> 
>  # kexec -l vmlinux
>  /proc/device-tree/chosen/linux,platform: No such file or directory
> 
> The kexec tools seem to want the linux,platform property:
> 
>         /* if LPAR, no need to read any more from /chosen */
>         if (platform != PLATFORM_PSERIES) {
>                 closedir(cdir);
>                 continue;
>         }

Damn.... the platform numbers are gone, we need to fix that. (And nobody
complained when I posted the patch twice over the past couple of monthes
btw).

I suppose kexec needs to look for /rtas/hypertas or such ..

Ben.
