Return-Path: <miltonm@bga.com>
Received: from kcout02.prserv.net (kcout02.prserv.net [12.154.55.32])
	by ozlabs.org (Postfix) with ESMTP id DD8C0DDE27
	for <linuxppc-dev@ozlabs.org>; Mon,  4 Jun 2007 19:22:50 +1000 (EST)
In-Reply-To: <25445.1180941825@neuling.org>
References: <25445.1180941825@neuling.org>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <8f5d8a214e9042b0c556ac7256928a52@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH] kexec ppc64: fix misaligned cmdline
Date: Mon, 4 Jun 2007 04:22:33 -0500
To: Michael Neuling <mikey@neuling.org>
Cc: linuxppc-dev@ozlabs.org, horms@verge.net.au, kexec@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 4, 2007, at 2:23 AM, Michael Neuling wrote:

> If the cmdline changes between boots, we can get misalignment of the
> bootargs entry, which in turn corrupts our device tree blob and hence
> kills our kexec boot.
...
> -		if ((len >= 8) && ((unsigned long)dt & 0x4))
> +		if ((len >= 8) && ((unsigned long)dt & 0x4)){
>  			dt++;
> +			dt_realigned = 1;
> +		}
>
>  		fd = open(pathname, O_RDONLY);
>  		if (fd == -1)
> @@ -283,6 +286,8 @@ static void putprops(char *fn, struct di
>  			strcat(local_cmdline, " ");
>  			cmd_len = strlen(local_cmdline);
>  			cmd_len = cmd_len + 1;
> +			if (dt_realigned && cmd_len < 8)
> +				dt--;
>  	

While this appears to fix the stated problem, did you explore my
suggestion of deleting and creating the property like we do for
the initrd base and size?

Deleting and recreating should also handle the case of no
boot-args in the original /chosen sub-tree (when the bootloader
didn't (need to) supply a command line).

milton
