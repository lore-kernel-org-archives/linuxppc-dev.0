Return-Path: <jbarnes@virtuousgeek.org>
Received: from cpoproxy2-pub.bluehost.com (cpoproxy2-pub.bluehost.com
	[67.222.39.38]) by ozlabs.org (Postfix) with SMTP id 82564B70B6
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 31 Jul 2010 02:42:52 +1000 (EST)
Date: Fri, 30 Jul 2010 09:42:47 -0700
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: Ben Hutchings <bhutchings@solarflare.com>
Subject: Re: [PATCH] PCI: MSI: Restore read_msi_msg_desc(); add
	get_cached_msi_msg_desc()
Message-ID: <20100730094247.05cb070e@virtuousgeek.org>
In-Reply-To: <1279893388.2089.9.camel@achroite.uk.solarflarecom.com>
References: <20100723102202.871a3131.sfr@canb.auug.org.au>
	<1279847985.4883.391.camel@localhost>
	<1279850740.6381.19.camel@concordia>
	<1279893388.2089.9.camel@achroite.uk.solarflarecom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	ppc-dev <linuxppc-dev@lists.ozlabs.org>,
	LKML <linux-kernel@vger.kernel.org>, linux-pci <linux-pci@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 23 Jul 2010 14:56:28 +0100
Ben Hutchings <bhutchings@solarflare.com> wrote:

> commit 2ca1af9aa3285c6a5f103ed31ad09f7399fc65d7 "PCI: MSI: Remove
> unsafe and unnecessary hardware access" changed read_msi_msg_desc() to
> return the last MSI message written instead of reading it from the
> device, since it may be called while the device is in a reduced
> power state.
> 
> However, the pSeries platform code really does need to read messages
> from the device, since they are initially written by firmware.
> Therefore:
> - Restore the previous behaviour of read_msi_msg_desc()
> - Add new functions get_cached_msi_msg{,_desc}() which return the
>   last MSI message written
> - Use the new functions where appropriate
> 
> Signed-off-by: Ben Hutchings <bhutchings@solarflare.com>
> ---
> Compile-tested only.
> 

Applied to linux-next with Michael's ack, thanks.  I hope it actually
works, I didn't see a tested-by!

-- 
Jesse Barnes, Intel Open Source Technology Center
