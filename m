Return-Path: <Liang.Li@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.windriver.com",
	Issuer "Intel External Basic Issuing CA 3A" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 7D495B71A6
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Sep 2010 11:18:41 +1000 (EST)
Date: Fri, 3 Sep 2010 09:20:29 +0800
From: Liang Li <liang.li@windriver.com>
To: Ben Hutchings <bhutchings@solarflare.com>
Subject: Re: [v2 PATCH] ucc_geth: fix ethtool set ring param bug
Message-ID: <20100903012029.GB9901@localhost>
References: <1283305429-8426-1-git-send-email-liang.li@windriver.com>
	<1283443364-2136-1-git-send-email-liang.li@windriver.com>
	<1283450699.2272.18.camel@achroite.uk.solarflarecom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1283450699.2272.18.camel@achroite.uk.solarflarecom.com>
Cc: netdev@vger.kernel.org, avorontsov@ru.mvista.com, davem@davemloft.net,
	linuxppc-dev@ozlabs.org
Reply-To: Liang Li <liang.li@windriver.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Sep 02, 2010 at 07:04:59PM +0100, Ben Hutchings wrote:
> On Fri, 2010-09-03 at 00:02 +0800, Liang Li wrote:
> > It's common sense that when we should do change to driver ring
> > desc/buffer etc only after 'stop/shutdown' the device. When we
> > do change while devices/driver is running, kernel oops occur:
> [...]
> > +		printk(KERN_INFO "Reactivating interface %s.\n", netdev->name);
> > +		ret = ucc_geth_open(netdev);
> > +		if (ret) {
> > +			printk(KERN_WARNING "uec_set_ringparam: set ring param for running"
> > +					" interface %s failed. Please try again.\n", netdev->name);
> > +			dev_close(netdev);
> [...]
> 
> If ucc_geth_open() failed you MUST NOT call ucc_geth_close(), but that
> is what dev_close() is going to do.  But the device is still flagged as
> running so 'ifconfig down' is going to call dev_close() as well.  There
> is no way out.

dev_close is safe enough IMHO. Call dev_close repeatly won't cause
problem though.

> 
> This is why I said you must call dev_close() and then dev_open()
> instead.  Then if dev_open() fails, just print the error, e.g.:
> 
>                dev_close(netdev);
>                ret = dev_open(netdev);
>                if (ret)
>                        netdev_err(netdev,
>                                   "uec_set_ringparam: failed to restart"
>                                   " interface with new ring parameters\n");
> 
> (And I think this really is a serious error, hence the 'err' rather than
> 'warning' severity.)

I checked NIC drivers in drivers/net, there is no such:

	dev_close(netdev);
	ret = dev_open(netdev)
	if (ret)
		netdev_err(...);

Instead, there are:

	nic_driver_close/down(netdev);
	ret = nic_driver_open/restart(netdev);
	if (ret) {
		waring;
		dev_close(netdev);
	}

> 
> (By the way, I noticed there are other places where ucc_geth_close() and
> ucc_geth_open() are called, without error checking.  These are also
> bugs, but that doesn't justify adding new bugs.)

I think I did not invite new bugs, as I mentioned before, can you show
scenario that the reopen fail and perfect cleanup way?

Thanks,
				-Liang Li

> 
> Ben.
> 
> -- 
> Ben Hutchings, Senior Software Engineer, Solarflare Communications
> Not speaking for my employer; that's the marketing department's job.
> They asked us to note that Solarflare product names are trademarked.
