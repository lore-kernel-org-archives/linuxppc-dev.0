Return-Path: <bhutchings@solarflare.com>
Received: from smtp.covadwireless.com (smtp.covadwireless.com [216.237.6.30])
	by ozlabs.org (Postfix) with ESMTP id 45387B7182
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Sep 2010 04:05:06 +1000 (EST)
Received: from mail.nextweb.net (mail.nextweb.net [216.237.6.33])
	by smtp.covadwireless.com (Spam & Virus Firewall) with ESMTP id
	53E304AC3F6
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Sep 2010 11:05:04 -0700 (PDT)
Received: from mail.nextweb.net (mail.nextweb.net [216.237.6.33]) by
	smtp.covadwireless.com with ESMTP id H6fD6pGns0z9ncM0 for
	<linuxppc-dev@ozlabs.org>; Thu, 02 Sep 2010 11:05:04 -0700 (PDT)
Received: from unknown (HELO exchange.solarflare.com) ([216.237.3.220])
	(envelope-sender <bhutchings@solarflare.com>)
	by mail.nextweb.net (qmail-ldap-1.03) with SMTP
	for <linuxppc-dev@ozlabs.org>; 2 Sep 2010 18:05:02 -0000
Subject: Re: [v2 PATCH] ucc_geth: fix ethtool set ring param bug
From: Ben Hutchings <bhutchings@solarflare.com>
To: Liang Li <liang.li@windriver.com>
In-Reply-To: <1283443364-2136-1-git-send-email-liang.li@windriver.com>
References: <1283305429-8426-1-git-send-email-liang.li@windriver.com>
	<1283443364-2136-1-git-send-email-liang.li@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 02 Sep 2010 19:04:59 +0100
Message-ID: <1283450699.2272.18.camel@achroite.uk.solarflarecom.com>
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

On Fri, 2010-09-03 at 00:02 +0800, Liang Li wrote:
> It's common sense that when we should do change to driver ring
> desc/buffer etc only after 'stop/shutdown' the device. When we
> do change while devices/driver is running, kernel oops occur:
[...]
> +		printk(KERN_INFO "Reactivating interface %s.\n", netdev->name);
> +		ret = ucc_geth_open(netdev);
> +		if (ret) {
> +			printk(KERN_WARNING "uec_set_ringparam: set ring param for running"
> +					" interface %s failed. Please try again.\n", netdev->name);
> +			dev_close(netdev);
[...]

If ucc_geth_open() failed you MUST NOT call ucc_geth_close(), but that
is what dev_close() is going to do.  But the device is still flagged as
running so 'ifconfig down' is going to call dev_close() as well.  There
is no way out.

This is why I said you must call dev_close() and then dev_open()
instead.  Then if dev_open() fails, just print the error, e.g.:

               dev_close(netdev);
               ret = dev_open(netdev);
               if (ret)
                       netdev_err(netdev,
                                  "uec_set_ringparam: failed to restart"
                                  " interface with new ring parameters\n");

(And I think this really is a serious error, hence the 'err' rather than
'warning' severity.)

(By the way, I noticed there are other places where ucc_geth_close() and
ucc_geth_open() are called, without error checking.  These are also
bugs, but that doesn't justify adding new bugs.)

Ben.

-- 
Ben Hutchings, Senior Software Engineer, Solarflare Communications
Not speaking for my employer; that's the marketing department's job.
They asked us to note that Solarflare product names are trademarked.
