Return-Path: <lists@nerdbynature.de>
Received: from trent.utfs.org (trent.utfs.org [94.185.90.103])
 by ozlabs.org (Postfix) with ESMTP id 1C7A32C00D1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Sep 2013 19:24:49 +1000 (EST)
Date: Thu, 26 Sep 2013 02:16:16 -0700 (PDT)
From: Christian Kujau <lists@nerdbynature.de>
To: colin@colino.net, khali@linux-fr.org, linuxppc-dev@lists.ozlabs.org
Subject: therm_adt746x: -3 invalid for parameter limit_adjust
Message-ID: <alpine.DEB.2.11.1309260202480.6519@trent.utfs.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

after upgrading from 3.11 to 3.12-rc2, the therm_adt746x module could not 
be loaded any more:

  therm_adt746x: `-2' invalid for parameter `limit_adjust'

I've alwasy passed "limit_adjust=-3" (negative 3) to the module via 
modprobe.conf, to lower the max temperature. Up until 3.11, loading the 
module would print:

  adt746x: Lowering max temperatures from 73, 80, 109 to 67, 47, 67

I can load the module without limit_adjust or with positive values, but 
really wanted to lower the temperature, so that the fan would kick in 
earlier. For reference, this is what happens in 3.12-rc2:

 v--- limit_adjust
 |
 0: adt746x: Lowering max temperatures from 73, 80, 109 to 70, 50, 70
 1: adt746x: Lowering max temperatures from 73, 80, 109 to 71, 51, 71
 2: adt746x: Lowering max temperatures from 73, 80, 109 to 72, 52, 72
 3: adt746x: Lowering max temperatures from 73, 80, 109 to 73, 53, 73
 4: adt746x: Lowering max temperatures from 73, 80, 109 to 74, 54, 74
10: adt746x: Lowering max temperatures from 73, 80, 109 to 80, 60, 80

Was passing negative values to therm_adt746x ever supported? 

drivers/macintosh/therm_adt746x.c hasn't been touched in a while, this 
means some other change did it.

Before I attempt a full git bisect, any hints what could have caused this?

Thanks,
Christian.
-- 
BOFH excuse #339:

manager in the cable duct
