Return-Path: <benh@kernel.crashing.org>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp08.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id F1425B7006
 for <linuxppc-dev@ozlabs.org>; Thu, 19 Apr 2012 19:04:50 +1000 (EST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <benh@kernel.crashing.org>;
 Thu, 19 Apr 2012 08:18:55 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q3J8DD741671264
 for <linuxppc-dev@ozlabs.org>; Thu, 19 Apr 2012 18:13:13 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q3J8JmT6008266
 for <linuxppc-dev@ozlabs.org>; Thu, 19 Apr 2012 18:19:49 +1000
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 00/15] PowerMac i2c API conversions & windfarm updates
Date: Thu, 19 Apr 2012 18:16:41 +1000
Message-Id: <1334823416-9138-1-git-send-email-benh@kernel.crashing.org>
Cc: khali@linux-fr.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The goal of this series is to convert a bulk of PowerMac i2c drivers
to the new "proper" i2c driver registration model. This series is
not complete in that there are still a few drivers to do but it
goes through the bulk of thermal control and some of the nastiest.

The biggest change is that windfarm is ported to generally use
the new model, and I've written a new set of windfarm modules to
take over from the old therm_pm72 (which was mostly unfixable)
on the PowerMac G5 AGP and Xserve G5 machines.

This had a bit of testing on a couple of PowerMac G5 AGP variants
but none at all on Xserve G5 since the one I have is unfortunately
dead.

If you want to help me test this, don't forget to disable therm_pm72,
and instead load windfarm_pm72 or windfarm_rm31 depending on your
machine (you can load or build-in the whole lot as well). As usual
windfarm don't properly auto-load yet, I still need to fix that.

So please test ! Especially if you have an XServe G5
