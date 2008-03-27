Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound8-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id A51E4DDF9D
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Mar 2008 12:04:15 +1100 (EST)
Message-ID: <47EAF288.5080407@am.sony.com>
Date: Wed, 26 Mar 2008 18:04:08 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: benh@kernel.crashing.org
Subject: Re: [patch 5/6] PS3: Sys-manager Wake-on-LAN support
References: <20080327001821.827672589@am.sony.com>	
	<47EAECA8.5030707@am.sony.com> <1206579226.6926.64.camel@pasglop>
In-Reply-To: <1206579226.6926.64.camel@pasglop>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, jgarzik@pobox.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

Benjamin Herrenschmidt wrote:
> On Wed, 2008-03-26 at 17:39 -0700, Geoff Levand wrote:
>> Add Wake-on-LAN support to the PS3 system-manager.  Other OS WOL
>> support was introduced in PS3 system firmware 2.20.
> 
> There is no sleep in the first place tho :-) Or does this power it up /
> boot it using WoL packets ?

Whenever that red light in ON in the front, the system is in 'stand by'
mode.  If you setup WOL before entering standby mode (by using linux
poweroff command, pressing the power button, etc.), you can wake it up:

  On ps3
  # ethtool -s eth0 wol g
  # shutdown -h now

  by remote host (eth1 is connected to the subnet which PS3 resides in)
  # etherwake -i eth1 aa:bb:cc:dd:ee:ff


I plan to send out a how-to to the ceb-oss-dev ML in the next day or so.

-Geoff
