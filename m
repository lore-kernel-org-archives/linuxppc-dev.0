Return-Path: <kumar.gala@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A5C16DDE11
	for <linuxppc-dev@ozlabs.org>; Sat,  7 Feb 2009 03:37:13 +1100 (EST)
Message-Id: <291AD70D-BBC6-42B7-AF7A-0968C35C58A2@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
To: Michael Neuling <mikey@neuling.org>
In-Reply-To: <1436.1233879027@neuling.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: Build breakage for CONFIG_PM but no CONFIG_SUSPEND 
Date: Fri, 6 Feb 2009 10:37:04 -0600
References: <1436.1233879027@neuling.org>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Feb 5, 2009, at 6:10 PM, Michael Neuling wrote:

> I noticed this doing some randconfig testing (.config below).  I have
> CONFIG_PM but no CONFIG_SUSPEND.  Bug is against mainline.
>
> arch/powerpc/sysdev/built-in.o: In function `ipic_suspend':
> ipic.c:(.text+0x6b34): undefined reference to `fsl_deep_sleep'
> make[1]: *** [.tmp_vmlinux1] Error 1
> make: *** [sub-make] Error 2
>
> Looks like #ifdef CONFIG_PM in arch/powerpc/sysdev/ipic.c should be
> CONFIG_SUSPEND.  d49747bdfb2ddebea24d1580da55b79d093d48a9 introduced
> this.
>
> Maybe this fixes it?
>
>
> Fix build when we have CONFIG_PM but no CONFIG_SUSPEND.
>
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> ---
> arch/powerpc/sysdev/ipic.c |    2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

applied (ignore my noise from earlier)

- k
