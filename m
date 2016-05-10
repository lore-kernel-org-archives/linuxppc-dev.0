Return-Path: <rpjday@crashcourse.ca>
Received: from smtp486.redcondor.net (smtp486.redcondor.net [208.80.204.86])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r4Blg3blRzDq5s
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 May 2016 07:12:12 +1000 (AEST)
Received: from astoria.ccjclearline.com ([64.235.106.9])
 by smtp486.redcondor.net ({6695537a-536a-45f9-a249-877c85428649})
 via TCP (outbound) with ESMTPS id 20160510211209414_0486
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 May 2016 21:12:09 +0000
Received: from [99.240.204.5] (port=45852 helo=crashcourse.ca)
 by astoria.ccjclearline.com with esmtpsa (TLSv1:AES256-SHA:256)
 (Exim 4.80) (envelope-from <rpjday@crashcourse.ca>)
 id 1b0EyL-0005Cz-C7
 for linuxppc-dev@lists.ozlabs.org; Tue, 10 May 2016 17:13:41 -0400
Date: Tue, 10 May 2016 17:11:37 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
To: Linux PPC Mailing List <linuxppc-dev@lists.ozlabs.org>
Subject: on a MPC8360 system, how can i read the *actual* bus frequencies?
Message-ID: <alpine.LFD.2.20.1605101703320.6285@localhost.localdomain>
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


  bit of a conundrum here ... we have a legacy MPC8360 system here, on
which we installed linux built with wind river linux 8. we obviously
want to push the various bus frequencies to their max for best
performance, and the device tree that was being used for this system
assigned rather slow speeds (266MHz) for the various buses.

  i wasn't sure how to view the bus frequencies that were *actually*
being used. first, i thought that anything you found under
/proc/devicetree simply showed the device tree values as they were
passed to the kernel, so i wasn't going to trust those.

  also, i thought that anything under /sys would show the genuine
frequency values and, after searching, i found various PPC bus
frequencies under /sys/firmware/..., but they *also* showed fairly
slow speeds.

  finally, someone wrote a program that read directly from the
system registers:

    tempVal = *M83XX_SPMR(vxCCSBARGet());
    lbcm   = M83XX_SPMR_LBCM_VAL(tempVal);
    ddrcm = M83XX_SPMR_DDRCM_VAL(tempVal);
    spmf   = M83XX_SPMR_SPMF_VAL(tempVal);
    clkDiv      = M83XX_SPMR_CLKID_VAL(tempVal);
    corePll = M83XX_SPMR_COREPLL_VAL(tempVal);
    cepdf  = M83XX_SPMR_CEPDF_VAL(tempVal);
    cepmf  = M83XX_SPMR_CEPMF_VAL(tempVal);

which, surprisingly, showed what appears to be the maximum allowable
bus frequencies; for example

  Enter mcd command -> sysGetCoreSpeed
  value = 533332800 = 0x1fca0340

so i'm willing to believe that the system really is running at max
speed, but is there no easier way to see the bus frequencies that are
actually in use, rather than having to dig into the system registers?

  why would the values under /sys not reflect the actual bus
frequencies, and not (as it appears) just the ones passed to the
kernel which were obviously not used?

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
