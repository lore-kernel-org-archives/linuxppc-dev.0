Return-Path: <bhutchings@solarflare.com>
Received: from smtp.covadwireless.com (smtp.covadwireless.com [216.237.6.30])
	by ozlabs.org (Postfix) with ESMTP id EE744B7170
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Sep 2010 02:33:04 +1000 (EST)
Received: from mail.nextweb.net (mail.nextweb.net [216.237.6.33])
	by smtp.covadwireless.com (Spam & Virus Firewall) with ESMTP id
	11BD44AC3F6
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Sep 2010 09:33:01 -0700 (PDT)
Received: from mail.nextweb.net (mail.nextweb.net [216.237.6.33]) by
	smtp.covadwireless.com with ESMTP id 0JDl3MUQFSg2dWWX for
	<linuxppc-dev@ozlabs.org>; Thu, 02 Sep 2010 09:33:01 -0700 (PDT)
Received: from unknown (HELO exchange.solarflare.com) ([216.237.3.220])
	(envelope-sender <bhutchings@solarflare.com>)
	by mail.nextweb.net (qmail-ldap-1.03) with SMTP
	for <linuxppc-dev@ozlabs.org>; 2 Sep 2010 16:32:59 -0000
Subject: Re: [v1 PATCH] ucc_geth: fix ethtool set ring param bug
From: Ben Hutchings <bhutchings@solarflare.com>
To: Liang Li <liang.li@windriver.com>
In-Reply-To: <20100902154818.GA30293@localhost>
References: <1283179677-21262-1-git-send-email-liang.li@windriver.com>
	<1283305429-8426-1-git-send-email-liang.li@windriver.com>
	<1283348550.2268.7.camel@achroite.uk.solarflarecom.com>
	<20100902005034.GA9901@localhost>
	<1283425907.2272.0.camel@achroite.uk.solarflarecom.com>
	<20100902154818.GA30293@localhost>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 02 Sep 2010 17:32:56 +0100
Message-ID: <1283445176.2272.3.camel@achroite.uk.solarflarecom.com>
Mime-Version: 1.0
Cc: netdev@vger.kernel.org, avorontsov@ru.mvista.com, davem@davemloft.net,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2010-09-02 at 23:48 +0800, Liang Li wrote:
> On Thu, Sep 02, 2010 at 12:11:47PM +0100, Ben Hutchings wrote:
> > On Thu, 2010-09-02 at 08:50 +0800, Liang Li wrote:
> > > On Wed, Sep 01, 2010 at 02:42:30PM +0100, Ben Hutchings wrote:
> > > > On Wed, 2010-09-01 at 09:43 +0800, Liang Li wrote:
> > > > > It's common sense that when we should do change to driver ring
> > > > > desc/buffer etc only after 'stop/shutdown' the device. When we
> > > > > do change while devices/driver is running, kernel oops occur:
> > > > [...]
> > > > > -	ug_info->bdRingLenRx[queue] = ring->rx_pending;
> > > > > -	ug_info->bdRingLenTx[queue] = ring->tx_pending;
> > > > > -
> > > > >  	if (netif_running(netdev)) {
> > > > > -		/* FIXME: restart automatically */
> > > > > -		printk(KERN_INFO
> > > > > -			"Please re-open the interface.\n");
> > > > > +		u16 rx_t;
> > > > > +		u16 tx_t;
> > > > > +		printk(KERN_INFO "Stopping interface %s.\n", netdev->name);
> > > > > +		ucc_geth_close(netdev);
> > > > > +
> > > > > +		rx_t = ug_info->bdRingLenRx[queue];
> > > > > +		tx_t = ug_info->bdRingLenTx[queue];
> > > > > +
> > > > > +		ug_info->bdRingLenRx[queue] = ring->rx_pending;
> > > > > +		ug_info->bdRingLenTx[queue] = ring->tx_pending;
> > > > > +
> > > > > +		printk(KERN_INFO "Reactivating interface %s.\n", netdev->name);
> > > > > +		ret = ucc_geth_open(netdev);
> > > > > +		if (ret) {
> > > > > +			printk(KERN_WARNING "uec_set_ringparam: set ring param for running"
> > > > > +					" interface %s failed. Please try to make the interface "
> > > > > +					" down, then try again.\n", netdev->name);
> > > > > +			ug_info->bdRingLenRx[queue] = rx_t;
> > > > > +			ug_info->bdRingLenTx[queue] = tx_t;
> > > > > +		}
> > > > [...]
> > > > 
> > > > Bringing the interface down will call ucc_geth_close(), which will try
> > > > to free resources that have not been allocated!
> > > 
> > > Sorry, I did not understand you on this point. There is no
> > > ucc_geth_close when 'open fail'. What you mean here exactly?
> > [...]
> > 
> > Read your own warning.
> 
> So the warning is mis-leading... We may not need it... Still, let's talk
> about the rare case that 'fail of open', may you please show me what is
> the right thing to do 'clean up work' when ever the open fail. Maybe
> dev_close(net_dev)?

I give up.

Just s/ucc_geth_open/dev_open/ and s/ucc_geth_close/dev_close/.

Ben.

-- 
Ben Hutchings, Senior Software Engineer, Solarflare Communications
Not speaking for my employer; that's the marketing department's job.
They asked us to note that Solarflare product names are trademarked.
