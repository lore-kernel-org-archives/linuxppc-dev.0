Return-Path: <greg@kroah.com>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0673BB6F88
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 20 May 2011 00:31:23 +1000 (EST)
Date: Thu, 19 May 2011 07:22:25 -0700
From: Greg KH <greg@kroah.com>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 6/7] tty/powerpc: introduce the ePAPR embedded hypervisor
	byte channel driver
Message-ID: <20110519142225.GC21441@kroah.com>
References: <1305813272-31826-1-git-send-email-timur@freescale.com>
	<1305813272-31826-7-git-send-email-timur@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1305813272-31826-7-git-send-email-timur@freescale.com>
Cc: kumar.gala@freescale.com, linux-kernel@vger.kernel.org, akpm@kernel.org,
	linux-console@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, May 19, 2011 at 08:54:31AM -0500, Timur Tabi wrote:
> +/*
> + * The udbg subsystem calls this function to display a single character.
> + * We convert CR to a CR/LF.
> + */
> +static void ehv_bc_udbg_putc(char c)
> +{
> +	if (c == '\n')
> +		byte_channel_spin_send('\r');
> +
> +	byte_channel_spin_send(c);
> +}

Why do this conversion in the driver?  Shouldn't that be something that
userspace worries about?

thanks,

greg k-h
