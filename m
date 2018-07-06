Return-Path: <tim@seoss.co.uk>
Received: from relay1.allsecuredomains.com (relay1.allsecuredomains.com
 [78.47.251.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41MdVL6RbTzDqBW
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Jul 2018 01:11:37 +1000 (AEST)
To: linuxppc-dev@lists.ozlabs.org
From: Tim Small <tim@seoss.co.uk>
Cc: Scott Wood <oss@buserror.net>, Kumar Gala <galak@kernel.crashing.org>
Subject: NXP p1010se device trees only correct for P1010E/P1014E, not
 P1010/P1014 SoCs.
Message-ID: <1ed6ce0c-f7df-615b-ffdb-8dab25b506f6@seoss.co.uk>
Date: Fri, 6 Jul 2018 15:50:27 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

I contributed a patch to OpenWRT a couple of days ago to fix the device 
tree for a device which uses an NXP p1014 without the SEC4 module.  I 
was wondering about getting a similar fix applied upstream...

The device uses the P1014 (without SEC4 functionality), and includes:

fsl/p1010si-pre.dtsi and fsl/p1010si-post.dtsi

... in its device tree.  The latter pulls in leads to a node for 
soc@ffe00000/crypto@30000 - which then causes the CAAM modules to be 
used for crypto operations, when then fail at runtime.

AN4938 states that there are versions of both the p1010 and p1014 
without the SEC4 module.

The P1010 errata at:

https://media.digikey.com/pdf/PCNs/Freescale/P1010CE_RevL.pdf

(table 2 on page 2), says that the P1010 and P1014 don't have the SEC4 
module, only the P1010E and P1014E models do.

So, I think there should probably be device trees for p101xE (with SEC) 
and p101x (without SEC).

Any thoughts?  Not really sure how best to do that...  My openwrt patch 
just does a:

/delete-node/ crypto@30000;

after the p1010si-post.dtsi include.

Cheers,

Tim.
-- 
South East Open Source Solutions Limited
Registered in England and Wales with company number 06134732.
Registered Office: 2 Powell Gardens, Redhill, Surrey, RH1 1TQ
VAT number: 900 6633 53  http://seoss.co.uk/ +44-(0)1273-808309
