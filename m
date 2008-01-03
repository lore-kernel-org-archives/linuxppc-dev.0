Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 89D2ADDE01
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  4 Jan 2008 03:21:48 +1100 (EST)
Date: Thu, 3 Jan 2008 10:30:19 -0600
From: Olof Johansson <olof@lixom.net>
To: Misbah khan <misbah_khan@engineer.com>
Subject: Re: Reading a config file in a driver ....
Message-ID: <20080103163019.GA4223@lixom.net>
References: <14591717.post@talk.nabble.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <14591717.post@talk.nabble.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, Jan 02, 2008 at 09:03:20PM -0800, Misbah khan wrote:
> 
> Hi all ....
> 
> I am writing a LCD driver in which the default configuration for LCD would
> be loded at the Init . This default configuration if keep in the driver then
> for a change in default configuration we need to compile the driver which we
> never want . Hence we want a .config file in /etc/lcd.config dir which could
> be changed and the next boot will take this configuration as the default
> configuration. 
> 
> I need to know How to read from the config file in the driver form the dir
> /etc/lcd.config. The driver would be installed at boot up 

The driver/kernel shouldn't read the file directly, if anything you
should have a userspace tool that reads it and adjusts the driver via
sysfs or similar. That tool can be run from some of the init scripts,
or from the ramdisk in case you want to do it early.


-Olof
