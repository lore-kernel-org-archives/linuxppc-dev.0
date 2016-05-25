Return-Path: <rpjday@crashcourse.ca>
Received: from smtp685.redcondor.net (smtp685.redcondor.net [208.80.206.85])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rFFp008S1zDqW4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 May 2016 01:00:38 +1000 (AEST)
Received: from astoria.ccjclearline.com ([64.235.106.9])
 by smtp685.redcondor.net ({20c8e40f-6b6c-4c9e-abff-1640ea7bf404})
 via TCP (outbound) with ESMTPS id 20160525150028713_0685
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 May 2016 08:00:28 -0700
Received: from [216.191.234.70] (port=12546 helo=crashcourse.ca)
 by astoria.ccjclearline.com with esmtpsa (TLSv1:AES256-SHA:256)
 (Exim 4.80) (envelope-from <rpjday@crashcourse.ca>)
 id 1b5aJx-0007bZ-B3
 for linuxppc-dev@lists.ozlabs.org; Wed, 25 May 2016 11:02:05 -0400
Date: Wed, 25 May 2016 10:59:51 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
To: Linux PPC Mailing List <linuxppc-dev@lists.ozlabs.org>
Subject: how can i see the *actual* bus and brg frequencies on running system?
Message-ID: <alpine.LFD.2.20.1605251052330.30194@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


  i asked about this a while ago, didn't see any response, and i'm
still curious ... i have an MPC8360 system, ported u-boot to it, and
in the dts file i got from someone, the bus and brg frequencies were
set to lower values than they should have been, but we left them there
and, once the system was up, i tried to check what the *actual*
frequencies were being used.

  i checked under both /proc/device-tree, and way down under /sys, and
both showed lower frequencies, but one of the embedded guys wrote a
utility to read the actual PPC register that contained the bus
frequency, and assured us it was running at 533MHz, which is what we
wanted all along.

  so dts stuff aside, is there a simple user space way to display the
frequencies that are actually being used on the system? because it
appears that what's under both /proc and /sys are showing only what is
set in the device tree blob passed to the kernel, but that's not where
the kernel is getting the final value from.

rday

p.s. we got the BSP for this board from elsewhere, so it's possible
that during kernel boot, the kernel has been patched to ignore what it
sees in the DTB, and gets the value from somewhere unique to this BSP.

  but still, if that's the case, should it not still be possible to
view the frequency that was finally set and used on the running
system?

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
