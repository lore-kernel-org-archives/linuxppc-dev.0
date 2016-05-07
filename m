Return-Path: <rpjday@crashcourse.ca>
Received: from smtp486.redcondor.net (smtp486.redcondor.net [208.80.204.86])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r28Bk1Ks3zDqBn
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 May 2016 23:10:04 +1000 (AEST)
Received: from astoria.ccjclearline.com ([64.235.106.9])
 by smtp486.redcondor.net ({6695537a-536a-45f9-a249-877c85428649})
 via TCP (outbound) with ESMTPS id 20160507130957502_0486
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 07 May 2016 13:09:57 +0000
Received: from [216.191.234.70] (port=60000 helo=crashcourse.ca)
 by astoria.ccjclearline.com with esmtpsa (TLSv1:AES256-SHA:256)
 (Exim 4.80) (envelope-from <rpjday@crashcourse.ca>)
 id 1az213-0005SN-8v
 for linuxppc-dev@lists.ozlabs.org; Sat, 07 May 2016 09:11:29 -0400
Date: Sat, 7 May 2016 09:09:31 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
To: Linux PPC Mailing List <linuxppc-dev@lists.ozlabs.org>
Subject: followup: kernel manipulation of {bus,brg}-frequency for MPC8360?
Message-ID: <alpine.LFD.2.20.1605070850530.5054@localhost.localdomain>
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


  followup to earlier post and WARNING -- my ppc dev box is suddenly
off the net so i'm doing all this from memory. le *sigh*.

  again in context of porting linux (4.1 kernel, using v2015.10 uboot)
to MPC8360 target, a couple of questions.

  first, while in this case u-boot might be modifying some of the
values in the DTB before passing it to the kernel, is it true that the
contents of the /proc/devicetree directory on the running linux system
represent the DTB as it was passed from u-boot, or after it was
possibly modified by the PPC kernel boot code? (clearly, this isn't
exclusively a PPC issue -- it's a more general device tree issue.)

  second (and more involved) question, i noticed pretty quickly that
the two frequency values i was interested in were visible under /sys
... from memory, /sys/firmware(?).../ and so on. i also noticed they
were stored in internal format so i needed to run them through
"hexdump" to get their values, no problem.

  i'm assuming *those* values for {bus,brg}-frequency visible under
/sys *are* the final values, after possible processing by the kernel
boot code. in my case (MPC8360), which ppc boot files are responsible
for checking the values passed in the DTB and possibly adjusting them
early in the boot process?

  not looking for extensive explanation, i already see what look like
potentially relevant files under arch/powerpc:

  * sysdev/fsl_soc.c
  * sysdev/qe_lib/qe.c
  * boot/devtree.c

am i at least looking in the right place? thanks.

rday

p.s. if there is something online that addresses the values of
bus-frequency and brg-frequency that's relevant, by all means, let me
know. i'm just perusing the kernel doc file
Documentation/devicetree/bindings/powerpc/fsl/cpm_qe/qe.txt

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
