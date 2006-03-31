Return-Path: <greg@kroah.com>
Received: from perch.kroah.org (mail.kroah.org [69.55.234.183])
	by ozlabs.org (Postfix) with ESMTP id 2E280679E1
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Mar 2006 16:51:49 +1100 (EST)
Date: Thu, 30 Mar 2006 21:46:54 -0800
From: Greg KH <greg@kroah.com>
To: Linas Vepstas <linas@austin.ibm.com>
Subject: Re: [PATCH]: e1000: prevent statistics from getting garbled during
	reset.
Message-ID: <20060331054654.GA6632@kroah.com>
References: <20060330213928.GQ2172@austin.ibm.com>
	<20060331000208.GS2172@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060331000208.GS2172@austin.ibm.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	jesse.brandeburg@intel.com, linuxppc-dev@ozlabs.org,
	john.ronciak@intel.com, jeffrey.t.kirsher@intel.com,
	linux-pci@atrey.karlin.mff.cuni.cz, Jeff Garzik <jgarzik@pobox.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Mar 30, 2006 at 06:02:08PM -0600, Linas Vepstas wrote:
> -	/* Prevent stats update while adapter is being reset */
> +	/* Prevent stats update while adapter is being reset,
> +	 * or if the pci connection is down. */
>  	if (adapter->link_speed == 0)
>  		return;
> +   if (pdev->error_state && pdev->error_state != pci_channel_io_normal)
> +		return;

Coding style is still wrong here :(

(hint, use a tab...)

thanks,

greg k-h
