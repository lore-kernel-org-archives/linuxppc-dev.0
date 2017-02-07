Return-Path: <hmurray@megapathdsl.net>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vHfrb2Y1MzDqC7
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Feb 2017 20:57:03 +1100 (AEDT)
To: Michael Ellerman <michael@ellerman.id.au>
cc: Hal Murray <hmurray@megapathdsl.net>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Hugh Blemings <hugh@blemings.org>, linuxppc-dev@ozlabs.org,
 devel@ntpsec.org, Paul Mackerras <paulus@ozlabs.org>
From: Hal Murray <hmurray@megapathdsl.net>
Subject: Re: Timekeeping oddities on MacMini G4s
In-Reply-To: Message from Michael Ellerman <michael@ellerman.id.au>
 of "Tue, 07 Feb 2017 13:21:40 +1100." <87h946g2q3.fsf@concordia.ellerman.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 07 Feb 2017 01:56:59 -0800
Message-Id: <20170207095659.41AC2406076@ip-64-139-1-69.sjc.megapath.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> What do I do if I don't have an existing ntp.conf ?

Assuming ntpsec builds...

There are sample config files in config/
  contrib/ntp.conf.log.sample has logging which you probably want.
it has lots of comments.

It is setup to use us.pool.ntp.org
If you aren't in the us, you should probably change that to your country code.

If you know of any good servers near your location (by network quality, not 
miles/km), you can add them with:
  server <ip-address-or-name> iburst

It will write in several files:
  /var/lib/ntp/ntp.drift
  /var/log/ntp.log
  /var/log/ntpstats/<various>
So you need to make sure the directories exist.


Turn off whatever is currently keeping time on your system.

./build/main/ntpd/ntpd -N -c ./contrib/ntp.conf.log.sample

(It may need a file name starting at /)


-- 
These are my opinions.  I hate spam.
