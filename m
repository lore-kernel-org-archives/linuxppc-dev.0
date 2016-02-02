Return-Path: <runaway@candw.ms>
Received: from smtp754.redcondor.net (smtp754.redcondor.net [208.80.206.54])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 10F5B1A01D8
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Feb 2016 01:05:36 +1100 (AEDT)
From: Julian Margetson <runaway@candw.ms>
Subject: commit 9178ba294b6839eeff1a91bed95515d783f3ee6c
To: Alexander Graf <agraf@suse.de>
References: <54E08E06.8060607@candw.ms>
 <1424045921.3018.4.camel@ellerman.id.au> <54E4EBD7.5000307@candw.ms>
 <1424304787.22020.4.camel@ellerman.id.au> <54E53E07.60609@candw.ms>
 <1424314594.22408.1.camel@ellerman.id.au>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
Message-ID: <56B0B502.9030400@candw.ms>
Date: Tue, 2 Feb 2016 09:54:10 -0400
MIME-Version: 1.0
In-Reply-To: <1424314594.22408.1.camel@ellerman.id.au>
Content-Type: multipart/mixed; boundary="------------010602030401010803000502"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------010602030401010803000502
Content-Type: multipart/alternative;
 boundary="------------050107080603010300030701"


--------------050107080603010300030701
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Commit 9178ba294b6839eeff1a91bed95515d783f3ee6c prevents building of 
kernel 4.1 branch on A-Eon Tabor Board.

CC arch/powerpc/math-emu/fsqrt.o
arch/powerpc/platforms/85xx/tabor.c:194:2: error: unknown field 
‘power_off’ specified in initializer
   .power_off  = tabor_power_off,
   ^
make[2]: *** [arch/powerpc/platforms/85xx/tabor.o] Error 1
make[1]: *** [arch/powerpc/platforms/85xx] Error 2
make: *** [arch/powerpc/platforms] Error 2


Builds after reverting  85xx portions of commit.

commit 9178ba294b6839eeff1a91bed95515d783f3ee6c

==========================================================================================================
commit 9178ba294b6839eeff1a91bed95515d783f3ee6c

Author: Alexander Graf <agraf@suse.de>

Date: Mon Oct 13 16:01:09 2014 +0200


powerpc: Convert power off logic to pm_power_off

The generic Linux framework to power off the machine is a function pointer

called pm_power_off. The trick about this pointer is that device drivers 
can

potentially implement it rather than board files.

Today on powerpc we set pm_power_off to invoke our generic full machine 
power

off logic which then calls ppc_md.power_off to invoke machine specific 
power

off.

However, when we want to add a power off GPIO via the "gpio-poweroff" 
driver,

this card house falls apart. That driver only registers itself if 
pm_power_off

is NULL to ensure it doesn't override board specific logic. However, 
since we

always set pm_power_off to the generic power off logic (which will just not

power off the machine if no ppc_md.power_off call is implemented), we can't

implement power off via the generic GPIO power off driver.

To fix this up, let's get rid of the ppc_md.power_off logic and just 
always use

pm_power_off as was intended. Then individual drivers such as the GPIO 
power off

driver can implement power off logic via that function pointer.

With this patch set applied and a few patches on top of QEMU that 
implement a

power off GPIO on the virt e500 machine, I can successfully turn off my 
virtual

machine after halt.

Signed-off-by: Alexander Graf <agraf@suse.de>

[mpe: Squash into one patch and update changelog based on cover letter]

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>


:040000 040000 11d9242dda2d364042ad2443b81aa124655ca79d 
8e5c37793f68e09977278bcea28e97ac7e0b812d M arch

root@julian-VirtualBox:/usr/src/linux-test#


root@julian-VirtualBox:/usr/src/linux-test# git bisect log

git bisect start

# bad: [97bf6af1f928216fd6c5a66e8a57bfa95a659672] Linux 3.19-rc1

git bisect bad 97bf6af1f928216fd6c5a66e8a57bfa95a659672

# good: [b2776bf7149bddd1f4161f14f79520f17fc1d71d] Linux 3.18

git bisect good b2776bf7149bddd1f4161f14f79520f17fc1d71d

# bad: [97bf6af1f928216fd6c5a66e8a57bfa95a659672] Linux 3.19-rc1

git bisect bad 97bf6af1f928216fd6c5a66e8a57bfa95a659672

# bad: [97bf6af1f928216fd6c5a66e8a57bfa95a659672] Linux 3.19-rc1

git bisect bad 97bf6af1f928216fd6c5a66e8a57bfa95a659672

# good: [70e71ca0af244f48a5dcf56dc435243792e3a495] Merge 
git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next

git bisect good 70e71ca0af244f48a5dcf56dc435243792e3a495

# bad: [988adfdffdd43cfd841df734664727993076d7cb] Merge branch 
'drm-next' of git://people.freedesktop.org/~airlied/linux

git bisect bad 988adfdffdd43cfd841df734664727993076d7cb

# bad: [e7cf773d431a63a2417902696fcc9e0ebdc83bbe] Merge tag 
'usb-3.19-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb

git bisect bad e7cf773d431a63a2417902696fcc9e0ebdc83bbe

# bad: [26ceb127f7bcf473db926c6a026b18ddd6f274e8] Merge branch 
'for-linus' of git://ftp.arm.linux.org.uk/~rmk/linux-arm

git bisect bad 26ceb127f7bcf473db926c6a026b18ddd6f274e8

# bad: [9bfccec24e31f4f83445cfe0c1b0a5ef97900628] Merge tag 
'ext4_for_linus' of 
git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4

git bisect bad 9bfccec24e31f4f83445cfe0c1b0a5ef97900628

# good: [e2965cd0003f222bd49f67907c2bc6ed691c6d20] MIPS: Add MFHC0 and 
MTHC0 instructions to uasm.

git bisect good e2965cd0003f222bd49f67907c2bc6ed691c6d20

# bad: [56548fc0e86cb9156af7a7e1f15ba78f251dafaf] powerpc/powernv: 
Return to cpu offline loop when finished in KVM guest

git bisect bad 56548fc0e86cb9156af7a7e1f15ba78f251dafaf

# bad: [59994fb01a102a448ba758c9b824a29b4a99cc1b] powerpc: Use generic 
PIE randomization

git bisect bad 59994fb01a102a448ba758c9b824a29b4a99cc1b

# bad: [7aa189c8f57f2141b8655c2a13c7486d0844d490] powerpc/pseries: 
Quieten ibm,pcie-link-speed-stats warning

git bisect bad 7aa189c8f57f2141b8655c2a13c7486d0844d490

# bad: [6e4c632cdff7bf0238a2543dfe98bd1ad40313c2] powerpc: make __ffs 
return unsigned long

git bisect bad 6e4c632cdff7bf0238a2543dfe98bd1ad40313c2

# bad: [adb7cd732292b06ee964d9f6090b17c70bd8bd3d] powerpc/pci: Quieten 
unset I/O resource warning

git bisect bad adb7cd732292b06ee964d9f6090b17c70bd8bd3d

# bad: [8418804ef27e5f7988480d86ecf9dfd56cebc53b] Merge branch 
'topic/pm-power-off' into next

git bisect bad 8418804ef27e5f7988480d86ecf9dfd56cebc53b

# bad: [9178ba294b6839eeff1a91bed95515d783f3ee6c] powerpc: Convert power 
off logic to pm_power_off

git bisect bad 9178ba294b6839eeff1a91bed95515d783f3ee6c

# first bad commit: [9178ba294b6839eeff1a91bed95515d783f3ee6c] powerpc: 
Convert power off logic to pm_power_off


--------------050107080603010300030701
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <meta http-equiv="content-type" content="text/html; charset=utf-8">
    <p style="margin-bottom: 0in; line-height: 100%">Commit
      9178ba294b6839eeff1a91bed95515d783f3ee6c prevents building of
      kernel 4.1 branch on A-Eon Tabor Board.</p>
    <p style="margin-bottom: 0in; line-height: 100%">CC     
      arch/powerpc/math-emu/fsqrt.o<br>
      arch/powerpc/platforms/85xx/tabor.c:194:2: error: unknown field
      ‘power_off’ specified in initializer<br>
        .power_off  = tabor_power_off,<br>
        ^<br>
      make[2]: *** [arch/powerpc/platforms/85xx/tabor.o] Error 1<br>
      make[1]: *** [arch/powerpc/platforms/85xx] Error 2<br>
      make: *** [arch/powerpc/platforms] Error 2<br>
    </p>
    <p style="margin-bottom: 0in; line-height: 100%"><br>
      Builds after reverting  85xx portions of commit.<br>
      <br>
    </p>
    <p style="margin-bottom: 0in; line-height: 100%">
      <meta http-equiv="content-type" content="text/html; charset=utf-8">
    </p>
    <p style="margin-bottom: 0in; line-height: 100%">
      <title>commit 9178ba294b6839eeff1a91bed95515d783f3ee6c </title>
      <meta name="generator" content="LibreOffice 4.4.5.2 (Windows)">
      <style type="text/css">
		@page { margin: 0.79in }
		pre.cjk { font-family: "NSimSun", monospace }
		p { margin-bottom: 0.1in; line-height: 120% }/85xx</style> </p>
    <p style="margin-bottom: 0in; line-height: 100%">==========================================================================================================<br>
      commit 9178ba294b6839eeff1a91bed95515d783f3ee6c </p>
    <p style="margin-bottom: 0in; line-height: 100%">Author: Alexander
      Graf <a class="moz-txt-link-rfc2396E" href="mailto:agraf@suse.de">&lt;agraf@suse.de&gt;</a>
    </p>
    <p style="margin-bottom: 0in; line-height: 100%">Date: Mon Oct 13
      16:01:09 2014 +0200 </p>
    <p style="margin-bottom: 0in; line-height: 100%"><br>
    </p>
    <p style="margin-bottom: 0in; line-height: 100%"> powerpc: Convert
      power off logic to pm_power_off </p>
    <p style="margin-bottom: 0in; line-height: 100%"> </p>
    <p style="margin-bottom: 0in; line-height: 100%"> The generic Linux
      framework to power off the machine is a function pointer </p>
    <p style="margin-bottom: 0in; line-height: 100%"> called
      pm_power_off. The trick about this pointer is that device drivers
      can </p>
    <p style="margin-bottom: 0in; line-height: 100%"> potentially
      implement it rather than board files. </p>
    <p style="margin-bottom: 0in; line-height: 100%"> </p>
    <p style="margin-bottom: 0in; line-height: 100%"> Today on powerpc
      we set pm_power_off to invoke our generic full machine power </p>
    <p style="margin-bottom: 0in; line-height: 100%"> off logic which
      then calls ppc_md.power_off to invoke machine specific power </p>
    <p style="margin-bottom: 0in; line-height: 100%"> off. </p>
    <p style="margin-bottom: 0in; line-height: 100%"> </p>
    <p style="margin-bottom: 0in; line-height: 100%"> However, when we
      want to add a power off GPIO via the "gpio-poweroff" driver, </p>
    <p style="margin-bottom: 0in; line-height: 100%"> this card house
      falls apart. That driver only registers itself if pm_power_off </p>
    <p style="margin-bottom: 0in; line-height: 100%"> is NULL to ensure
      it doesn't override board specific logic. However, since we </p>
    <p style="margin-bottom: 0in; line-height: 100%"> always set
      pm_power_off to the generic power off logic (which will just not </p>
    <p style="margin-bottom: 0in; line-height: 100%"> power off the
      machine if no ppc_md.power_off call is implemented), we can't </p>
    <p style="margin-bottom: 0in; line-height: 100%"> implement power
      off via the generic GPIO power off driver. </p>
    <p style="margin-bottom: 0in; line-height: 100%"> </p>
    <p style="margin-bottom: 0in; line-height: 100%"> To fix this up,
      let's get rid of the ppc_md.power_off logic and just always use </p>
    <p style="margin-bottom: 0in; line-height: 100%"> pm_power_off as
      was intended. Then individual drivers such as the GPIO power off </p>
    <p style="margin-bottom: 0in; line-height: 100%"> driver can
      implement power off logic via that function pointer. </p>
    <p style="margin-bottom: 0in; line-height: 100%"> </p>
    <p style="margin-bottom: 0in; line-height: 100%"> With this patch
      set applied and a few patches on top of QEMU that implement a </p>
    <p style="margin-bottom: 0in; line-height: 100%"> power off GPIO on
      the virt e500 machine, I can successfully turn off my virtual </p>
    <p style="margin-bottom: 0in; line-height: 100%"> machine after
      halt. </p>
    <p style="margin-bottom: 0in; line-height: 100%"> </p>
    <p style="margin-bottom: 0in; line-height: 100%"> Signed-off-by:
      Alexander Graf <a class="moz-txt-link-rfc2396E"
        href="mailto:agraf@suse.de">&lt;agraf@suse.de&gt;</a> </p>
    <p style="margin-bottom: 0in; line-height: 100%"> [mpe: Squash into
      one patch and update changelog based on cover letter] </p>
    <p style="margin-bottom: 0in; line-height: 100%"> Signed-off-by:
      Michael Ellerman <a class="moz-txt-link-rfc2396E"
        href="mailto:mpe@ellerman.id.au">&lt;mpe@ellerman.id.au&gt;</a>
    </p>
    <p style="margin-bottom: 0in; line-height: 100%"><br>
    </p>
    <p style="margin-bottom: 0in; line-height: 100%">:040000 040000
      11d9242dda2d364042ad2443b81aa124655ca79d
      8e5c37793f68e09977278bcea28e97ac7e0b812d M arch </p>
    <p style="margin-bottom: 0in; line-height: 100%">root@julian-VirtualBox:/usr/src/linux-test#

    </p>
    <p style="margin-bottom: 0in; line-height: 100%"><br>
    </p>
    <p style="margin-bottom: 0in; line-height: 100%">root@julian-VirtualBox:/usr/src/linux-test#
git

      bisect log </p>
    <p style="margin-bottom: 0in; line-height: 100%">git bisect start </p>
    <p style="margin-bottom: 0in; line-height: 100%"># bad:
      [97bf6af1f928216fd6c5a66e8a57bfa95a659672] Linux 3.19-rc1 </p>
    <p style="margin-bottom: 0in; line-height: 100%">git bisect bad
      97bf6af1f928216fd6c5a66e8a57bfa95a659672 </p>
    <p style="margin-bottom: 0in; line-height: 100%"># good:
      [b2776bf7149bddd1f4161f14f79520f17fc1d71d] Linux 3.18 </p>
    <p style="margin-bottom: 0in; line-height: 100%">git bisect good
      b2776bf7149bddd1f4161f14f79520f17fc1d71d </p>
    <p style="margin-bottom: 0in; line-height: 100%"># bad:
      [97bf6af1f928216fd6c5a66e8a57bfa95a659672] Linux 3.19-rc1 </p>
    <p style="margin-bottom: 0in; line-height: 100%">git bisect bad
      97bf6af1f928216fd6c5a66e8a57bfa95a659672 </p>
    <p style="margin-bottom: 0in; line-height: 100%"># bad:
      [97bf6af1f928216fd6c5a66e8a57bfa95a659672] Linux 3.19-rc1 </p>
    <p style="margin-bottom: 0in; line-height: 100%">git bisect bad
      97bf6af1f928216fd6c5a66e8a57bfa95a659672 </p>
    <p style="margin-bottom: 0in; line-height: 100%"># good:
      [70e71ca0af244f48a5dcf56dc435243792e3a495] Merge
      git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next </p>
    <p style="margin-bottom: 0in; line-height: 100%">git bisect good
      70e71ca0af244f48a5dcf56dc435243792e3a495 </p>
    <p style="margin-bottom: 0in; line-height: 100%"># bad:
      [988adfdffdd43cfd841df734664727993076d7cb] Merge branch 'drm-next'
      of git://people.freedesktop.org/~airlied/linux </p>
    <p style="margin-bottom: 0in; line-height: 100%">git bisect bad
      988adfdffdd43cfd841df734664727993076d7cb </p>
    <p style="margin-bottom: 0in; line-height: 100%"># bad:
      [e7cf773d431a63a2417902696fcc9e0ebdc83bbe] Merge tag
      'usb-3.19-rc1' of
      git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb </p>
    <p style="margin-bottom: 0in; line-height: 100%">git bisect bad
      e7cf773d431a63a2417902696fcc9e0ebdc83bbe </p>
    <p style="margin-bottom: 0in; line-height: 100%"># bad:
      [26ceb127f7bcf473db926c6a026b18ddd6f274e8] Merge branch
      'for-linus' of git://ftp.arm.linux.org.uk/~rmk/linux-arm </p>
    <p style="margin-bottom: 0in; line-height: 100%">git bisect bad
      26ceb127f7bcf473db926c6a026b18ddd6f274e8 </p>
    <p style="margin-bottom: 0in; line-height: 100%"># bad:
      [9bfccec24e31f4f83445cfe0c1b0a5ef97900628] Merge tag
      'ext4_for_linus' of
      git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4 </p>
    <p style="margin-bottom: 0in; line-height: 100%">git bisect bad
      9bfccec24e31f4f83445cfe0c1b0a5ef97900628 </p>
    <p style="margin-bottom: 0in; line-height: 100%"># good:
      [e2965cd0003f222bd49f67907c2bc6ed691c6d20] MIPS: Add MFHC0 and
      MTHC0 instructions to uasm. </p>
    <p style="margin-bottom: 0in; line-height: 100%">git bisect good
      e2965cd0003f222bd49f67907c2bc6ed691c6d20 </p>
    <p style="margin-bottom: 0in; line-height: 100%"># bad:
      [56548fc0e86cb9156af7a7e1f15ba78f251dafaf] powerpc/powernv: Return
      to cpu offline loop when finished in KVM guest </p>
    <p style="margin-bottom: 0in; line-height: 100%">git bisect bad
      56548fc0e86cb9156af7a7e1f15ba78f251dafaf </p>
    <p style="margin-bottom: 0in; line-height: 100%"># bad:
      [59994fb01a102a448ba758c9b824a29b4a99cc1b] powerpc: Use generic
      PIE randomization </p>
    <p style="margin-bottom: 0in; line-height: 100%">git bisect bad
      59994fb01a102a448ba758c9b824a29b4a99cc1b </p>
    <p style="margin-bottom: 0in; line-height: 100%"># bad:
      [7aa189c8f57f2141b8655c2a13c7486d0844d490] powerpc/pseries:
      Quieten ibm,pcie-link-speed-stats warning </p>
    <p style="margin-bottom: 0in; line-height: 100%">git bisect bad
      7aa189c8f57f2141b8655c2a13c7486d0844d490 </p>
    <p style="margin-bottom: 0in; line-height: 100%"># bad:
      [6e4c632cdff7bf0238a2543dfe98bd1ad40313c2] powerpc: make __ffs
      return unsigned long </p>
    <p style="margin-bottom: 0in; line-height: 100%">git bisect bad
      6e4c632cdff7bf0238a2543dfe98bd1ad40313c2 </p>
    <p style="margin-bottom: 0in; line-height: 100%"># bad:
      [adb7cd732292b06ee964d9f6090b17c70bd8bd3d] powerpc/pci: Quieten
      unset I/O resource warning </p>
    <p style="margin-bottom: 0in; line-height: 100%">git bisect bad
      adb7cd732292b06ee964d9f6090b17c70bd8bd3d </p>
    <p style="margin-bottom: 0in; line-height: 100%"># bad:
      [8418804ef27e5f7988480d86ecf9dfd56cebc53b] Merge branch
      'topic/pm-power-off' into next </p>
    <p style="margin-bottom: 0in; line-height: 100%">git bisect bad
      8418804ef27e5f7988480d86ecf9dfd56cebc53b </p>
    <p style="margin-bottom: 0in; line-height: 100%"># bad:
      [9178ba294b6839eeff1a91bed95515d783f3ee6c] powerpc: Convert power
      off logic to pm_power_off </p>
    <p style="margin-bottom: 0in; line-height: 100%">git bisect bad
      9178ba294b6839eeff1a91bed95515d783f3ee6c </p>
    <p style="margin-bottom: 0in; line-height: 100%"># first bad commit:
      [9178ba294b6839eeff1a91bed95515d783f3ee6c] powerpc: Convert power
      off logic to pm_power_off </p>
    <title></title>
    <meta name="generator" content="LibreOffice 4.4.5.2 (Windows)">
    <style type="text/css">
		@page { margin: 0.79in }
		p { margin-bottom: 0.1in; line-height: 120% }
	</style>
  </body>
</html>

--------------050107080603010300030701--

--------------010602030401010803000502
Content-Type: text/plain; charset=UTF-8;
 name="Tabor-4.1.17-JM.config"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="Tabor-4.1.17-JM.config"

IwojIEF1dG9tYXRpY2FsbHkgZ2VuZXJhdGVkIGZpbGU7IERPIE5PVCBFRElULgojIExpbnV4
L3Bvd2VycGMgNC4xLjE3IEtlcm5lbCBDb25maWd1cmF0aW9uCiMKIyBDT05GSUdfUFBDNjQg
aXMgbm90IHNldAoKIwojIFByb2Nlc3NvciBzdXBwb3J0CiMKIyBDT05GSUdfUFBDX0JPT0sz
U18zMiBpcyBub3Qgc2V0CkNPTkZJR19QUENfODV4eD15CiMgQ09ORklHX1BQQ184eHggaXMg
bm90IHNldAojIENPTkZJR180MHggaXMgbm90IHNldAojIENPTkZJR180NHggaXMgbm90IHNl
dAojIENPTkZJR19FMjAwIGlzIG5vdCBzZXQKQ09ORklHX0U1MDA9eQojIENPTkZJR19QUENf
RTUwME1DIGlzIG5vdCBzZXQKQ09ORklHX0ZTTF9FTUJfUEVSRk1PTj15CkNPTkZJR19GU0xf
RU1CX1BFUkZfRVZFTlQ9eQpDT05GSUdfRlNMX0VNQl9QRVJGX0VWRU5UX0U1MDA9eQpDT05G
SUdfQk9PS0U9eQpDT05GSUdfRlNMX0JPT0tFPXkKQ09ORklHX1BQQ19GU0xfQk9PSzNFPXkK
Q09ORklHX1BURV82NEJJVD15CkNPTkZJR19QSFlTXzY0QklUPXkKQ09ORklHX1NQRV9QT1NT
SUJMRT15CkNPTkZJR19TUEU9eQpDT05GSUdfUFBDX01NVV9OT0hBU0g9eQpDT05GSUdfUFBD
X0JPT0szRV9NTVU9eQojIENPTkZJR19QUENfTU1fU0xJQ0VTIGlzIG5vdCBzZXQKQ09ORklH
X1NNUD15CkNPTkZJR19OUl9DUFVTPTIKQ09ORklHX1BQQ19ET09SQkVMTD15CkNPTkZJR19D
UFVfQklHX0VORElBTj15CiMgQ09ORklHX0NQVV9MSVRUTEVfRU5ESUFOIGlzIG5vdCBzZXQK
Q09ORklHX1BQQzMyPXkKQ09ORklHXzMyQklUPXkKQ09ORklHX1dPUkRfU0laRT0zMgpDT05G
SUdfQVJDSF9QSFlTX0FERFJfVF82NEJJVD15CkNPTkZJR19BUkNIX0RNQV9BRERSX1RfNjRC
SVQ9eQpDT05GSUdfTU1VPXkKIyBDT05GSUdfSEFWRV9TRVRVUF9QRVJfQ1BVX0FSRUEgaXMg
bm90IHNldAojIENPTkZJR19ORUVEX1BFUl9DUFVfRU1CRURfRklSU1RfQ0hVTksgaXMgbm90
IHNldApDT05GSUdfTlJfSVJRUz01MTIKQ09ORklHX1NUQUNLVFJBQ0VfU1VQUE9SVD15CkNP
TkZJR19IQVZFX0xBVEVOQ1lUT1BfU1VQUE9SVD15CkNPTkZJR19UUkFDRV9JUlFGTEFHU19T
VVBQT1JUPXkKQ09ORklHX0xPQ0tERVBfU1VQUE9SVD15CkNPTkZJR19SV1NFTV9YQ0hHQURE
X0FMR09SSVRITT15CkNPTkZJR19HRU5FUklDX0xPQ0tCUkVBSz15CkNPTkZJR19BUkNIX0hB
U19JTE9HMl9VMzI9eQpDT05GSUdfR0VORVJJQ19IV0VJR0hUPXkKQ09ORklHX1BQQz15CiMg
Q09ORklHX0dFTkVSSUNfQ1NVTSBpcyBub3Qgc2V0CkNPTkZJR19FQVJMWV9QUklOVEs9eQpD
T05GSUdfUEFOSUNfVElNRU9VVD0xODAKQ09ORklHX0dFTkVSSUNfTlZSQU09eQpDT05GSUdf
U0NIRURfT01JVF9GUkFNRV9QT0lOVEVSPXkKQ09ORklHX0FSQ0hfTUFZX0hBVkVfUENfRkRD
PXkKQ09ORklHX1BQQ19VREJHXzE2NTUwPXkKQ09ORklHX0dFTkVSSUNfVEJTWU5DPXkKQ09O
RklHX0FVRElUX0FSQ0g9eQpDT05GSUdfR0VORVJJQ19CVUc9eQojIENPTkZJR19FUEFQUl9C
T09UIGlzIG5vdCBzZXQKQ09ORklHX0RFRkFVTFRfVUlNQUdFPXkKQ09ORklHX0FSQ0hfSElC
RVJOQVRJT05fUE9TU0lCTEU9eQpDT05GSUdfQVJDSF9TVVNQRU5EX1BPU1NJQkxFPXkKIyBD
T05GSUdfUFBDX0RDUl9OQVRJVkUgaXMgbm90IHNldAojIENPTkZJR19QUENfRENSX01NSU8g
aXMgbm90IHNldApDT05GSUdfQVJDSF9TVVBQT1JUU19ERUJVR19QQUdFQUxMT0M9eQpDT05G
SUdfQVJDSF9TVVBQT1JUU19VUFJPQkVTPXkKQ09ORklHX1BQQ19BRFZfREVCVUdfUkVHUz15
CkNPTkZJR19QUENfQURWX0RFQlVHX0lBQ1M9MgpDT05GSUdfUFBDX0FEVl9ERUJVR19EQUNT
PTIKQ09ORklHX1BQQ19BRFZfREVCVUdfRFZDUz0wCkNPTkZJR19QR1RBQkxFX0xFVkVMUz0y
CkNPTkZJR19ERUZDT05GSUdfTElTVD0iL2xpYi9tb2R1bGVzLyRVTkFNRV9SRUxFQVNFLy5j
b25maWciCkNPTkZJR19JUlFfV09SSz15CgojCiMgR2VuZXJhbCBzZXR1cAojCkNPTkZJR19J
TklUX0VOVl9BUkdfTElNSVQ9MzIKQ09ORklHX0NST1NTX0NPTVBJTEU9InBvd2VycGMtbGlu
dXgtZ251LSIKIyBDT05GSUdfQ09NUElMRV9URVNUIGlzIG5vdCBzZXQKQ09ORklHX0xPQ0FM
VkVSU0lPTj0iLVRhYm9yLUpNIgpDT05GSUdfTE9DQUxWRVJTSU9OX0FVVE89eQpDT05GSUdf
REVGQVVMVF9IT1NUTkFNRT0iVGFib3IiCkNPTkZJR19TV0FQPXkKQ09ORklHX1NZU1ZJUEM9
eQpDT05GSUdfU1lTVklQQ19TWVNDVEw9eQpDT05GSUdfUE9TSVhfTVFVRVVFPXkKQ09ORklH
X1BPU0lYX01RVUVVRV9TWVNDVEw9eQpDT05GSUdfQ1JPU1NfTUVNT1JZX0FUVEFDSD15CkNP
TkZJR19GSEFORExFPXkKQ09ORklHX1VTRUxJQj15CiMgQ09ORklHX0FVRElUIGlzIG5vdCBz
ZXQKQ09ORklHX0hBVkVfQVJDSF9BVURJVFNZU0NBTEw9eQoKIwojIElSUSBzdWJzeXN0ZW0K
IwpDT05GSUdfR0VORVJJQ19JUlFfU0hPVz15CkNPTkZJR19HRU5FUklDX0lSUV9TSE9XX0xF
VkVMPXkKQ09ORklHX0lSUV9ET01BSU49eQpDT05GSUdfR0VORVJJQ19NU0lfSVJRPXkKIyBD
T05GSUdfSVJRX0RPTUFJTl9ERUJVRyBpcyBub3Qgc2V0CkNPTkZJR19JUlFfRk9SQ0VEX1RI
UkVBRElORz15CkNPTkZJR19TUEFSU0VfSVJRPXkKQ09ORklHX0dFTkVSSUNfVElNRV9WU1lT
Q0FMTF9PTEQ9eQpDT05GSUdfR0VORVJJQ19DTE9DS0VWRU5UUz15CkNPTkZJR19BUkNIX0hB
U19USUNLX0JST0FEQ0FTVD15CkNPTkZJR19HRU5FUklDX0NMT0NLRVZFTlRTX0JST0FEQ0FT
VD15CkNPTkZJR19HRU5FUklDX0NNT1NfVVBEQVRFPXkKCiMKIyBUaW1lcnMgc3Vic3lzdGVt
CiMKQ09ORklHX1RJQ0tfT05FU0hPVD15CkNPTkZJR19OT19IWl9DT01NT049eQojIENPTkZJ
R19IWl9QRVJJT0RJQyBpcyBub3Qgc2V0CkNPTkZJR19OT19IWl9JRExFPXkKQ09ORklHX05P
X0haPXkKQ09ORklHX0hJR0hfUkVTX1RJTUVSUz15CgojCiMgQ1BVL1Rhc2sgdGltZSBhbmQg
c3RhdHMgYWNjb3VudGluZwojCkNPTkZJR19USUNLX0NQVV9BQ0NPVU5USU5HPXkKIyBDT05G
SUdfQlNEX1BST0NFU1NfQUNDVCBpcyBub3Qgc2V0CiMgQ09ORklHX1RBU0tTVEFUUyBpcyBu
b3Qgc2V0CgojCiMgUkNVIFN1YnN5c3RlbQojCkNPTkZJR19QUkVFTVBUX1JDVT15CkNPTkZJ
R19TUkNVPXkKIyBDT05GSUdfVEFTS1NfUkNVIGlzIG5vdCBzZXQKQ09ORklHX1JDVV9TVEFM
TF9DT01NT049eQpDT05GSUdfUkNVX0ZBTk9VVD0zMgpDT05GSUdfUkNVX0ZBTk9VVF9MRUFG
PTE2CiMgQ09ORklHX1JDVV9GQU5PVVRfRVhBQ1QgaXMgbm90IHNldAojIENPTkZJR19SQ1Vf
RkFTVF9OT19IWiBpcyBub3Qgc2V0CiMgQ09ORklHX1RSRUVfUkNVX1RSQUNFIGlzIG5vdCBz
ZXQKIyBDT05GSUdfUkNVX0JPT1NUIGlzIG5vdCBzZXQKQ09ORklHX1JDVV9LVEhSRUFEX1BS
SU89MAojIENPTkZJR19SQ1VfTk9DQl9DUFUgaXMgbm90IHNldAojIENPTkZJR19SQ1VfRVhQ
RURJVEVfQk9PVCBpcyBub3Qgc2V0CkNPTkZJR19CVUlMRF9CSU4yQz15CkNPTkZJR19JS0NP
TkZJRz15CkNPTkZJR19JS0NPTkZJR19QUk9DPXkKQ09ORklHX0xPR19CVUZfU0hJRlQ9MTcK
Q09ORklHX0xPR19DUFVfTUFYX0JVRl9TSElGVD0xMgpDT05GSUdfQ0dST1VQUz15CiMgQ09O
RklHX0NHUk9VUF9ERUJVRyBpcyBub3Qgc2V0CiMgQ09ORklHX0NHUk9VUF9GUkVFWkVSIGlz
IG5vdCBzZXQKIyBDT05GSUdfQ0dST1VQX0RFVklDRSBpcyBub3Qgc2V0CiMgQ09ORklHX0NQ
VVNFVFMgaXMgbm90IHNldAojIENPTkZJR19DR1JPVVBfQ1BVQUNDVCBpcyBub3Qgc2V0CiMg
Q09ORklHX01FTUNHIGlzIG5vdCBzZXQKIyBDT05GSUdfQ0dST1VQX1BFUkYgaXMgbm90IHNl
dApDT05GSUdfQ0dST1VQX1NDSEVEPXkKQ09ORklHX0ZBSVJfR1JPVVBfU0NIRUQ9eQojIENP
TkZJR19DRlNfQkFORFdJRFRIIGlzIG5vdCBzZXQKIyBDT05GSUdfUlRfR1JPVVBfU0NIRUQg
aXMgbm90IHNldAojIENPTkZJR19CTEtfQ0dST1VQIGlzIG5vdCBzZXQKIyBDT05GSUdfQ0hF
Q0tQT0lOVF9SRVNUT1JFIGlzIG5vdCBzZXQKQ09ORklHX05BTUVTUEFDRVM9eQpDT05GSUdf
VVRTX05TPXkKQ09ORklHX0lQQ19OUz15CkNPTkZJR19VU0VSX05TPXkKQ09ORklHX1BJRF9O
Uz15CkNPTkZJR19ORVRfTlM9eQpDT05GSUdfU0NIRURfQVVUT0dST1VQPXkKIyBDT05GSUdf
U1lTRlNfREVQUkVDQVRFRCBpcyBub3Qgc2V0CiMgQ09ORklHX1JFTEFZIGlzIG5vdCBzZXQK
Q09ORklHX0JMS19ERVZfSU5JVFJEPXkKQ09ORklHX0lOSVRSQU1GU19TT1VSQ0U9IiIKQ09O
RklHX1JEX0daSVA9eQojIENPTkZJR19SRF9CWklQMiBpcyBub3Qgc2V0CiMgQ09ORklHX1JE
X0xaTUEgaXMgbm90IHNldAojIENPTkZJR19SRF9YWiBpcyBub3Qgc2V0CiMgQ09ORklHX1JE
X0xaTyBpcyBub3Qgc2V0CiMgQ09ORklHX1JEX0xaNCBpcyBub3Qgc2V0CkNPTkZJR19DQ19P
UFRJTUlaRV9GT1JfU0laRT15CkNPTkZJR19TWVNDVEw9eQpDT05GSUdfQU5PTl9JTk9ERVM9
eQpDT05GSUdfU1lTQ1RMX0VYQ0VQVElPTl9UUkFDRT15CkNPTkZJR19CUEY9eQpDT05GSUdf
RVhQRVJUPXkKQ09ORklHX01VTFRJVVNFUj15CkNPTkZJR19TR0VUTUFTS19TWVNDQUxMPXkK
Q09ORklHX1NZU0ZTX1NZU0NBTEw9eQpDT05GSUdfU1lTQ1RMX1NZU0NBTEw9eQpDT05GSUdf
S0FMTFNZTVM9eQojIENPTkZJR19LQUxMU1lNU19BTEwgaXMgbm90IHNldApDT05GSUdfUFJJ
TlRLPXkKQ09ORklHX0JVRz15CkNPTkZJR19FTEZfQ09SRT15CkNPTkZJR19CQVNFX0ZVTEw9
eQpDT05GSUdfRlVURVg9eQpDT05GSUdfRVBPTEw9eQpDT05GSUdfU0lHTkFMRkQ9eQpDT05G
SUdfVElNRVJGRD15CkNPTkZJR19FVkVOVEZEPXkKIyBDT05GSUdfQlBGX1NZU0NBTEwgaXMg
bm90IHNldApDT05GSUdfU0hNRU09eQpDT05GSUdfQUlPPXkKQ09ORklHX0FEVklTRV9TWVND
QUxMUz15CkNPTkZJR19QQ0lfUVVJUktTPXkKQ09ORklHX0VNQkVEREVEPXkKQ09ORklHX0hB
VkVfUEVSRl9FVkVOVFM9eQoKIwojIEtlcm5lbCBQZXJmb3JtYW5jZSBFdmVudHMgQW5kIENv
dW50ZXJzCiMKQ09ORklHX1BFUkZfRVZFTlRTPXkKIyBDT05GSUdfREVCVUdfUEVSRl9VU0Vf
Vk1BTExPQyBpcyBub3Qgc2V0CkNPTkZJR19WTV9FVkVOVF9DT1VOVEVSUz15CkNPTkZJR19T
TFVCX0RFQlVHPXkKIyBDT05GSUdfQ09NUEFUX0JSSyBpcyBub3Qgc2V0CiMgQ09ORklHX1NM
QUIgaXMgbm90IHNldApDT05GSUdfU0xVQj15CiMgQ09ORklHX1NMT0IgaXMgbm90IHNldApD
T05GSUdfU0xVQl9DUFVfUEFSVElBTD15CiMgQ09ORklHX1NZU1RFTV9UUlVTVEVEX0tFWVJJ
TkcgaXMgbm90IHNldAojIENPTkZJR19QUk9GSUxJTkcgaXMgbm90IHNldApDT05GSUdfSEFW
RV9PUFJPRklMRT15CiMgQ09ORklHX0tQUk9CRVMgaXMgbm90IHNldAojIENPTkZJR19KVU1Q
X0xBQkVMIGlzIG5vdCBzZXQKIyBDT05GSUdfVVBST0JFUyBpcyBub3Qgc2V0CiMgQ09ORklH
X0hBVkVfNjRCSVRfQUxJR05FRF9BQ0NFU1MgaXMgbm90IHNldApDT05GSUdfSEFWRV9FRkZJ
Q0lFTlRfVU5BTElHTkVEX0FDQ0VTUz15CkNPTkZJR19BUkNIX1VTRV9CVUlMVElOX0JTV0FQ
PXkKQ09ORklHX0hBVkVfSU9SRU1BUF9QUk9UPXkKQ09ORklHX0hBVkVfS1BST0JFUz15CkNP
TkZJR19IQVZFX0tSRVRQUk9CRVM9eQpDT05GSUdfSEFWRV9BUkNIX1RSQUNFSE9PSz15CkNP
TkZJR19IQVZFX0RNQV9BVFRSUz15CkNPTkZJR19HRU5FUklDX1NNUF9JRExFX1RIUkVBRD15
CkNPTkZJR19IQVZFX1JFR1NfQU5EX1NUQUNLX0FDQ0VTU19BUEk9eQpDT05GSUdfSEFWRV9E
TUFfQVBJX0RFQlVHPXkKQ09ORklHX0hBVkVfQVJDSF9KVU1QX0xBQkVMPXkKQ09ORklHX0hB
VkVfUkNVX1RBQkxFX0ZSRUU9eQpDT05GSUdfQVJDSF9IQVZFX05NSV9TQUZFX0NNUFhDSEc9
eQpDT05GSUdfQVJDSF9XQU5UX0lQQ19QQVJTRV9WRVJTSU9OPXkKIyBDT05GSUdfQ0NfU1RB
Q0tQUk9URUNUT1IgaXMgbm90IHNldApDT05GSUdfSEFWRV9NT0RfQVJDSF9TUEVDSUZJQz15
CkNPTkZJR19NT0RVTEVTX1VTRV9FTEZfUkVMQT15CkNPTkZJR19IQVZFX0lSUV9FWElUX09O
X0lSUV9TVEFDSz15CkNPTkZJR19BUkNIX0hBU19FTEZfUkFORE9NSVpFPXkKQ09ORklHX0NM
T05FX0JBQ0tXQVJEUz15CkNPTkZJR19PTERfU0lHU1VTUEVORD15CkNPTkZJR19PTERfU0lH
QUNUSU9OPXkKCiMKIyBHQ09WLWJhc2VkIGtlcm5lbCBwcm9maWxpbmcKIwojIENPTkZJR19H
Q09WX0tFUk5FTCBpcyBub3Qgc2V0CkNPTkZJR19BUkNIX0hBU19HQ09WX1BST0ZJTEVfQUxM
PXkKIyBDT05GSUdfSEFWRV9HRU5FUklDX0RNQV9DT0hFUkVOVCBpcyBub3Qgc2V0CkNPTkZJ
R19TTEFCSU5GTz15CkNPTkZJR19SVF9NVVRFWEVTPXkKQ09ORklHX0JBU0VfU01BTEw9MApD
T05GSUdfTU9EVUxFUz15CiMgQ09ORklHX01PRFVMRV9GT1JDRV9MT0FEIGlzIG5vdCBzZXQK
Q09ORklHX01PRFVMRV9VTkxPQUQ9eQojIENPTkZJR19NT0RVTEVfRk9SQ0VfVU5MT0FEIGlz
IG5vdCBzZXQKIyBDT05GSUdfTU9EVkVSU0lPTlMgaXMgbm90IHNldAojIENPTkZJR19NT0RV
TEVfU1JDVkVSU0lPTl9BTEwgaXMgbm90IHNldAojIENPTkZJR19NT0RVTEVfU0lHIGlzIG5v
dCBzZXQKIyBDT05GSUdfTU9EVUxFX0NPTVBSRVNTIGlzIG5vdCBzZXQKQ09ORklHX1NUT1Bf
TUFDSElORT15CkNPTkZJR19CTE9DSz15CkNPTkZJR19MQkRBRj15CkNPTkZJR19CTEtfREVW
X0JTRz15CiMgQ09ORklHX0JMS19ERVZfQlNHTElCIGlzIG5vdCBzZXQKIyBDT05GSUdfQkxL
X0RFVl9JTlRFR1JJVFkgaXMgbm90IHNldAojIENPTkZJR19CTEtfQ01ETElORV9QQVJTRVIg
aXMgbm90IHNldAoKIwojIFBhcnRpdGlvbiBUeXBlcwojCkNPTkZJR19QQVJUSVRJT05fQURW
QU5DRUQ9eQojIENPTkZJR19BQ09STl9QQVJUSVRJT04gaXMgbm90IHNldAojIENPTkZJR19B
SVhfUEFSVElUSU9OIGlzIG5vdCBzZXQKIyBDT05GSUdfT1NGX1BBUlRJVElPTiBpcyBub3Qg
c2V0CkNPTkZJR19BTUlHQV9QQVJUSVRJT049eQojIENPTkZJR19BVEFSSV9QQVJUSVRJT04g
aXMgbm90IHNldAojIENPTkZJR19NQUNfUEFSVElUSU9OIGlzIG5vdCBzZXQKQ09ORklHX01T
RE9TX1BBUlRJVElPTj15CiMgQ09ORklHX0JTRF9ESVNLTEFCRUwgaXMgbm90IHNldAojIENP
TkZJR19NSU5JWF9TVUJQQVJUSVRJT04gaXMgbm90IHNldAojIENPTkZJR19TT0xBUklTX1g4
Nl9QQVJUSVRJT04gaXMgbm90IHNldAojIENPTkZJR19VTklYV0FSRV9ESVNLTEFCRUwgaXMg
bm90IHNldAojIENPTkZJR19MRE1fUEFSVElUSU9OIGlzIG5vdCBzZXQKIyBDT05GSUdfU0dJ
X1BBUlRJVElPTiBpcyBub3Qgc2V0CiMgQ09ORklHX1VMVFJJWF9QQVJUSVRJT04gaXMgbm90
IHNldAojIENPTkZJR19TVU5fUEFSVElUSU9OIGlzIG5vdCBzZXQKIyBDT05GSUdfS0FSTUFf
UEFSVElUSU9OIGlzIG5vdCBzZXQKIyBDT05GSUdfRUZJX1BBUlRJVElPTiBpcyBub3Qgc2V0
CiMgQ09ORklHX1NZU1Y2OF9QQVJUSVRJT04gaXMgbm90IHNldAojIENPTkZJR19DTURMSU5F
X1BBUlRJVElPTiBpcyBub3Qgc2V0CgojCiMgSU8gU2NoZWR1bGVycwojCkNPTkZJR19JT1ND
SEVEX05PT1A9eQojIENPTkZJR19JT1NDSEVEX0RFQURMSU5FIGlzIG5vdCBzZXQKQ09ORklH
X0lPU0NIRURfQ0ZRPXkKQ09ORklHX0RFRkFVTFRfQ0ZRPXkKIyBDT05GSUdfREVGQVVMVF9O
T09QIGlzIG5vdCBzZXQKQ09ORklHX0RFRkFVTFRfSU9TQ0hFRD0iY2ZxIgpDT05GSUdfVU5J
TkxJTkVfU1BJTl9VTkxPQ0s9eQpDT05GSUdfQVJDSF9TVVBQT1JUU19BVE9NSUNfUk1XPXkK
Q09ORklHX01VVEVYX1NQSU5fT05fT1dORVI9eQpDT05GSUdfUldTRU1fU1BJTl9PTl9PV05F
Uj15CkNPTkZJR19MT0NLX1NQSU5fT05fT1dORVI9eQojIENPTkZJR19GUkVFWkVSIGlzIG5v
dCBzZXQKQ09ORklHX1BQQ19NU0lfQklUTUFQPXkKIyBDT05GSUdfUFBDX1hJQ1MgaXMgbm90
IHNldAojIENPTkZJR19QUENfSUNQX05BVElWRSBpcyBub3Qgc2V0CiMgQ09ORklHX1BQQ19J
Q1BfSFYgaXMgbm90IHNldAojIENPTkZJR19QUENfSUNTX1JUQVMgaXMgbm90IHNldAojIENP
TkZJR19HRV9GUEdBIGlzIG5vdCBzZXQKCiMKIyBQbGF0Zm9ybSBzdXBwb3J0CiMKIyBDT05G
SUdfUFBDX0NFTEwgaXMgbm90IHNldAojIENPTkZJR19QUENfQ0VMTF9OQVRJVkUgaXMgbm90
IHNldAojIENPTkZJR19QUTJBRFMgaXMgbm90IHNldApDT05GSUdfRlNMX1NPQ19CT09LRT15
CkNPTkZJR19IQVNfRlNMX1FCTUFOPXkKQ09ORklHX0ZTTF84NVhYX0NBQ0hFX1NSQU09eQoj
IENPTkZJR19CU0M5MTMxX1JEQiBpcyBub3Qgc2V0CiMgQ09ORklHX0MyOTNfUENJRSBpcyBu
b3Qgc2V0CiMgQ09ORklHX0JTQzkxMzJfUURTIGlzIG5vdCBzZXQKIyBDT05GSUdfTVBDODU0
MF9BRFMgaXMgbm90IHNldAojIENPTkZJR19NUEM4NTYwX0FEUyBpcyBub3Qgc2V0CiMgQ09O
RklHX01QQzg1eHhfQ0RTIGlzIG5vdCBzZXQKIyBDT05GSUdfTVBDODV4eF9NRFMgaXMgbm90
IHNldAojIENPTkZJR19NUEM4NTM2X0RTIGlzIG5vdCBzZXQKIyBDT05GSUdfTVBDODV4eF9E
UyBpcyBub3Qgc2V0CiMgQ09ORklHX01QQzg1eHhfUkRCIGlzIG5vdCBzZXQKIyBDT05GSUdf
UDEwMTBfUkRCIGlzIG5vdCBzZXQKQ09ORklHX1RBQk9SPXkKIyBDT05GSUdfUDEwMjJfRFMg
aXMgbm90IHNldAojIENPTkZJR19QMTAyMl9SREsgaXMgbm90IHNldAojIENPTkZJR19QMTAy
M19SREIgaXMgbm90IHNldAojIENPTkZJR19UV1JfUDEwMnggaXMgbm90IHNldAojIENPTkZJ
R19TT0NSQVRFUyBpcyBub3Qgc2V0CiMgQ09ORklHX0tTSTg1NjAgaXMgbm90IHNldAojIENP
TkZJR19YRVNfTVBDODV4eCBpcyBub3Qgc2V0CiMgQ09ORklHX1NUWF9HUDMgaXMgbm90IHNl
dAojIENPTkZJR19UUU04NTQwIGlzIG5vdCBzZXQKIyBDT05GSUdfVFFNODU0MSBpcyBub3Qg
c2V0CiMgQ09ORklHX1RRTTg1NDggaXMgbm90IHNldAojIENPTkZJR19UUU04NTU1IGlzIG5v
dCBzZXQKIyBDT05GSUdfVFFNODU2MCBpcyBub3Qgc2V0CiMgQ09ORklHX1NCQzg1NDggaXMg
bm90IHNldAojIENPTkZJR19QUEE4NTQ4IGlzIG5vdCBzZXQKIyBDT05GSUdfR0VfSU1QM0Eg
aXMgbm90IHNldAojIENPTkZJR19NVk1FMjUwMCBpcyBub3Qgc2V0CiMgQ09ORklHX0NZUlVT
IGlzIG5vdCBzZXQKIyBDT05GSUdfUFBDX1FFTVVfRTUwMCBpcyBub3Qgc2V0CiMgQ09ORklH
X0NPUkVORVRfR0VORVJJQyBpcyBub3Qgc2V0CiMgQ09ORklHX0tWTV9HVUVTVCBpcyBub3Qg
c2V0CiMgQ09ORklHX0VQQVBSX1BBUkFWSVJUIGlzIG5vdCBzZXQKQ09ORklHX1BQQ19TTVBf
TVVYRURfSVBJPXkKIyBDT05GSUdfSVBJQyBpcyBub3Qgc2V0CkNPTkZJR19NUElDPXkKIyBD
T05GSUdfTVBJQ19USU1FUiBpcyBub3Qgc2V0CiMgQ09ORklHX1BQQ19FUEFQUl9IVl9QSUMg
aXMgbm90IHNldAojIENPTkZJR19NUElDX1dFSVJEIGlzIG5vdCBzZXQKIyBDT05GSUdfTVBJ
Q19NU0dSIGlzIG5vdCBzZXQKIyBDT05GSUdfUFBDX0k4MjU5IGlzIG5vdCBzZXQKIyBDT05G
SUdfUFBDX1JUQVMgaXMgbm90IHNldAojIENPTkZJR19NTUlPX05WUkFNIGlzIG5vdCBzZXQK
IyBDT05GSUdfTVBJQ19VM19IVF9JUlFTIGlzIG5vdCBzZXQKIyBDT05GSUdfUFBDX01QQzEw
NiBpcyBub3Qgc2V0CiMgQ09ORklHX1BQQ185NzBfTkFQIGlzIG5vdCBzZXQKIyBDT05GSUdf
UFBDX1A3X05BUCBpcyBub3Qgc2V0CgojCiMgQ1BVIEZyZXF1ZW5jeSBzY2FsaW5nCiMKQ09O
RklHX0NQVV9GUkVRPXkKQ09ORklHX0NQVV9GUkVRX0dPVl9DT01NT049eQpDT05GSUdfQ1BV
X0ZSRVFfU1RBVD15CkNPTkZJR19DUFVfRlJFUV9TVEFUX0RFVEFJTFM9eQpDT05GSUdfQ1BV
X0ZSRVFfREVGQVVMVF9HT1ZfUEVSRk9STUFOQ0U9eQojIENPTkZJR19DUFVfRlJFUV9ERUZB
VUxUX0dPVl9QT1dFUlNBVkUgaXMgbm90IHNldAojIENPTkZJR19DUFVfRlJFUV9ERUZBVUxU
X0dPVl9VU0VSU1BBQ0UgaXMgbm90IHNldAojIENPTkZJR19DUFVfRlJFUV9ERUZBVUxUX0dP
Vl9PTkRFTUFORCBpcyBub3Qgc2V0CiMgQ09ORklHX0NQVV9GUkVRX0RFRkFVTFRfR09WX0NP
TlNFUlZBVElWRSBpcyBub3Qgc2V0CkNPTkZJR19DUFVfRlJFUV9HT1ZfUEVSRk9STUFOQ0U9
eQpDT05GSUdfQ1BVX0ZSRVFfR09WX1BPV0VSU0FWRT15CkNPTkZJR19DUFVfRlJFUV9HT1Zf
VVNFUlNQQUNFPXkKQ09ORklHX0NQVV9GUkVRX0dPVl9PTkRFTUFORD15CkNPTkZJR19DUFVf
RlJFUV9HT1ZfQ09OU0VSVkFUSVZFPXkKCiMKIyBDUFUgZnJlcXVlbmN5IHNjYWxpbmcgZHJp
dmVycwojCgojCiMgQ1BVSWRsZSBkcml2ZXIKIwoKIwojIENQVSBJZGxlCiMKQ09ORklHX0NQ
VV9JRExFPXkKQ09ORklHX0NQVV9JRExFX0dPVl9MQURERVI9eQpDT05GSUdfQ1BVX0lETEVf
R09WX01FTlU9eQoKIwojIFBPV0VSUEMgQ1BVIElkbGUgRHJpdmVycwojCiMgQ09ORklHX0FS
Q0hfTkVFRFNfQ1BVX0lETEVfQ09VUExFRCBpcyBub3Qgc2V0CkNPTkZJR19RVUlDQ19FTkdJ
TkU9eQpDT05GSUdfUUVfR1BJTz15CkNPTkZJR19DUE0yPXkKIyBDT05GSUdfRlNMX1VMSTE1
NzUgaXMgbm90IHNldApDT05GSUdfQ1BNPXkKIyBDT05GSUdfU0lNUExFX0dQSU8gaXMgbm90
IHNldAoKIwojIEtlcm5lbCBvcHRpb25zCiMKQ09ORklHX0hJR0hNRU09eQojIENPTkZJR19I
Wl8xMDAgaXMgbm90IHNldAojIENPTkZJR19IWl8yNTAgaXMgbm90IHNldAojIENPTkZJR19I
Wl8zMDAgaXMgbm90IHNldApDT05GSUdfSFpfMTAwMD15CkNPTkZJR19IWj0xMDAwCkNPTkZJ
R19TQ0hFRF9IUlRJQ0s9eQojIENPTkZJR19QUkVFTVBUX05PTkUgaXMgbm90IHNldAojIENP
TkZJR19QUkVFTVBUX1ZPTFVOVEFSWSBpcyBub3Qgc2V0CkNPTkZJR19QUkVFTVBUPXkKQ09O
RklHX1BSRUVNUFRfQ09VTlQ9eQpDT05GSUdfQklORk1UX0VMRj15CiMgQ09ORklHX0NPUkVf
RFVNUF9ERUZBVUxUX0VMRl9IRUFERVJTIGlzIG5vdCBzZXQKQ09ORklHX0JJTkZNVF9TQ1JJ
UFQ9eQojIENPTkZJR19IQVZFX0FPVVQgaXMgbm90IHNldApDT05GSUdfQklORk1UX01JU0M9
eQpDT05GSUdfQ09SRURVTVA9eQpDT05GSUdfTUFUSF9FTVVMQVRJT049eQpDT05GSUdfTUFU
SF9FTVVMQVRJT05fRlVMTD15CiMgQ09ORklHX01BVEhfRU1VTEFUSU9OX0hXX1VOSU1QTEVN
RU5URUQgaXMgbm90IHNldApDT05GSUdfSU9NTVVfSEVMUEVSPXkKQ09ORklHX1NXSU9UTEI9
eQpDT05GSUdfSE9UUExVR19DUFU9eQpDT05GSUdfQVJDSF9DUFVfUFJPQkVfUkVMRUFTRT15
CkNPTkZJR19BUkNIX0VOQUJMRV9NRU1PUllfSE9UUExVRz15CkNPTkZJR19BUkNIX0hBU19X
QUxLX01FTU9SWT15CkNPTkZJR19BUkNIX0VOQUJMRV9NRU1PUllfSE9UUkVNT1ZFPXkKIyBD
T05GSUdfS0VYRUMgaXMgbm90IHNldAojIENPTkZJR19DUkFTSF9EVU1QIGlzIG5vdCBzZXQK
Q09ORklHX0lSUV9BTExfQ1BVUz15CkNPTkZJR19BUkNIX0ZMQVRNRU1fRU5BQkxFPXkKQ09O
RklHX1NZU19TVVBQT1JUU19IVUdFVExCRlM9eQpDT05GSUdfRkxBVE1FTT15CkNPTkZJR19G
TEFUX05PREVfTUVNX01BUD15CkNPTkZJR19IQVZFX01FTUJMT0NLPXkKQ09ORklHX0hBVkVf
TUVNQkxPQ0tfTk9ERV9NQVA9eQpDT05GSUdfSEFWRV9HRU5FUklDX1JDVV9HVVA9eQpDT05G
SUdfTk9fQk9PVE1FTT15CiMgQ09ORklHX0hBVkVfQk9PVE1FTV9JTkZPX05PREUgaXMgbm90
IHNldApDT05GSUdfUEFHRUZMQUdTX0VYVEVOREVEPXkKQ09ORklHX1NQTElUX1BUTE9DS19D
UFVTPTQKIyBDT05GSUdfQ09NUEFDVElPTiBpcyBub3Qgc2V0CiMgQ09ORklHX01JR1JBVElP
TiBpcyBub3Qgc2V0CkNPTkZJR19QSFlTX0FERFJfVF82NEJJVD15CkNPTkZJR19aT05FX0RN
QV9GTEFHPTEKQ09ORklHX0JPVU5DRT15CkNPTkZJR19WSVJUX1RPX0JVUz15CiMgQ09ORklH
X0tTTSBpcyBub3Qgc2V0CkNPTkZJR19ERUZBVUxUX01NQVBfTUlOX0FERFI9NDA5NgojIENP
TkZJR19DTEVBTkNBQ0hFIGlzIG5vdCBzZXQKIyBDT05GSUdfRlJPTlRTV0FQIGlzIG5vdCBz
ZXQKIyBDT05GSUdfQ01BIGlzIG5vdCBzZXQKIyBDT05GSUdfWlBPT0wgaXMgbm90IHNldAoj
IENPTkZJR19aQlVEIGlzIG5vdCBzZXQKIyBDT05GSUdfWlNNQUxMT0MgaXMgbm90IHNldApD
T05GSUdfUFBDXzRLX1BBR0VTPXkKQ09ORklHX0ZPUkNFX01BWF9aT05FT1JERVI9MTEKIyBD
T05GSUdfUFBDX0NPUFJPX0JBU0UgaXMgbm90IHNldApDT05GSUdfQ01ETElORV9CT09MPXkK
Q09ORklHX0NNRExJTkU9ImNvbnNvbGU9dHR5UzAsMTE1MjAwIGNvbnNvbGU9dHR5MCIKIyBD
T05GSUdfQ01ETElORV9GT1JDRSBpcyBub3Qgc2V0CkNPTkZJR19FWFRSQV9UQVJHRVRTPSIi
CiMgQ09ORklHX1NVU1BFTkQgaXMgbm90IHNldAojIENPTkZJR19ISUJFUk5BVElPTiBpcyBu
b3Qgc2V0CiMgQ09ORklHX1BNIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VDQ09NUCBpcyBub3Qg
c2V0CkNPTkZJR19JU0FfRE1BX0FQST15CgojCiMgQnVzIG9wdGlvbnMKIwpDT05GSUdfWk9O
RV9ETUE9eQojIENPTkZJR19ORUVEX0RNQV9NQVBfU1RBVEUgaXMgbm90IHNldApDT05GSUdf
TkVFRF9TR19ETUFfTEVOR1RIPXkKQ09ORklHX0dFTkVSSUNfSVNBX0RNQT15CkNPTkZJR19Q
UENfSU5ESVJFQ1RfUENJPXkKQ09ORklHX0ZTTF9TT0M9eQpDT05GSUdfRlNMX1BDST15CkNP
TkZJR19GU0xfTEJDPXkKQ09ORklHX1BQQ19QQ0lfQ0hPSUNFPXkKQ09ORklHX1BDST15CkNP
TkZJR19QQ0lfRE9NQUlOUz15CkNPTkZJR19QQ0lfU1lTQ0FMTD15CkNPTkZJR19QQ0lFUE9S
VEJVUz15CkNPTkZJR19QQ0lFQUVSPXkKQ09ORklHX1BDSUVfRUNSQz15CkNPTkZJR19QQ0lF
QUVSX0lOSkVDVD15CkNPTkZJR19QQ0lFQVNQTT15CiMgQ09ORklHX1BDSUVBU1BNX0RFQlVH
IGlzIG5vdCBzZXQKQ09ORklHX1BDSUVBU1BNX0RFRkFVTFQ9eQojIENPTkZJR19QQ0lFQVNQ
TV9QT1dFUlNBVkUgaXMgbm90IHNldAojIENPTkZJR19QQ0lFQVNQTV9QRVJGT1JNQU5DRSBp
cyBub3Qgc2V0CkNPTkZJR19QQ0lfQlVTX0FERFJfVF82NEJJVD15CkNPTkZJR19QQ0lfTVNJ
PXkKIyBDT05GSUdfUENJX0RFQlVHIGlzIG5vdCBzZXQKIyBDT05GSUdfUENJX1JFQUxMT0Nf
RU5BQkxFX0FVVE8gaXMgbm90IHNldAojIENPTkZJR19QQ0lfU1RVQiBpcyBub3Qgc2V0CiMg
Q09ORklHX1BDSV9JT1YgaXMgbm90IHNldAojIENPTkZJR19QQ0lfUFJJIGlzIG5vdCBzZXQK
IyBDT05GSUdfUENJX1BBU0lEIGlzIG5vdCBzZXQKCiMKIyBQQ0kgaG9zdCBjb250cm9sbGVy
IGRyaXZlcnMKIwojIENPTkZJR19QQ0NBUkQgaXMgbm90IHNldAojIENPTkZJR19IT1RQTFVH
X1BDSSBpcyBub3Qgc2V0CiMgQ09ORklHX0hBU19SQVBJRElPIGlzIG5vdCBzZXQKIyBDT05G
SUdfUkFQSURJTyBpcyBub3Qgc2V0CiMgQ09ORklHX05PTlNUQVRJQ19LRVJORUwgaXMgbm90
IHNldAoKIwojIEFkdmFuY2VkIHNldHVwCiMKIyBDT05GSUdfQURWQU5DRURfT1BUSU9OUyBp
cyBub3Qgc2V0CgojCiMgRGVmYXVsdCBzZXR0aW5ncyBmb3IgYWR2YW5jZWQgY29uZmlndXJh
dGlvbiBvcHRpb25zIGFyZSB1c2VkCiMKQ09ORklHX0xPV01FTV9TSVpFPTB4MzAwMDAwMDAK
Q09ORklHX0xPV01FTV9DQU1fTlVNPTMKQ09ORklHX1BBR0VfT0ZGU0VUPTB4YzAwMDAwMDAK
Q09ORklHX0tFUk5FTF9TVEFSVD0weGMwMDAwMDAwCkNPTkZJR19QSFlTSUNBTF9TVEFSVD0w
eDAwMDAwMDAwCkNPTkZJR19QSFlTSUNBTF9BTElHTj0weDA0MDAwMDAwCkNPTkZJR19UQVNL
X1NJWkU9MHhjMDAwMDAwMAojIENPTkZJR19BUkNIX1JBTkRPTSBpcyBub3Qgc2V0CkNPTkZJ
R19ORVQ9eQoKIwojIE5ldHdvcmtpbmcgb3B0aW9ucwojCkNPTkZJR19QQUNLRVQ9eQojIENP
TkZJR19QQUNLRVRfRElBRyBpcyBub3Qgc2V0CkNPTkZJR19VTklYPXkKIyBDT05GSUdfVU5J
WF9ESUFHIGlzIG5vdCBzZXQKQ09ORklHX1hGUk09eQpDT05GSUdfWEZSTV9BTEdPPXkKQ09O
RklHX1hGUk1fVVNFUj15CiMgQ09ORklHX1hGUk1fU1VCX1BPTElDWSBpcyBub3Qgc2V0CiMg
Q09ORklHX1hGUk1fTUlHUkFURSBpcyBub3Qgc2V0CiMgQ09ORklHX1hGUk1fU1RBVElTVElD
UyBpcyBub3Qgc2V0CkNPTkZJR19ORVRfS0VZPXkKIyBDT05GSUdfTkVUX0tFWV9NSUdSQVRF
IGlzIG5vdCBzZXQKQ09ORklHX0lORVQ9eQpDT05GSUdfSVBfTVVMVElDQVNUPXkKIyBDT05G
SUdfSVBfQURWQU5DRURfUk9VVEVSIGlzIG5vdCBzZXQKQ09ORklHX0lQX1BOUD15CkNPTkZJ
R19JUF9QTlBfREhDUD15CkNPTkZJR19JUF9QTlBfQk9PVFA9eQpDT05GSUdfSVBfUE5QX1JB
UlA9eQpDT05GSUdfTkVUX0lQSVA9eQojIENPTkZJR19ORVRfSVBHUkVfREVNVVggaXMgbm90
IHNldApDT05GSUdfTkVUX0lQX1RVTk5FTD15CiMgQ09ORklHX0lQX01ST1VURSBpcyBub3Qg
c2V0CkNPTkZJR19TWU5fQ09PS0lFUz15CiMgQ09ORklHX05FVF9JUFZUSSBpcyBub3Qgc2V0
CiMgQ09ORklHX05FVF9VRFBfVFVOTkVMIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX0ZPVSBp
cyBub3Qgc2V0CiMgQ09ORklHX05FVF9GT1VfSVBfVFVOTkVMUyBpcyBub3Qgc2V0CiMgQ09O
RklHX0dFTkVWRSBpcyBub3Qgc2V0CkNPTkZJR19JTkVUX0FIPXkKQ09ORklHX0lORVRfRVNQ
PXkKIyBDT05GSUdfSU5FVF9JUENPTVAgaXMgbm90IHNldAojIENPTkZJR19JTkVUX1hGUk1f
VFVOTkVMIGlzIG5vdCBzZXQKQ09ORklHX0lORVRfVFVOTkVMPXkKQ09ORklHX0lORVRfWEZS
TV9NT0RFX1RSQU5TUE9SVD15CkNPTkZJR19JTkVUX1hGUk1fTU9ERV9UVU5ORUw9eQpDT05G
SUdfSU5FVF9YRlJNX01PREVfQkVFVD15CkNPTkZJR19JTkVUX0xSTz15CkNPTkZJR19JTkVU
X0RJQUc9eQpDT05GSUdfSU5FVF9UQ1BfRElBRz15CiMgQ09ORklHX0lORVRfVURQX0RJQUcg
aXMgbm90IHNldAojIENPTkZJR19UQ1BfQ09OR19BRFZBTkNFRCBpcyBub3Qgc2V0CkNPTkZJ
R19UQ1BfQ09OR19DVUJJQz15CkNPTkZJR19ERUZBVUxUX1RDUF9DT05HPSJjdWJpYyIKIyBD
T05GSUdfVENQX01ENVNJRyBpcyBub3Qgc2V0CkNPTkZJR19JUFY2PXkKIyBDT05GSUdfSVBW
Nl9ST1VURVJfUFJFRiBpcyBub3Qgc2V0CiMgQ09ORklHX0lQVjZfT1BUSU1JU1RJQ19EQUQg
aXMgbm90IHNldAojIENPTkZJR19JTkVUNl9BSCBpcyBub3Qgc2V0CiMgQ09ORklHX0lORVQ2
X0VTUCBpcyBub3Qgc2V0CiMgQ09ORklHX0lORVQ2X0lQQ09NUCBpcyBub3Qgc2V0CiMgQ09O
RklHX0lQVjZfTUlQNiBpcyBub3Qgc2V0CiMgQ09ORklHX0lORVQ2X1hGUk1fVFVOTkVMIGlz
IG5vdCBzZXQKIyBDT05GSUdfSU5FVDZfVFVOTkVMIGlzIG5vdCBzZXQKQ09ORklHX0lORVQ2
X1hGUk1fTU9ERV9UUkFOU1BPUlQ9eQpDT05GSUdfSU5FVDZfWEZSTV9NT0RFX1RVTk5FTD15
CkNPTkZJR19JTkVUNl9YRlJNX01PREVfQkVFVD15CiMgQ09ORklHX0lORVQ2X1hGUk1fTU9E
RV9ST1VURU9QVElNSVpBVElPTiBpcyBub3Qgc2V0CiMgQ09ORklHX0lQVjZfVlRJIGlzIG5v
dCBzZXQKQ09ORklHX0lQVjZfU0lUPXkKIyBDT05GSUdfSVBWNl9TSVRfNlJEIGlzIG5vdCBz
ZXQKQ09ORklHX0lQVjZfTkRJU0NfTk9ERVRZUEU9eQojIENPTkZJR19JUFY2X1RVTk5FTCBp
cyBub3Qgc2V0CiMgQ09ORklHX0lQVjZfR1JFIGlzIG5vdCBzZXQKIyBDT05GSUdfSVBWNl9N
VUxUSVBMRV9UQUJMRVMgaXMgbm90IHNldAojIENPTkZJR19JUFY2X01ST1VURSBpcyBub3Qg
c2V0CiMgQ09ORklHX05FVFdPUktfU0VDTUFSSyBpcyBub3Qgc2V0CkNPTkZJR19ORVRfUFRQ
X0NMQVNTSUZZPXkKIyBDT05GSUdfTkVUV09SS19QSFlfVElNRVNUQU1QSU5HIGlzIG5vdCBz
ZXQKIyBDT05GSUdfTkVURklMVEVSIGlzIG5vdCBzZXQKIyBDT05GSUdfSVBfRENDUCBpcyBu
b3Qgc2V0CiMgQ09ORklHX0lQX1NDVFAgaXMgbm90IHNldAojIENPTkZJR19SRFMgaXMgbm90
IHNldAojIENPTkZJR19USVBDIGlzIG5vdCBzZXQKIyBDT05GSUdfQVRNIGlzIG5vdCBzZXQK
IyBDT05GSUdfTDJUUCBpcyBub3Qgc2V0CiMgQ09ORklHX0JSSURHRSBpcyBub3Qgc2V0CkNP
TkZJR19IQVZFX05FVF9EU0E9eQojIENPTkZJR19WTEFOXzgwMjFRIGlzIG5vdCBzZXQKIyBD
T05GSUdfREVDTkVUIGlzIG5vdCBzZXQKIyBDT05GSUdfTExDMiBpcyBub3Qgc2V0CiMgQ09O
RklHX0lQWCBpcyBub3Qgc2V0CiMgQ09ORklHX0FUQUxLIGlzIG5vdCBzZXQKIyBDT05GSUdf
WDI1IGlzIG5vdCBzZXQKIyBDT05GSUdfTEFQQiBpcyBub3Qgc2V0CiMgQ09ORklHX1BIT05F
VCBpcyBub3Qgc2V0CiMgQ09ORklHXzZMT1dQQU4gaXMgbm90IHNldAojIENPTkZJR19JRUVF
ODAyMTU0IGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX1NDSEVEIGlzIG5vdCBzZXQKIyBDT05G
SUdfRENCIGlzIG5vdCBzZXQKIyBDT05GSUdfRE5TX1JFU09MVkVSIGlzIG5vdCBzZXQKIyBD
T05GSUdfQkFUTUFOX0FEViBpcyBub3Qgc2V0CiMgQ09ORklHX09QRU5WU1dJVENIIGlzIG5v
dCBzZXQKIyBDT05GSUdfVlNPQ0tFVFMgaXMgbm90IHNldAojIENPTkZJR19ORVRMSU5LX01N
QVAgaXMgbm90IHNldAojIENPTkZJR19ORVRMSU5LX0RJQUcgaXMgbm90IHNldAojIENPTkZJ
R19NUExTIGlzIG5vdCBzZXQKIyBDT05GSUdfSFNSIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVU
X1NXSVRDSERFViBpcyBub3Qgc2V0CkNPTkZJR19SUFM9eQpDT05GSUdfUkZTX0FDQ0VMPXkK
Q09ORklHX1hQUz15CiMgQ09ORklHX0NHUk9VUF9ORVRfUFJJTyBpcyBub3Qgc2V0CiMgQ09O
RklHX0NHUk9VUF9ORVRfQ0xBU1NJRCBpcyBub3Qgc2V0CkNPTkZJR19ORVRfUlhfQlVTWV9Q
T0xMPXkKQ09ORklHX0JRTD15CiMgQ09ORklHX0JQRl9KSVQgaXMgbm90IHNldApDT05GSUdf
TkVUX0ZMT1dfTElNSVQ9eQoKIwojIE5ldHdvcmsgdGVzdGluZwojCiMgQ09ORklHX05FVF9Q
S1RHRU4gaXMgbm90IHNldAojIENPTkZJR19IQU1SQURJTyBpcyBub3Qgc2V0CiMgQ09ORklH
X0NBTiBpcyBub3Qgc2V0CkNPTkZJR19JUkRBPW0KCiMKIyBJckRBIHByb3RvY29scwojCkNP
TkZJR19JUkxBTj1tCkNPTkZJR19JUk5FVD1tCkNPTkZJR19JUkNPTU09bQpDT05GSUdfSVJE
QV9VTFRSQT15CgojCiMgSXJEQSBvcHRpb25zCiMKQ09ORklHX0lSREFfQ0FDSEVfTEFTVF9M
U0FQPXkKQ09ORklHX0lSREFfRkFTVF9SUj15CkNPTkZJR19JUkRBX0RFQlVHPXkKCiMKIyBJ
bmZyYXJlZC1wb3J0IGRldmljZSBkcml2ZXJzCiMKCiMKIyBTSVIgZGV2aWNlIGRyaXZlcnMK
IwpDT05GSUdfSVJUVFlfU0lSPW0KCiMKIyBEb25nbGUgc3VwcG9ydAojCkNPTkZJR19ET05H
TEU9eQpDT05GSUdfRVNJX0RPTkdMRT1tCkNPTkZJR19BQ1RJU1lTX0RPTkdMRT1tCkNPTkZJ
R19URUtSQU1fRE9OR0xFPW0KQ09ORklHX1RPSU0zMjMyX0RPTkdMRT1tCkNPTkZJR19MSVRF
TElOS19ET05HTEU9bQpDT05GSUdfTUE2MDBfRE9OR0xFPW0KQ09ORklHX0dJUkJJTF9ET05H
TEU9bQpDT05GSUdfTUNQMjEyMF9ET05HTEU9bQpDT05GSUdfT0xEX0JFTEtJTl9ET05HTEU9
bQpDT05GSUdfQUNUMjAwTF9ET05HTEU9bQpDT05GSUdfS0lOR1NVTl9ET05HTEU9bQpDT05G
SUdfS1NEQVpaTEVfRE9OR0xFPW0KQ09ORklHX0tTOTU5X0RPTkdMRT1tCgojCiMgRklSIGRl
dmljZSBkcml2ZXJzCiMKQ09ORklHX1VTQl9JUkRBPW0KQ09ORklHX1NJR01BVEVMX0ZJUj1t
CkNPTkZJR19OU0NfRklSPW0KQ09ORklHX1dJTkJPTkRfRklSPW0KQ09ORklHX1RPU0hJQkFf
RklSPW0KQ09ORklHX1NNQ19JUkNDX0ZJUj1tCkNPTkZJR19BTElfRklSPW0KQ09ORklHX1ZM
U0lfRklSPW0KQ09ORklHX1ZJQV9GSVI9bQpDT05GSUdfTUNTX0ZJUj1tCkNPTkZJR19CVD15
CkNPTkZJR19CVF9CUkVEUj15CkNPTkZJR19CVF9SRkNPTU09eQpDT05GSUdfQlRfUkZDT01N
X1RUWT15CkNPTkZJR19CVF9CTkVQPXkKQ09ORklHX0JUX0JORVBfTUNfRklMVEVSPXkKQ09O
RklHX0JUX0JORVBfUFJPVE9fRklMVEVSPXkKQ09ORklHX0JUX0hJRFA9eQpDT05GSUdfQlRf
TEU9eQojIENPTkZJR19CVF9TRUxGVEVTVCBpcyBub3Qgc2V0CkNPTkZJR19CVF9ERUJVR0ZT
PXkKCiMKIyBCbHVldG9vdGggZGV2aWNlIGRyaXZlcnMKIwpDT05GSUdfQlRfSU5URUw9bQpD
T05GSUdfQlRfQkNNPW0KQ09ORklHX0JUX0hDSUJUVVNCPW0KQ09ORklHX0JUX0hDSUJUVVNC
X0JDTT15CkNPTkZJR19CVF9IQ0lCVFNESU89bQpDT05GSUdfQlRfSENJVUFSVD1tCkNPTkZJ
R19CVF9IQ0lVQVJUX0g0PXkKQ09ORklHX0JUX0hDSVVBUlRfQkNTUD15CkNPTkZJR19CVF9I
Q0lVQVJUX0FUSDNLPXkKQ09ORklHX0JUX0hDSVVBUlRfTEw9eQpDT05GSUdfQlRfSENJVUFS
VF8zV0lSRT15CiMgQ09ORklHX0JUX0hDSVVBUlRfSU5URUwgaXMgbm90IHNldAojIENPTkZJ
R19CVF9IQ0lVQVJUX0JDTSBpcyBub3Qgc2V0CkNPTkZJR19CVF9IQ0lCQ00yMDNYPW0KQ09O
RklHX0JUX0hDSUJQQTEwWD1tCkNPTkZJR19CVF9IQ0lCRlVTQj1tCkNPTkZJR19CVF9IQ0lW
SENJPW0KQ09ORklHX0JUX01SVkw9bQpDT05GSUdfQlRfTVJWTF9TRElPPW0KQ09ORklHX0JU
X0FUSDNLPW0KIyBDT05GSUdfQUZfUlhSUEMgaXMgbm90IHNldApDT05GSUdfV0lSRUxFU1M9
eQpDT05GSUdfV0VYVF9DT1JFPXkKQ09ORklHX1dFWFRfUFJPQz15CkNPTkZJR19DRkc4MDIx
MT1tCiMgQ09ORklHX05MODAyMTFfVEVTVE1PREUgaXMgbm90IHNldAojIENPTkZJR19DRkc4
MDIxMV9ERVZFTE9QRVJfV0FSTklOR1MgaXMgbm90IHNldAojIENPTkZJR19DRkc4MDIxMV9S
RUdfREVCVUcgaXMgbm90IHNldAojIENPTkZJR19DRkc4MDIxMV9DRVJUSUZJQ0FUSU9OX09O
VVMgaXMgbm90IHNldApDT05GSUdfQ0ZHODAyMTFfREVGQVVMVF9QUz15CiMgQ09ORklHX0NG
RzgwMjExX0RFQlVHRlMgaXMgbm90IHNldAojIENPTkZJR19DRkc4MDIxMV9JTlRFUk5BTF9S
RUdEQiBpcyBub3Qgc2V0CkNPTkZJR19DRkc4MDIxMV9XRVhUPXkKIyBDT05GSUdfTElCODAy
MTEgaXMgbm90IHNldApDT05GSUdfTUFDODAyMTE9bQpDT05GSUdfTUFDODAyMTFfSEFTX1JD
PXkKQ09ORklHX01BQzgwMjExX1JDX01JTlNUUkVMPXkKQ09ORklHX01BQzgwMjExX1JDX01J
TlNUUkVMX0hUPXkKIyBDT05GSUdfTUFDODAyMTFfUkNfTUlOU1RSRUxfVkhUIGlzIG5vdCBz
ZXQKQ09ORklHX01BQzgwMjExX1JDX0RFRkFVTFRfTUlOU1RSRUw9eQpDT05GSUdfTUFDODAy
MTFfUkNfREVGQVVMVD0ibWluc3RyZWxfaHQiCiMgQ09ORklHX01BQzgwMjExX01FU0ggaXMg
bm90IHNldApDT05GSUdfTUFDODAyMTFfTEVEUz15CiMgQ09ORklHX01BQzgwMjExX0RFQlVH
RlMgaXMgbm90IHNldAojIENPTkZJR19NQUM4MDIxMV9NRVNTQUdFX1RSQUNJTkcgaXMgbm90
IHNldAojIENPTkZJR19NQUM4MDIxMV9ERUJVR19NRU5VIGlzIG5vdCBzZXQKIyBDT05GSUdf
V0lNQVggaXMgbm90IHNldAojIENPTkZJR19SRktJTEwgaXMgbm90IHNldAojIENPTkZJR19O
RVRfOVAgaXMgbm90IHNldAojIENPTkZJR19DQUlGIGlzIG5vdCBzZXQKIyBDT05GSUdfQ0VQ
SF9MSUIgaXMgbm90IHNldAojIENPTkZJR19ORkMgaXMgbm90IHNldApDT05GSUdfSEFWRV9C
UEZfSklUPXkKCiMKIyBEZXZpY2UgRHJpdmVycwojCgojCiMgR2VuZXJpYyBEcml2ZXIgT3B0
aW9ucwojCkNPTkZJR19VRVZFTlRfSEVMUEVSPXkKQ09ORklHX1VFVkVOVF9IRUxQRVJfUEFU
SD0iIgpDT05GSUdfREVWVE1QRlM9eQpDT05GSUdfREVWVE1QRlNfTU9VTlQ9eQpDT05GSUdf
U1RBTkRBTE9ORT15CkNPTkZJR19QUkVWRU5UX0ZJUk1XQVJFX0JVSUxEPXkKQ09ORklHX0ZX
X0xPQURFUj15CkNPTkZJR19GSVJNV0FSRV9JTl9LRVJORUw9eQpDT05GSUdfRVhUUkFfRklS
TVdBUkU9InJhZGVvbi90YWhpdGlfY2UuYmluIHJhZGVvbi90YWhpdGlfbWMuYmluIHJhZGVv
bi90YWhpdGlfbWUuYmluIHJhZGVvbi90YWhpdGlfcGZwLmJpbiByYWRlb24vdGFoaXRpX3Js
Yy5iaW4gcmFkZW9uL3RhaGl0aV9zbWMuYmluIHJhZGVvbi9UQUhJVElfdXZkLmJpbiByYWRl
b24vcGl0Y2Fpcm5fY2UuYmluIHJhZGVvbi9waXRjYWlybl9tYy5iaW4gcmFkZW9uL3BpdGNh
aXJuX21lLmJpbiByYWRlb24vcGl0Y2Fpcm5fcGZwLmJpbiByYWRlb24vcGl0Y2Fpcm5fcmxj
LmJpbiByYWRlb24vcGl0Y2Fpcm5fc21jLmJpbiByYWRlb24vdmVyZGVfY2UuYmluIHJhZGVv
bi92ZXJkZV9tYy5iaW4gcmFkZW9uL3ZlcmRlX21lLmJpbiByYWRlb24vdmVyZGVfcGZwLmJp
biByYWRlb24vdmVyZGVfcmxjLmJpbiByYWRlb24vdmVyZGVfc21jLmJpbiByYWRlb24vQlRD
X3JsYy5iaW4gcmFkZW9uL1RVUktTX21jLmJpbiByYWRlb24vVFVSS1NfbWUuYmluIHJhZGVv
bi9UVVJLU19wZnAuYmluIHJhZGVvbi9UVVJLU19zbWMuYmluIHJhZGVvbi9TVU1PX3V2ZC5i
aW4gcmFkZW9uL0NBSUNPU19tYy5iaW4gcmFkZW9uL0NBSUNPU19tZS5iaW4gcmFkZW9uL0NB
SUNPU19wZnAuYmluIHJhZGVvbi9DQUlDT1Nfc21jLmJpbiByYWRlb24vQ0VEQVJfbWUuYmlu
IHJhZGVvbi9DRURBUl9wZnAuYmluIHJhZGVvbi9DRURBUl9ybGMuYmluIHJhZGVvbi9DRURB
Ul9zbWMuYmluIHJhZGVvbi9DWVBSRVNTX3V2ZC5iaW4gIgpDT05GSUdfRVhUUkFfRklSTVdB
UkVfRElSPSIvbGliL2Zpcm13YXJlIgojIENPTkZJR19GV19MT0FERVJfVVNFUl9IRUxQRVJf
RkFMTEJBQ0sgaXMgbm90IHNldApDT05GSUdfV0FOVF9ERVZfQ09SRURVTVA9eQpDT05GSUdf
QUxMT1dfREVWX0NPUkVEVU1QPXkKQ09ORklHX0RFVl9DT1JFRFVNUD15CiMgQ09ORklHX0RF
QlVHX0RSSVZFUiBpcyBub3Qgc2V0CiMgQ09ORklHX0RFQlVHX0RFVlJFUyBpcyBub3Qgc2V0
CiMgQ09ORklHX1NZU19IWVBFUlZJU09SIGlzIG5vdCBzZXQKIyBDT05GSUdfR0VORVJJQ19D
UFVfREVWSUNFUyBpcyBub3Qgc2V0CkNPTkZJR19SRUdNQVA9eQpDT05GSUdfUkVHTUFQX0ky
Qz15CkNPTkZJR19SRUdNQVBfTU1JTz15CkNPTkZJR19ETUFfU0hBUkVEX0JVRkZFUj15CiMg
Q09ORklHX0ZFTkNFX1RSQUNFIGlzIG5vdCBzZXQKCiMKIyBCdXMgZGV2aWNlcwojCiMgQ09O
RklHX0NPTk5FQ1RPUiBpcyBub3Qgc2V0CiMgQ09ORklHX01URCBpcyBub3Qgc2V0CkNPTkZJ
R19EVEM9eQpDT05GSUdfT0Y9eQoKIwojIERldmljZSBUcmVlIGFuZCBPcGVuIEZpcm13YXJl
IHN1cHBvcnQKIwojIENPTkZJR19PRl9VTklUVEVTVCBpcyBub3Qgc2V0CkNPTkZJR19PRl9G
TEFUVFJFRT15CkNPTkZJR19PRl9FQVJMWV9GTEFUVFJFRT15CkNPTkZJR19PRl9BRERSRVNT
PXkKQ09ORklHX09GX0FERFJFU1NfUENJPXkKQ09ORklHX09GX0lSUT15CkNPTkZJR19PRl9O
RVQ9eQpDT05GSUdfT0ZfTURJTz15CkNPTkZJR19PRl9QQ0k9eQpDT05GSUdfT0ZfUENJX0lS
UT15CkNPTkZJR19PRl9SRVNFUlZFRF9NRU09eQojIENPTkZJR19PRl9PVkVSTEFZIGlzIG5v
dCBzZXQKQ09ORklHX0FSQ0hfTUlHSFRfSEFWRV9QQ19QQVJQT1JUPXkKIyBDT05GSUdfUEFS
UE9SVCBpcyBub3Qgc2V0CkNPTkZJR19CTEtfREVWPXkKIyBDT05GSUdfQkxLX0RFVl9OVUxM
X0JMSyBpcyBub3Qgc2V0CiMgQ09ORklHX0JMS19ERVZfRkQgaXMgbm90IHNldAojIENPTkZJ
R19CTEtfREVWX1BDSUVTU0RfTVRJUDMyWFggaXMgbm90IHNldAojIENPTkZJR19CTEtfQ1BR
X0NJU1NfREEgaXMgbm90IHNldAojIENPTkZJR19CTEtfREVWX0RBQzk2MCBpcyBub3Qgc2V0
CiMgQ09ORklHX0JMS19ERVZfVU1FTSBpcyBub3Qgc2V0CiMgQ09ORklHX0JMS19ERVZfQ09X
X0NPTU1PTiBpcyBub3Qgc2V0CkNPTkZJR19CTEtfREVWX0xPT1A9eQpDT05GSUdfQkxLX0RF
Vl9MT09QX01JTl9DT1VOVD04CiMgQ09ORklHX0JMS19ERVZfQ1JZUFRPTE9PUCBpcyBub3Qg
c2V0CiMgQ09ORklHX0JMS19ERVZfRFJCRCBpcyBub3Qgc2V0CiMgQ09ORklHX0JMS19ERVZf
TkJEIGlzIG5vdCBzZXQKIyBDT05GSUdfQkxLX0RFVl9OVk1FIGlzIG5vdCBzZXQKIyBDT05G
SUdfQkxLX0RFVl9TWDggaXMgbm90IHNldApDT05GSUdfQkxLX0RFVl9SQU09eQpDT05GSUdf
QkxLX0RFVl9SQU1fQ09VTlQ9MTYKQ09ORklHX0JMS19ERVZfUkFNX1NJWkU9MTMxMDcyCiMg
Q09ORklHX0JMS19ERVZfUE1FTSBpcyBub3Qgc2V0CiMgQ09ORklHX0NEUk9NX1BLVENEVkQg
aXMgbm90IHNldAojIENPTkZJR19BVEFfT1ZFUl9FVEggaXMgbm90IHNldAojIENPTkZJR19C
TEtfREVWX0hEIGlzIG5vdCBzZXQKIyBDT05GSUdfQkxLX0RFVl9SQkQgaXMgbm90IHNldAoj
IENPTkZJR19CTEtfREVWX1JTWFggaXMgbm90IHNldAoKIwojIE1pc2MgZGV2aWNlcwojCiMg
Q09ORklHX1NFTlNPUlNfTElTM0xWMDJEIGlzIG5vdCBzZXQKIyBDT05GSUdfQUQ1MjVYX0RQ
T1QgaXMgbm90IHNldAojIENPTkZJR19EVU1NWV9JUlEgaXMgbm90IHNldAojIENPTkZJR19Q
SEFOVE9NIGlzIG5vdCBzZXQKIyBDT05GSUdfU0dJX0lPQzQgaXMgbm90IHNldAojIENPTkZJ
R19USUZNX0NPUkUgaXMgbm90IHNldAojIENPTkZJR19JQ1M5MzJTNDAxIGlzIG5vdCBzZXQK
IyBDT05GSUdfRU5DTE9TVVJFX1NFUlZJQ0VTIGlzIG5vdCBzZXQKIyBDT05GSUdfSFBfSUxP
IGlzIG5vdCBzZXQKIyBDT05GSUdfQVBEUzk4MDJBTFMgaXMgbm90IHNldAojIENPTkZJR19J
U0wyOTAwMyBpcyBub3Qgc2V0CiMgQ09ORklHX0lTTDI5MDIwIGlzIG5vdCBzZXQKIyBDT05G
SUdfU0VOU09SU19UU0wyNTUwIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19CSDE3ODAg
aXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0JIMTc3MCBpcyBub3Qgc2V0CiMgQ09ORklH
X1NFTlNPUlNfQVBEUzk5MFggaXMgbm90IHNldAojIENPTkZJR19ITUM2MzUyIGlzIG5vdCBz
ZXQKIyBDT05GSUdfRFMxNjgyIGlzIG5vdCBzZXQKIyBDT05GSUdfQk1QMDg1X0kyQyBpcyBu
b3Qgc2V0CiMgQ09ORklHX1VTQl9TV0lUQ0hfRlNBOTQ4MCBpcyBub3Qgc2V0CiMgQ09ORklH
X1NSQU0gaXMgbm90IHNldAojIENPTkZJR19DMlBPUlQgaXMgbm90IHNldAoKIwojIEVFUFJP
TSBzdXBwb3J0CiMKIyBDT05GSUdfRUVQUk9NX0FUMjQgaXMgbm90IHNldAojIENPTkZJR19F
RVBST01fTEVHQUNZIGlzIG5vdCBzZXQKIyBDT05GSUdfRUVQUk9NX01BWDY4NzUgaXMgbm90
IHNldApDT05GSUdfRUVQUk9NXzkzQ1g2PW0KIyBDT05GSUdfQ0I3MTBfQ09SRSBpcyBub3Qg
c2V0CgojCiMgVGV4YXMgSW5zdHJ1bWVudHMgc2hhcmVkIHRyYW5zcG9ydCBsaW5lIGRpc2Np
cGxpbmUKIwojIENPTkZJR19USV9TVCBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfTElT
M19JMkMgaXMgbm90IHNldAoKIwojIEFsdGVyYSBGUEdBIGZpcm13YXJlIGRvd25sb2FkIG1v
ZHVsZQojCiMgQ09ORklHX0FMVEVSQV9TVEFQTCBpcyBub3Qgc2V0CgojCiMgSW50ZWwgTUlD
IEJ1cyBEcml2ZXIKIwoKIwojIEludGVsIE1JQyBIb3N0IERyaXZlcgojCgojCiMgSW50ZWwg
TUlDIENhcmQgRHJpdmVyCiMKIyBDT05GSUdfRUNITyBpcyBub3Qgc2V0CiMgQ09ORklHX0NY
TF9CQVNFIGlzIG5vdCBzZXQKQ09ORklHX0hBVkVfSURFPXkKIyBDT05GSUdfSURFIGlzIG5v
dCBzZXQKCiMKIyBTQ1NJIGRldmljZSBzdXBwb3J0CiMKQ09ORklHX1NDU0lfTU9EPXkKIyBD
T05GSUdfUkFJRF9BVFRSUyBpcyBub3Qgc2V0CkNPTkZJR19TQ1NJPXkKQ09ORklHX1NDU0lf
RE1BPXkKIyBDT05GSUdfU0NTSV9ORVRMSU5LIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9N
UV9ERUZBVUxUIGlzIG5vdCBzZXQKQ09ORklHX1NDU0lfUFJPQ19GUz15CgojCiMgU0NTSSBz
dXBwb3J0IHR5cGUgKGRpc2ssIHRhcGUsIENELVJPTSkKIwpDT05GSUdfQkxLX0RFVl9TRD15
CiMgQ09ORklHX0NIUl9ERVZfU1QgaXMgbm90IHNldAojIENPTkZJR19DSFJfREVWX09TU1Qg
aXMgbm90IHNldApDT05GSUdfQkxLX0RFVl9TUj15CkNPTkZJR19CTEtfREVWX1NSX1ZFTkRP
Uj15CkNPTkZJR19DSFJfREVWX1NHPXkKIyBDT05GSUdfQ0hSX0RFVl9TQ0ggaXMgbm90IHNl
dAojIENPTkZJR19TQ1NJX0NPTlNUQU5UUyBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfTE9H
R0lORyBpcyBub3Qgc2V0CkNPTkZJR19TQ1NJX1NDQU5fQVNZTkM9eQoKIwojIFNDU0kgVHJh
bnNwb3J0cwojCiMgQ09ORklHX1NDU0lfU1BJX0FUVFJTIGlzIG5vdCBzZXQKIyBDT05GSUdf
U0NTSV9GQ19BVFRSUyBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfSVNDU0lfQVRUUlMgaXMg
bm90IHNldAojIENPTkZJR19TQ1NJX1NBU19BVFRSUyBpcyBub3Qgc2V0CiMgQ09ORklHX1ND
U0lfU0FTX0xJQlNBUyBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfU1JQX0FUVFJTIGlzIG5v
dCBzZXQKQ09ORklHX1NDU0lfTE9XTEVWRUw9eQojIENPTkZJR19JU0NTSV9UQ1AgaXMgbm90
IHNldAojIENPTkZJR19JU0NTSV9CT09UX1NZU0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NT
SV9DWEdCM19JU0NTSSBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfQ1hHQjRfSVNDU0kgaXMg
bm90IHNldAojIENPTkZJR19TQ1NJX0JOWDJfSVNDU0kgaXMgbm90IHNldAojIENPTkZJR19C
RTJJU0NTSSBpcyBub3Qgc2V0CiMgQ09ORklHX0JMS19ERVZfM1dfWFhYWF9SQUlEIGlzIG5v
dCBzZXQKIyBDT05GSUdfU0NTSV9IUFNBIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV8zV185
WFhYIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV8zV19TQVMgaXMgbm90IHNldAojIENPTkZJ
R19TQ1NJX0FDQVJEIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9BQUNSQUlEIGlzIG5vdCBz
ZXQKIyBDT05GSUdfU0NTSV9BSUM3WFhYIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9BSUM3
OVhYIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9BSUM5NFhYIGlzIG5vdCBzZXQKIyBDT05G
SUdfU0NTSV9NVlNBUyBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfTVZVTUkgaXMgbm90IHNl
dAojIENPTkZJR19TQ1NJX0RQVF9JMk8gaXMgbm90IHNldAojIENPTkZJR19TQ1NJX0FEVkFO
U1lTIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9BUkNNU1IgaXMgbm90IHNldAojIENPTkZJ
R19TQ1NJX0VTQVMyUiBpcyBub3Qgc2V0CiMgQ09ORklHX01FR0FSQUlEX05FV0dFTiBpcyBu
b3Qgc2V0CiMgQ09ORklHX01FR0FSQUlEX0xFR0FDWSBpcyBub3Qgc2V0CiMgQ09ORklHX01F
R0FSQUlEX1NBUyBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfTVBUMlNBUyBpcyBub3Qgc2V0
CiMgQ09ORklHX1NDU0lfTVBUM1NBUyBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfVUZTSENE
IGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9IUFRJT1AgaXMgbm90IHNldAojIENPTkZJR19T
Q1NJX0JVU0xPR0lDIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9ETVgzMTkxRCBpcyBub3Qg
c2V0CiMgQ09ORklHX1NDU0lfRUFUQSBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfRlVUVVJF
X0RPTUFJTiBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfR0RUSCBpcyBub3Qgc2V0CiMgQ09O
RklHX1NDU0lfSVBTIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9JTklUSU8gaXMgbm90IHNl
dAojIENPTkZJR19TQ1NJX0lOSUExMDAgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX1NURVgg
aXMgbm90IHNldAojIENPTkZJR19TQ1NJX1NZTTUzQzhYWF8yIGlzIG5vdCBzZXQKIyBDT05G
SUdfU0NTSV9JUFIgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX1FMT0dJQ18xMjgwIGlzIG5v
dCBzZXQKIyBDT05GSUdfU0NTSV9RTEFfSVNDU0kgaXMgbm90IHNldAojIENPTkZJR19TQ1NJ
X0RDMzk1eCBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfQU01M0M5NzQgaXMgbm90IHNldAoj
IENPTkZJR19TQ1NJX05TUDMyIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9XRDcxOVggaXMg
bm90IHNldAojIENPTkZJR19TQ1NJX0RFQlVHIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9Q
TUNSQUlEIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9QTTgwMDEgaXMgbm90IHNldAojIENP
TkZJR19TQ1NJX0RIIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9PU0RfSU5JVElBVE9SIGlz
IG5vdCBzZXQKQ09ORklHX0FUQT15CiMgQ09ORklHX0FUQV9OT05TVEFOREFSRCBpcyBub3Qg
c2V0CkNPTkZJR19BVEFfVkVSQk9TRV9FUlJPUj15CkNPTkZJR19TQVRBX1BNUD15CgojCiMg
Q29udHJvbGxlcnMgd2l0aCBub24tU0ZGIG5hdGl2ZSBpbnRlcmZhY2UKIwpDT05GSUdfU0FU
QV9BSENJPXkKQ09ORklHX1NBVEFfQUhDSV9QTEFURk9STT15CkNPTkZJR19TQVRBX0ZTTD15
CiMgQ09ORklHX1NBVEFfSU5JQzE2MlggaXMgbm90IHNldAojIENPTkZJR19TQVRBX0FDQVJE
X0FIQ0kgaXMgbm90IHNldAojIENPTkZJR19TQVRBX1NJTDI0IGlzIG5vdCBzZXQKQ09ORklH
X0FUQV9TRkY9eQoKIwojIFNGRiBjb250cm9sbGVycyB3aXRoIGN1c3RvbSBETUEgaW50ZXJm
YWNlCiMKIyBDT05GSUdfUERDX0FETUEgaXMgbm90IHNldAojIENPTkZJR19TQVRBX1FTVE9S
IGlzIG5vdCBzZXQKIyBDT05GSUdfU0FUQV9TWDQgaXMgbm90IHNldApDT05GSUdfQVRBX0JN
RE1BPXkKCiMKIyBTQVRBIFNGRiBjb250cm9sbGVycyB3aXRoIEJNRE1BCiMKIyBDT05GSUdf
QVRBX1BJSVggaXMgbm90IHNldAojIENPTkZJR19TQVRBX01WIGlzIG5vdCBzZXQKIyBDT05G
SUdfU0FUQV9OViBpcyBub3Qgc2V0CiMgQ09ORklHX1NBVEFfUFJPTUlTRSBpcyBub3Qgc2V0
CiMgQ09ORklHX1NBVEFfU0lMIGlzIG5vdCBzZXQKIyBDT05GSUdfU0FUQV9TSVMgaXMgbm90
IHNldAojIENPTkZJR19TQVRBX1NWVyBpcyBub3Qgc2V0CiMgQ09ORklHX1NBVEFfVUxJIGlz
IG5vdCBzZXQKIyBDT05GSUdfU0FUQV9WSUEgaXMgbm90IHNldAojIENPTkZJR19TQVRBX1ZJ
VEVTU0UgaXMgbm90IHNldAoKIwojIFBBVEEgU0ZGIGNvbnRyb2xsZXJzIHdpdGggQk1ETUEK
IwojIENPTkZJR19QQVRBX0FMSSBpcyBub3Qgc2V0CiMgQ09ORklHX1BBVEFfQU1EIGlzIG5v
dCBzZXQKIyBDT05GSUdfUEFUQV9BUlRPUCBpcyBub3Qgc2V0CiMgQ09ORklHX1BBVEFfQVRJ
SVhQIGlzIG5vdCBzZXQKIyBDT05GSUdfUEFUQV9BVFA4NjdYIGlzIG5vdCBzZXQKIyBDT05G
SUdfUEFUQV9DTUQ2NFggaXMgbm90IHNldAojIENPTkZJR19QQVRBX0NZUFJFU1MgaXMgbm90
IHNldAojIENPTkZJR19QQVRBX0VGQVIgaXMgbm90IHNldAojIENPTkZJR19QQVRBX0hQVDM2
NiBpcyBub3Qgc2V0CiMgQ09ORklHX1BBVEFfSFBUMzdYIGlzIG5vdCBzZXQKIyBDT05GSUdf
UEFUQV9IUFQzWDJOIGlzIG5vdCBzZXQKIyBDT05GSUdfUEFUQV9IUFQzWDMgaXMgbm90IHNl
dAojIENPTkZJR19QQVRBX0lUODIxMyBpcyBub3Qgc2V0CiMgQ09ORklHX1BBVEFfSVQ4MjFY
IGlzIG5vdCBzZXQKIyBDT05GSUdfUEFUQV9KTUlDUk9OIGlzIG5vdCBzZXQKIyBDT05GSUdf
UEFUQV9NQVJWRUxMIGlzIG5vdCBzZXQKIyBDT05GSUdfUEFUQV9ORVRDRUxMIGlzIG5vdCBz
ZXQKIyBDT05GSUdfUEFUQV9OSU5KQTMyIGlzIG5vdCBzZXQKIyBDT05GSUdfUEFUQV9OUzg3
NDE1IGlzIG5vdCBzZXQKIyBDT05GSUdfUEFUQV9PTERQSUlYIGlzIG5vdCBzZXQKIyBDT05G
SUdfUEFUQV9PUFRJRE1BIGlzIG5vdCBzZXQKIyBDT05GSUdfUEFUQV9QREMyMDI3WCBpcyBu
b3Qgc2V0CiMgQ09ORklHX1BBVEFfUERDX09MRCBpcyBub3Qgc2V0CiMgQ09ORklHX1BBVEFf
UkFESVNZUyBpcyBub3Qgc2V0CiMgQ09ORklHX1BBVEFfUkRDIGlzIG5vdCBzZXQKIyBDT05G
SUdfUEFUQV9TQ0ggaXMgbm90IHNldAojIENPTkZJR19QQVRBX1NFUlZFUldPUktTIGlzIG5v
dCBzZXQKIyBDT05GSUdfUEFUQV9TSUw2ODAgaXMgbm90IHNldAojIENPTkZJR19QQVRBX1NJ
UyBpcyBub3Qgc2V0CiMgQ09ORklHX1BBVEFfVE9TSElCQSBpcyBub3Qgc2V0CiMgQ09ORklH
X1BBVEFfVFJJRkxFWCBpcyBub3Qgc2V0CiMgQ09ORklHX1BBVEFfVklBIGlzIG5vdCBzZXQK
IyBDT05GSUdfUEFUQV9XSU5CT05EIGlzIG5vdCBzZXQKCiMKIyBQSU8tb25seSBTRkYgY29u
dHJvbGxlcnMKIwojIENPTkZJR19QQVRBX0NNRDY0MF9QQ0kgaXMgbm90IHNldAojIENPTkZJ
R19QQVRBX01QSUlYIGlzIG5vdCBzZXQKIyBDT05GSUdfUEFUQV9OUzg3NDEwIGlzIG5vdCBz
ZXQKIyBDT05GSUdfUEFUQV9PUFRJIGlzIG5vdCBzZXQKIyBDT05GSUdfUEFUQV9QTEFURk9S
TSBpcyBub3Qgc2V0CiMgQ09ORklHX1BBVEFfUloxMDAwIGlzIG5vdCBzZXQKCiMKIyBHZW5l
cmljIGZhbGxiYWNrIC8gbGVnYWN5IGRyaXZlcnMKIwojIENPTkZJR19BVEFfR0VORVJJQyBp
cyBub3Qgc2V0CiMgQ09ORklHX1BBVEFfTEVHQUNZIGlzIG5vdCBzZXQKQ09ORklHX01EPXkK
Q09ORklHX0JMS19ERVZfTUQ9eQpDT05GSUdfTURfQVVUT0RFVEVDVD15CkNPTkZJR19NRF9M
SU5FQVI9eQpDT05GSUdfTURfUkFJRDA9eQpDT05GSUdfTURfUkFJRDE9eQpDT05GSUdfTURf
UkFJRDEwPXkKQ09ORklHX01EX1JBSUQ0NTY9eQojIENPTkZJR19NRF9NVUxUSVBBVEggaXMg
bm90IHNldAojIENPTkZJR19NRF9GQVVMVFkgaXMgbm90IHNldAojIENPTkZJR19CQ0FDSEUg
aXMgbm90IHNldApDT05GSUdfQkxLX0RFVl9ETV9CVUlMVElOPXkKQ09ORklHX0JMS19ERVZf
RE09eQojIENPTkZJR19ETV9NUV9ERUZBVUxUIGlzIG5vdCBzZXQKIyBDT05GSUdfRE1fREVC
VUcgaXMgbm90IHNldAojIENPTkZJR19ETV9DUllQVCBpcyBub3Qgc2V0CiMgQ09ORklHX0RN
X1NOQVBTSE9UIGlzIG5vdCBzZXQKIyBDT05GSUdfRE1fVEhJTl9QUk9WSVNJT05JTkcgaXMg
bm90IHNldAojIENPTkZJR19ETV9DQUNIRSBpcyBub3Qgc2V0CiMgQ09ORklHX0RNX0VSQSBp
cyBub3Qgc2V0CiMgQ09ORklHX0RNX01JUlJPUiBpcyBub3Qgc2V0CiMgQ09ORklHX0RNX1JB
SUQgaXMgbm90IHNldAojIENPTkZJR19ETV9aRVJPIGlzIG5vdCBzZXQKIyBDT05GSUdfRE1f
TVVMVElQQVRIIGlzIG5vdCBzZXQKIyBDT05GSUdfRE1fREVMQVkgaXMgbm90IHNldAojIENP
TkZJR19ETV9VRVZFTlQgaXMgbm90IHNldAojIENPTkZJR19ETV9GTEFLRVkgaXMgbm90IHNl
dAojIENPTkZJR19ETV9WRVJJVFkgaXMgbm90IHNldAojIENPTkZJR19ETV9TV0lUQ0ggaXMg
bm90IHNldAojIENPTkZJR19ETV9MT0dfV1JJVEVTIGlzIG5vdCBzZXQKIyBDT05GSUdfVEFS
R0VUX0NPUkUgaXMgbm90IHNldAojIENPTkZJR19GVVNJT04gaXMgbm90IHNldAoKIwojIElF
RUUgMTM5NCAoRmlyZVdpcmUpIHN1cHBvcnQKIwojIENPTkZJR19GSVJFV0lSRSBpcyBub3Qg
c2V0CiMgQ09ORklHX0ZJUkVXSVJFX05PU1kgaXMgbm90IHNldAojIENPTkZJR19NQUNJTlRP
U0hfRFJJVkVSUyBpcyBub3Qgc2V0CkNPTkZJR19ORVRERVZJQ0VTPXkKQ09ORklHX01JST15
CkNPTkZJR19ORVRfQ09SRT15CiMgQ09ORklHX0JPTkRJTkcgaXMgbm90IHNldApDT05GSUdf
RFVNTVk9eQojIENPTkZJR19FUVVBTElaRVIgaXMgbm90IHNldAojIENPTkZJR19ORVRfRkMg
aXMgbm90IHNldAojIENPTkZJR19ORVRfVEVBTSBpcyBub3Qgc2V0CiMgQ09ORklHX01BQ1ZM
QU4gaXMgbm90IHNldAojIENPTkZJR19JUFZMQU4gaXMgbm90IHNldAojIENPTkZJR19WWExB
TiBpcyBub3Qgc2V0CiMgQ09ORklHX05FVENPTlNPTEUgaXMgbm90IHNldAojIENPTkZJR19O
RVRQT0xMIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX1BPTExfQ09OVFJPTExFUiBpcyBub3Qg
c2V0CiMgQ09ORklHX1RVTiBpcyBub3Qgc2V0CiMgQ09ORklHX1ZFVEggaXMgbm90IHNldAoj
IENPTkZJR19OTE1PTiBpcyBub3Qgc2V0CiMgQ09ORklHX0FSQ05FVCBpcyBub3Qgc2V0Cgoj
CiMgQ0FJRiB0cmFuc3BvcnQgZHJpdmVycwojCgojCiMgRGlzdHJpYnV0ZWQgU3dpdGNoIEFy
Y2hpdGVjdHVyZSBkcml2ZXJzCiMKIyBDT05GSUdfTkVUX0RTQV9NVjg4RTZYWFggaXMgbm90
IHNldAojIENPTkZJR19ORVRfRFNBX01WODhFNlhYWF9ORUVEX1BQVSBpcyBub3Qgc2V0CkNP
TkZJR19FVEhFUk5FVD15CiMgQ09ORklHX05FVF9WRU5ET1JfM0NPTSBpcyBub3Qgc2V0CiMg
Q09ORklHX05FVF9WRU5ET1JfQURBUFRFQyBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9WRU5E
T1JfQUdFUkUgaXMgbm90IHNldAojIENPTkZJR19ORVRfVkVORE9SX0FMVEVPTiBpcyBub3Qg
c2V0CiMgQ09ORklHX0FMVEVSQV9UU0UgaXMgbm90IHNldAojIENPTkZJR19ORVRfVkVORE9S
X0FNRCBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9WRU5ET1JfQVJDIGlzIG5vdCBzZXQKIyBD
T05GSUdfTkVUX1ZFTkRPUl9BVEhFUk9TIGlzIG5vdCBzZXQKQ09ORklHX05FVF9DQURFTkNF
PXkKIyBDT05GSUdfTUFDQiBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9WRU5ET1JfQlJPQURD
T00gaXMgbm90IHNldAojIENPTkZJR19ORVRfVkVORE9SX0JST0NBREUgaXMgbm90IHNldAoj
IENPTkZJR19ORVRfVkVORE9SX0NIRUxTSU8gaXMgbm90IHNldAojIENPTkZJR19ORVRfVkVO
RE9SX0NJU0NPIGlzIG5vdCBzZXQKIyBDT05GSUdfRE5FVCBpcyBub3Qgc2V0CiMgQ09ORklH
X05FVF9WRU5ET1JfREVDIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX1ZFTkRPUl9ETElOSyBp
cyBub3Qgc2V0CiMgQ09ORklHX05FVF9WRU5ET1JfRU1VTEVYIGlzIG5vdCBzZXQKIyBDT05G
SUdfTkVUX1ZFTkRPUl9FWEFSIGlzIG5vdCBzZXQKQ09ORklHX05FVF9WRU5ET1JfRlJFRVND
QUxFPXkKQ09ORklHX0ZTX0VORVQ9eQojIENPTkZJR19GU19FTkVUX0hBU19TQ0MgaXMgbm90
IHNldAojIENPTkZJR19GU19FTkVUX0hBU19GQ0MgaXMgbm90IHNldAojIENPTkZJR19GU19F
TkVUX01ESU9fRkNDIGlzIG5vdCBzZXQKQ09ORklHX0ZTTF9QUV9NRElPPXkKIyBDT05GSUdf
RlNMX1hHTUFDX01ESU8gaXMgbm90IHNldAojIENPTkZJR19VQ0NfR0VUSCBpcyBub3Qgc2V0
CkNPTkZJR19HSUFORkFSPXkKCiMKIyBGcmFtZSBNYW5hZ2VyIHN1cHBvcnQKIwojIENPTkZJ
R19ORVRfVkVORE9SX0hQIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX1ZFTkRPUl9JTlRFTCBp
cyBub3Qgc2V0CiMgQ09ORklHX0lQMTAwMCBpcyBub3Qgc2V0CiMgQ09ORklHX0pNRSBpcyBu
b3Qgc2V0CiMgQ09ORklHX05FVF9WRU5ET1JfTUFSVkVMTCBpcyBub3Qgc2V0CiMgQ09ORklH
X05FVF9WRU5ET1JfTUVMTEFOT1ggaXMgbm90IHNldAojIENPTkZJR19ORVRfVkVORE9SX01J
Q1JFTCBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9WRU5ET1JfTVlSSSBpcyBub3Qgc2V0CiMg
Q09ORklHX0ZFQUxOWCBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9WRU5ET1JfTkFUU0VNSSBp
cyBub3Qgc2V0CiMgQ09ORklHX05FVF9WRU5ET1JfTlZJRElBIGlzIG5vdCBzZXQKIyBDT05G
SUdfTkVUX1ZFTkRPUl9PS0kgaXMgbm90IHNldAojIENPTkZJR19FVEhPQyBpcyBub3Qgc2V0
CiMgQ09ORklHX05FVF9QQUNLRVRfRU5HSU5FIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX1ZF
TkRPUl9RTE9HSUMgaXMgbm90IHNldAojIENPTkZJR19ORVRfVkVORE9SX1FVQUxDT01NIGlz
IG5vdCBzZXQKIyBDT05GSUdfTkVUX1ZFTkRPUl9SRUFMVEVLIGlzIG5vdCBzZXQKIyBDT05G
SUdfTkVUX1ZFTkRPUl9SREMgaXMgbm90IHNldApDT05GSUdfTkVUX1ZFTkRPUl9ST0NLRVI9
eQojIENPTkZJR19ORVRfVkVORE9SX1NBTVNVTkcgaXMgbm90IHNldAojIENPTkZJR19ORVRf
VkVORE9SX1NFRVEgaXMgbm90IHNldAojIENPTkZJR19ORVRfVkVORE9SX1NJTEFOIGlzIG5v
dCBzZXQKIyBDT05GSUdfTkVUX1ZFTkRPUl9TSVMgaXMgbm90IHNldAojIENPTkZJR19TRkMg
aXMgbm90IHNldAojIENPTkZJR19ORVRfVkVORE9SX1NNU0MgaXMgbm90IHNldAojIENPTkZJ
R19ORVRfVkVORE9SX1NUTUlDUk8gaXMgbm90IHNldAojIENPTkZJR19ORVRfVkVORE9SX1NV
TiBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9WRU5ET1JfVEVIVVRJIGlzIG5vdCBzZXQKIyBD
T05GSUdfTkVUX1ZFTkRPUl9USSBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9WRU5ET1JfVklB
IGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX1ZFTkRPUl9XSVpORVQgaXMgbm90IHNldAojIENP
TkZJR19ORVRfVkVORE9SX1hJTElOWCBpcyBub3Qgc2V0CiMgQ09ORklHX0ZEREkgaXMgbm90
IHNldAojIENPTkZJR19ISVBQSSBpcyBub3Qgc2V0CkNPTkZJR19QSFlMSUI9eQoKIwojIE1J
SSBQSFkgZGV2aWNlIGRyaXZlcnMKIwojIENPTkZJR19BVDgwM1hfUEhZIGlzIG5vdCBzZXQK
IyBDT05GSUdfQU1EX1BIWSBpcyBub3Qgc2V0CiMgQ09ORklHX01BUlZFTExfUEhZIGlzIG5v
dCBzZXQKIyBDT05GSUdfREFWSUNPTV9QSFkgaXMgbm90IHNldAojIENPTkZJR19RU0VNSV9Q
SFkgaXMgbm90IHNldAojIENPTkZJR19MWFRfUEhZIGlzIG5vdCBzZXQKIyBDT05GSUdfQ0lD
QURBX1BIWSBpcyBub3Qgc2V0CiMgQ09ORklHX1ZJVEVTU0VfUEhZIGlzIG5vdCBzZXQKIyBD
T05GSUdfU01TQ19QSFkgaXMgbm90IHNldAojIENPTkZJR19CUk9BRENPTV9QSFkgaXMgbm90
IHNldAojIENPTkZJR19CQ003WFhYX1BIWSBpcyBub3Qgc2V0CiMgQ09ORklHX0JDTTg3WFhf
UEhZIGlzIG5vdCBzZXQKIyBDT05GSUdfSUNQTFVTX1BIWSBpcyBub3Qgc2V0CiMgQ09ORklH
X1JFQUxURUtfUEhZIGlzIG5vdCBzZXQKIyBDT05GSUdfTkFUSU9OQUxfUEhZIGlzIG5vdCBz
ZXQKIyBDT05GSUdfU1RFMTBYUCBpcyBub3Qgc2V0CiMgQ09ORklHX0xTSV9FVDEwMTFDX1BI
WSBpcyBub3Qgc2V0CiMgQ09ORklHX01JQ1JFTF9QSFkgaXMgbm90IHNldAojIENPTkZJR19G
SVhFRF9QSFkgaXMgbm90IHNldAojIENPTkZJR19NRElPX0JJVEJBTkcgaXMgbm90IHNldAoj
IENPTkZJR19NRElPX0JVU19NVVhfR1BJTyBpcyBub3Qgc2V0CiMgQ09ORklHX01ESU9fQlVT
X01VWF9NTUlPUkVHIGlzIG5vdCBzZXQKIyBDT05GSUdfTURJT19CQ01fVU5JTUFDIGlzIG5v
dCBzZXQKQ09ORklHX1BQUD15CkNPTkZJR19QUFBfQlNEQ09NUD15CkNPTkZJR19QUFBfREVG
TEFURT15CkNPTkZJR19QUFBfRklMVEVSPXkKIyBDT05GSUdfUFBQX01QUEUgaXMgbm90IHNl
dAojIENPTkZJR19QUFBfTVVMVElMSU5LIGlzIG5vdCBzZXQKQ09ORklHX1BQUE9FPXkKQ09O
RklHX1BQUF9BU1lOQz15CiMgQ09ORklHX1BQUF9TWU5DX1RUWSBpcyBub3Qgc2V0CiMgQ09O
RklHX1NMSVAgaXMgbm90IHNldApDT05GSUdfU0xIQz15CkNPTkZJR19VU0JfTkVUX0RSSVZF
UlM9eQojIENPTkZJR19VU0JfQ0FUQyBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9LQVdFVEgg
aXMgbm90IHNldAojIENPTkZJR19VU0JfUEVHQVNVUyBpcyBub3Qgc2V0CiMgQ09ORklHX1VT
Ql9SVEw4MTUwIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1JUTDgxNTIgaXMgbm90IHNldAoj
IENPTkZJR19VU0JfVVNCTkVUIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX0lQSEVUSCBpcyBu
b3Qgc2V0CkNPTkZJR19XTEFOPXkKIyBDT05GSUdfTElCRVJUQVNfVEhJTkZJUk0gaXMgbm90
IHNldAojIENPTkZJR19BSVJPIGlzIG5vdCBzZXQKIyBDT05GSUdfQVRNRUwgaXMgbm90IHNl
dAojIENPTkZJR19BVDc2QzUwWF9VU0IgaXMgbm90IHNldAojIENPTkZJR19QUklTTTU0IGlz
IG5vdCBzZXQKIyBDT05GSUdfVVNCX1pEMTIwMSBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9O
RVRfUk5ESVNfV0xBTiBpcyBub3Qgc2V0CiMgQ09ORklHX1JUTDgxODAgaXMgbm90IHNldApD
T05GSUdfUlRMODE4Nz1tCkNPTkZJR19SVEw4MTg3X0xFRFM9eQojIENPTkZJR19BRE04MjEx
IGlzIG5vdCBzZXQKIyBDT05GSUdfTUFDODAyMTFfSFdTSU0gaXMgbm90IHNldAojIENPTkZJ
R19NV0w4SyBpcyBub3Qgc2V0CiMgQ09ORklHX0FUSF9DQVJEUyBpcyBub3Qgc2V0CkNPTkZJ
R19CNDM9bQpDT05GSUdfQjQzX0JDTUE9eQpDT05GSUdfQjQzX1NTQj15CkNPTkZJR19CNDNf
QlVTRVNfQkNNQV9BTkRfU1NCPXkKIyBDT05GSUdfQjQzX0JVU0VTX0JDTUEgaXMgbm90IHNl
dAojIENPTkZJR19CNDNfQlVTRVNfU1NCIGlzIG5vdCBzZXQKQ09ORklHX0I0M19QQ0lfQVVU
T1NFTEVDVD15CkNPTkZJR19CNDNfUENJQ09SRV9BVVRPU0VMRUNUPXkKIyBDT05GSUdfQjQz
X1NESU8gaXMgbm90IHNldApDT05GSUdfQjQzX0JDTUFfUElPPXkKQ09ORklHX0I0M19QSU89
eQojIENPTkZJR19CNDNfUEhZX0cgaXMgbm90IHNldAojIENPTkZJR19CNDNfUEhZX04gaXMg
bm90IHNldAojIENPTkZJR19CNDNfUEhZX0xQIGlzIG5vdCBzZXQKIyBDT05GSUdfQjQzX1BI
WV9IVCBpcyBub3Qgc2V0CkNPTkZJR19CNDNfTEVEUz15CkNPTkZJR19CNDNfSFdSTkc9eQoj
IENPTkZJR19CNDNfREVCVUcgaXMgbm90IHNldAojIENPTkZJR19CNDNMRUdBQ1kgaXMgbm90
IHNldAojIENPTkZJR19CUkNNU01BQyBpcyBub3Qgc2V0CiMgQ09ORklHX0JSQ01GTUFDIGlz
IG5vdCBzZXQKIyBDT05GSUdfSE9TVEFQIGlzIG5vdCBzZXQKIyBDT05GSUdfSVBXMjEwMCBp
cyBub3Qgc2V0CiMgQ09ORklHX0lQVzIyMDAgaXMgbm90IHNldAojIENPTkZJR19JV0xXSUZJ
IGlzIG5vdCBzZXQKIyBDT05GSUdfSVdMNDk2NSBpcyBub3Qgc2V0CiMgQ09ORklHX0lXTDM5
NDUgaXMgbm90IHNldAojIENPTkZJR19MSUJFUlRBUyBpcyBub3Qgc2V0CiMgQ09ORklHX0hF
Uk1FUyBpcyBub3Qgc2V0CiMgQ09ORklHX1A1NF9DT01NT04gaXMgbm90IHNldAojIENPTkZJ
R19SVDJYMDAgaXMgbm90IHNldApDT05GSUdfUlRMX0NBUkRTPW0KIyBDT05GSUdfUlRMODE5
MkNFIGlzIG5vdCBzZXQKIyBDT05GSUdfUlRMODE5MlNFIGlzIG5vdCBzZXQKIyBDT05GSUdf
UlRMODE5MkRFIGlzIG5vdCBzZXQKIyBDT05GSUdfUlRMODcyM0FFIGlzIG5vdCBzZXQKIyBD
T05GSUdfUlRMODcyM0JFIGlzIG5vdCBzZXQKIyBDT05GSUdfUlRMODE4OEVFIGlzIG5vdCBz
ZXQKIyBDT05GSUdfUlRMODE5MkVFIGlzIG5vdCBzZXQKIyBDT05GSUdfUlRMODgyMUFFIGlz
IG5vdCBzZXQKIyBDT05GSUdfUlRMODE5MkNVIGlzIG5vdCBzZXQKIyBDT05GSUdfV0xfVEkg
aXMgbm90IHNldAojIENPTkZJR19aRDEyMTFSVyBpcyBub3Qgc2V0CiMgQ09ORklHX01XSUZJ
RVggaXMgbm90IHNldAojIENPTkZJR19DVzEyMDAgaXMgbm90IHNldAojIENPTkZJR19SU0lf
OTFYIGlzIG5vdCBzZXQKCiMKIyBFbmFibGUgV2lNQVggKE5ldHdvcmtpbmcgb3B0aW9ucykg
dG8gc2VlIHRoZSBXaU1BWCBkcml2ZXJzCiMKIyBDT05GSUdfV0FOIGlzIG5vdCBzZXQKIyBD
T05GSUdfVk1YTkVUMyBpcyBub3Qgc2V0CiMgQ09ORklHX0lTRE4gaXMgbm90IHNldAoKIwoj
IElucHV0IGRldmljZSBzdXBwb3J0CiMKQ09ORklHX0lOUFVUPXkKQ09ORklHX0lOUFVUX0ZG
X01FTUxFU1M9eQojIENPTkZJR19JTlBVVF9QT0xMREVWIGlzIG5vdCBzZXQKIyBDT05GSUdf
SU5QVVRfU1BBUlNFS01BUCBpcyBub3Qgc2V0CiMgQ09ORklHX0lOUFVUX01BVFJJWEtNQVAg
aXMgbm90IHNldAoKIwojIFVzZXJsYW5kIGludGVyZmFjZXMKIwpDT05GSUdfSU5QVVRfTU9V
U0VERVY9eQpDT05GSUdfSU5QVVRfTU9VU0VERVZfUFNBVVg9eQpDT05GSUdfSU5QVVRfTU9V
U0VERVZfU0NSRUVOX1g9MTAyNApDT05GSUdfSU5QVVRfTU9VU0VERVZfU0NSRUVOX1k9NzY4
CkNPTkZJR19JTlBVVF9KT1lERVY9eQpDT05GSUdfSU5QVVRfRVZERVY9eQojIENPTkZJR19J
TlBVVF9FVkJVRyBpcyBub3Qgc2V0CgojCiMgSW5wdXQgRGV2aWNlIERyaXZlcnMKIwpDT05G
SUdfSU5QVVRfS0VZQk9BUkQ9eQojIENPTkZJR19LRVlCT0FSRF9BRFA1NTg4IGlzIG5vdCBz
ZXQKIyBDT05GSUdfS0VZQk9BUkRfQURQNTU4OSBpcyBub3Qgc2V0CiMgQ09ORklHX0tFWUJP
QVJEX0FUS0JEIGlzIG5vdCBzZXQKIyBDT05GSUdfS0VZQk9BUkRfUVQxMDcwIGlzIG5vdCBz
ZXQKIyBDT05GSUdfS0VZQk9BUkRfUVQyMTYwIGlzIG5vdCBzZXQKIyBDT05GSUdfS0VZQk9B
UkRfTEtLQkQgaXMgbm90IHNldAojIENPTkZJR19LRVlCT0FSRF9HUElPIGlzIG5vdCBzZXQK
IyBDT05GSUdfS0VZQk9BUkRfR1BJT19QT0xMRUQgaXMgbm90IHNldAojIENPTkZJR19LRVlC
T0FSRF9UQ0E2NDE2IGlzIG5vdCBzZXQKIyBDT05GSUdfS0VZQk9BUkRfVENBODQxOCBpcyBu
b3Qgc2V0CiMgQ09ORklHX0tFWUJPQVJEX01BVFJJWCBpcyBub3Qgc2V0CiMgQ09ORklHX0tF
WUJPQVJEX0xNODMyMyBpcyBub3Qgc2V0CiMgQ09ORklHX0tFWUJPQVJEX0xNODMzMyBpcyBu
b3Qgc2V0CiMgQ09ORklHX0tFWUJPQVJEX01BWDczNTkgaXMgbm90IHNldAojIENPTkZJR19L
RVlCT0FSRF9NQ1MgaXMgbm90IHNldAojIENPTkZJR19LRVlCT0FSRF9NUFIxMjEgaXMgbm90
IHNldAojIENPTkZJR19LRVlCT0FSRF9ORVdUT04gaXMgbm90IHNldAojIENPTkZJR19LRVlC
T0FSRF9PUEVOQ09SRVMgaXMgbm90IHNldAojIENPTkZJR19LRVlCT0FSRF9TVE9XQVdBWSBp
cyBub3Qgc2V0CiMgQ09ORklHX0tFWUJPQVJEX1NVTktCRCBpcyBub3Qgc2V0CiMgQ09ORklH
X0tFWUJPQVJEX09NQVA0IGlzIG5vdCBzZXQKIyBDT05GSUdfS0VZQk9BUkRfWFRLQkQgaXMg
bm90IHNldAojIENPTkZJR19LRVlCT0FSRF9DQVAxMVhYIGlzIG5vdCBzZXQKQ09ORklHX0lO
UFVUX01PVVNFPXkKIyBDT05GSUdfTU9VU0VfUFMyIGlzIG5vdCBzZXQKIyBDT05GSUdfTU9V
U0VfU0VSSUFMIGlzIG5vdCBzZXQKIyBDT05GSUdfTU9VU0VfQVBQTEVUT1VDSCBpcyBub3Qg
c2V0CiMgQ09ORklHX01PVVNFX0JDTTU5NzQgaXMgbm90IHNldAojIENPTkZJR19NT1VTRV9D
WUFQQSBpcyBub3Qgc2V0CiMgQ09ORklHX01PVVNFX0VMQU5fSTJDIGlzIG5vdCBzZXQKIyBD
T05GSUdfTU9VU0VfVlNYWFhBQSBpcyBub3Qgc2V0CiMgQ09ORklHX01PVVNFX0dQSU8gaXMg
bm90IHNldAojIENPTkZJR19NT1VTRV9TWU5BUFRJQ1NfSTJDIGlzIG5vdCBzZXQKIyBDT05G
SUdfTU9VU0VfU1lOQVBUSUNTX1VTQiBpcyBub3Qgc2V0CkNPTkZJR19JTlBVVF9KT1lTVElD
Sz15CkNPTkZJR19KT1lTVElDS19BTkFMT0c9eQpDT05GSUdfSk9ZU1RJQ0tfQTNEPXkKQ09O
RklHX0pPWVNUSUNLX0FEST15CkNPTkZJR19KT1lTVElDS19DT0JSQT15CkNPTkZJR19KT1lT
VElDS19HRjJLPXkKQ09ORklHX0pPWVNUSUNLX0dSSVA9eQpDT05GSUdfSk9ZU1RJQ0tfR1JJ
UF9NUD15CkNPTkZJR19KT1lTVElDS19HVUlMTEVNT1Q9eQpDT05GSUdfSk9ZU1RJQ0tfSU5U
RVJBQ1Q9eQpDT05GSUdfSk9ZU1RJQ0tfU0lERVdJTkRFUj15CkNPTkZJR19KT1lTVElDS19U
TURDPXkKQ09ORklHX0pPWVNUSUNLX0lGT1JDRT15CkNPTkZJR19KT1lTVElDS19JRk9SQ0Vf
VVNCPXkKQ09ORklHX0pPWVNUSUNLX0lGT1JDRV8yMzI9eQpDT05GSUdfSk9ZU1RJQ0tfV0FS
UklPUj15CkNPTkZJR19KT1lTVElDS19NQUdFTExBTj15CkNPTkZJR19KT1lTVElDS19TUEFD
RU9SQj15CkNPTkZJR19KT1lTVElDS19TUEFDRUJBTEw9eQpDT05GSUdfSk9ZU1RJQ0tfU1RJ
TkdFUj15CkNPTkZJR19KT1lTVElDS19UV0lESk9ZPXkKIyBDT05GSUdfSk9ZU1RJQ0tfWkhF
TkhVQSBpcyBub3Qgc2V0CkNPTkZJR19KT1lTVElDS19BUzUwMTE9eQpDT05GSUdfSk9ZU1RJ
Q0tfSk9ZRFVNUD15CkNPTkZJR19KT1lTVElDS19YUEFEPXkKQ09ORklHX0pPWVNUSUNLX1hQ
QURfRkY9eQojIENPTkZJR19KT1lTVElDS19YUEFEX0xFRFMgaXMgbm90IHNldApDT05GSUdf
SU5QVVRfVEFCTEVUPXkKQ09ORklHX1RBQkxFVF9VU0JfQUNFQ0FEPW0KQ09ORklHX1RBQkxF
VF9VU0JfQUlQVEVLPW0KQ09ORklHX1RBQkxFVF9VU0JfR1RDTz1tCkNPTkZJR19UQUJMRVRf
VVNCX0hBTldBTkc9bQpDT05GSUdfVEFCTEVUX1VTQl9LQlRBQj1tCkNPTkZJR19UQUJMRVRf
U0VSSUFMX1dBQ09NND1tCkNPTkZJR19JTlBVVF9UT1VDSFNDUkVFTj15CkNPTkZJR19PRl9U
T1VDSFNDUkVFTj15CiMgQ09ORklHX1RPVUNIU0NSRUVOX0FENzg3OSBpcyBub3Qgc2V0CiMg
Q09ORklHX1RPVUNIU0NSRUVOX0FSMTAyMV9JMkMgaXMgbm90IHNldAojIENPTkZJR19UT1VD
SFNDUkVFTl9BVE1FTF9NWFQgaXMgbm90IHNldAojIENPTkZJR19UT1VDSFNDUkVFTl9BVU9f
UElYQ0lSIGlzIG5vdCBzZXQKIyBDT05GSUdfVE9VQ0hTQ1JFRU5fQlUyMTAxMyBpcyBub3Qg
c2V0CiMgQ09ORklHX1RPVUNIU0NSRUVOX0NISVBPTkVfSUNOODMxOCBpcyBub3Qgc2V0CiMg
Q09ORklHX1RPVUNIU0NSRUVOX0NZOENUTUcxMTAgaXMgbm90IHNldAojIENPTkZJR19UT1VD
SFNDUkVFTl9DWVRUU1BfQ09SRSBpcyBub3Qgc2V0CiMgQ09ORklHX1RPVUNIU0NSRUVOX0NZ
VFRTUDRfQ09SRSBpcyBub3Qgc2V0CiMgQ09ORklHX1RPVUNIU0NSRUVOX0RZTkFQUk8gaXMg
bm90IHNldAojIENPTkZJR19UT1VDSFNDUkVFTl9IQU1QU0hJUkUgaXMgbm90IHNldAojIENP
TkZJR19UT1VDSFNDUkVFTl9FRVRJIGlzIG5vdCBzZXQKIyBDT05GSUdfVE9VQ0hTQ1JFRU5f
RUdBTEFYIGlzIG5vdCBzZXQKIyBDT05GSUdfVE9VQ0hTQ1JFRU5fRlVKSVRTVSBpcyBub3Qg
c2V0CiMgQ09ORklHX1RPVUNIU0NSRUVOX0dPT0RJWCBpcyBub3Qgc2V0CiMgQ09ORklHX1RP
VUNIU0NSRUVOX0lMSTIxMFggaXMgbm90IHNldAojIENPTkZJR19UT1VDSFNDUkVFTl9HVU5a
RSBpcyBub3Qgc2V0CiMgQ09ORklHX1RPVUNIU0NSRUVOX0VMQU4gaXMgbm90IHNldAojIENP
TkZJR19UT1VDSFNDUkVFTl9FTE8gaXMgbm90IHNldAojIENPTkZJR19UT1VDSFNDUkVFTl9X
QUNPTV9XODAwMSBpcyBub3Qgc2V0CiMgQ09ORklHX1RPVUNIU0NSRUVOX1dBQ09NX0kyQyBp
cyBub3Qgc2V0CiMgQ09ORklHX1RPVUNIU0NSRUVOX01BWDExODAxIGlzIG5vdCBzZXQKIyBD
T05GSUdfVE9VQ0hTQ1JFRU5fTUNTNTAwMCBpcyBub3Qgc2V0CiMgQ09ORklHX1RPVUNIU0NS
RUVOX01NUzExNCBpcyBub3Qgc2V0CiMgQ09ORklHX1RPVUNIU0NSRUVOX01UT1VDSCBpcyBu
b3Qgc2V0CiMgQ09ORklHX1RPVUNIU0NSRUVOX0lORVhJTyBpcyBub3Qgc2V0CiMgQ09ORklH
X1RPVUNIU0NSRUVOX01LNzEyIGlzIG5vdCBzZXQKIyBDT05GSUdfVE9VQ0hTQ1JFRU5fUEVO
TU9VTlQgaXMgbm90IHNldAojIENPTkZJR19UT1VDSFNDUkVFTl9FRFRfRlQ1WDA2IGlzIG5v
dCBzZXQKIyBDT05GSUdfVE9VQ0hTQ1JFRU5fVE9VQ0hSSUdIVCBpcyBub3Qgc2V0CiMgQ09O
RklHX1RPVUNIU0NSRUVOX1RPVUNIV0lOIGlzIG5vdCBzZXQKIyBDT05GSUdfVE9VQ0hTQ1JF
RU5fUElYQ0lSIGlzIG5vdCBzZXQKIyBDT05GSUdfVE9VQ0hTQ1JFRU5fVVNCX0NPTVBPU0lU
RSBpcyBub3Qgc2V0CiMgQ09ORklHX1RPVUNIU0NSRUVOX1RPVUNISVQyMTMgaXMgbm90IHNl
dAojIENPTkZJR19UT1VDSFNDUkVFTl9UU0NfU0VSSU8gaXMgbm90IHNldAojIENPTkZJR19U
T1VDSFNDUkVFTl9UU0MyMDA3IGlzIG5vdCBzZXQKIyBDT05GSUdfVE9VQ0hTQ1JFRU5fU1Qx
MjMyIGlzIG5vdCBzZXQKIyBDT05GSUdfVE9VQ0hTQ1JFRU5fU1VSNDAgaXMgbm90IHNldAoj
IENPTkZJR19UT1VDSFNDUkVFTl9TWDg2NTQgaXMgbm90IHNldAojIENPTkZJR19UT1VDSFND
UkVFTl9UUFM2NTA3WCBpcyBub3Qgc2V0CiMgQ09ORklHX1RPVUNIU0NSRUVOX1pGT1JDRSBp
cyBub3Qgc2V0CkNPTkZJR19JTlBVVF9NSVNDPXkKIyBDT05GSUdfSU5QVVRfQUQ3MTRYIGlz
IG5vdCBzZXQKIyBDT05GSUdfSU5QVVRfQk1BMTUwIGlzIG5vdCBzZXQKIyBDT05GSUdfSU5Q
VVRfRTNYMF9CVVRUT04gaXMgbm90IHNldAojIENPTkZJR19JTlBVVF9NTUE4NDUwIGlzIG5v
dCBzZXQKIyBDT05GSUdfSU5QVVRfTVBVMzA1MCBpcyBub3Qgc2V0CiMgQ09ORklHX0lOUFVU
X0dQMkEgaXMgbm90IHNldAojIENPTkZJR19JTlBVVF9HUElPX0JFRVBFUiBpcyBub3Qgc2V0
CiMgQ09ORklHX0lOUFVUX0dQSU9fVElMVF9QT0xMRUQgaXMgbm90IHNldAojIENPTkZJR19J
TlBVVF9BVElfUkVNT1RFMiBpcyBub3Qgc2V0CiMgQ09ORklHX0lOUFVUX0tFWVNQQU5fUkVN
T1RFIGlzIG5vdCBzZXQKIyBDT05GSUdfSU5QVVRfS1hUSjkgaXMgbm90IHNldAojIENPTkZJ
R19JTlBVVF9QT1dFUk1BVEUgaXMgbm90IHNldAojIENPTkZJR19JTlBVVF9ZRUFMSU5LIGlz
IG5vdCBzZXQKIyBDT05GSUdfSU5QVVRfQ00xMDkgaXMgbm90IHNldAojIENPTkZJR19JTlBV
VF9VSU5QVVQgaXMgbm90IHNldAojIENPTkZJR19JTlBVVF9QQ0Y4NTc0IGlzIG5vdCBzZXQK
IyBDT05GSUdfSU5QVVRfR1BJT19ST1RBUllfRU5DT0RFUiBpcyBub3Qgc2V0CiMgQ09ORklH
X0lOUFVUX0FEWEwzNFggaXMgbm90IHNldAojIENPTkZJR19JTlBVVF9JTVNfUENVIGlzIG5v
dCBzZXQKIyBDT05GSUdfSU5QVVRfQ01BMzAwMCBpcyBub3Qgc2V0CiMgQ09ORklHX0lOUFVU
X0RSVjI2MFhfSEFQVElDUyBpcyBub3Qgc2V0CiMgQ09ORklHX0lOUFVUX0RSVjI2NjdfSEFQ
VElDUyBpcyBub3Qgc2V0CgojCiMgSGFyZHdhcmUgSS9PIHBvcnRzCiMKQ09ORklHX1NFUklP
PXkKQ09ORklHX0FSQ0hfTUlHSFRfSEFWRV9QQ19TRVJJTz15CiMgQ09ORklHX1NFUklPX0k4
MDQyIGlzIG5vdCBzZXQKQ09ORklHX1NFUklPX1NFUlBPUlQ9eQojIENPTkZJR19TRVJJT19Q
Q0lQUzIgaXMgbm90IHNldApDT05GSUdfU0VSSU9fTElCUFMyPXkKIyBDT05GSUdfU0VSSU9f
UkFXIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VSSU9fWElMSU5YX1hQU19QUzIgaXMgbm90IHNl
dAojIENPTkZJR19TRVJJT19BTFRFUkFfUFMyIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VSSU9f
UFMyTVVMVCBpcyBub3Qgc2V0CiMgQ09ORklHX1NFUklPX0FSQ19QUzIgaXMgbm90IHNldAoj
IENPTkZJR19TRVJJT19BUEJQUzIgaXMgbm90IHNldApDT05GSUdfR0FNRVBPUlQ9eQojIENP
TkZJR19HQU1FUE9SVF9OUzU1OCBpcyBub3Qgc2V0CiMgQ09ORklHX0dBTUVQT1JUX0w0IGlz
IG5vdCBzZXQKIyBDT05GSUdfR0FNRVBPUlRfRU1VMTBLMSBpcyBub3Qgc2V0CiMgQ09ORklH
X0dBTUVQT1JUX0ZNODAxIGlzIG5vdCBzZXQKCiMKIyBDaGFyYWN0ZXIgZGV2aWNlcwojCkNP
TkZJR19UVFk9eQpDT05GSUdfVlQ9eQpDT05GSUdfQ09OU09MRV9UUkFOU0xBVElPTlM9eQpD
T05GSUdfVlRfQ09OU09MRT15CkNPTkZJR19IV19DT05TT0xFPXkKQ09ORklHX1ZUX0hXX0NP
TlNPTEVfQklORElORz15CkNPTkZJR19VTklYOThfUFRZUz15CkNPTkZJR19ERVZQVFNfTVVM
VElQTEVfSU5TVEFOQ0VTPXkKQ09ORklHX0xFR0FDWV9QVFlTPXkKQ09ORklHX0xFR0FDWV9Q
VFlfQ09VTlQ9MjU2CiMgQ09ORklHX1NFUklBTF9OT05TVEFOREFSRCBpcyBub3Qgc2V0CiMg
Q09ORklHX05PWk9NSSBpcyBub3Qgc2V0CiMgQ09ORklHX05fR1NNIGlzIG5vdCBzZXQKIyBD
T05GSUdfVFJBQ0VfU0lOSyBpcyBub3Qgc2V0CiMgQ09ORklHX1BQQ19FUEFQUl9IVl9CWVRF
Q0hBTiBpcyBub3Qgc2V0CkNPTkZJR19ERVZNRU09eQpDT05GSUdfREVWS01FTT15CgojCiMg
U2VyaWFsIGRyaXZlcnMKIwpDT05GSUdfU0VSSUFMX0VBUkxZQ09OPXkKQ09ORklHX1NFUklB
TF84MjUwPXkKQ09ORklHX1NFUklBTF84MjUwX0RFUFJFQ0FURURfT1BUSU9OUz15CkNPTkZJ
R19TRVJJQUxfODI1MF9DT05TT0xFPXkKQ09ORklHX1NFUklBTF84MjUwX0RNQT15CkNPTkZJ
R19TRVJJQUxfODI1MF9QQ0k9eQpDT05GSUdfU0VSSUFMXzgyNTBfTlJfVUFSVFM9MgpDT05G
SUdfU0VSSUFMXzgyNTBfUlVOVElNRV9VQVJUUz0yCkNPTkZJR19TRVJJQUxfODI1MF9FWFRF
TkRFRD15CiMgQ09ORklHX1NFUklBTF84MjUwX01BTllfUE9SVFMgaXMgbm90IHNldApDT05G
SUdfU0VSSUFMXzgyNTBfU0hBUkVfSVJRPXkKIyBDT05GSUdfU0VSSUFMXzgyNTBfREVURUNU
X0lSUSBpcyBub3Qgc2V0CiMgQ09ORklHX1NFUklBTF84MjUwX1JTQSBpcyBub3Qgc2V0CkNP
TkZJR19TRVJJQUxfODI1MF9GU0w9eQojIENPTkZJR19TRVJJQUxfODI1MF9EVyBpcyBub3Qg
c2V0CgojCiMgTm9uLTgyNTAgc2VyaWFsIHBvcnQgc3VwcG9ydAojCiMgQ09ORklHX1NFUklB
TF9VQVJUTElURSBpcyBub3Qgc2V0CkNPTkZJR19TRVJJQUxfQ09SRT15CkNPTkZJR19TRVJJ
QUxfQ09SRV9DT05TT0xFPXkKIyBDT05GSUdfU0VSSUFMX0NQTSBpcyBub3Qgc2V0CiMgQ09O
RklHX1NFUklBTF9KU00gaXMgbm90IHNldAojIENPTkZJR19TRVJJQUxfT0ZfUExBVEZPUk0g
aXMgbm90IHNldApDT05GSUdfU0VSSUFMX1FFPXkKIyBDT05GSUdfU0VSSUFMX1NDQ05YUCBp
cyBub3Qgc2V0CiMgQ09ORklHX1NFUklBTF9TQzE2SVM3WFggaXMgbm90IHNldAojIENPTkZJ
R19TRVJJQUxfQUxURVJBX0pUQUdVQVJUIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VSSUFMX0FM
VEVSQV9VQVJUIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VSSUFMX1hJTElOWF9QU19VQVJUIGlz
IG5vdCBzZXQKIyBDT05GSUdfU0VSSUFMX0FSQyBpcyBub3Qgc2V0CiMgQ09ORklHX1NFUklB
TF9SUDIgaXMgbm90IHNldAojIENPTkZJR19TRVJJQUxfRlNMX0xQVUFSVCBpcyBub3Qgc2V0
CiMgQ09ORklHX1NFUklBTF9DT05FWEFOVF9ESUdJQ09MT1IgaXMgbm90IHNldAojIENPTkZJ
R19UVFlfUFJJTlRLIGlzIG5vdCBzZXQKIyBDT05GSUdfSFZDX1VEQkcgaXMgbm90IHNldAoj
IENPTkZJR19JUE1JX0hBTkRMRVIgaXMgbm90IHNldApDT05GSUdfSFdfUkFORE9NPXkKIyBD
T05GSUdfSFdfUkFORE9NX1RJTUVSSU9NRU0gaXMgbm90IHNldApDT05GSUdfTlZSQU09eQoj
IENPTkZJR19SMzk2NCBpcyBub3Qgc2V0CiMgQ09ORklHX0FQUExJQ09NIGlzIG5vdCBzZXQK
Q09ORklHX1JBV19EUklWRVI9eQpDT05GSUdfTUFYX1JBV19ERVZTPTI1NgojIENPTkZJR19U
Q0dfVFBNIGlzIG5vdCBzZXQKQ09ORklHX0RFVlBPUlQ9eQojIENPTkZJR19YSUxMWUJVUyBp
cyBub3Qgc2V0CgojCiMgSTJDIHN1cHBvcnQKIwpDT05GSUdfSTJDPXkKQ09ORklHX0kyQ19C
T0FSRElORk89eQpDT05GSUdfSTJDX0NPTVBBVD15CkNPTkZJR19JMkNfQ0hBUkRFVj15CkNP
TkZJR19JMkNfTVVYPW0KCiMKIyBNdWx0aXBsZXhlciBJMkMgQ2hpcCBzdXBwb3J0CiMKIyBD
T05GSUdfSTJDX0FSQl9HUElPX0NIQUxMRU5HRSBpcyBub3Qgc2V0CiMgQ09ORklHX0kyQ19N
VVhfR1BJTyBpcyBub3Qgc2V0CiMgQ09ORklHX0kyQ19NVVhfUENBOTU0MSBpcyBub3Qgc2V0
CiMgQ09ORklHX0kyQ19NVVhfUENBOTU0eCBpcyBub3Qgc2V0CkNPTkZJR19JMkNfSEVMUEVS
X0FVVE89eQpDT05GSUdfSTJDX0FMR09CSVQ9eQoKIwojIEkyQyBIYXJkd2FyZSBCdXMgc3Vw
cG9ydAojCgojCiMgUEMgU01CdXMgaG9zdCBjb250cm9sbGVyIGRyaXZlcnMKIwojIENPTkZJ
R19JMkNfQUxJMTUzNSBpcyBub3Qgc2V0CiMgQ09ORklHX0kyQ19BTEkxNTYzIGlzIG5vdCBz
ZXQKIyBDT05GSUdfSTJDX0FMSTE1WDMgaXMgbm90IHNldAojIENPTkZJR19JMkNfQU1ENzU2
IGlzIG5vdCBzZXQKIyBDT05GSUdfSTJDX0FNRDgxMTEgaXMgbm90IHNldAojIENPTkZJR19J
MkNfSTgwMSBpcyBub3Qgc2V0CiMgQ09ORklHX0kyQ19JU0NIIGlzIG5vdCBzZXQKIyBDT05G
SUdfSTJDX1BJSVg0IGlzIG5vdCBzZXQKIyBDT05GSUdfSTJDX05GT1JDRTIgaXMgbm90IHNl
dAojIENPTkZJR19JMkNfU0lTNTU5NSBpcyBub3Qgc2V0CiMgQ09ORklHX0kyQ19TSVM2MzAg
aXMgbm90IHNldAojIENPTkZJR19JMkNfU0lTOTZYIGlzIG5vdCBzZXQKIyBDT05GSUdfSTJD
X1ZJQSBpcyBub3Qgc2V0CiMgQ09ORklHX0kyQ19WSUFQUk8gaXMgbm90IHNldAoKIwojIEky
QyBzeXN0ZW0gYnVzIGRyaXZlcnMgKG1vc3RseSBlbWJlZGRlZCAvIHN5c3RlbS1vbi1jaGlw
KQojCiMgQ09ORklHX0kyQ19DQlVTX0dQSU8gaXMgbm90IHNldApDT05GSUdfSTJDX0NQTT15
CiMgQ09ORklHX0kyQ19ERVNJR05XQVJFX1BMQVRGT1JNIGlzIG5vdCBzZXQKIyBDT05GSUdf
STJDX0RFU0lHTldBUkVfUENJIGlzIG5vdCBzZXQKIyBDT05GSUdfSTJDX0dQSU8gaXMgbm90
IHNldApDT05GSUdfSTJDX01QQz15CiMgQ09ORklHX0kyQ19PQ09SRVMgaXMgbm90IHNldAoj
IENPTkZJR19JMkNfUENBX1BMQVRGT1JNIGlzIG5vdCBzZXQKIyBDT05GSUdfSTJDX1BYQV9Q
Q0kgaXMgbm90IHNldAojIENPTkZJR19JMkNfU0lNVEVDIGlzIG5vdCBzZXQKIyBDT05GSUdf
STJDX1hJTElOWCBpcyBub3Qgc2V0CgojCiMgRXh0ZXJuYWwgSTJDL1NNQnVzIGFkYXB0ZXIg
ZHJpdmVycwojCiMgQ09ORklHX0kyQ19ESU9MQU5fVTJDIGlzIG5vdCBzZXQKIyBDT05GSUdf
STJDX1BBUlBPUlRfTElHSFQgaXMgbm90IHNldAojIENPTkZJR19JMkNfUk9CT1RGVVpaX09T
SUYgaXMgbm90IHNldAojIENPTkZJR19JMkNfVEFPU19FVk0gaXMgbm90IHNldAojIENPTkZJ
R19JMkNfVElOWV9VU0IgaXMgbm90IHNldAoKIwojIE90aGVyIEkyQy9TTUJ1cyBidXMgZHJp
dmVycwojCiMgQ09ORklHX0kyQ19TVFVCIGlzIG5vdCBzZXQKIyBDT05GSUdfSTJDX1NMQVZF
IGlzIG5vdCBzZXQKIyBDT05GSUdfSTJDX0RFQlVHX0NPUkUgaXMgbm90IHNldAojIENPTkZJ
R19JMkNfREVCVUdfQUxHTyBpcyBub3Qgc2V0CiMgQ09ORklHX0kyQ19ERUJVR19CVVMgaXMg
bm90IHNldAojIENPTkZJR19TUEkgaXMgbm90IHNldAojIENPTkZJR19TUE1JIGlzIG5vdCBz
ZXQKIyBDT05GSUdfSFNJIGlzIG5vdCBzZXQKCiMKIyBQUFMgc3VwcG9ydAojCkNPTkZJR19Q
UFM9eQojIENPTkZJR19QUFNfREVCVUcgaXMgbm90IHNldAoKIwojIFBQUyBjbGllbnRzIHN1
cHBvcnQKIwojIENPTkZJR19QUFNfQ0xJRU5UX0tUSU1FUiBpcyBub3Qgc2V0CiMgQ09ORklH
X1BQU19DTElFTlRfTERJU0MgaXMgbm90IHNldAojIENPTkZJR19QUFNfQ0xJRU5UX0dQSU8g
aXMgbm90IHNldAoKIwojIFBQUyBnZW5lcmF0b3JzIHN1cHBvcnQKIwoKIwojIFBUUCBjbG9j
ayBzdXBwb3J0CiMKQ09ORklHX1BUUF8xNTg4X0NMT0NLPXkKQ09ORklHX1BUUF8xNTg4X0NM
T0NLX0dJQU5GQVI9eQoKIwojIEVuYWJsZSBQSFlMSUIgYW5kIE5FVFdPUktfUEhZX1RJTUVT
VEFNUElORyB0byBzZWUgdGhlIGFkZGl0aW9uYWwgY2xvY2tzLgojCkNPTkZJR19BUkNIX1dB
TlRfT1BUSU9OQUxfR1BJT0xJQj15CkNPTkZJR19BUkNIX1JFUVVJUkVfR1BJT0xJQj15CkNP
TkZJR19HUElPTElCPXkKQ09ORklHX0dQSU9fREVWUkVTPXkKQ09ORklHX09GX0dQSU89eQoj
IENPTkZJR19ERUJVR19HUElPIGlzIG5vdCBzZXQKIyBDT05GSUdfR1BJT19TWVNGUyBpcyBu
b3Qgc2V0CgojCiMgTWVtb3J5IG1hcHBlZCBHUElPIGRyaXZlcnMKIwojIENPTkZJR19HUElP
Xzc0WFhfTU1JTyBpcyBub3Qgc2V0CiMgQ09ORklHX0dQSU9fQUxURVJBIGlzIG5vdCBzZXQK
IyBDT05GSUdfR1BJT19EV0FQQiBpcyBub3Qgc2V0CiMgQ09ORklHX0dQSU9fR0VORVJJQ19Q
TEFURk9STSBpcyBub3Qgc2V0CiMgQ09ORklHX0dQSU9fR1JHUElPIGlzIG5vdCBzZXQKQ09O
RklHX0dQSU9fTVBDOFhYWD15CiMgQ09ORklHX0dQSU9fU0NIMzExWCBpcyBub3Qgc2V0CiMg
Q09ORklHX0dQSU9fVlg4NTUgaXMgbm90IHNldAojIENPTkZJR19HUElPX1hJTElOWCBpcyBu
b3Qgc2V0CgojCiMgSTJDIEdQSU8gZXhwYW5kZXJzCiMKIyBDT05GSUdfR1BJT19BRFA1NTg4
IGlzIG5vdCBzZXQKIyBDT05GSUdfR1BJT19BRE5QIGlzIG5vdCBzZXQKIyBDT05GSUdfR1BJ
T19NQVg3MzAwIGlzIG5vdCBzZXQKIyBDT05GSUdfR1BJT19NQVg3MzJYIGlzIG5vdCBzZXQK
IyBDT05GSUdfR1BJT19QQ0E5NTNYIGlzIG5vdCBzZXQKIyBDT05GSUdfR1BJT19QQ0Y4NTdY
IGlzIG5vdCBzZXQKIyBDT05GSUdfR1BJT19TWDE1MFggaXMgbm90IHNldAoKIwojIE1GRCBH
UElPIGV4cGFuZGVycwojCgojCiMgUENJIEdQSU8gZXhwYW5kZXJzCiMKIyBDT05GSUdfR1BJ
T19BTUQ4MTExIGlzIG5vdCBzZXQKIyBDT05GSUdfR1BJT19CVDhYWCBpcyBub3Qgc2V0CiMg
Q09ORklHX0dQSU9fTUxfSU9IIGlzIG5vdCBzZXQKIyBDT05GSUdfR1BJT19SREMzMjFYIGlz
IG5vdCBzZXQKCiMKIyBVU0IgR1BJTyBleHBhbmRlcnMKIwojIENPTkZJR19XMSBpcyBub3Qg
c2V0CkNPTkZJR19QT1dFUl9TVVBQTFk9eQojIENPTkZJR19QT1dFUl9TVVBQTFlfREVCVUcg
aXMgbm90IHNldAojIENPTkZJR19QREFfUE9XRVIgaXMgbm90IHNldAojIENPTkZJR19URVNU
X1BPV0VSIGlzIG5vdCBzZXQKIyBDT05GSUdfQkFUVEVSWV9EUzI3ODAgaXMgbm90IHNldAoj
IENPTkZJR19CQVRURVJZX0RTMjc4MSBpcyBub3Qgc2V0CiMgQ09ORklHX0JBVFRFUllfRFMy
NzgyIGlzIG5vdCBzZXQKIyBDT05GSUdfQkFUVEVSWV9TQlMgaXMgbm90IHNldAojIENPTkZJ
R19CQVRURVJZX0JRMjd4MDAgaXMgbm90IHNldAojIENPTkZJR19CQVRURVJZX01BWDE3MDQw
IGlzIG5vdCBzZXQKIyBDT05GSUdfQkFUVEVSWV9NQVgxNzA0MiBpcyBub3Qgc2V0CiMgQ09O
RklHX0NIQVJHRVJfTUFYODkwMyBpcyBub3Qgc2V0CiMgQ09ORklHX0NIQVJHRVJfTFA4NzI3
IGlzIG5vdCBzZXQKIyBDT05GSUdfQ0hBUkdFUl9HUElPIGlzIG5vdCBzZXQKIyBDT05GSUdf
Q0hBUkdFUl9CUTI0MTVYIGlzIG5vdCBzZXQKIyBDT05GSUdfQ0hBUkdFUl9CUTI0MTkwIGlz
IG5vdCBzZXQKIyBDT05GSUdfQ0hBUkdFUl9CUTI0NzM1IGlzIG5vdCBzZXQKIyBDT05GSUdf
Q0hBUkdFUl9TTUIzNDcgaXMgbm90IHNldAojIENPTkZJR19CQVRURVJZX0dBVUdFX0xUQzI5
NDEgaXMgbm90IHNldAojIENPTkZJR19QT1dFUl9SRVNFVCBpcyBub3Qgc2V0CiMgQ09ORklH
X1BPV0VSX0FWUyBpcyBub3Qgc2V0CkNPTkZJR19IV01PTj15CiMgQ09ORklHX0hXTU9OX1ZJ
RCBpcyBub3Qgc2V0CiMgQ09ORklHX0hXTU9OX0RFQlVHX0NISVAgaXMgbm90IHNldAoKIwoj
IE5hdGl2ZSBkcml2ZXJzCiMKIyBDT05GSUdfU0VOU09SU19BRDc0MTQgaXMgbm90IHNldAoj
IENPTkZJR19TRU5TT1JTX0FENzQxOCBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfQURN
MTAyMSBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfQURNMTAyNSBpcyBub3Qgc2V0CiMg
Q09ORklHX1NFTlNPUlNfQURNMTAyNiBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfQURN
MTAyOSBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfQURNMTAzMSBpcyBub3Qgc2V0CiMg
Q09ORklHX1NFTlNPUlNfQURNOTI0MCBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfQURU
NzQxMCBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfQURUNzQxMSBpcyBub3Qgc2V0CiMg
Q09ORklHX1NFTlNPUlNfQURUNzQ2MiBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfQURU
NzQ3MCBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfQURUNzQ3NSBpcyBub3Qgc2V0CiMg
Q09ORklHX1NFTlNPUlNfQVNDNzYyMSBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfQVRY
UDEgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0RTNjIwIGlzIG5vdCBzZXQKIyBDT05G
SUdfU0VOU09SU19EUzE2MjEgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0k1S19BTUIg
aXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0Y3NTM3NVMgaXMgbm90IHNldAojIENPTkZJ
R19TRU5TT1JTX0dMNTE4U00gaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0dMNTIwU00g
aXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0c3NjBBIGlzIG5vdCBzZXQKIyBDT05GSUdf
U0VOU09SU19HNzYyIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19HUElPX0ZBTiBpcyBu
b3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfSElINjEzMCBpcyBub3Qgc2V0CiMgQ09ORklHX1NF
TlNPUlNfSkM0MiBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfUE9XUjEyMjAgaXMgbm90
IHNldAojIENPTkZJR19TRU5TT1JTX0xJTkVBR0UgaXMgbm90IHNldAojIENPTkZJR19TRU5T
T1JTX0xUQzI5NDUgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0xUQzQxNTEgaXMgbm90
IHNldAojIENPTkZJR19TRU5TT1JTX0xUQzQyMTUgaXMgbm90IHNldAojIENPTkZJR19TRU5T
T1JTX0xUQzQyMjIgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0xUQzQyNDUgaXMgbm90
IHNldAojIENPTkZJR19TRU5TT1JTX0xUQzQyNjAgaXMgbm90IHNldAojIENPTkZJR19TRU5T
T1JTX0xUQzQyNjEgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX01BWDE2MDY1IGlzIG5v
dCBzZXQKIyBDT05GSUdfU0VOU09SU19NQVgxNjE5IGlzIG5vdCBzZXQKIyBDT05GSUdfU0VO
U09SU19NQVgxNjY4IGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19NQVgxOTcgaXMgbm90
IHNldAojIENPTkZJR19TRU5TT1JTX01BWDY2MzkgaXMgbm90IHNldAojIENPTkZJR19TRU5T
T1JTX01BWDY2NDIgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX01BWDY2NTAgaXMgbm90
IHNldAojIENPTkZJR19TRU5TT1JTX01BWDY2OTcgaXMgbm90IHNldAojIENPTkZJR19TRU5T
T1JTX0hUVTIxIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19NQ1AzMDIxIGlzIG5vdCBz
ZXQKIyBDT05GSUdfU0VOU09SU19MTTYzIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19M
TTczIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19MTTc1IGlzIG5vdCBzZXQKIyBDT05G
SUdfU0VOU09SU19MTTc3IGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19MTTc4IGlzIG5v
dCBzZXQKIyBDT05GSUdfU0VOU09SU19MTTgwIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09S
U19MTTgzIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19MTTg1IGlzIG5vdCBzZXQKIyBD
T05GSUdfU0VOU09SU19MTTg3IGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19MTTkwIGlz
IG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19MTTkyIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VO
U09SU19MTTkzIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19MTTk1MjM0IGlzIG5vdCBz
ZXQKIyBDT05GSUdfU0VOU09SU19MTTk1MjQxIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09S
U19MTTk1MjQ1IGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19OVENfVEhFUk1JU1RPUiBp
cyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfTkNUNzgwMiBpcyBub3Qgc2V0CiMgQ09ORklH
X1NFTlNPUlNfTkNUNzkwNCBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfUENGODU5MSBp
cyBub3Qgc2V0CiMgQ09ORklHX1BNQlVTIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19T
SFQxNSBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfU0hUMjEgaXMgbm90IHNldAojIENP
TkZJR19TRU5TT1JTX1NIVEMxIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19TSVM1NTk1
IGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19FTUMxNDAzIGlzIG5vdCBzZXQKIyBDT05G
SUdfU0VOU09SU19FTUMyMTAzIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19FTUM2VzIw
MSBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfU01TQzQ3TTE5MiBpcyBub3Qgc2V0CiMg
Q09ORklHX1NFTlNPUlNfU0NINTZYWF9DT01NT04gaXMgbm90IHNldAojIENPTkZJR19TRU5T
T1JTX1NNTTY2NSBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfQURDMTI4RDgxOCBpcyBu
b3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfQURTMTAxNSBpcyBub3Qgc2V0CiMgQ09ORklHX1NF
TlNPUlNfQURTNzgyOCBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfQU1DNjgyMSBpcyBu
b3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfSU5BMjA5IGlzIG5vdCBzZXQKIyBDT05GSUdfU0VO
U09SU19JTkEyWFggaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX1RITUM1MCBpcyBub3Qg
c2V0CiMgQ09ORklHX1NFTlNPUlNfVE1QMTAyIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09S
U19UTVAxMDMgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX1RNUDQwMSBpcyBub3Qgc2V0
CiMgQ09ORklHX1NFTlNPUlNfVE1QNDIxIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19W
SUE2ODZBIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19WVDgyMzEgaXMgbm90IHNldAoj
IENPTkZJR19TRU5TT1JTX1c4Mzc4MUQgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX1c4
Mzc5MUQgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX1c4Mzc5MkQgaXMgbm90IHNldAoj
IENPTkZJR19TRU5TT1JTX1c4Mzc5MyBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfVzgz
Nzk1IGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19XODNMNzg1VFMgaXMgbm90IHNldAoj
IENPTkZJR19TRU5TT1JTX1c4M0w3ODZORyBpcyBub3Qgc2V0CiMgQ09ORklHX1RIRVJNQUwg
aXMgbm90IHNldAojIENPTkZJR19XQVRDSERPRyBpcyBub3Qgc2V0CkNPTkZJR19TU0JfUE9T
U0lCTEU9eQoKIwojIFNvbmljcyBTaWxpY29uIEJhY2twbGFuZQojCkNPTkZJR19TU0I9bQpD
T05GSUdfU1NCX1NQUk9NPXkKQ09ORklHX1NTQl9CTE9DS0lPPXkKQ09ORklHX1NTQl9QQ0lI
T1NUX1BPU1NJQkxFPXkKQ09ORklHX1NTQl9QQ0lIT1NUPXkKQ09ORklHX1NTQl9CNDNfUENJ
X0JSSURHRT15CkNPTkZJR19TU0JfU0RJT0hPU1RfUE9TU0lCTEU9eQojIENPTkZJR19TU0Jf
U0RJT0hPU1QgaXMgbm90IHNldAojIENPTkZJR19TU0JfU0lMRU5UIGlzIG5vdCBzZXQKIyBD
T05GSUdfU1NCX0RFQlVHIGlzIG5vdCBzZXQKQ09ORklHX1NTQl9EUklWRVJfUENJQ09SRV9Q
T1NTSUJMRT15CkNPTkZJR19TU0JfRFJJVkVSX1BDSUNPUkU9eQojIENPTkZJR19TU0JfRFJJ
VkVSX0dQSU8gaXMgbm90IHNldApDT05GSUdfQkNNQV9QT1NTSUJMRT15CgojCiMgQnJvYWRj
b20gc3BlY2lmaWMgQU1CQQojCkNPTkZJR19CQ01BPW0KQ09ORklHX0JDTUFfQkxPQ0tJTz15
CkNPTkZJR19CQ01BX0hPU1RfUENJX1BPU1NJQkxFPXkKIyBDT05GSUdfQkNNQV9IT1NUX1BD
SSBpcyBub3Qgc2V0CiMgQ09ORklHX0JDTUFfSE9TVF9TT0MgaXMgbm90IHNldApDT05GSUdf
QkNNQV9EUklWRVJfUENJPXkKIyBDT05GSUdfQkNNQV9EUklWRVJfR01BQ19DTU4gaXMgbm90
IHNldAojIENPTkZJR19CQ01BX0RSSVZFUl9HUElPIGlzIG5vdCBzZXQKIyBDT05GSUdfQkNN
QV9ERUJVRyBpcyBub3Qgc2V0CgojCiMgTXVsdGlmdW5jdGlvbiBkZXZpY2UgZHJpdmVycwoj
CiMgQ09ORklHX01GRF9DT1JFIGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX0FTMzcxMSBpcyBu
b3Qgc2V0CiMgQ09ORklHX01GRF9BUzM3MjIgaXMgbm90IHNldAojIENPTkZJR19QTUlDX0FE
UDU1MjAgaXMgbm90IHNldAojIENPTkZJR19NRkRfQUFUMjg3MF9DT1JFIGlzIG5vdCBzZXQK
IyBDT05GSUdfTUZEX0FUTUVMX0hMQ0RDIGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX0JDTTU5
MFhYIGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX0FYUDIwWCBpcyBub3Qgc2V0CiMgQ09ORklH
X01GRF9DUk9TX0VDIGlzIG5vdCBzZXQKIyBDT05GSUdfUE1JQ19EQTkwM1ggaXMgbm90IHNl
dAojIENPTkZJR19NRkRfREE5MDUyX0kyQyBpcyBub3Qgc2V0CiMgQ09ORklHX01GRF9EQTkw
NTUgaXMgbm90IHNldAojIENPTkZJR19NRkRfREE5MDYzIGlzIG5vdCBzZXQKIyBDT05GSUdf
TUZEX0RBOTE1MCBpcyBub3Qgc2V0CiMgQ09ORklHX01GRF9ETE4yIGlzIG5vdCBzZXQKIyBD
T05GSUdfTUZEX01DMTNYWFhfSTJDIGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX0hJNjQyMV9Q
TUlDIGlzIG5vdCBzZXQKIyBDT05GSUdfSFRDX1BBU0lDMyBpcyBub3Qgc2V0CiMgQ09ORklH
X0hUQ19JMkNQTEQgaXMgbm90IHNldAojIENPTkZJR19MUENfSUNIIGlzIG5vdCBzZXQKIyBD
T05GSUdfTFBDX1NDSCBpcyBub3Qgc2V0CiMgQ09ORklHX0lOVEVMX1NPQ19QTUlDIGlzIG5v
dCBzZXQKIyBDT05GSUdfTUZEX0pBTlpfQ01PRElPIGlzIG5vdCBzZXQKIyBDT05GSUdfTUZE
X0tFTVBMRCBpcyBub3Qgc2V0CiMgQ09ORklHX01GRF84OFBNODAwIGlzIG5vdCBzZXQKIyBD
T05GSUdfTUZEXzg4UE04MDUgaXMgbm90IHNldAojIENPTkZJR19NRkRfODhQTTg2MFggaXMg
bm90IHNldAojIENPTkZJR19NRkRfTUFYMTQ1NzcgaXMgbm90IHNldAojIENPTkZJR19NRkRf
TUFYNzc2ODYgaXMgbm90IHNldAojIENPTkZJR19NRkRfTUFYNzc2OTMgaXMgbm90IHNldAoj
IENPTkZJR19NRkRfTUFYNzc4NDMgaXMgbm90IHNldAojIENPTkZJR19NRkRfTUFYODkwNyBp
cyBub3Qgc2V0CiMgQ09ORklHX01GRF9NQVg4OTI1IGlzIG5vdCBzZXQKIyBDT05GSUdfTUZE
X01BWDg5OTcgaXMgbm90IHNldAojIENPTkZJR19NRkRfTUFYODk5OCBpcyBub3Qgc2V0CiMg
Q09ORklHX01GRF9NVDYzOTcgaXMgbm90IHNldAojIENPTkZJR19NRkRfTUVORjIxQk1DIGlz
IG5vdCBzZXQKIyBDT05GSUdfTUZEX1ZJUEVSQk9BUkQgaXMgbm90IHNldAojIENPTkZJR19N
RkRfUkVUVSBpcyBub3Qgc2V0CiMgQ09ORklHX01GRF9QQ0Y1MDYzMyBpcyBub3Qgc2V0CiMg
Q09ORklHX01GRF9SREMzMjFYIGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX1JUU1hfUENJIGlz
IG5vdCBzZXQKIyBDT05GSUdfTUZEX1JUNTAzMyBpcyBub3Qgc2V0CiMgQ09ORklHX01GRF9S
VFNYX1VTQiBpcyBub3Qgc2V0CiMgQ09ORklHX01GRF9SQzVUNTgzIGlzIG5vdCBzZXQKIyBD
T05GSUdfTUZEX1JLODA4IGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX1JONVQ2MTggaXMgbm90
IHNldAojIENPTkZJR19NRkRfU0VDX0NPUkUgaXMgbm90IHNldAojIENPTkZJR19NRkRfU0k0
NzZYX0NPUkUgaXMgbm90IHNldAojIENPTkZJR19NRkRfU001MDEgaXMgbm90IHNldAojIENP
TkZJR19NRkRfU0tZODE0NTIgaXMgbm90IHNldAojIENPTkZJR19NRkRfU01TQyBpcyBub3Qg
c2V0CiMgQ09ORklHX0FCWDUwMF9DT1JFIGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX1NUTVBF
IGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX1NZU0NPTiBpcyBub3Qgc2V0CiMgQ09ORklHX01G
RF9USV9BTTMzNVhfVFNDQURDIGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX0xQMzk0MyBpcyBu
b3Qgc2V0CiMgQ09ORklHX01GRF9MUDg3ODggaXMgbm90IHNldAojIENPTkZJR19NRkRfUEFM
TUFTIGlzIG5vdCBzZXQKIyBDT05GSUdfVFBTNjEwNVggaXMgbm90IHNldAojIENPTkZJR19U
UFM2NTAxMCBpcyBub3Qgc2V0CiMgQ09ORklHX1RQUzY1MDdYIGlzIG5vdCBzZXQKIyBDT05G
SUdfTUZEX1RQUzY1MDkwIGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX1RQUzY1MjE3IGlzIG5v
dCBzZXQKIyBDT05GSUdfTUZEX1RQUzY1MjE4IGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX1RQ
UzY1ODZYIGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX1RQUzY1OTEwIGlzIG5vdCBzZXQKIyBD
T05GSUdfTUZEX1RQUzY1OTEyIGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX1RQUzY1OTEyX0ky
QyBpcyBub3Qgc2V0CiMgQ09ORklHX01GRF9UUFM4MDAzMSBpcyBub3Qgc2V0CiMgQ09ORklH
X1RXTDQwMzBfQ09SRSBpcyBub3Qgc2V0CiMgQ09ORklHX1RXTDYwNDBfQ09SRSBpcyBub3Qg
c2V0CiMgQ09ORklHX01GRF9XTDEyNzNfQ09SRSBpcyBub3Qgc2V0CiMgQ09ORklHX01GRF9M
TTM1MzMgaXMgbm90IHNldAojIENPTkZJR19NRkRfVEMzNTg5WCBpcyBub3Qgc2V0CiMgQ09O
RklHX01GRF9UTUlPIGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX1ZYODU1IGlzIG5vdCBzZXQK
IyBDT05GSUdfTUZEX0FSSVpPTkFfSTJDIGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX1dNODQw
MCBpcyBub3Qgc2V0CiMgQ09ORklHX01GRF9XTTgzMVhfSTJDIGlzIG5vdCBzZXQKIyBDT05G
SUdfTUZEX1dNODM1MF9JMkMgaXMgbm90IHNldAojIENPTkZJR19NRkRfV004OTk0IGlzIG5v
dCBzZXQKIyBDT05GSUdfUkVHVUxBVE9SIGlzIG5vdCBzZXQKQ09ORklHX01FRElBX1NVUFBP
UlQ9bQoKIwojIE11bHRpbWVkaWEgY29yZSBzdXBwb3J0CiMKQ09ORklHX01FRElBX0NBTUVS
QV9TVVBQT1JUPXkKQ09ORklHX01FRElBX0FOQUxPR19UVl9TVVBQT1JUPXkKQ09ORklHX01F
RElBX0RJR0lUQUxfVFZfU1VQUE9SVD15CkNPTkZJR19NRURJQV9SQURJT19TVVBQT1JUPXkK
Q09ORklHX01FRElBX1NEUl9TVVBQT1JUPXkKQ09ORklHX01FRElBX1JDX1NVUFBPUlQ9eQpD
T05GSUdfTUVESUFfQ09OVFJPTExFUj15CkNPTkZJR19WSURFT19ERVY9bQojIENPTkZJR19W
SURFT19WNEwyX1NVQkRFVl9BUEkgaXMgbm90IHNldApDT05GSUdfVklERU9fVjRMMj1tCiMg
Q09ORklHX1ZJREVPX0FEVl9ERUJVRyBpcyBub3Qgc2V0CiMgQ09ORklHX1ZJREVPX0ZJWEVE
X01JTk9SX1JBTkdFUyBpcyBub3Qgc2V0CkNPTkZJR19WSURFT0JVRl9HRU49bQpDT05GSUdf
VklERU9CVUZfVk1BTExPQz1tCkNPTkZJR19WSURFT0JVRjJfQ09SRT1tCkNPTkZJR19WSURF
T0JVRjJfTUVNT1BTPW0KQ09ORklHX1ZJREVPQlVGMl9WTUFMTE9DPW0KQ09ORklHX0RWQl9D
T1JFPW0KQ09ORklHX0RWQl9ORVQ9eQojIENPTkZJR19UVFBDSV9FRVBST00gaXMgbm90IHNl
dApDT05GSUdfRFZCX01BWF9BREFQVEVSUz04CiMgQ09ORklHX0RWQl9EWU5BTUlDX01JTk9S
UyBpcyBub3Qgc2V0CgojCiMgTWVkaWEgZHJpdmVycwojCkNPTkZJR19SQ19DT1JFPW0KIyBD
T05GSUdfUkNfTUFQIGlzIG5vdCBzZXQKQ09ORklHX1JDX0RFQ09ERVJTPXkKIyBDT05GSUdf
TElSQyBpcyBub3Qgc2V0CkNPTkZJR19JUl9ORUNfREVDT0RFUj1tCkNPTkZJR19JUl9SQzVf
REVDT0RFUj1tCkNPTkZJR19JUl9SQzZfREVDT0RFUj1tCkNPTkZJR19JUl9KVkNfREVDT0RF
Uj1tCkNPTkZJR19JUl9TT05ZX0RFQ09ERVI9bQpDT05GSUdfSVJfU0FOWU9fREVDT0RFUj1t
CkNPTkZJR19JUl9TSEFSUF9ERUNPREVSPW0KQ09ORklHX0lSX01DRV9LQkRfREVDT0RFUj1t
CkNPTkZJR19JUl9YTVBfREVDT0RFUj1tCkNPTkZJR19SQ19ERVZJQ0VTPXkKQ09ORklHX1JD
X0FUSV9SRU1PVEU9bQojIENPTkZJR19JUl9ISVg1SEQyIGlzIG5vdCBzZXQKQ09ORklHX0lS
X0lNT049bQpDT05GSUdfSVJfTUNFVVNCPW0KQ09ORklHX0lSX1JFRFJBVDM9bQpDT05GSUdf
SVJfU1RSRUFNWkFQPW0KIyBDT05GSUdfSVJfSUdPUlBMVUdVU0IgaXMgbm90IHNldApDT05G
SUdfSVJfSUdVQU5BPW0KQ09ORklHX0lSX1RUVVNCSVI9bQpDT05GSUdfUkNfTE9PUEJBQ0s9
bQpDT05GSUdfSVJfR1BJT19DSVI9bQpDT05GSUdfTUVESUFfVVNCX1NVUFBPUlQ9eQoKIwoj
IFdlYmNhbSBkZXZpY2VzCiMKQ09ORklHX1VTQl9WSURFT19DTEFTUz1tCkNPTkZJR19VU0Jf
VklERU9fQ0xBU1NfSU5QVVRfRVZERVY9eQpDT05GSUdfVVNCX0dTUENBPW0KIyBDT05GSUdf
VVNCX001NjAyIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1NUVjA2WFggaXMgbm90IHNldAoj
IENPTkZJR19VU0JfR0w4NjAgaXMgbm90IHNldAojIENPTkZJR19VU0JfR1NQQ0FfQkVOUSBp
cyBub3Qgc2V0CiMgQ09ORklHX1VTQl9HU1BDQV9DT05FWCBpcyBub3Qgc2V0CiMgQ09ORklH
X1VTQl9HU1BDQV9DUElBMSBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9HU1BDQV9EVENTMDMz
IGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX0dTUENBX0VUT01TIGlzIG5vdCBzZXQKIyBDT05G
SUdfVVNCX0dTUENBX0ZJTkVQSVggaXMgbm90IHNldAojIENPTkZJR19VU0JfR1NQQ0FfSkVJ
TElOSiBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9HU1BDQV9KTDIwMDVCQ0QgaXMgbm90IHNl
dAojIENPTkZJR19VU0JfR1NQQ0FfS0lORUNUIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX0dT
UENBX0tPTklDQSBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9HU1BDQV9NQVJTIGlzIG5vdCBz
ZXQKIyBDT05GSUdfVVNCX0dTUENBX01SOTczMTBBIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNC
X0dTUENBX05XODBYIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX0dTUENBX09WNTE5IGlzIG5v
dCBzZXQKIyBDT05GSUdfVVNCX0dTUENBX09WNTM0IGlzIG5vdCBzZXQKIyBDT05GSUdfVVNC
X0dTUENBX09WNTM0XzkgaXMgbm90IHNldAojIENPTkZJR19VU0JfR1NQQ0FfUEFDMjA3IGlz
IG5vdCBzZXQKIyBDT05GSUdfVVNCX0dTUENBX1BBQzczMDIgaXMgbm90IHNldAojIENPTkZJ
R19VU0JfR1NQQ0FfUEFDNzMxMSBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9HU1BDQV9TRTQw
MSBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9HU1BDQV9TTjlDMjAyOCBpcyBub3Qgc2V0CiMg
Q09ORklHX1VTQl9HU1BDQV9TTjlDMjBYIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX0dTUENB
X1NPTklYQiBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9HU1BDQV9TT05JWEogaXMgbm90IHNl
dAojIENPTkZJR19VU0JfR1NQQ0FfU1BDQTUwMCBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9H
U1BDQV9TUENBNTAxIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX0dTUENBX1NQQ0E1MDUgaXMg
bm90IHNldAojIENPTkZJR19VU0JfR1NQQ0FfU1BDQTUwNiBpcyBub3Qgc2V0CiMgQ09ORklH
X1VTQl9HU1BDQV9TUENBNTA4IGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX0dTUENBX1NQQ0E1
NjEgaXMgbm90IHNldAojIENPTkZJR19VU0JfR1NQQ0FfU1BDQTE1MjggaXMgbm90IHNldAoj
IENPTkZJR19VU0JfR1NQQ0FfU1E5MDUgaXMgbm90IHNldAojIENPTkZJR19VU0JfR1NQQ0Ff
U1E5MDVDIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX0dTUENBX1NROTMwWCBpcyBub3Qgc2V0
CiMgQ09ORklHX1VTQl9HU1BDQV9TVEswMTQgaXMgbm90IHNldAojIENPTkZJR19VU0JfR1NQ
Q0FfU1RLMTEzNSBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9HU1BDQV9TVFYwNjgwIGlzIG5v
dCBzZXQKIyBDT05GSUdfVVNCX0dTUENBX1NVTlBMVVMgaXMgbm90IHNldAojIENPTkZJR19V
U0JfR1NQQ0FfVDYxMyBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9HU1BDQV9UT1BSTyBpcyBu
b3Qgc2V0CiMgQ09ORklHX1VTQl9HU1BDQV9UT1VQVEVLIGlzIG5vdCBzZXQKIyBDT05GSUdf
VVNCX0dTUENBX1RWODUzMiBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9HU1BDQV9WQzAzMlgg
aXMgbm90IHNldAojIENPTkZJR19VU0JfR1NQQ0FfVklDQU0gaXMgbm90IHNldAojIENPTkZJ
R19VU0JfR1NQQ0FfWElSTElOS19DSVQgaXMgbm90IHNldAojIENPTkZJR19VU0JfR1NQQ0Ff
WkMzWFggaXMgbm90IHNldApDT05GSUdfVVNCX1BXQz1tCiMgQ09ORklHX1VTQl9QV0NfREVC
VUcgaXMgbm90IHNldApDT05GSUdfVVNCX1BXQ19JTlBVVF9FVkRFVj15CkNPTkZJR19WSURF
T19DUElBMj1tCkNPTkZJR19VU0JfWlIzNjRYWD1tCkNPTkZJR19VU0JfU1RLV0VCQ0FNPW0K
Q09ORklHX1VTQl9TMjI1NT1tCkNPTkZJR19WSURFT19VU0JUVj1tCgojCiMgQW5hbG9nIFRW
IFVTQiBkZXZpY2VzCiMKIyBDT05GSUdfVklERU9fUFZSVVNCMiBpcyBub3Qgc2V0CiMgQ09O
RklHX1ZJREVPX0hEUFZSIGlzIG5vdCBzZXQKIyBDT05GSUdfVklERU9fVVNCVklTSU9OIGlz
IG5vdCBzZXQKIyBDT05GSUdfVklERU9fU1RLMTE2MF9DT01NT04gaXMgbm90IHNldAojIENP
TkZJR19WSURFT19HTzcwMDcgaXMgbm90IHNldAoKIwojIEFuYWxvZy9kaWdpdGFsIFRWIFVT
QiBkZXZpY2VzCiMKIyBDT05GSUdfVklERU9fQVUwODI4IGlzIG5vdCBzZXQKIyBDT05GSUdf
VklERU9fQ1gyMzFYWCBpcyBub3Qgc2V0CiMgQ09ORklHX1ZJREVPX1RNNjAwMCBpcyBub3Qg
c2V0CgojCiMgRGlnaXRhbCBUViBVU0IgZGV2aWNlcwojCiMgQ09ORklHX0RWQl9VU0IgaXMg
bm90IHNldAojIENPTkZJR19EVkJfVVNCX1YyIGlzIG5vdCBzZXQKIyBDT05GSUdfRFZCX1RU
VVNCX0JVREdFVCBpcyBub3Qgc2V0CiMgQ09ORklHX0RWQl9UVFVTQl9ERUMgaXMgbm90IHNl
dAojIENPTkZJR19TTVNfVVNCX0RSViBpcyBub3Qgc2V0CiMgQ09ORklHX0RWQl9CMkMyX0ZM
RVhDT1BfVVNCIGlzIG5vdCBzZXQKIyBDT05GSUdfRFZCX0FTMTAyIGlzIG5vdCBzZXQKCiMK
IyBXZWJjYW0sIFRWIChhbmFsb2cvZGlnaXRhbCkgVVNCIGRldmljZXMKIwojIENPTkZJR19W
SURFT19FTTI4WFggaXMgbm90IHNldAoKIwojIFNvZnR3YXJlIGRlZmluZWQgcmFkaW8gVVNC
IGRldmljZXMKIwojIENPTkZJR19VU0JfQUlSU1BZIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNC
X0hBQ0tSRiBpcyBub3Qgc2V0CiMgQ09ORklHX01FRElBX1BDSV9TVVBQT1JUIGlzIG5vdCBz
ZXQKIyBDT05GSUdfVjRMX1BMQVRGT1JNX0RSSVZFUlMgaXMgbm90IHNldAojIENPTkZJR19W
NExfTUVNMk1FTV9EUklWRVJTIGlzIG5vdCBzZXQKIyBDT05GSUdfVjRMX1RFU1RfRFJJVkVS
UyBpcyBub3Qgc2V0CgojCiMgU3VwcG9ydGVkIE1NQy9TRElPIGFkYXB0ZXJzCiMKIyBDT05G
SUdfU01TX1NESU9fRFJWIGlzIG5vdCBzZXQKQ09ORklHX1JBRElPX0FEQVBURVJTPXkKIyBD
T05GSUdfUkFESU9fU0k0NzBYIGlzIG5vdCBzZXQKIyBDT05GSUdfUkFESU9fU0k0NzEzIGlz
IG5vdCBzZXQKIyBDT05GSUdfVVNCX01SODAwIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX0RT
QlIgaXMgbm90IHNldAojIENPTkZJR19SQURJT19NQVhJUkFESU8gaXMgbm90IHNldAojIENP
TkZJR19SQURJT19TSEFSSyBpcyBub3Qgc2V0CiMgQ09ORklHX1JBRElPX1NIQVJLMiBpcyBu
b3Qgc2V0CiMgQ09ORklHX1VTQl9LRUVORSBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9SQVJF
TU9OTyBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9NQTkwMSBpcyBub3Qgc2V0CiMgQ09ORklH
X1JBRElPX1RFQTU3NjQgaXMgbm90IHNldAojIENPTkZJR19SQURJT19TQUE3NzA2SCBpcyBu
b3Qgc2V0CiMgQ09ORklHX1JBRElPX1RFRjY4NjIgaXMgbm90IHNldAojIENPTkZJR19SQURJ
T19XTDEyNzMgaXMgbm90IHNldAoKIwojIFRleGFzIEluc3RydW1lbnRzIFdMMTI4eCBGTSBk
cml2ZXIgKFNUIGJhc2VkKQojCiMgQ09ORklHX0NZUFJFU1NfRklSTVdBUkUgaXMgbm90IHNl
dAoKIwojIE1lZGlhIGFuY2lsbGFyeSBkcml2ZXJzICh0dW5lcnMsIHNlbnNvcnMsIGkyYywg
ZnJvbnRlbmRzKQojCkNPTkZJR19NRURJQV9TVUJEUlZfQVVUT1NFTEVDVD15CkNPTkZJR19N
RURJQV9BVFRBQ0g9eQpDT05GSUdfVklERU9fSVJfSTJDPW0KCiMKIyBBdWRpbyBkZWNvZGVy
cywgcHJvY2Vzc29ycyBhbmQgbWl4ZXJzCiMKCiMKIyBSRFMgZGVjb2RlcnMKIwoKIwojIFZp
ZGVvIGRlY29kZXJzCiMKCiMKIyBWaWRlbyBhbmQgYXVkaW8gZGVjb2RlcnMKIwoKIwojIFZp
ZGVvIGVuY29kZXJzCiMKCiMKIyBDYW1lcmEgc2Vuc29yIGRldmljZXMKIwoKIwojIEZsYXNo
IGRldmljZXMKIwoKIwojIFZpZGVvIGltcHJvdmVtZW50IGNoaXBzCiMKCiMKIyBBdWRpby9W
aWRlbyBjb21wcmVzc2lvbiBjaGlwcwojCgojCiMgTWlzY2VsbGFuZW91cyBoZWxwZXIgY2hp
cHMKIwoKIwojIFNlbnNvcnMgdXNlZCBvbiBzb2NfY2FtZXJhIGRyaXZlcgojCkNPTkZJR19N
RURJQV9UVU5FUj1tCkNPTkZJR19NRURJQV9UVU5FUl9TSU1QTEU9bQpDT05GSUdfTUVESUFf
VFVORVJfVERBODI5MD1tCkNPTkZJR19NRURJQV9UVU5FUl9UREE4MjdYPW0KQ09ORklHX01F
RElBX1RVTkVSX1REQTE4MjcxPW0KQ09ORklHX01FRElBX1RVTkVSX1REQTk4ODc9bQpDT05G
SUdfTUVESUFfVFVORVJfVEVBNTc2MT1tCkNPTkZJR19NRURJQV9UVU5FUl9URUE1NzY3PW0K
Q09ORklHX01FRElBX1RVTkVSX01UMjBYWD1tCkNPTkZJR19NRURJQV9UVU5FUl9YQzIwMjg9
bQpDT05GSUdfTUVESUFfVFVORVJfWEM1MDAwPW0KQ09ORklHX01FRElBX1RVTkVSX1hDNDAw
MD1tCkNPTkZJR19NRURJQV9UVU5FUl9NQzQ0UzgwMz1tCgojCiMgTXVsdGlzdGFuZGFyZCAo
c2F0ZWxsaXRlKSBmcm9udGVuZHMKIwoKIwojIE11bHRpc3RhbmRhcmQgKGNhYmxlICsgdGVy
cmVzdHJpYWwpIGZyb250ZW5kcwojCgojCiMgRFZCLVMgKHNhdGVsbGl0ZSkgZnJvbnRlbmRz
CiMKCiMKIyBEVkItVCAodGVycmVzdHJpYWwpIGZyb250ZW5kcwojCiMgQ09ORklHX0RWQl9B
UzEwMl9GRSBpcyBub3Qgc2V0CgojCiMgRFZCLUMgKGNhYmxlKSBmcm9udGVuZHMKIwoKIwoj
IEFUU0MgKE5vcnRoIEFtZXJpY2FuL0tvcmVhbiBUZXJyZXN0cmlhbC9DYWJsZSBEVFYpIGZy
b250ZW5kcwojCgojCiMgSVNEQi1UICh0ZXJyZXN0cmlhbCkgZnJvbnRlbmRzCiMKCiMKIyBJ
U0RCLVMgKHNhdGVsbGl0ZSkgJiBJU0RCLVQgKHRlcnJlc3RyaWFsKSBmcm9udGVuZHMKIwoK
IwojIERpZ2l0YWwgdGVycmVzdHJpYWwgb25seSB0dW5lcnMvUExMCiMKCiMKIyBTRUMgY29u
dHJvbCBkZXZpY2VzIGZvciBEVkItUwojCgojCiMgVG9vbHMgdG8gZGV2ZWxvcCBuZXcgZnJv
bnRlbmRzCiMKIyBDT05GSUdfRFZCX0RVTU1ZX0ZFIGlzIG5vdCBzZXQKCiMKIyBHcmFwaGlj
cyBzdXBwb3J0CiMKIyBDT05GSUdfQUdQIGlzIG5vdCBzZXQKIyBDT05GSUdfVkdBX0FSQiBp
cyBub3Qgc2V0CgojCiMgRGlyZWN0IFJlbmRlcmluZyBNYW5hZ2VyCiMKQ09ORklHX0RSTT15
CkNPTkZJR19EUk1fS01TX0hFTFBFUj15CkNPTkZJR19EUk1fS01TX0ZCX0hFTFBFUj15CiMg
Q09ORklHX0RSTV9MT0FEX0VESURfRklSTVdBUkUgaXMgbm90IHNldApDT05GSUdfRFJNX1RU
TT15CgojCiMgSTJDIGVuY29kZXIgb3IgaGVscGVyIGNoaXBzCiMKIyBDT05GSUdfRFJNX0ky
Q19BRFY3NTExIGlzIG5vdCBzZXQKIyBDT05GSUdfRFJNX0kyQ19DSDcwMDYgaXMgbm90IHNl
dAojIENPTkZJR19EUk1fSTJDX1NJTDE2NCBpcyBub3Qgc2V0CiMgQ09ORklHX0RSTV9JMkNf
TlhQX1REQTk5OFggaXMgbm90IHNldAojIENPTkZJR19EUk1fUFROMzQ2MCBpcyBub3Qgc2V0
CiMgQ09ORklHX0RSTV9QUzg2MjIgaXMgbm90IHNldAojIENPTkZJR19EUk1fVERGWCBpcyBu
b3Qgc2V0CiMgQ09ORklHX0RSTV9SMTI4IGlzIG5vdCBzZXQKQ09ORklHX0RSTV9SQURFT049
eQojIENPTkZJR19EUk1fUkFERU9OX1VTRVJQVFIgaXMgbm90IHNldAojIENPTkZJR19EUk1f
UkFERU9OX1VNUyBpcyBub3Qgc2V0CiMgQ09ORklHX0RSTV9OT1VWRUFVIGlzIG5vdCBzZXQK
IyBDT05GSUdfRFJNX01HQSBpcyBub3Qgc2V0CiMgQ09ORklHX0RSTV9WSUEgaXMgbm90IHNl
dAojIENPTkZJR19EUk1fU0FWQUdFIGlzIG5vdCBzZXQKIyBDT05GSUdfRFJNX1ZHRU0gaXMg
bm90IHNldAojIENPTkZJR19EUk1fVk1XR0ZYIGlzIG5vdCBzZXQKIyBDT05GSUdfRFJNX1VE
TCBpcyBub3Qgc2V0CiMgQ09ORklHX0RSTV9BU1QgaXMgbm90IHNldAojIENPTkZJR19EUk1f
TUdBRzIwMCBpcyBub3Qgc2V0CiMgQ09ORklHX0RSTV9DSVJSVVNfUUVNVSBpcyBub3Qgc2V0
CiMgQ09ORklHX0RSTV9RWEwgaXMgbm90IHNldAojIENPTkZJR19EUk1fQk9DSFMgaXMgbm90
IHNldAoKIwojIEZyYW1lIGJ1ZmZlciBEZXZpY2VzCiMKQ09ORklHX0ZCPXkKIyBDT05GSUdf
RklSTVdBUkVfRURJRCBpcyBub3Qgc2V0CkNPTkZJR19GQl9DTURMSU5FPXkKIyBDT05GSUdf
RkJfRERDIGlzIG5vdCBzZXQKIyBDT05GSUdfRkJfQk9PVF9WRVNBX1NVUFBPUlQgaXMgbm90
IHNldApDT05GSUdfRkJfQ0ZCX0ZJTExSRUNUPXkKQ09ORklHX0ZCX0NGQl9DT1BZQVJFQT15
CkNPTkZJR19GQl9DRkJfSU1BR0VCTElUPXkKIyBDT05GSUdfRkJfQ0ZCX1JFVl9QSVhFTFNf
SU5fQllURSBpcyBub3Qgc2V0CiMgQ09ORklHX0ZCX1NZU19GSUxMUkVDVCBpcyBub3Qgc2V0
CiMgQ09ORklHX0ZCX1NZU19DT1BZQVJFQSBpcyBub3Qgc2V0CiMgQ09ORklHX0ZCX1NZU19J
TUFHRUJMSVQgaXMgbm90IHNldAojIENPTkZJR19GQl9GT1JFSUdOX0VORElBTiBpcyBub3Qg
c2V0CiMgQ09ORklHX0ZCX1NZU19GT1BTIGlzIG5vdCBzZXQKIyBDT05GSUdfRkJfU1ZHQUxJ
QiBpcyBub3Qgc2V0CiMgQ09ORklHX0ZCX01BQ01PREVTIGlzIG5vdCBzZXQKIyBDT05GSUdf
RkJfQkFDS0xJR0hUIGlzIG5vdCBzZXQKQ09ORklHX0ZCX01PREVfSEVMUEVSUz15CkNPTkZJ
R19GQl9USUxFQkxJVFRJTkc9eQoKIwojIEZyYW1lIGJ1ZmZlciBoYXJkd2FyZSBkcml2ZXJz
CiMKIyBDT05GSUdfRkJfQ0lSUlVTIGlzIG5vdCBzZXQKIyBDT05GSUdfRkJfUE0yIGlzIG5v
dCBzZXQKIyBDT05GSUdfRkJfQ1lCRVIyMDAwIGlzIG5vdCBzZXQKIyBDT05GSUdfRkJfT0Yg
aXMgbm90IHNldAojIENPTkZJR19GQl9DVDY1NTUwIGlzIG5vdCBzZXQKIyBDT05GSUdfRkJf
QVNJTElBTlQgaXMgbm90IHNldAojIENPTkZJR19GQl9JTVNUVCBpcyBub3Qgc2V0CiMgQ09O
RklHX0ZCX1ZHQTE2IGlzIG5vdCBzZXQKIyBDT05GSUdfRkJfT1BFTkNPUkVTIGlzIG5vdCBz
ZXQKIyBDT05GSUdfRkJfUzFEMTNYWFggaXMgbm90IHNldAojIENPTkZJR19GQl9OVklESUEg
aXMgbm90IHNldAojIENPTkZJR19GQl9SSVZBIGlzIG5vdCBzZXQKIyBDT05GSUdfRkJfSTc0
MCBpcyBub3Qgc2V0CiMgQ09ORklHX0ZCX01BVFJPWCBpcyBub3Qgc2V0CiMgQ09ORklHX0ZC
X1JBREVPTiBpcyBub3Qgc2V0CiMgQ09ORklHX0ZCX0FUWTEyOCBpcyBub3Qgc2V0CiMgQ09O
RklHX0ZCX0FUWSBpcyBub3Qgc2V0CiMgQ09ORklHX0ZCX1MzIGlzIG5vdCBzZXQKIyBDT05G
SUdfRkJfU0FWQUdFIGlzIG5vdCBzZXQKIyBDT05GSUdfRkJfU0lTIGlzIG5vdCBzZXQKIyBD
T05GSUdfRkJfTkVPTUFHSUMgaXMgbm90IHNldAojIENPTkZJR19GQl9LWVJPIGlzIG5vdCBz
ZXQKIyBDT05GSUdfRkJfM0RGWCBpcyBub3Qgc2V0CiMgQ09ORklHX0ZCX1ZPT0RPTzEgaXMg
bm90IHNldAojIENPTkZJR19GQl9WVDg2MjMgaXMgbm90IHNldAojIENPTkZJR19GQl9UUklE
RU5UIGlzIG5vdCBzZXQKIyBDT05GSUdfRkJfQVJLIGlzIG5vdCBzZXQKIyBDT05GSUdfRkJf
UE0zIGlzIG5vdCBzZXQKIyBDT05GSUdfRkJfQ0FSTUlORSBpcyBub3Qgc2V0CiMgQ09ORklH
X0ZCX0ZTTF9ESVUgaXMgbm90IHNldAojIENPTkZJR19GQl9TTVNDVUZYIGlzIG5vdCBzZXQK
IyBDT05GSUdfRkJfVURMIGlzIG5vdCBzZXQKIyBDT05GSUdfRkJfSUJNX0dYVDQ1MDAgaXMg
bm90IHNldAojIENPTkZJR19GQl9WSVJUVUFMIGlzIG5vdCBzZXQKIyBDT05GSUdfRkJfTUVU
Uk9OT01FIGlzIG5vdCBzZXQKIyBDT05GSUdfRkJfTUI4NjJYWCBpcyBub3Qgc2V0CiMgQ09O
RklHX0ZCX0JST0FEU0hFRVQgaXMgbm90IHNldAojIENPTkZJR19GQl9BVU9fSzE5MFggaXMg
bm90IHNldAojIENPTkZJR19GQl9TSU1QTEUgaXMgbm90IHNldAojIENPTkZJR19GQl9TU0Qx
MzA3IGlzIG5vdCBzZXQKQ09ORklHX0JBQ0tMSUdIVF9MQ0RfU1VQUE9SVD15CkNPTkZJR19M
Q0RfQ0xBU1NfREVWSUNFPXkKIyBDT05GSUdfTENEX1BMQVRGT1JNIGlzIG5vdCBzZXQKQ09O
RklHX0JBQ0tMSUdIVF9DTEFTU19ERVZJQ0U9eQpDT05GSUdfQkFDS0xJR0hUX0dFTkVSSUM9
eQojIENPTkZJR19CQUNLTElHSFRfQURQODg2MCBpcyBub3Qgc2V0CiMgQ09ORklHX0JBQ0tM
SUdIVF9BRFA4ODcwIGlzIG5vdCBzZXQKIyBDT05GSUdfQkFDS0xJR0hUX0xNMzYzOSBpcyBu
b3Qgc2V0CiMgQ09ORklHX0JBQ0tMSUdIVF9HUElPIGlzIG5vdCBzZXQKIyBDT05GSUdfQkFD
S0xJR0hUX0xWNTIwN0xQIGlzIG5vdCBzZXQKIyBDT05GSUdfQkFDS0xJR0hUX0JENjEwNyBp
cyBub3Qgc2V0CiMgQ09ORklHX1ZHQVNUQVRFIGlzIG5vdCBzZXQKQ09ORklHX0hETUk9eQoK
IwojIENvbnNvbGUgZGlzcGxheSBkcml2ZXIgc3VwcG9ydAojCkNPTkZJR19WR0FfQ09OU09M
RT15CiMgQ09ORklHX1ZHQUNPTl9TT0ZUX1NDUk9MTEJBQ0sgaXMgbm90IHNldApDT05GSUdf
RFVNTVlfQ09OU09MRT15CkNPTkZJR19EVU1NWV9DT05TT0xFX0NPTFVNTlM9ODAKQ09ORklH
X0RVTU1ZX0NPTlNPTEVfUk9XUz0yNQpDT05GSUdfRlJBTUVCVUZGRVJfQ09OU09MRT15CkNP
TkZJR19GUkFNRUJVRkZFUl9DT05TT0xFX0RFVEVDVF9QUklNQVJZPXkKIyBDT05GSUdfRlJB
TUVCVUZGRVJfQ09OU09MRV9ST1RBVElPTiBpcyBub3Qgc2V0CkNPTkZJR19MT0dPPXkKQ09O
RklHX0xPR09fTElOVVhfTU9OTz15CkNPTkZJR19MT0dPX0xJTlVYX1ZHQTE2PXkKQ09ORklH
X0xPR09fTElOVVhfQ0xVVDIyND15CkNPTkZJR19TT1VORD15CkNPTkZJR19TT1VORF9PU1Nf
Q09SRT15CkNPTkZJR19TT1VORF9PU1NfQ09SRV9QUkVDTEFJTT15CkNPTkZJR19TTkQ9eQpD
T05GSUdfU05EX1RJTUVSPXkKQ09ORklHX1NORF9QQ009eQpDT05GSUdfU05EX0hXREVQPXkK
Q09ORklHX1NORF9SQVdNSURJPXkKQ09ORklHX1NORF9DT01QUkVTU19PRkZMT0FEPXkKQ09O
RklHX1NORF9KQUNLPXkKQ09ORklHX1NORF9TRVFVRU5DRVI9eQojIENPTkZJR19TTkRfU0VR
X0RVTU1ZIGlzIG5vdCBzZXQKQ09ORklHX1NORF9PU1NFTVVMPXkKQ09ORklHX1NORF9NSVhF
Ul9PU1M9eQpDT05GSUdfU05EX1BDTV9PU1M9eQpDT05GSUdfU05EX1BDTV9PU1NfUExVR0lO
Uz15CkNPTkZJR19TTkRfU0VRVUVOQ0VSX09TUz15CiMgQ09ORklHX1NORF9IUlRJTUVSIGlz
IG5vdCBzZXQKQ09ORklHX1NORF9EWU5BTUlDX01JTk9SUz15CkNPTkZJR19TTkRfTUFYX0NB
UkRTPTMyCiMgQ09ORklHX1NORF9TVVBQT1JUX09MRF9BUEkgaXMgbm90IHNldApDT05GSUdf
U05EX1ZFUkJPU0VfUFJPQ0ZTPXkKQ09ORklHX1NORF9WRVJCT1NFX1BSSU5USz15CkNPTkZJ
R19TTkRfREVCVUc9eQpDT05GSUdfU05EX0RFQlVHX1ZFUkJPU0U9eQojIENPTkZJR19TTkRf
UENNX1hSVU5fREVCVUcgaXMgbm90IHNldApDT05GSUdfU05EX1ZNQVNURVI9eQpDT05GSUdf
U05EX0tDVExfSkFDSz15CkNPTkZJR19TTkRfUkFXTUlESV9TRVE9eQojIENPTkZJR19TTkRf
T1BMM19MSUJfU0VRIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX09QTDRfTElCX1NFUSBpcyBu
b3Qgc2V0CiMgQ09ORklHX1NORF9TQkFXRV9TRVEgaXMgbm90IHNldAojIENPTkZJR19TTkRf
RU1VMTBLMV9TRVEgaXMgbm90IHNldApDT05GSUdfU05EX0RSSVZFUlM9eQojIENPTkZJR19T
TkRfRFVNTVkgaXMgbm90IHNldAojIENPTkZJR19TTkRfQUxPT1AgaXMgbm90IHNldApDT05G
SUdfU05EX1ZJUk1JREk9eQojIENPTkZJR19TTkRfTVRQQVYgaXMgbm90IHNldAojIENPTkZJ
R19TTkRfU0VSSUFMX1UxNjU1MCBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9NUFU0MDEgaXMg
bm90IHNldApDT05GSUdfU05EX1BDST15CiMgQ09ORklHX1NORF9BRDE4ODkgaXMgbm90IHNl
dAojIENPTkZJR19TTkRfQUxTMzAwIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX0FMUzQwMDAg
aXMgbm90IHNldAojIENPTkZJR19TTkRfQUxJNTQ1MSBpcyBub3Qgc2V0CiMgQ09ORklHX1NO
RF9BVElJWFAgaXMgbm90IHNldAojIENPTkZJR19TTkRfQVRJSVhQX01PREVNIGlzIG5vdCBz
ZXQKIyBDT05GSUdfU05EX0FVODgxMCBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9BVTg4MjAg
aXMgbm90IHNldAojIENPTkZJR19TTkRfQVU4ODMwIGlzIG5vdCBzZXQKIyBDT05GSUdfU05E
X0FXMiBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9BWlQzMzI4IGlzIG5vdCBzZXQKIyBDT05G
SUdfU05EX0JUODdYIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX0NBMDEwNiBpcyBub3Qgc2V0
CiMgQ09ORklHX1NORF9DTUlQQ0kgaXMgbm90IHNldAojIENPTkZJR19TTkRfT1hZR0VOIGlz
IG5vdCBzZXQKIyBDT05GSUdfU05EX0NTNDI4MSBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9D
UzQ2WFggaXMgbm90IHNldAojIENPTkZJR19TTkRfQ1RYRkkgaXMgbm90IHNldAojIENPTkZJ
R19TTkRfREFSTEEyMCBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9HSU5BMjAgaXMgbm90IHNl
dAojIENPTkZJR19TTkRfTEFZTEEyMCBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9EQVJMQTI0
IGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX0dJTkEyNCBpcyBub3Qgc2V0CiMgQ09ORklHX1NO
RF9MQVlMQTI0IGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX01PTkEgaXMgbm90IHNldAojIENP
TkZJR19TTkRfTUlBIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX0VDSE8zRyBpcyBub3Qgc2V0
CiMgQ09ORklHX1NORF9JTkRJR08gaXMgbm90IHNldAojIENPTkZJR19TTkRfSU5ESUdPSU8g
aXMgbm90IHNldAojIENPTkZJR19TTkRfSU5ESUdPREogaXMgbm90IHNldAojIENPTkZJR19T
TkRfSU5ESUdPSU9YIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX0lORElHT0RKWCBpcyBub3Qg
c2V0CiMgQ09ORklHX1NORF9FTVUxMEsxIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX0VNVTEw
SzFYIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX0VOUzEzNzAgaXMgbm90IHNldAojIENPTkZJ
R19TTkRfRU5TMTM3MSBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9FUzE5MzggaXMgbm90IHNl
dAojIENPTkZJR19TTkRfRVMxOTY4IGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX0ZNODAxIGlz
IG5vdCBzZXQKIyBDT05GSUdfU05EX0hEU1AgaXMgbm90IHNldAojIENPTkZJR19TTkRfSERT
UE0gaXMgbm90IHNldAojIENPTkZJR19TTkRfSUNFMTcxMiBpcyBub3Qgc2V0CiMgQ09ORklH
X1NORF9JQ0UxNzI0IGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX0lOVEVMOFgwIGlzIG5vdCBz
ZXQKIyBDT05GSUdfU05EX0lOVEVMOFgwTSBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9LT1JH
MTIxMiBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9MT0xBIGlzIG5vdCBzZXQKIyBDT05GSUdf
U05EX0xYNjQ2NEVTIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX01BRVNUUk8zIGlzIG5vdCBz
ZXQKIyBDT05GSUdfU05EX01JWEFSVCBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9OTTI1NiBp
cyBub3Qgc2V0CiMgQ09ORklHX1NORF9QQ1hIUiBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9S
SVBUSURFIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX1JNRTMyIGlzIG5vdCBzZXQKIyBDT05G
SUdfU05EX1JNRTk2IGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX1JNRTk2NTIgaXMgbm90IHNl
dAojIENPTkZJR19TTkRfU0U2WCBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9TT05JQ1ZJQkVT
IGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX1RSSURFTlQgaXMgbm90IHNldAojIENPTkZJR19T
TkRfVklBODJYWCBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9WSUE4MlhYX01PREVNIGlzIG5v
dCBzZXQKIyBDT05GSUdfU05EX1ZJUlRVT1NPIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX1ZY
MjIyIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX1lNRlBDSSBpcyBub3Qgc2V0CgojCiMgSEQt
QXVkaW8KIwpDT05GSUdfU05EX0hEQT15CkNPTkZJR19TTkRfSERBX0lOVEVMPXkKQ09ORklH
X1NORF9IREFfUFJFQUxMT0NfU0laRT02NAojIENPTkZJR19TTkRfSERBX0hXREVQIGlzIG5v
dCBzZXQKQ09ORklHX1NORF9IREFfUkVDT05GSUc9eQpDT05GSUdfU05EX0hEQV9JTlBVVF9C
RUVQPXkKQ09ORklHX1NORF9IREFfSU5QVVRfQkVFUF9NT0RFPTEKQ09ORklHX1NORF9IREFf
SU5QVVRfSkFDSz15CiMgQ09ORklHX1NORF9IREFfUEFUQ0hfTE9BREVSIGlzIG5vdCBzZXQK
IyBDT05GSUdfU05EX0hEQV9DT0RFQ19SRUFMVEVLIGlzIG5vdCBzZXQKIyBDT05GSUdfU05E
X0hEQV9DT0RFQ19BTkFMT0cgaXMgbm90IHNldAojIENPTkZJR19TTkRfSERBX0NPREVDX1NJ
R01BVEVMIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX0hEQV9DT0RFQ19WSUEgaXMgbm90IHNl
dApDT05GSUdfU05EX0hEQV9DT0RFQ19IRE1JPXkKIyBDT05GSUdfU05EX0hEQV9DT0RFQ19D
SVJSVVMgaXMgbm90IHNldAojIENPTkZJR19TTkRfSERBX0NPREVDX0NPTkVYQU5UIGlzIG5v
dCBzZXQKIyBDT05GSUdfU05EX0hEQV9DT0RFQ19DQTAxMTAgaXMgbm90IHNldAojIENPTkZJ
R19TTkRfSERBX0NPREVDX0NBMDEzMiBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9IREFfQ09E
RUNfQ01FRElBIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX0hEQV9DT0RFQ19TSTMwNTQgaXMg
bm90IHNldApDT05GSUdfU05EX0hEQV9HRU5FUklDPXkKQ09ORklHX1NORF9IREFfQ09SRT15
CkNPTkZJR19TTkRfUFBDPXkKQ09ORklHX1NORF9VU0I9eQpDT05GSUdfU05EX1VTQl9BVURJ
Tz15CkNPTkZJR19TTkRfVVNCX1VBMTAxPXkKQ09ORklHX1NORF9VU0JfVVNYMlk9eQpDT05G
SUdfU05EX1VTQl9DQUlBUT1tCkNPTkZJR19TTkRfVVNCX0NBSUFRX0lOUFVUPXkKQ09ORklH
X1NORF9VU0JfNkZJUkU9bQpDT05GSUdfU05EX1VTQl9ISUZBQ0U9bQojIENPTkZJR19TTkRf
QkNEMjAwMCBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9VU0JfUE9EIGlzIG5vdCBzZXQKIyBD
T05GSUdfU05EX1VTQl9QT0RIRCBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9VU0JfVE9ORVBP
UlQgaXMgbm90IHNldAojIENPTkZJR19TTkRfVVNCX1ZBUklBWCBpcyBub3Qgc2V0CkNPTkZJ
R19TTkRfU09DPXkKIyBDT05GSUdfU05EX0FUTUVMX1NPQyBpcyBub3Qgc2V0CgojCiMgU29D
IEF1ZGlvIGZvciBGcmVlc2NhbGUgQ1BVcwojCgojCiMgQ29tbW9uIFNvQyBBdWRpbyBvcHRp
b25zIGZvciBGcmVlc2NhbGUgQ1BVczoKIwojIENPTkZJR19TTkRfU09DX0ZTTF9BU1JDIGlz
IG5vdCBzZXQKIyBDT05GSUdfU05EX1NPQ19GU0xfU0FJIGlzIG5vdCBzZXQKQ09ORklHX1NO
RF9TT0NfRlNMX1NTST15CiMgQ09ORklHX1NORF9TT0NfRlNMX1NQRElGIGlzIG5vdCBzZXQK
IyBDT05GSUdfU05EX1NPQ19GU0xfRVNBSSBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9TT0Nf
SU1YX0FVRE1VWCBpcyBub3Qgc2V0CkNPTkZJR19TTkRfUE9XRVJQQ19TT0M9eQoKIwojIFNv
QyBBdWRpbyBzdXBwb3J0IGZvciBGcmVlc2NhbGUgUFBDIGJvYXJkczoKIwojIENPTkZJR19T
TkRfU09DX1FDT00gaXMgbm90IHNldAojIENPTkZJR19TTkRfU09DX1hURlBHQV9JMlMgaXMg
bm90IHNldApDT05GSUdfU05EX1NPQ19JMkNfQU5EX1NQST15CgojCiMgQ09ERUMgZHJpdmVy
cwojCiMgQ09ORklHX1NORF9TT0NfQURBVTE3MDEgaXMgbm90IHNldAojIENPTkZJR19TTkRf
U09DX0FLNDU1NCBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9TT0NfQUs0NjQyIGlzIG5vdCBz
ZXQKIyBDT05GSUdfU05EX1NPQ19BSzUzODYgaXMgbm90IHNldAojIENPTkZJR19TTkRfU09D
X0FMQzU2MjMgaXMgbm90IHNldAojIENPTkZJR19TTkRfU09DX0NTMzVMMzIgaXMgbm90IHNl
dAojIENPTkZJR19TTkRfU09DX0NTNDJMNTFfSTJDIGlzIG5vdCBzZXQKIyBDT05GSUdfU05E
X1NPQ19DUzQyTDUyIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX1NPQ19DUzQyTDU2IGlzIG5v
dCBzZXQKIyBDT05GSUdfU05EX1NPQ19DUzQyTDczIGlzIG5vdCBzZXQKIyBDT05GSUdfU05E
X1NPQ19DUzQyNjUgaXMgbm90IHNldAojIENPTkZJR19TTkRfU09DX0NTNDI3MCBpcyBub3Qg
c2V0CiMgQ09ORklHX1NORF9TT0NfQ1M0MjcxX0kyQyBpcyBub3Qgc2V0CiMgQ09ORklHX1NO
RF9TT0NfQ1M0MlhYOF9JMkMgaXMgbm90IHNldAojIENPTkZJR19TTkRfU09DX0hETUlfQ09E
RUMgaXMgbm90IHNldAojIENPTkZJR19TTkRfU09DX0VTODMyOCBpcyBub3Qgc2V0CiMgQ09O
RklHX1NORF9TT0NfUENNMTY4MSBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9TT0NfUENNNTEy
eF9JMkMgaXMgbm90IHNldAojIENPTkZJR19TTkRfU09DX1JUNTYzMSBpcyBub3Qgc2V0CiMg
Q09ORklHX1NORF9TT0NfUlQ1Njc3X1NQSSBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9TT0Nf
U0dUTDUwMDAgaXMgbm90IHNldAojIENPTkZJR19TTkRfU09DX1NJUkZfQVVESU9fQ09ERUMg
aXMgbm90IHNldAojIENPTkZJR19TTkRfU09DX1NQRElGIGlzIG5vdCBzZXQKIyBDT05GSUdf
U05EX1NPQ19TU00yNjAyX0kyQyBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9TT0NfU1NNNDU2
NyBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9TT0NfU1RBMzJYIGlzIG5vdCBzZXQKIyBDT05G
SUdfU05EX1NPQ19TVEEzNTAgaXMgbm90IHNldAojIENPTkZJR19TTkRfU09DX1RBUzI1NTIg
aXMgbm90IHNldAojIENPTkZJR19TTkRfU09DX1RBUzUwODYgaXMgbm90IHNldAojIENPTkZJ
R19TTkRfU09DX1RGQTk4NzkgaXMgbm90IHNldAojIENPTkZJR19TTkRfU09DX1RMVjMyMEFJ
QzIzX0kyQyBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9TT0NfVExWMzIwQUlDMzFYWCBpcyBu
b3Qgc2V0CiMgQ09ORklHX1NORF9TT0NfVExWMzIwQUlDM1ggaXMgbm90IHNldAojIENPTkZJ
R19TTkRfU09DX1RTM0EyMjdFIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX1NPQ19XTTg1MTAg
aXMgbm90IHNldAojIENPTkZJR19TTkRfU09DX1dNODUyMyBpcyBub3Qgc2V0CiMgQ09ORklH
X1NORF9TT0NfV004NTgwIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX1NPQ19XTTg3MTEgaXMg
bm90IHNldAojIENPTkZJR19TTkRfU09DX1dNODcyOCBpcyBub3Qgc2V0CiMgQ09ORklHX1NO
RF9TT0NfV004NzMxIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX1NPQ19XTTg3MzcgaXMgbm90
IHNldAojIENPTkZJR19TTkRfU09DX1dNODc0MSBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9T
T0NfV004NzUwIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX1NPQ19XTTg3NTMgaXMgbm90IHNl
dApDT05GSUdfU05EX1NPQ19XTTg3NzY9eQojIENPTkZJR19TTkRfU09DX1dNODgwNF9JMkMg
aXMgbm90IHNldAojIENPTkZJR19TTkRfU09DX1dNODkwMyBpcyBub3Qgc2V0CiMgQ09ORklH
X1NORF9TT0NfV004OTYyIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX1NPQ19XTTg5NzggaXMg
bm90IHNldAojIENPTkZJR19TTkRfU09DX1RQQTYxMzBBMiBpcyBub3Qgc2V0CiMgQ09ORklH
X1NORF9TSU1QTEVfQ0FSRCBpcyBub3Qgc2V0CiMgQ09ORklHX1NPVU5EX1BSSU1FIGlzIG5v
dCBzZXQKCiMKIyBISUQgc3VwcG9ydAojCkNPTkZJR19ISUQ9eQpDT05GSUdfSElEX0JBVFRF
UllfU1RSRU5HVEg9eQpDT05GSUdfSElEUkFXPXkKIyBDT05GSUdfVUhJRCBpcyBub3Qgc2V0
CkNPTkZJR19ISURfR0VORVJJQz15CgojCiMgU3BlY2lhbCBISUQgZHJpdmVycwojCkNPTkZJ
R19ISURfQTRURUNIPXkKIyBDT05GSUdfSElEX0FDUlVYIGlzIG5vdCBzZXQKQ09ORklHX0hJ
RF9BUFBMRT15CiMgQ09ORklHX0hJRF9BUFBMRUlSIGlzIG5vdCBzZXQKIyBDT05GSUdfSElE
X0FVUkVBTCBpcyBub3Qgc2V0CkNPTkZJR19ISURfQkVMS0lOPXkKIyBDT05GSUdfSElEX0JF
VE9QX0ZGIGlzIG5vdCBzZXQKQ09ORklHX0hJRF9DSEVSUlk9eQpDT05GSUdfSElEX0NISUNP
Tlk9eQojIENPTkZJR19ISURfUFJPRElLRVlTIGlzIG5vdCBzZXQKIyBDT05GSUdfSElEX0NQ
MjExMiBpcyBub3Qgc2V0CkNPTkZJR19ISURfQ1lQUkVTUz15CiMgQ09ORklHX0hJRF9EUkFH
T05SSVNFIGlzIG5vdCBzZXQKIyBDT05GSUdfSElEX0VNU19GRiBpcyBub3Qgc2V0CiMgQ09O
RklHX0hJRF9FTEVDT00gaXMgbm90IHNldAojIENPTkZJR19ISURfRUxPIGlzIG5vdCBzZXQK
Q09ORklHX0hJRF9FWktFWT15CiMgQ09ORklHX0hJRF9IT0xURUsgaXMgbm90IHNldAojIENP
TkZJR19ISURfR1Q2ODNSIGlzIG5vdCBzZXQKIyBDT05GSUdfSElEX0tFWVRPVUNIIGlzIG5v
dCBzZXQKIyBDT05GSUdfSElEX0tZRSBpcyBub3Qgc2V0CiMgQ09ORklHX0hJRF9VQ0xPR0lD
IGlzIG5vdCBzZXQKIyBDT05GSUdfSElEX1dBTFRPUCBpcyBub3Qgc2V0CiMgQ09ORklHX0hJ
RF9HWVJBVElPTiBpcyBub3Qgc2V0CiMgQ09ORklHX0hJRF9JQ0FERSBpcyBub3Qgc2V0CiMg
Q09ORklHX0hJRF9UV0lOSEFOIGlzIG5vdCBzZXQKQ09ORklHX0hJRF9LRU5TSU5HVE9OPXkK
IyBDT05GSUdfSElEX0xDUE9XRVIgaXMgbm90IHNldAojIENPTkZJR19ISURfTEVOT1ZPIGlz
IG5vdCBzZXQKQ09ORklHX0hJRF9MT0dJVEVDSD15CiMgQ09ORklHX0hJRF9MT0dJVEVDSF9E
SiBpcyBub3Qgc2V0CiMgQ09ORklHX0hJRF9MT0dJVEVDSF9ISURQUCBpcyBub3Qgc2V0CiMg
Q09ORklHX0xPR0lURUNIX0ZGIGlzIG5vdCBzZXQKIyBDT05GSUdfTE9HSVJVTUJMRVBBRDJf
RkYgaXMgbm90IHNldAojIENPTkZJR19MT0dJRzk0MF9GRiBpcyBub3Qgc2V0CiMgQ09ORklH
X0xPR0lXSEVFTFNfRkYgaXMgbm90IHNldAojIENPTkZJR19ISURfTUFHSUNNT1VTRSBpcyBu
b3Qgc2V0CkNPTkZJR19ISURfTUlDUk9TT0ZUPXkKQ09ORklHX0hJRF9NT05URVJFWT15CiMg
Q09ORklHX0hJRF9NVUxUSVRPVUNIIGlzIG5vdCBzZXQKIyBDT05GSUdfSElEX05UUklHIGlz
IG5vdCBzZXQKIyBDT05GSUdfSElEX09SVEVLIGlzIG5vdCBzZXQKIyBDT05GSUdfSElEX1BB
TlRIRVJMT1JEIGlzIG5vdCBzZXQKIyBDT05GSUdfSElEX1BFTk1PVU5UIGlzIG5vdCBzZXQK
IyBDT05GSUdfSElEX1BFVEFMWU5YIGlzIG5vdCBzZXQKIyBDT05GSUdfSElEX1BJQ09MQ0Qg
aXMgbm90IHNldAojIENPTkZJR19ISURfUExBTlRST05JQ1MgaXMgbm90IHNldAojIENPTkZJ
R19ISURfUFJJTUFYIGlzIG5vdCBzZXQKIyBDT05GSUdfSElEX1JPQ0NBVCBpcyBub3Qgc2V0
CiMgQ09ORklHX0hJRF9TQUlURUsgaXMgbm90IHNldAojIENPTkZJR19ISURfU0FNU1VORyBp
cyBub3Qgc2V0CiMgQ09ORklHX0hJRF9TT05ZIGlzIG5vdCBzZXQKIyBDT05GSUdfSElEX1NQ
RUVETElOSyBpcyBub3Qgc2V0CiMgQ09ORklHX0hJRF9TVEVFTFNFUklFUyBpcyBub3Qgc2V0
CiMgQ09ORklHX0hJRF9TVU5QTFVTIGlzIG5vdCBzZXQKIyBDT05GSUdfSElEX1JNSSBpcyBu
b3Qgc2V0CiMgQ09ORklHX0hJRF9HUkVFTkFTSUEgaXMgbm90IHNldAojIENPTkZJR19ISURf
U01BUlRKT1lQTFVTIGlzIG5vdCBzZXQKIyBDT05GSUdfSElEX1RJVk8gaXMgbm90IHNldAoj
IENPTkZJR19ISURfVE9QU0VFRCBpcyBub3Qgc2V0CiMgQ09ORklHX0hJRF9USElOR00gaXMg
bm90IHNldAojIENPTkZJR19ISURfVEhSVVNUTUFTVEVSIGlzIG5vdCBzZXQKIyBDT05GSUdf
SElEX1dBQ09NIGlzIG5vdCBzZXQKIyBDT05GSUdfSElEX1dJSU1PVEUgaXMgbm90IHNldAoj
IENPTkZJR19ISURfWElOTU8gaXMgbm90IHNldAojIENPTkZJR19ISURfWkVST1BMVVMgaXMg
bm90IHNldAojIENPTkZJR19ISURfWllEQUNST04gaXMgbm90IHNldAojIENPTkZJR19ISURf
U0VOU09SX0hVQiBpcyBub3Qgc2V0CgojCiMgVVNCIEhJRCBzdXBwb3J0CiMKQ09ORklHX1VT
Ql9ISUQ9eQojIENPTkZJR19ISURfUElEIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX0hJRERF
ViBpcyBub3Qgc2V0CgojCiMgSTJDIEhJRCBzdXBwb3J0CiMKIyBDT05GSUdfSTJDX0hJRCBp
cyBub3Qgc2V0CkNPTkZJR19VU0JfT0hDSV9CSUdfRU5ESUFOX0RFU0M9eQpDT05GSUdfVVNC
X09IQ0lfQklHX0VORElBTl9NTUlPPXkKQ09ORklHX1VTQl9PSENJX0xJVFRMRV9FTkRJQU49
eQpDT05GSUdfVVNCX1NVUFBPUlQ9eQpDT05GSUdfVVNCX0NPTU1PTj15CkNPTkZJR19VU0Jf
QVJDSF9IQVNfSENEPXkKQ09ORklHX1VTQj15CkNPTkZJR19VU0JfQU5OT1VOQ0VfTkVXX0RF
VklDRVM9eQoKIwojIE1pc2NlbGxhbmVvdXMgVVNCIG9wdGlvbnMKIwpDT05GSUdfVVNCX0RF
RkFVTFRfUEVSU0lTVD15CkNPTkZJR19VU0JfRFlOQU1JQ19NSU5PUlM9eQojIENPTkZJR19V
U0JfT1RHX1dISVRFTElTVCBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9PVEdfQkxBQ0tMSVNU
X0hVQiBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9PVEdfRlNNIGlzIG5vdCBzZXQKQ09ORklH
X1VTQl9NT049eQojIENPTkZJR19VU0JfV1VTQl9DQkFGIGlzIG5vdCBzZXQKCiMKIyBVU0Ig
SG9zdCBDb250cm9sbGVyIERyaXZlcnMKIwojIENPTkZJR19VU0JfQzY3WDAwX0hDRCBpcyBu
b3Qgc2V0CkNPTkZJR19VU0JfWEhDSV9IQ0Q9eQpDT05GSUdfVVNCX1hIQ0lfUENJPXkKQ09O
RklHX1VTQl9FSENJX0hDRD15CkNPTkZJR19VU0JfRUhDSV9ST09UX0hVQl9UVD15CkNPTkZJ
R19VU0JfRUhDSV9UVF9ORVdTQ0hFRD15CkNPTkZJR19VU0JfRlNMX01QSF9EUl9PRj15CkNP
TkZJR19VU0JfRUhDSV9QQ0k9eQojIENPTkZJR19YUFNfVVNCX0hDRF9YSUxJTlggaXMgbm90
IHNldApDT05GSUdfVVNCX0VIQ0lfRlNMPXkKQ09ORklHX1VTQl9FSENJX0hDRF9QUENfT0Y9
eQojIENPTkZJR19VU0JfRUhDSV9IQ0RfUExBVEZPUk0gaXMgbm90IHNldAojIENPTkZJR19V
U0JfT1hVMjEwSFBfSENEIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX0lTUDExNlhfSENEIGlz
IG5vdCBzZXQKIyBDT05GSUdfVVNCX0lTUDEzNjJfSENEIGlzIG5vdCBzZXQKIyBDT05GSUdf
VVNCX0ZVU0JIMjAwX0hDRCBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9GT1RHMjEwX0hDRCBp
cyBub3Qgc2V0CkNPTkZJR19VU0JfT0hDSV9IQ0Q9eQpDT05GSUdfVVNCX09IQ0lfSENEX1BQ
Q19PRl9CRT15CkNPTkZJR19VU0JfT0hDSV9IQ0RfUFBDX09GX0xFPXkKQ09ORklHX1VTQl9P
SENJX0hDRF9QUENfT0Y9eQpDT05GSUdfVVNCX09IQ0lfSENEX1BDST15CiMgQ09ORklHX1VT
Ql9PSENJX0hDRF9QTEFURk9STSBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9VSENJX0hDRCBp
cyBub3Qgc2V0CiMgQ09ORklHX1VTQl9GSENJX0hDRCBpcyBub3Qgc2V0CiMgQ09ORklHX1VT
Ql9TTDgxMV9IQ0QgaXMgbm90IHNldAojIENPTkZJR19VU0JfUjhBNjY1OTdfSENEIGlzIG5v
dCBzZXQKIyBDT05GSUdfVVNCX0hDRF9CQ01BIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX0hD
RF9TU0IgaXMgbm90IHNldAojIENPTkZJR19VU0JfSENEX1RFU1RfTU9ERSBpcyBub3Qgc2V0
CgojCiMgVVNCIERldmljZSBDbGFzcyBkcml2ZXJzCiMKQ09ORklHX1VTQl9BQ009bQpDT05G
SUdfVVNCX1BSSU5URVI9eQpDT05GSUdfVVNCX1dETT1tCiMgQ09ORklHX1VTQl9UTUMgaXMg
bm90IHNldAoKIwojIE5PVEU6IFVTQl9TVE9SQUdFIGRlcGVuZHMgb24gU0NTSSBidXQgQkxL
X0RFVl9TRCBtYXkKIwoKIwojIGFsc28gYmUgbmVlZGVkOyBzZWUgVVNCX1NUT1JBR0UgSGVs
cCBmb3IgbW9yZSBpbmZvCiMKQ09ORklHX1VTQl9TVE9SQUdFPXkKIyBDT05GSUdfVVNCX1NU
T1JBR0VfREVCVUcgaXMgbm90IHNldAojIENPTkZJR19VU0JfU1RPUkFHRV9SRUFMVEVLIGlz
IG5vdCBzZXQKIyBDT05GSUdfVVNCX1NUT1JBR0VfREFUQUZBQiBpcyBub3Qgc2V0CiMgQ09O
RklHX1VTQl9TVE9SQUdFX0ZSRUVDT00gaXMgbm90IHNldAojIENPTkZJR19VU0JfU1RPUkFH
RV9JU0QyMDAgaXMgbm90IHNldAojIENPTkZJR19VU0JfU1RPUkFHRV9VU0JBVCBpcyBub3Qg
c2V0CiMgQ09ORklHX1VTQl9TVE9SQUdFX1NERFIwOSBpcyBub3Qgc2V0CiMgQ09ORklHX1VT
Ql9TVE9SQUdFX1NERFI1NSBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9TVE9SQUdFX0pVTVBT
SE9UIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1NUT1JBR0VfQUxBVURBIGlzIG5vdCBzZXQK
IyBDT05GSUdfVVNCX1NUT1JBR0VfT05FVE9VQ0ggaXMgbm90IHNldAojIENPTkZJR19VU0Jf
U1RPUkFHRV9LQVJNQSBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9TVE9SQUdFX0NZUFJFU1Nf
QVRBQ0IgaXMgbm90IHNldAojIENPTkZJR19VU0JfU1RPUkFHRV9FTkVfVUI2MjUwIGlzIG5v
dCBzZXQKIyBDT05GSUdfVVNCX1VBUyBpcyBub3Qgc2V0CgojCiMgVVNCIEltYWdpbmcgZGV2
aWNlcwojCiMgQ09ORklHX1VTQl9NREM4MDAgaXMgbm90IHNldAojIENPTkZJR19VU0JfTUlD
Uk9URUsgaXMgbm90IHNldAojIENPTkZJR19VU0JJUF9DT1JFIGlzIG5vdCBzZXQKIyBDT05G
SUdfVVNCX01VU0JfSERSQyBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9EV0MzIGlzIG5vdCBz
ZXQKIyBDT05GSUdfVVNCX0RXQzIgaXMgbm90IHNldAojIENPTkZJR19VU0JfQ0hJUElERUEg
aXMgbm90IHNldAojIENPTkZJR19VU0JfSVNQMTc2MCBpcyBub3Qgc2V0CgojCiMgVVNCIHBv
cnQgZHJpdmVycwojCkNPTkZJR19VU0JfU0VSSUFMPXkKQ09ORklHX1VTQl9TRVJJQUxfQ09O
U09MRT15CkNPTkZJR19VU0JfU0VSSUFMX0dFTkVSSUM9eQpDT05GSUdfVVNCX1NFUklBTF9T
SU1QTEU9bQpDT05GSUdfVVNCX1NFUklBTF9BSVJDQUJMRT1tCiMgQ09ORklHX1VTQl9TRVJJ
QUxfQVJLMzExNiBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9TRVJJQUxfQkVMS0lOIGlzIG5v
dCBzZXQKIyBDT05GSUdfVVNCX1NFUklBTF9DSDM0MSBpcyBub3Qgc2V0CiMgQ09ORklHX1VT
Ql9TRVJJQUxfV0hJVEVIRUFUIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1NFUklBTF9ESUdJ
X0FDQ0VMRVBPUlQgaXMgbm90IHNldAojIENPTkZJR19VU0JfU0VSSUFMX0NQMjEwWCBpcyBu
b3Qgc2V0CiMgQ09ORklHX1VTQl9TRVJJQUxfQ1lQUkVTU19NOCBpcyBub3Qgc2V0CiMgQ09O
RklHX1VTQl9TRVJJQUxfRU1QRUcgaXMgbm90IHNldAojIENPTkZJR19VU0JfU0VSSUFMX0ZU
RElfU0lPIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1NFUklBTF9WSVNPUiBpcyBub3Qgc2V0
CiMgQ09ORklHX1VTQl9TRVJJQUxfSVBBUSBpcyBub3Qgc2V0CkNPTkZJR19VU0JfU0VSSUFM
X0lSPW0KIyBDT05GSUdfVVNCX1NFUklBTF9FREdFUE9SVCBpcyBub3Qgc2V0CiMgQ09ORklH
X1VTQl9TRVJJQUxfRURHRVBPUlRfVEkgaXMgbm90IHNldAojIENPTkZJR19VU0JfU0VSSUFM
X0Y4MTIzMiBpcyBub3Qgc2V0CkNPTkZJR19VU0JfU0VSSUFMX0dBUk1JTj1tCiMgQ09ORklH
X1VTQl9TRVJJQUxfSVBXIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1NFUklBTF9JVVUgaXMg
bm90IHNldAojIENPTkZJR19VU0JfU0VSSUFMX0tFWVNQQU5fUERBIGlzIG5vdCBzZXQKIyBD
T05GSUdfVVNCX1NFUklBTF9LRVlTUEFOIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1NFUklB
TF9LTFNJIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1NFUklBTF9LT0JJTF9TQ1QgaXMgbm90
IHNldAojIENPTkZJR19VU0JfU0VSSUFMX01DVF9VMjMyIGlzIG5vdCBzZXQKIyBDT05GSUdf
VVNCX1NFUklBTF9NRVRSTyBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9TRVJJQUxfTU9TNzcy
MCBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9TRVJJQUxfTU9TNzg0MCBpcyBub3Qgc2V0CiMg
Q09ORklHX1VTQl9TRVJJQUxfTVhVUE9SVCBpcyBub3Qgc2V0CkNPTkZJR19VU0JfU0VSSUFM
X05BVk1BTj1tCkNPTkZJR19VU0JfU0VSSUFMX1BMMjMwMz1tCiMgQ09ORklHX1VTQl9TRVJJ
QUxfT1RJNjg1OCBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9TRVJJQUxfUUNBVVggaXMgbm90
IHNldAojIENPTkZJR19VU0JfU0VSSUFMX1FVQUxDT01NIGlzIG5vdCBzZXQKIyBDT05GSUdf
VVNCX1NFUklBTF9TUENQOFg1IGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1NFUklBTF9TQUZF
IGlzIG5vdCBzZXQKQ09ORklHX1VTQl9TRVJJQUxfU0lFUlJBV0lSRUxFU1M9bQojIENPTkZJ
R19VU0JfU0VSSUFMX1NZTUJPTCBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9TRVJJQUxfVEkg
aXMgbm90IHNldAojIENPTkZJR19VU0JfU0VSSUFMX0NZQkVSSkFDSyBpcyBub3Qgc2V0CiMg
Q09ORklHX1VTQl9TRVJJQUxfWElSQ09NIGlzIG5vdCBzZXQKQ09ORklHX1VTQl9TRVJJQUxf
V1dBTj1tCkNPTkZJR19VU0JfU0VSSUFMX09QVElPTj1tCiMgQ09ORklHX1VTQl9TRVJJQUxf
T01OSU5FVCBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9TRVJJQUxfT1BUSUNPTiBpcyBub3Qg
c2V0CiMgQ09ORklHX1VTQl9TRVJJQUxfWFNFTlNfTVQgaXMgbm90IHNldAojIENPTkZJR19V
U0JfU0VSSUFMX1dJU0hCT05FIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1NFUklBTF9TU1Ux
MDAgaXMgbm90IHNldAojIENPTkZJR19VU0JfU0VSSUFMX1FUMiBpcyBub3Qgc2V0CiMgQ09O
RklHX1VTQl9TRVJJQUxfREVCVUcgaXMgbm90IHNldAoKIwojIFVTQiBNaXNjZWxsYW5lb3Vz
IGRyaXZlcnMKIwojIENPTkZJR19VU0JfRU1JNjIgaXMgbm90IHNldAojIENPTkZJR19VU0Jf
RU1JMjYgaXMgbm90IHNldAojIENPTkZJR19VU0JfQURVVFVYIGlzIG5vdCBzZXQKIyBDT05G
SUdfVVNCX1NFVlNFRyBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9SSU81MDAgaXMgbm90IHNl
dAojIENPTkZJR19VU0JfTEVHT1RPV0VSIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX0xDRCBp
cyBub3Qgc2V0CiMgQ09ORklHX1VTQl9MRUQgaXMgbm90IHNldAojIENPTkZJR19VU0JfQ1lQ
UkVTU19DWTdDNjMgaXMgbm90IHNldAojIENPTkZJR19VU0JfQ1lUSEVSTSBpcyBub3Qgc2V0
CiMgQ09ORklHX1VTQl9JRE1PVVNFIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX0ZURElfRUxB
TiBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9BUFBMRURJU1BMQVkgaXMgbm90IHNldAojIENP
TkZJR19VU0JfU0lTVVNCVkdBIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX0xEIGlzIG5vdCBz
ZXQKQ09ORklHX1VTQl9UUkFOQ0VWSUJSQVRPUj1tCiMgQ09ORklHX1VTQl9JT1dBUlJJT1Ig
aXMgbm90IHNldAojIENPTkZJR19VU0JfVEVTVCBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9F
SFNFVF9URVNUX0ZJWFRVUkUgaXMgbm90IHNldAojIENPTkZJR19VU0JfSVNJR0hURlcgaXMg
bm90IHNldAojIENPTkZJR19VU0JfWVVSRVggaXMgbm90IHNldAojIENPTkZJR19VU0JfRVpV
U0JfRlgyIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX0hTSUNfVVNCMzUwMyBpcyBub3Qgc2V0
CiMgQ09ORklHX1VTQl9MSU5LX0xBWUVSX1RFU1QgaXMgbm90IHNldAojIENPTkZJR19VU0Jf
Q0hBT1NLRVkgaXMgbm90IHNldAoKIwojIFVTQiBQaHlzaWNhbCBMYXllciBkcml2ZXJzCiMK
IyBDT05GSUdfVVNCX1BIWSBpcyBub3Qgc2V0CiMgQ09ORklHX05PUF9VU0JfWENFSVYgaXMg
bm90IHNldAojIENPTkZJR19VU0JfR1BJT19WQlVTIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNC
X0lTUDEzMDEgaXMgbm90IHNldAojIENPTkZJR19VU0JfR0FER0VUIGlzIG5vdCBzZXQKQ09O
RklHX1VTQl9MRURfVFJJRz15CiMgQ09ORklHX1VXQiBpcyBub3Qgc2V0CkNPTkZJR19NTUM9
eQojIENPTkZJR19NTUNfREVCVUcgaXMgbm90IHNldAojIENPTkZJR19NTUNfQ0xLR0FURSBp
cyBub3Qgc2V0CgojCiMgTU1DL1NEL1NESU8gQ2FyZCBEcml2ZXJzCiMKQ09ORklHX01NQ19C
TE9DSz15CkNPTkZJR19NTUNfQkxPQ0tfTUlOT1JTPTgKQ09ORklHX01NQ19CTE9DS19CT1VO
Q0U9eQojIENPTkZJR19TRElPX1VBUlQgaXMgbm90IHNldAojIENPTkZJR19NTUNfVEVTVCBp
cyBub3Qgc2V0CgojCiMgTU1DL1NEL1NESU8gSG9zdCBDb250cm9sbGVyIERyaXZlcnMKIwoj
IENPTkZJR19NTUNfU0RIQ0kgaXMgbm90IHNldAojIENPTkZJR19NTUNfV0JTRCBpcyBub3Qg
c2V0CiMgQ09ORklHX01NQ19USUZNX1NEIGlzIG5vdCBzZXQKIyBDT05GSUdfTU1DX0NCNzEw
IGlzIG5vdCBzZXQKIyBDT05GSUdfTU1DX1ZJQV9TRE1NQyBpcyBub3Qgc2V0CiMgQ09ORklH
X01NQ19WVUIzMDAgaXMgbm90IHNldAojIENPTkZJR19NTUNfVVNIQyBpcyBub3Qgc2V0CiMg
Q09ORklHX01NQ19VU0RISTZST0wwIGlzIG5vdCBzZXQKIyBDT05GSUdfTU1DX1RPU0hJQkFf
UENJIGlzIG5vdCBzZXQKIyBDT05GSUdfTUVNU1RJQ0sgaXMgbm90IHNldApDT05GSUdfTkVX
X0xFRFM9eQpDT05GSUdfTEVEU19DTEFTUz15CiMgQ09ORklHX0xFRFNfQ0xBU1NfRkxBU0gg
aXMgbm90IHNldAoKIwojIExFRCBkcml2ZXJzCiMKIyBDT05GSUdfTEVEU19MTTM1MzAgaXMg
bm90IHNldAojIENPTkZJR19MRURTX0xNMzY0MiBpcyBub3Qgc2V0CiMgQ09ORklHX0xFRFNf
UENBOTUzMiBpcyBub3Qgc2V0CiMgQ09ORklHX0xFRFNfR1BJTyBpcyBub3Qgc2V0CiMgQ09O
RklHX0xFRFNfTFAzOTQ0IGlzIG5vdCBzZXQKIyBDT05GSUdfTEVEU19MUDU1MjEgaXMgbm90
IHNldAojIENPTkZJR19MRURTX0xQNTUyMyBpcyBub3Qgc2V0CiMgQ09ORklHX0xFRFNfTFA1
NTYyIGlzIG5vdCBzZXQKIyBDT05GSUdfTEVEU19MUDg1MDEgaXMgbm90IHNldAojIENPTkZJ
R19MRURTX0xQODg2MCBpcyBub3Qgc2V0CiMgQ09ORklHX0xFRFNfUENBOTU1WCBpcyBub3Qg
c2V0CiMgQ09ORklHX0xFRFNfUENBOTYzWCBpcyBub3Qgc2V0CiMgQ09ORklHX0xFRFNfQkQy
ODAyIGlzIG5vdCBzZXQKIyBDT05GSUdfTEVEU19MVDM1OTMgaXMgbm90IHNldAojIENPTkZJ
R19MRURTX1RDQTY1MDcgaXMgbm90IHNldAojIENPTkZJR19MRURTX0xNMzU1eCBpcyBub3Qg
c2V0CgojCiMgTEVEIGRyaXZlciBmb3IgYmxpbmsoMSkgVVNCIFJHQiBMRUQgaXMgdW5kZXIg
U3BlY2lhbCBISUQgZHJpdmVycyAoSElEX1RISU5HTSkKIwojIENPTkZJR19MRURTX0JMSU5L
TSBpcyBub3Qgc2V0CiMgQ09ORklHX0xFRFNfUE04OTQxX1dMRUQgaXMgbm90IHNldAoKIwoj
IExFRCBUcmlnZ2VycwojCkNPTkZJR19MRURTX1RSSUdHRVJTPXkKIyBDT05GSUdfTEVEU19U
UklHR0VSX1RJTUVSIGlzIG5vdCBzZXQKIyBDT05GSUdfTEVEU19UUklHR0VSX09ORVNIT1Qg
aXMgbm90IHNldAojIENPTkZJR19MRURTX1RSSUdHRVJfSEVBUlRCRUFUIGlzIG5vdCBzZXQK
IyBDT05GSUdfTEVEU19UUklHR0VSX0JBQ0tMSUdIVCBpcyBub3Qgc2V0CiMgQ09ORklHX0xF
RFNfVFJJR0dFUl9DUFUgaXMgbm90IHNldAojIENPTkZJR19MRURTX1RSSUdHRVJfR1BJTyBp
cyBub3Qgc2V0CiMgQ09ORklHX0xFRFNfVFJJR0dFUl9ERUZBVUxUX09OIGlzIG5vdCBzZXQK
CiMKIyBpcHRhYmxlcyB0cmlnZ2VyIGlzIHVuZGVyIE5ldGZpbHRlciBjb25maWcgKExFRCB0
YXJnZXQpCiMKIyBDT05GSUdfTEVEU19UUklHR0VSX1RSQU5TSUVOVCBpcyBub3Qgc2V0CiMg
Q09ORklHX0xFRFNfVFJJR0dFUl9DQU1FUkEgaXMgbm90IHNldAojIENPTkZJR19BQ0NFU1NJ
QklMSVRZIGlzIG5vdCBzZXQKIyBDT05GSUdfSU5GSU5JQkFORCBpcyBub3Qgc2V0CkNPTkZJ
R19FREFDPXkKQ09ORklHX0VEQUNfTEVHQUNZX1NZU0ZTPXkKIyBDT05GSUdfRURBQ19ERUJV
RyBpcyBub3Qgc2V0CkNPTkZJR19FREFDX01NX0VEQUM9eQpDT05GSUdfRURBQ19NUEM4NVhY
PXkKQ09ORklHX1JUQ19MSUI9eQpDT05GSUdfUlRDX0NMQVNTPXkKQ09ORklHX1JUQ19IQ1RP
U1lTPXkKQ09ORklHX1JUQ19TWVNUT0hDPXkKQ09ORklHX1JUQ19IQ1RPU1lTX0RFVklDRT0i
cnRjMCIKIyBDT05GSUdfUlRDX0RFQlVHIGlzIG5vdCBzZXQKCiMKIyBSVEMgaW50ZXJmYWNl
cwojCkNPTkZJR19SVENfSU5URl9TWVNGUz15CkNPTkZJR19SVENfSU5URl9QUk9DPXkKQ09O
RklHX1JUQ19JTlRGX0RFVj15CiMgQ09ORklHX1JUQ19JTlRGX0RFVl9VSUVfRU1VTCBpcyBu
b3Qgc2V0CiMgQ09ORklHX1JUQ19EUlZfVEVTVCBpcyBub3Qgc2V0CgojCiMgSTJDIFJUQyBk
cml2ZXJzCiMKIyBDT05GSUdfUlRDX0RSVl9BQkI1WkVTMyBpcyBub3Qgc2V0CiMgQ09ORklH
X1JUQ19EUlZfQUJYODBYIGlzIG5vdCBzZXQKQ09ORklHX1JUQ19EUlZfRFMxMzA3PXkKIyBD
T05GSUdfUlRDX0RSVl9EUzEzNzQgaXMgbm90IHNldAojIENPTkZJR19SVENfRFJWX0RTMTY3
MiBpcyBub3Qgc2V0CiMgQ09ORklHX1JUQ19EUlZfRFMzMjMyIGlzIG5vdCBzZXQKIyBDT05G
SUdfUlRDX0RSVl9IWU04NTYzIGlzIG5vdCBzZXQKIyBDT05GSUdfUlRDX0RSVl9NQVg2OTAw
IGlzIG5vdCBzZXQKIyBDT05GSUdfUlRDX0RSVl9SUzVDMzcyIGlzIG5vdCBzZXQKIyBDT05G
SUdfUlRDX0RSVl9JU0wxMjA4IGlzIG5vdCBzZXQKIyBDT05GSUdfUlRDX0RSVl9JU0wxMjAy
MiBpcyBub3Qgc2V0CiMgQ09ORklHX1JUQ19EUlZfSVNMMTIwNTcgaXMgbm90IHNldAojIENP
TkZJR19SVENfRFJWX1gxMjA1IGlzIG5vdCBzZXQKIyBDT05GSUdfUlRDX0RSVl9QQ0YyMTI3
IGlzIG5vdCBzZXQKIyBDT05GSUdfUlRDX0RSVl9QQ0Y4NTIzIGlzIG5vdCBzZXQKIyBDT05G
SUdfUlRDX0RSVl9QQ0Y4NTYzIGlzIG5vdCBzZXQKIyBDT05GSUdfUlRDX0RSVl9QQ0Y4NTA2
MyBpcyBub3Qgc2V0CiMgQ09ORklHX1JUQ19EUlZfUENGODU4MyBpcyBub3Qgc2V0CiMgQ09O
RklHX1JUQ19EUlZfTTQxVDgwIGlzIG5vdCBzZXQKIyBDT05GSUdfUlRDX0RSVl9CUTMySyBp
cyBub3Qgc2V0CiMgQ09ORklHX1JUQ19EUlZfUzM1MzkwQSBpcyBub3Qgc2V0CiMgQ09ORklH
X1JUQ19EUlZfRk0zMTMwIGlzIG5vdCBzZXQKIyBDT05GSUdfUlRDX0RSVl9SWDg1ODEgaXMg
bm90IHNldAojIENPTkZJR19SVENfRFJWX1JYODAyNSBpcyBub3Qgc2V0CiMgQ09ORklHX1JU
Q19EUlZfRU0zMDI3IGlzIG5vdCBzZXQKIyBDT05GSUdfUlRDX0RSVl9SVjMwMjlDMiBpcyBu
b3Qgc2V0CgojCiMgU1BJIFJUQyBkcml2ZXJzCiMKCiMKIyBQbGF0Zm9ybSBSVEMgZHJpdmVy
cwojCiMgQ09ORklHX1JUQ19EUlZfQ01PUyBpcyBub3Qgc2V0CiMgQ09ORklHX1JUQ19EUlZf
RFMxMjg2IGlzIG5vdCBzZXQKIyBDT05GSUdfUlRDX0RSVl9EUzE1MTEgaXMgbm90IHNldAoj
IENPTkZJR19SVENfRFJWX0RTMTU1MyBpcyBub3Qgc2V0CiMgQ09ORklHX1JUQ19EUlZfRFMx
Njg1X0ZBTUlMWSBpcyBub3Qgc2V0CiMgQ09ORklHX1JUQ19EUlZfRFMxNzQyIGlzIG5vdCBz
ZXQKIyBDT05GSUdfUlRDX0RSVl9EUzI0MDQgaXMgbm90IHNldAojIENPTkZJR19SVENfRFJW
X1NUSzE3VEE4IGlzIG5vdCBzZXQKIyBDT05GSUdfUlRDX0RSVl9NNDhUODYgaXMgbm90IHNl
dAojIENPTkZJR19SVENfRFJWX000OFQzNSBpcyBub3Qgc2V0CiMgQ09ORklHX1JUQ19EUlZf
TTQ4VDU5IGlzIG5vdCBzZXQKIyBDT05GSUdfUlRDX0RSVl9NU002MjQyIGlzIG5vdCBzZXQK
IyBDT05GSUdfUlRDX0RSVl9CUTQ4MDIgaXMgbm90IHNldAojIENPTkZJR19SVENfRFJWX1JQ
NUMwMSBpcyBub3Qgc2V0CiMgQ09ORklHX1JUQ19EUlZfVjMwMjAgaXMgbm90IHNldAoKIwoj
IG9uLUNQVSBSVEMgZHJpdmVycwojCiMgQ09ORklHX1JUQ19EUlZfR0VORVJJQyBpcyBub3Qg
c2V0CiMgQ09ORklHX1JUQ19EUlZfU05WUyBpcyBub3Qgc2V0CiMgQ09ORklHX1JUQ19EUlZf
WEdFTkUgaXMgbm90IHNldAoKIwojIEhJRCBTZW5zb3IgUlRDIGRyaXZlcnMKIwojIENPTkZJ
R19SVENfRFJWX0hJRF9TRU5TT1JfVElNRSBpcyBub3Qgc2V0CkNPTkZJR19ETUFERVZJQ0VT
PXkKIyBDT05GSUdfRE1BREVWSUNFU19ERUJVRyBpcyBub3Qgc2V0CgojCiMgRE1BIERldmlj
ZXMKIwpDT05GSUdfQVNZTkNfVFhfRU5BQkxFX0NIQU5ORUxfU1dJVENIPXkKIyBDT05GSUdf
RFdfRE1BQyBpcyBub3Qgc2V0CiMgQ09ORklHX0RXX0RNQUNfUENJIGlzIG5vdCBzZXQKQ09O
RklHX0ZTTF9ETUE9eQojIENPTkZJR19IU1VfRE1BX1BDSSBpcyBub3Qgc2V0CkNPTkZJR19G
U0xfRURNQT15CkNPTkZJR19ETUFfRU5HSU5FPXkKQ09ORklHX0RNQV9WSVJUVUFMX0NIQU5O
RUxTPXkKQ09ORklHX0RNQV9PRj15CgojCiMgRE1BIENsaWVudHMKIwpDT05GSUdfQVNZTkNf
VFhfRE1BPXkKIyBDT05GSUdfRE1BVEVTVCBpcyBub3Qgc2V0CiMgQ09ORklHX0FVWERJU1BM
QVkgaXMgbm90IHNldAojIENPTkZJR19VSU8gaXMgbm90IHNldAojIENPTkZJR19WSVJUX0RS
SVZFUlMgaXMgbm90IHNldAoKIwojIFZpcnRpbyBkcml2ZXJzCiMKIyBDT05GSUdfVklSVElP
X1BDSSBpcyBub3Qgc2V0CiMgQ09ORklHX1ZJUlRJT19NTUlPIGlzIG5vdCBzZXQKCiMKIyBN
aWNyb3NvZnQgSHlwZXItViBndWVzdCBzdXBwb3J0CiMKIyBDT05GSUdfU1RBR0lORyBpcyBu
b3Qgc2V0CgojCiMgSGFyZHdhcmUgU3BpbmxvY2sgZHJpdmVycwojCgojCiMgQ2xvY2sgU291
cmNlIGRyaXZlcnMKIwojIENPTkZJR19BVE1FTF9QSVQgaXMgbm90IHNldAojIENPTkZJR19T
SF9USU1FUl9DTVQgaXMgbm90IHNldAojIENPTkZJR19TSF9USU1FUl9NVFUyIGlzIG5vdCBz
ZXQKIyBDT05GSUdfU0hfVElNRVJfVE1VIGlzIG5vdCBzZXQKIyBDT05GSUdfRU1fVElNRVJf
U1RJIGlzIG5vdCBzZXQKIyBDT05GSUdfTUFJTEJPWCBpcyBub3Qgc2V0CkNPTkZJR19JT01N
VV9TVVBQT1JUPXkKCiMKIyBHZW5lcmljIElPTU1VIFBhZ2V0YWJsZSBTdXBwb3J0CiMKCiMK
IyBSZW1vdGVwcm9jIGRyaXZlcnMKIwojIENPTkZJR19TVEVfTU9ERU1fUlBST0MgaXMgbm90
IHNldAoKIwojIFJwbXNnIGRyaXZlcnMKIwoKIwojIFNPQyAoU3lzdGVtIE9uIENoaXApIHNw
ZWNpZmljIERyaXZlcnMKIwojIENPTkZJR19TT0NfVEkgaXMgbm90IHNldAojIENPTkZJR19Q
TV9ERVZGUkVRIGlzIG5vdCBzZXQKIyBDT05GSUdfRVhUQ09OIGlzIG5vdCBzZXQKIyBDT05G
SUdfTUVNT1JZIGlzIG5vdCBzZXQKIyBDT05GSUdfSUlPIGlzIG5vdCBzZXQKIyBDT05GSUdf
Vk1FX0JVUyBpcyBub3Qgc2V0CiMgQ09ORklHX1BXTSBpcyBub3Qgc2V0CkNPTkZJR19JUlFD
SElQPXkKIyBDT05GSUdfSVBBQ0tfQlVTIGlzIG5vdCBzZXQKIyBDT05GSUdfUkVTRVRfQ09O
VFJPTExFUiBpcyBub3Qgc2V0CiMgQ09ORklHX0ZNQyBpcyBub3Qgc2V0CgojCiMgUEhZIFN1
YnN5c3RlbQojCkNPTkZJR19HRU5FUklDX1BIWT15CiMgQ09ORklHX0JDTV9LT05BX1VTQjJf
UEhZIGlzIG5vdCBzZXQKIyBDT05GSUdfUE9XRVJDQVAgaXMgbm90IHNldAojIENPTkZJR19N
Q0IgaXMgbm90IHNldApDT05GSUdfUkFTPXkKIyBDT05GSUdfVEhVTkRFUkJPTFQgaXMgbm90
IHNldAoKIwojIEFuZHJvaWQKIwojIENPTkZJR19BTkRST0lEIGlzIG5vdCBzZXQKCiMKIyBG
aWxlIHN5c3RlbXMKIwojIENPTkZJR19FWFQyX0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdfRVhU
M19GUyBpcyBub3Qgc2V0CkNPTkZJR19FWFQ0X0ZTPXkKQ09ORklHX0VYVDRfVVNFX0ZPUl9F
WFQyMz15CkNPTkZJR19FWFQ0X0ZTX1BPU0lYX0FDTD15CkNPTkZJR19FWFQ0X0ZTX1NFQ1VS
SVRZPXkKIyBDT05GSUdfRVhUNF9FTkNSWVBUSU9OIGlzIG5vdCBzZXQKQ09ORklHX0VYVDRf
REVCVUc9eQpDT05GSUdfSkJEMj15CkNPTkZJR19KQkQyX0RFQlVHPXkKQ09ORklHX0ZTX01C
Q0FDSEU9eQpDT05GSUdfUkVJU0VSRlNfRlM9bQojIENPTkZJR19SRUlTRVJGU19DSEVDSyBp
cyBub3Qgc2V0CkNPTkZJR19SRUlTRVJGU19QUk9DX0lORk89eQpDT05GSUdfUkVJU0VSRlNf
RlNfWEFUVFI9eQpDT05GSUdfUkVJU0VSRlNfRlNfUE9TSVhfQUNMPXkKQ09ORklHX1JFSVNF
UkZTX0ZTX1NFQ1VSSVRZPXkKIyBDT05GSUdfSkZTX0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdf
WEZTX0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdfR0ZTMl9GUyBpcyBub3Qgc2V0CiMgQ09ORklH
X09DRlMyX0ZTIGlzIG5vdCBzZXQKQ09ORklHX0JUUkZTX0ZTPW0KQ09ORklHX0JUUkZTX0ZT
X1BPU0lYX0FDTD15CkNPTkZJR19CVFJGU19GU19DSEVDS19JTlRFR1JJVFk9eQpDT05GSUdf
QlRSRlNfRlNfUlVOX1NBTklUWV9URVNUUz15CkNPTkZJR19CVFJGU19ERUJVRz15CkNPTkZJ
R19CVFJGU19BU1NFUlQ9eQojIENPTkZJR19OSUxGUzJfRlMgaXMgbm90IHNldAojIENPTkZJ
R19GMkZTX0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdfRlNfREFYIGlzIG5vdCBzZXQKQ09ORklH
X0ZTX1BPU0lYX0FDTD15CkNPTkZJR19FWFBPUlRGUz15CkNPTkZJR19GSUxFX0xPQ0tJTkc9
eQpDT05GSUdfRlNOT1RJRlk9eQpDT05GSUdfRE5PVElGWT15CkNPTkZJR19JTk9USUZZX1VT
RVI9eQpDT05GSUdfRkFOT1RJRlk9eQojIENPTkZJR19RVU9UQSBpcyBub3Qgc2V0CiMgQ09O
RklHX1FVT1RBQ1RMIGlzIG5vdCBzZXQKQ09ORklHX0FVVE9GUzRfRlM9eQpDT05GSUdfRlVT
RV9GUz15CiMgQ09ORklHX0NVU0UgaXMgbm90IHNldAojIENPTkZJR19PVkVSTEFZX0ZTIGlz
IG5vdCBzZXQKCiMKIyBDYWNoZXMKIwojIENPTkZJR19GU0NBQ0hFIGlzIG5vdCBzZXQKCiMK
IyBDRC1ST00vRFZEIEZpbGVzeXN0ZW1zCiMKQ09ORklHX0lTTzk2NjBfRlM9eQpDT05GSUdf
Sk9MSUVUPXkKIyBDT05GSUdfWklTT0ZTIGlzIG5vdCBzZXQKQ09ORklHX1VERl9GUz15CkNP
TkZJR19VREZfTkxTPXkKCiMKIyBET1MvRkFUL05UIEZpbGVzeXN0ZW1zCiMKQ09ORklHX0ZB
VF9GUz15CkNPTkZJR19NU0RPU19GUz15CkNPTkZJR19WRkFUX0ZTPXkKQ09ORklHX0ZBVF9E
RUZBVUxUX0NPREVQQUdFPTQzNwpDT05GSUdfRkFUX0RFRkFVTFRfSU9DSEFSU0VUPSJpc284
ODU5LTEiCkNPTkZJR19OVEZTX0ZTPXkKIyBDT05GSUdfTlRGU19ERUJVRyBpcyBub3Qgc2V0
CkNPTkZJR19OVEZTX1JXPXkKCiMKIyBQc2V1ZG8gZmlsZXN5c3RlbXMKIwpDT05GSUdfUFJP
Q19GUz15CkNPTkZJR19QUk9DX0tDT1JFPXkKQ09ORklHX1BST0NfU1lTQ1RMPXkKQ09ORklH
X1BST0NfUEFHRV9NT05JVE9SPXkKQ09ORklHX0tFUk5GUz15CkNPTkZJR19TWVNGUz15CkNP
TkZJR19UTVBGUz15CkNPTkZJR19UTVBGU19QT1NJWF9BQ0w9eQpDT05GSUdfVE1QRlNfWEFU
VFI9eQojIENPTkZJR19IVUdFVExCRlMgaXMgbm90IHNldAojIENPTkZJR19IVUdFVExCX1BB
R0UgaXMgbm90IHNldApDT05GSUdfQ09ORklHRlNfRlM9eQpDT05GSUdfTUlTQ19GSUxFU1lT
VEVNUz15CiMgQ09ORklHX0FERlNfRlMgaXMgbm90IHNldAojIENPTkZJR19BRkZTX0ZTIGlz
IG5vdCBzZXQKIyBDT05GSUdfRUNSWVBUX0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdfSEZTX0ZT
IGlzIG5vdCBzZXQKIyBDT05GSUdfSEZTUExVU19GUyBpcyBub3Qgc2V0CiMgQ09ORklHX0JF
RlNfRlMgaXMgbm90IHNldAojIENPTkZJR19CRlNfRlMgaXMgbm90IHNldAojIENPTkZJR19F
RlNfRlMgaXMgbm90IHNldAojIENPTkZJR19MT0dGUyBpcyBub3Qgc2V0CiMgQ09ORklHX0NS
QU1GUyBpcyBub3Qgc2V0CkNPTkZJR19TUVVBU0hGUz1tCkNPTkZJR19TUVVBU0hGU19GSUxF
X0NBQ0hFPXkKIyBDT05GSUdfU1FVQVNIRlNfRklMRV9ESVJFQ1QgaXMgbm90IHNldApDT05G
SUdfU1FVQVNIRlNfREVDT01QX1NJTkdMRT15CiMgQ09ORklHX1NRVUFTSEZTX0RFQ09NUF9N
VUxUSSBpcyBub3Qgc2V0CiMgQ09ORklHX1NRVUFTSEZTX0RFQ09NUF9NVUxUSV9QRVJDUFUg
aXMgbm90IHNldApDT05GSUdfU1FVQVNIRlNfWEFUVFI9eQpDT05GSUdfU1FVQVNIRlNfWkxJ
Qj15CiMgQ09ORklHX1NRVUFTSEZTX0xaNCBpcyBub3Qgc2V0CkNPTkZJR19TUVVBU0hGU19M
Wk89eQpDT05GSUdfU1FVQVNIRlNfWFo9eQpDT05GSUdfU1FVQVNIRlNfNEtfREVWQkxLX1NJ
WkU9eQpDT05GSUdfU1FVQVNIRlNfRU1CRURERUQ9eQpDT05GSUdfU1FVQVNIRlNfRlJBR01F
TlRfQ0FDSEVfU0laRT0zCiMgQ09ORklHX1ZYRlNfRlMgaXMgbm90IHNldAojIENPTkZJR19N
SU5JWF9GUyBpcyBub3Qgc2V0CiMgQ09ORklHX09NRlNfRlMgaXMgbm90IHNldAojIENPTkZJ
R19IUEZTX0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdfUU5YNEZTX0ZTIGlzIG5vdCBzZXQKIyBD
T05GSUdfUU5YNkZTX0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdfUk9NRlNfRlMgaXMgbm90IHNl
dAojIENPTkZJR19QU1RPUkUgaXMgbm90IHNldAojIENPTkZJR19TWVNWX0ZTIGlzIG5vdCBz
ZXQKIyBDT05GSUdfVUZTX0ZTIGlzIG5vdCBzZXQKQ09ORklHX05FVFdPUktfRklMRVNZU1RF
TVM9eQpDT05GSUdfTkZTX0ZTPXkKQ09ORklHX05GU19WMj15CkNPTkZJR19ORlNfVjM9eQoj
IENPTkZJR19ORlNfVjNfQUNMIGlzIG5vdCBzZXQKIyBDT05GSUdfTkZTX1Y0IGlzIG5vdCBz
ZXQKIyBDT05GSUdfTkZTX1NXQVAgaXMgbm90IHNldApDT05GSUdfUk9PVF9ORlM9eQojIENP
TkZJR19ORlNEIGlzIG5vdCBzZXQKQ09ORklHX0dSQUNFX1BFUklPRD15CkNPTkZJR19MT0NL
RD15CkNPTkZJR19MT0NLRF9WND15CkNPTkZJR19ORlNfQ09NTU9OPXkKQ09ORklHX1NVTlJQ
Qz15CkNPTkZJR19TVU5SUENfR1NTPXkKQ09ORklHX1JQQ1NFQ19HU1NfS1JCNT15CiMgQ09O
RklHX1NVTlJQQ19ERUJVRyBpcyBub3Qgc2V0CiMgQ09ORklHX0NFUEhfRlMgaXMgbm90IHNl
dApDT05GSUdfQ0lGUz15CiMgQ09ORklHX0NJRlNfU1RBVFMgaXMgbm90IHNldApDT05GSUdf
Q0lGU19XRUFLX1BXX0hBU0g9eQojIENPTkZJR19DSUZTX1VQQ0FMTCBpcyBub3Qgc2V0CiMg
Q09ORklHX0NJRlNfWEFUVFIgaXMgbm90IHNldApDT05GSUdfQ0lGU19ERUJVRz15CiMgQ09O
RklHX0NJRlNfREVCVUcyIGlzIG5vdCBzZXQKIyBDT05GSUdfQ0lGU19ERlNfVVBDQUxMIGlz
IG5vdCBzZXQKIyBDT05GSUdfQ0lGU19TTUIyIGlzIG5vdCBzZXQKIyBDT05GSUdfTkNQX0ZT
IGlzIG5vdCBzZXQKIyBDT05GSUdfQ09EQV9GUyBpcyBub3Qgc2V0CiMgQ09ORklHX0FGU19G
UyBpcyBub3Qgc2V0CkNPTkZJR19OTFM9eQpDT05GSUdfTkxTX0RFRkFVTFQ9Imlzbzg4NTkt
MSIKQ09ORklHX05MU19DT0RFUEFHRV80Mzc9eQojIENPTkZJR19OTFNfQ09ERVBBR0VfNzM3
IGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX0NPREVQQUdFXzc3NSBpcyBub3Qgc2V0CiMgQ09O
RklHX05MU19DT0RFUEFHRV84NTAgaXMgbm90IHNldAojIENPTkZJR19OTFNfQ09ERVBBR0Vf
ODUyIGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX0NPREVQQUdFXzg1NSBpcyBub3Qgc2V0CiMg
Q09ORklHX05MU19DT0RFUEFHRV84NTcgaXMgbm90IHNldAojIENPTkZJR19OTFNfQ09ERVBB
R0VfODYwIGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX0NPREVQQUdFXzg2MSBpcyBub3Qgc2V0
CiMgQ09ORklHX05MU19DT0RFUEFHRV84NjIgaXMgbm90IHNldAojIENPTkZJR19OTFNfQ09E
RVBBR0VfODYzIGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX0NPREVQQUdFXzg2NCBpcyBub3Qg
c2V0CiMgQ09ORklHX05MU19DT0RFUEFHRV84NjUgaXMgbm90IHNldAojIENPTkZJR19OTFNf
Q09ERVBBR0VfODY2IGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX0NPREVQQUdFXzg2OSBpcyBu
b3Qgc2V0CiMgQ09ORklHX05MU19DT0RFUEFHRV85MzYgaXMgbm90IHNldAojIENPTkZJR19O
TFNfQ09ERVBBR0VfOTUwIGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX0NPREVQQUdFXzkzMiBp
cyBub3Qgc2V0CiMgQ09ORklHX05MU19DT0RFUEFHRV85NDkgaXMgbm90IHNldAojIENPTkZJ
R19OTFNfQ09ERVBBR0VfODc0IGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX0lTTzg4NTlfOCBp
cyBub3Qgc2V0CiMgQ09ORklHX05MU19DT0RFUEFHRV8xMjUwIGlzIG5vdCBzZXQKIyBDT05G
SUdfTkxTX0NPREVQQUdFXzEyNTEgaXMgbm90IHNldAojIENPTkZJR19OTFNfQVNDSUkgaXMg
bm90IHNldApDT05GSUdfTkxTX0lTTzg4NTlfMT15CiMgQ09ORklHX05MU19JU084ODU5XzIg
aXMgbm90IHNldAojIENPTkZJR19OTFNfSVNPODg1OV8zIGlzIG5vdCBzZXQKIyBDT05GSUdf
TkxTX0lTTzg4NTlfNCBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19JU084ODU5XzUgaXMgbm90
IHNldAojIENPTkZJR19OTFNfSVNPODg1OV82IGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX0lT
Tzg4NTlfNyBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19JU084ODU5XzkgaXMgbm90IHNldAoj
IENPTkZJR19OTFNfSVNPODg1OV8xMyBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19JU084ODU5
XzE0IGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX0lTTzg4NTlfMTUgaXMgbm90IHNldAojIENP
TkZJR19OTFNfS09JOF9SIGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX0tPSThfVSBpcyBub3Qg
c2V0CiMgQ09ORklHX05MU19NQUNfUk9NQU4gaXMgbm90IHNldAojIENPTkZJR19OTFNfTUFD
X0NFTFRJQyBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19NQUNfQ0VOVEVVUk8gaXMgbm90IHNl
dAojIENPTkZJR19OTFNfTUFDX0NST0FUSUFOIGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX01B
Q19DWVJJTExJQyBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19NQUNfR0FFTElDIGlzIG5vdCBz
ZXQKIyBDT05GSUdfTkxTX01BQ19HUkVFSyBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19NQUNf
SUNFTEFORCBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19NQUNfSU5VSVQgaXMgbm90IHNldAoj
IENPTkZJR19OTFNfTUFDX1JPTUFOSUFOIGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX01BQ19U
VVJLSVNIIGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX1VURjggaXMgbm90IHNldAojIENPTkZJ
R19ETE0gaXMgbm90IHNldApDT05GSUdfVUNDX1NMT1c9eQpDT05GSUdfVUNDPXkKIyBDT05G
SUdfQklOQVJZX1BSSU5URiBpcyBub3Qgc2V0CgojCiMgTGlicmFyeSByb3V0aW5lcwojCkNP
TkZJR19SQUlENl9QUT15CkNPTkZJR19CSVRSRVZFUlNFPXkKIyBDT05GSUdfSEFWRV9BUkNI
X0JJVFJFVkVSU0UgaXMgbm90IHNldApDT05GSUdfUkFUSU9OQUw9eQpDT05GSUdfR0VORVJJ
Q19TVFJOQ1BZX0ZST01fVVNFUj15CkNPTkZJR19HRU5FUklDX1NUUk5MRU5fVVNFUj15CkNP
TkZJR19HRU5FUklDX05FVF9VVElMUz15CkNPTkZJR19HRU5FUklDX1BDSV9JT01BUD15CkNP
TkZJR19HRU5FUklDX0lPPXkKQ09ORklHX0NSQ19DQ0lUVD15CkNPTkZJR19DUkMxNj15CiMg
Q09ORklHX0NSQ19UMTBESUYgaXMgbm90IHNldApDT05GSUdfQ1JDX0lUVV9UPXkKQ09ORklH
X0NSQzMyPXkKQ09ORklHX0NSQzMyX1NFTEZURVNUPXkKQ09ORklHX0NSQzMyX1NMSUNFQlk4
PXkKIyBDT05GSUdfQ1JDMzJfU0xJQ0VCWTQgaXMgbm90IHNldAojIENPTkZJR19DUkMzMl9T
QVJXQVRFIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JDMzJfQklUIGlzIG5vdCBzZXQKIyBDT05G
SUdfQ1JDNyBpcyBub3Qgc2V0CkNPTkZJR19MSUJDUkMzMkM9eQojIENPTkZJR19DUkM4IGlz
IG5vdCBzZXQKIyBDT05GSUdfQVVESVRfQVJDSF9DT01QQVRfR0VORVJJQyBpcyBub3Qgc2V0
CkNPTkZJR19SQU5ET00zMl9TRUxGVEVTVD15CkNPTkZJR19aTElCX0lORkxBVEU9eQpDT05G
SUdfWkxJQl9ERUZMQVRFPXkKQ09ORklHX0xaT19DT01QUkVTUz15CkNPTkZJR19MWk9fREVD
T01QUkVTUz15CkNPTkZJR19YWl9ERUM9eQojIENPTkZJR19YWl9ERUNfWDg2IGlzIG5vdCBz
ZXQKQ09ORklHX1haX0RFQ19QT1dFUlBDPXkKIyBDT05GSUdfWFpfREVDX0lBNjQgaXMgbm90
IHNldAojIENPTkZJR19YWl9ERUNfQVJNIGlzIG5vdCBzZXQKIyBDT05GSUdfWFpfREVDX0FS
TVRIVU1CIGlzIG5vdCBzZXQKIyBDT05GSUdfWFpfREVDX1NQQVJDIGlzIG5vdCBzZXQKQ09O
RklHX1haX0RFQ19CQ0o9eQojIENPTkZJR19YWl9ERUNfVEVTVCBpcyBub3Qgc2V0CkNPTkZJ
R19ERUNPTVBSRVNTX0daSVA9eQpDT05GSUdfSU5URVJWQUxfVFJFRT15CkNPTkZJR19BU1NP
Q0lBVElWRV9BUlJBWT15CkNPTkZJR19IQVNfSU9NRU09eQpDT05GSUdfSEFTX0lPUE9SVF9N
QVA9eQpDT05GSUdfSEFTX0RNQT15CkNPTkZJR19DUFVfUk1BUD15CkNPTkZJR19EUUw9eQpD
T05GSUdfR0xPQj15CkNPTkZJR19HTE9CX1NFTEZURVNUPXkKQ09ORklHX05MQVRUUj15CkNP
TkZJR19HRU5FUklDX0FUT01JQzY0PXkKQ09ORklHX0FSQ0hfSEFTX0FUT01JQzY0X0RFQ19J
Rl9QT1NJVElWRT15CkNPTkZJR19BVkVSQUdFPXkKIyBDT05GSUdfQ09SRElDIGlzIG5vdCBz
ZXQKQ09ORklHX0REUj15CkNPTkZJR19MSUJGRFQ9eQpDT05GSUdfT0lEX1JFR0lTVFJZPXkK
Q09ORklHX0ZPTlRfU1VQUE9SVD15CkNPTkZJR19GT05UUz15CkNPTkZJR19GT05UXzh4OD15
CkNPTkZJR19GT05UXzh4MTY9eQpDT05GSUdfRk9OVF82eDExPXkKQ09ORklHX0ZPTlRfN3gx
ND15CkNPTkZJR19GT05UX1BFQVJMXzh4OD15CkNPTkZJR19GT05UX0FDT1JOXzh4OD15CkNP
TkZJR19GT05UX01JTklfNHg2PXkKQ09ORklHX0ZPTlRfNngxMD15CkNPTkZJR19GT05UX1NV
Tjh4MTY9eQpDT05GSUdfRk9OVF9TVU4xMngyMj15CkNPTkZJR19GT05UXzEweDE4PXkKQ09O
RklHX0FSQ0hfSEFTX1NHX0NIQUlOPXkKCiMKIyBLZXJuZWwgaGFja2luZwojCgojCiMgcHJp
bnRrIGFuZCBkbWVzZyBvcHRpb25zCiMKQ09ORklHX1BSSU5US19USU1FPXkKQ09ORklHX01F
U1NBR0VfTE9HTEVWRUxfREVGQVVMVD00CiMgQ09ORklHX0RZTkFNSUNfREVCVUcgaXMgbm90
IHNldAoKIwojIENvbXBpbGUtdGltZSBjaGVja3MgYW5kIGNvbXBpbGVyIG9wdGlvbnMKIwoj
IENPTkZJR19ERUJVR19JTkZPIGlzIG5vdCBzZXQKQ09ORklHX0VOQUJMRV9XQVJOX0RFUFJF
Q0FURUQ9eQpDT05GSUdfRU5BQkxFX01VU1RfQ0hFQ0s9eQpDT05GSUdfRlJBTUVfV0FSTj0y
MDQ4CiMgQ09ORklHX1NUUklQX0FTTV9TWU1TIGlzIG5vdCBzZXQKIyBDT05GSUdfUkVBREFC
TEVfQVNNIGlzIG5vdCBzZXQKIyBDT05GSUdfVU5VU0VEX1NZTUJPTFMgaXMgbm90IHNldAoj
IENPTkZJR19QQUdFX09XTkVSIGlzIG5vdCBzZXQKQ09ORklHX0RFQlVHX0ZTPXkKIyBDT05G
SUdfSEVBREVSU19DSEVDSyBpcyBub3Qgc2V0CiMgQ09ORklHX0RFQlVHX1NFQ1RJT05fTUlT
TUFUQ0ggaXMgbm90IHNldAojIENPTkZJR19ERUJVR19GT1JDRV9XRUFLX1BFUl9DUFUgaXMg
bm90IHNldApDT05GSUdfTUFHSUNfU1lTUlE9eQpDT05GSUdfTUFHSUNfU1lTUlFfREVGQVVM
VF9FTkFCTEU9MHgxCkNPTkZJR19ERUJVR19LRVJORUw9eQoKIwojIE1lbW9yeSBEZWJ1Z2dp
bmcKIwojIENPTkZJR19QQUdFX0VYVEVOU0lPTiBpcyBub3Qgc2V0CiMgQ09ORklHX0RFQlVH
X1BBR0VBTExPQyBpcyBub3Qgc2V0CiMgQ09ORklHX0RFQlVHX09CSkVDVFMgaXMgbm90IHNl
dAojIENPTkZJR19TTFVCX0RFQlVHX09OIGlzIG5vdCBzZXQKIyBDT05GSUdfU0xVQl9TVEFU
UyBpcyBub3Qgc2V0CkNPTkZJR19IQVZFX0RFQlVHX0tNRU1MRUFLPXkKIyBDT05GSUdfREVC
VUdfS01FTUxFQUsgaXMgbm90IHNldAojIENPTkZJR19ERUJVR19TVEFDS19VU0FHRSBpcyBu
b3Qgc2V0CiMgQ09ORklHX0RFQlVHX1ZNIGlzIG5vdCBzZXQKIyBDT05GSUdfREVCVUdfTUVN
T1JZX0lOSVQgaXMgbm90IHNldAojIENPTkZJR19ERUJVR19QRVJfQ1BVX01BUFMgaXMgbm90
IHNldAojIENPTkZJR19ERUJVR19ISUdITUVNIGlzIG5vdCBzZXQKQ09ORklHX0hBVkVfREVC
VUdfU1RBQ0tPVkVSRkxPVz15CiMgQ09ORklHX0RFQlVHX1NUQUNLT1ZFUkZMT1cgaXMgbm90
IHNldAojIENPTkZJR19ERUJVR19TSElSUSBpcyBub3Qgc2V0CgojCiMgRGVidWcgTG9ja3Vw
cyBhbmQgSGFuZ3MKIwojIENPTkZJR19MT0NLVVBfREVURUNUT1IgaXMgbm90IHNldApDT05G
SUdfREVURUNUX0hVTkdfVEFTSz15CkNPTkZJR19ERUZBVUxUX0hVTkdfVEFTS19USU1FT1VU
PTEyMAojIENPTkZJR19CT09UUEFSQU1fSFVOR19UQVNLX1BBTklDIGlzIG5vdCBzZXQKQ09O
RklHX0JPT1RQQVJBTV9IVU5HX1RBU0tfUEFOSUNfVkFMVUU9MAojIENPTkZJR19QQU5JQ19P
Tl9PT1BTIGlzIG5vdCBzZXQKQ09ORklHX1BBTklDX09OX09PUFNfVkFMVUU9MApDT05GSUdf
U0NIRURfREVCVUc9eQojIENPTkZJR19TQ0hFRFNUQVRTIGlzIG5vdCBzZXQKIyBDT05GSUdf
U0NIRURfU1RBQ0tfRU5EX0NIRUNLIGlzIG5vdCBzZXQKIyBDT05GSUdfREVCVUdfVElNRUtF
RVBJTkcgaXMgbm90IHNldApDT05GSUdfVElNRVJfU1RBVFM9eQpDT05GSUdfREVCVUdfUFJF
RU1QVD15CgojCiMgTG9jayBEZWJ1Z2dpbmcgKHNwaW5sb2NrcywgbXV0ZXhlcywgZXRjLi4u
KQojCiMgQ09ORklHX0RFQlVHX1JUX01VVEVYRVMgaXMgbm90IHNldApDT05GSUdfREVCVUdf
U1BJTkxPQ0s9eQojIENPTkZJR19ERUJVR19NVVRFWEVTIGlzIG5vdCBzZXQKIyBDT05GSUdf
REVCVUdfV1dfTVVURVhfU0xPV1BBVEggaXMgbm90IHNldAojIENPTkZJR19ERUJVR19MT0NL
X0FMTE9DIGlzIG5vdCBzZXQKIyBDT05GSUdfUFJPVkVfTE9DS0lORyBpcyBub3Qgc2V0CiMg
Q09ORklHX0xPQ0tfU1RBVCBpcyBub3Qgc2V0CiMgQ09ORklHX0RFQlVHX0FUT01JQ19TTEVF
UCBpcyBub3Qgc2V0CiMgQ09ORklHX0RFQlVHX0xPQ0tJTkdfQVBJX1NFTEZURVNUUyBpcyBu
b3Qgc2V0CiMgQ09ORklHX0xPQ0tfVE9SVFVSRV9URVNUIGlzIG5vdCBzZXQKIyBDT05GSUdf
U1RBQ0tUUkFDRSBpcyBub3Qgc2V0CiMgQ09ORklHX0RFQlVHX0tPQkpFQ1QgaXMgbm90IHNl
dApDT05GSUdfREVCVUdfQlVHVkVSQk9TRT15CiMgQ09ORklHX0RFQlVHX0xJU1QgaXMgbm90
IHNldAojIENPTkZJR19ERUJVR19QSV9MSVNUIGlzIG5vdCBzZXQKIyBDT05GSUdfREVCVUdf
U0cgaXMgbm90IHNldAojIENPTkZJR19ERUJVR19OT1RJRklFUlMgaXMgbm90IHNldAojIENP
TkZJR19ERUJVR19DUkVERU5USUFMUyBpcyBub3Qgc2V0CgojCiMgUkNVIERlYnVnZ2luZwoj
CiMgQ09ORklHX1BST1ZFX1JDVSBpcyBub3Qgc2V0CiMgQ09ORklHX1NQQVJTRV9SQ1VfUE9J
TlRFUiBpcyBub3Qgc2V0CiMgQ09ORklHX1RPUlRVUkVfVEVTVCBpcyBub3Qgc2V0CiMgQ09O
RklHX1JDVV9UT1JUVVJFX1RFU1QgaXMgbm90IHNldApDT05GSUdfUkNVX0NQVV9TVEFMTF9U
SU1FT1VUPTIxCiMgQ09ORklHX1JDVV9DUFVfU1RBTExfSU5GTyBpcyBub3Qgc2V0CiMgQ09O
RklHX1JDVV9UUkFDRSBpcyBub3Qgc2V0CiMgQ09ORklHX0RFQlVHX0JMT0NLX0VYVF9ERVZU
IGlzIG5vdCBzZXQKIyBDT05GSUdfTk9USUZJRVJfRVJST1JfSU5KRUNUSU9OIGlzIG5vdCBz
ZXQKIyBDT05GSUdfRkFVTFRfSU5KRUNUSU9OIGlzIG5vdCBzZXQKIyBDT05GSUdfTEFURU5D
WVRPUCBpcyBub3Qgc2V0CkNPTkZJR19IQVZFX0ZVTkNUSU9OX1RSQUNFUj15CkNPTkZJR19I
QVZFX0ZVTkNUSU9OX0dSQVBIX1RSQUNFUj15CkNPTkZJR19IQVZFX0RZTkFNSUNfRlRSQUNF
PXkKQ09ORklHX0hBVkVfRlRSQUNFX01DT1VOVF9SRUNPUkQ9eQpDT05GSUdfSEFWRV9TWVND
QUxMX1RSQUNFUE9JTlRTPXkKQ09ORklHX1RSQUNJTkdfU1VQUE9SVD15CkNPTkZJR19GVFJB
Q0U9eQojIENPTkZJR19GVU5DVElPTl9UUkFDRVIgaXMgbm90IHNldAojIENPTkZJR19JUlFT
T0ZGX1RSQUNFUiBpcyBub3Qgc2V0CiMgQ09ORklHX1BSRUVNUFRfVFJBQ0VSIGlzIG5vdCBz
ZXQKIyBDT05GSUdfU0NIRURfVFJBQ0VSIGlzIG5vdCBzZXQKIyBDT05GSUdfRU5BQkxFX0RF
RkFVTFRfVFJBQ0VSUyBpcyBub3Qgc2V0CiMgQ09ORklHX0ZUUkFDRV9TWVNDQUxMUyBpcyBu
b3Qgc2V0CiMgQ09ORklHX1RSQUNFUl9TTkFQU0hPVCBpcyBub3Qgc2V0CkNPTkZJR19CUkFO
Q0hfUFJPRklMRV9OT05FPXkKIyBDT05GSUdfUFJPRklMRV9BTk5PVEFURURfQlJBTkNIRVMg
aXMgbm90IHNldAojIENPTkZJR19QUk9GSUxFX0FMTF9CUkFOQ0hFUyBpcyBub3Qgc2V0CiMg
Q09ORklHX1NUQUNLX1RSQUNFUiBpcyBub3Qgc2V0CiMgQ09ORklHX0JMS19ERVZfSU9fVFJB
Q0UgaXMgbm90IHNldAojIENPTkZJR19VUFJPQkVfRVZFTlQgaXMgbm90IHNldAojIENPTkZJ
R19QUk9CRV9FVkVOVFMgaXMgbm90IHNldAojIENPTkZJR19UUkFDRVBPSU5UX0JFTkNITUFS
SyBpcyBub3Qgc2V0CgojCiMgUnVudGltZSBUZXN0aW5nCiMKIyBDT05GSUdfTEtEVE0gaXMg
bm90IHNldAojIENPTkZJR19URVNUX0xJU1RfU09SVCBpcyBub3Qgc2V0CiMgQ09ORklHX0JB
Q0tUUkFDRV9TRUxGX1RFU1QgaXMgbm90IHNldAojIENPTkZJR19SQlRSRUVfVEVTVCBpcyBu
b3Qgc2V0CiMgQ09ORklHX0lOVEVSVkFMX1RSRUVfVEVTVCBpcyBub3Qgc2V0CiMgQ09ORklH
X1BFUkNQVV9URVNUIGlzIG5vdCBzZXQKIyBDT05GSUdfQVRPTUlDNjRfU0VMRlRFU1QgaXMg
bm90IHNldAojIENPTkZJR19BU1lOQ19SQUlENl9URVNUIGlzIG5vdCBzZXQKIyBDT05GSUdf
VEVTVF9IRVhEVU1QIGlzIG5vdCBzZXQKIyBDT05GSUdfVEVTVF9TVFJJTkdfSEVMUEVSUyBp
cyBub3Qgc2V0CiMgQ09ORklHX1RFU1RfS1NUUlRPWCBpcyBub3Qgc2V0CiMgQ09ORklHX1RF
U1RfUkhBU0hUQUJMRSBpcyBub3Qgc2V0CkNPTkZJR19ETUFfQVBJX0RFQlVHPXkKIyBDT05G
SUdfVEVTVF9MS00gaXMgbm90IHNldAojIENPTkZJR19URVNUX1VTRVJfQ09QWSBpcyBub3Qg
c2V0CiMgQ09ORklHX1RFU1RfQlBGIGlzIG5vdCBzZXQKIyBDT05GSUdfVEVTVF9GSVJNV0FS
RSBpcyBub3Qgc2V0CiMgQ09ORklHX1RFU1RfVURFTEFZIGlzIG5vdCBzZXQKIyBDT05GSUdf
TUVNVEVTVCBpcyBub3Qgc2V0CiMgQ09ORklHX1NBTVBMRVMgaXMgbm90IHNldApDT05GSUdf
SEFWRV9BUkNIX0tHREI9eQojIENPTkZJR19LR0RCIGlzIG5vdCBzZXQKIyBDT05GSUdfUFBD
X0RJU0FCTEVfV0VSUk9SIGlzIG5vdCBzZXQKQ09ORklHX1BQQ19XRVJST1I9eQpDT05GSUdf
UFJJTlRfU1RBQ0tfREVQVEg9NjQKQ09ORklHX1BQQ19FTVVMQVRFRF9TVEFUUz15CiMgQ09O
RklHX0NPREVfUEFUQ0hJTkdfU0VMRlRFU1QgaXMgbm90IHNldAojIENPTkZJR19GVFJfRklY
VVBfU0VMRlRFU1QgaXMgbm90IHNldApDT05GSUdfTVNJX0JJVE1BUF9TRUxGVEVTVD15CiMg
Q09ORklHX1hNT04gaXMgbm90IHNldAojIENPTkZJR19CRElfU1dJVENIIGlzIG5vdCBzZXQK
IyBDT05GSUdfUFBDX0VBUkxZX0RFQlVHIGlzIG5vdCBzZXQKQ09ORklHX1NUUklDVF9ERVZN
RU09eQoKIwojIFNlY3VyaXR5IG9wdGlvbnMKIwpDT05GSUdfS0VZUz15CiMgQ09ORklHX1BF
UlNJU1RFTlRfS0VZUklOR1MgaXMgbm90IHNldAojIENPTkZJR19CSUdfS0VZUyBpcyBub3Qg
c2V0CkNPTkZJR19FTkNSWVBURURfS0VZUz15CiMgQ09ORklHX1NFQ1VSSVRZX0RNRVNHX1JF
U1RSSUNUIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VDVVJJVFkgaXMgbm90IHNldAojIENPTkZJ
R19TRUNVUklUWUZTIGlzIG5vdCBzZXQKQ09ORklHX0RFRkFVTFRfU0VDVVJJVFlfREFDPXkK
Q09ORklHX0RFRkFVTFRfU0VDVVJJVFk9IiIKQ09ORklHX1hPUl9CTE9DS1M9eQpDT05GSUdf
QVNZTkNfQ09SRT15CkNPTkZJR19BU1lOQ19NRU1DUFk9eQpDT05GSUdfQVNZTkNfWE9SPXkK
Q09ORklHX0FTWU5DX1BRPXkKQ09ORklHX0FTWU5DX1JBSUQ2X1JFQ09WPXkKQ09ORklHX0NS
WVBUTz15CgojCiMgQ3J5cHRvIGNvcmUgb3IgaGVscGVyCiMKQ09ORklHX0NSWVBUT19BTEdB
UEk9eQpDT05GSUdfQ1JZUFRPX0FMR0FQSTI9eQpDT05GSUdfQ1JZUFRPX0FFQUQ9eQpDT05G
SUdfQ1JZUFRPX0FFQUQyPXkKQ09ORklHX0NSWVBUT19CTEtDSVBIRVI9eQpDT05GSUdfQ1JZ
UFRPX0JMS0NJUEhFUjI9eQpDT05GSUdfQ1JZUFRPX0hBU0g9eQpDT05GSUdfQ1JZUFRPX0hB
U0gyPXkKQ09ORklHX0NSWVBUT19STkc9eQpDT05GSUdfQ1JZUFRPX1JORzI9eQpDT05GSUdf
Q1JZUFRPX1BDT01QMj15CkNPTkZJR19DUllQVE9fTUFOQUdFUj15CkNPTkZJR19DUllQVE9f
TUFOQUdFUjI9eQojIENPTkZJR19DUllQVE9fVVNFUiBpcyBub3Qgc2V0CkNPTkZJR19DUllQ
VE9fTUFOQUdFUl9ESVNBQkxFX1RFU1RTPXkKQ09ORklHX0NSWVBUT19HRjEyOE1VTD15CkNP
TkZJR19DUllQVE9fTlVMTD15CiMgQ09ORklHX0NSWVBUT19QQ1JZUFQgaXMgbm90IHNldApD
T05GSUdfQ1JZUFRPX1dPUktRVUVVRT15CiMgQ09ORklHX0NSWVBUT19DUllQVEQgaXMgbm90
IHNldAojIENPTkZJR19DUllQVE9fTUNSWVBURCBpcyBub3Qgc2V0CkNPTkZJR19DUllQVE9f
QVVUSEVOQz15CiMgQ09ORklHX0NSWVBUT19URVNUIGlzIG5vdCBzZXQKCiMKIyBBdXRoZW50
aWNhdGVkIEVuY3J5cHRpb24gd2l0aCBBc3NvY2lhdGVkIERhdGEKIwpDT05GSUdfQ1JZUFRP
X0NDTT1tCkNPTkZJR19DUllQVE9fR0NNPW0KQ09ORklHX0NSWVBUT19TRVFJVj15CgojCiMg
QmxvY2sgbW9kZXMKIwpDT05GSUdfQ1JZUFRPX0NCQz15CkNPTkZJR19DUllQVE9fQ1RSPXkK
Q09ORklHX0NSWVBUT19DVFM9eQpDT05GSUdfQ1JZUFRPX0VDQj15CiMgQ09ORklHX0NSWVBU
T19MUlcgaXMgbm90IHNldAojIENPTkZJR19DUllQVE9fUENCQyBpcyBub3Qgc2V0CkNPTkZJ
R19DUllQVE9fWFRTPXkKCiMKIyBIYXNoIG1vZGVzCiMKQ09ORklHX0NSWVBUT19DTUFDPXkK
Q09ORklHX0NSWVBUT19ITUFDPXkKIyBDT05GSUdfQ1JZUFRPX1hDQkMgaXMgbm90IHNldAoj
IENPTkZJR19DUllQVE9fVk1BQyBpcyBub3Qgc2V0CgojCiMgRGlnZXN0CiMKQ09ORklHX0NS
WVBUT19DUkMzMkM9eQojIENPTkZJR19DUllQVE9fQ1JDMzIgaXMgbm90IHNldAojIENPTkZJ
R19DUllQVE9fQ1JDVDEwRElGIGlzIG5vdCBzZXQKQ09ORklHX0NSWVBUT19HSEFTSD1tCkNP
TkZJR19DUllQVE9fTUQ0PXkKQ09ORklHX0NSWVBUT19NRDU9eQojIENPTkZJR19DUllQVE9f
TUQ1X1BQQyBpcyBub3Qgc2V0CkNPTkZJR19DUllQVE9fTUlDSEFFTF9NSUM9bQojIENPTkZJ
R19DUllQVE9fUk1EMTI4IGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX1JNRDE2MCBpcyBu
b3Qgc2V0CiMgQ09ORklHX0NSWVBUT19STUQyNTYgaXMgbm90IHNldAojIENPTkZJR19DUllQ
VE9fUk1EMzIwIGlzIG5vdCBzZXQKQ09ORklHX0NSWVBUT19TSEExPXkKIyBDT05GSUdfQ1JZ
UFRPX1NIQTFfUFBDIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX1NIQTFfUFBDX1NQRSBp
cyBub3Qgc2V0CkNPTkZJR19DUllQVE9fU0hBMjU2PXkKIyBDT05GSUdfQ1JZUFRPX1NIQTI1
Nl9QUENfU1BFIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX1NIQTUxMiBpcyBub3Qgc2V0
CiMgQ09ORklHX0NSWVBUT19UR1IxOTIgaXMgbm90IHNldAojIENPTkZJR19DUllQVE9fV1A1
MTIgaXMgbm90IHNldAoKIwojIENpcGhlcnMKIwpDT05GSUdfQ1JZUFRPX0FFUz15CiMgQ09O
RklHX0NSWVBUT19BRVNfUFBDX1NQRSBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19BTlVC
SVMgaXMgbm90IHNldApDT05GSUdfQ1JZUFRPX0FSQzQ9eQojIENPTkZJR19DUllQVE9fQkxP
V0ZJU0ggaXMgbm90IHNldAojIENPTkZJR19DUllQVE9fQ0FNRUxMSUEgaXMgbm90IHNldAoj
IENPTkZJR19DUllQVE9fQ0FTVDUgaXMgbm90IHNldAojIENPTkZJR19DUllQVE9fQ0FTVDYg
aXMgbm90IHNldApDT05GSUdfQ1JZUFRPX0RFUz15CiMgQ09ORklHX0NSWVBUT19GQ1JZUFQg
aXMgbm90IHNldAojIENPTkZJR19DUllQVE9fS0hBWkFEIGlzIG5vdCBzZXQKIyBDT05GSUdf
Q1JZUFRPX1NBTFNBMjAgaXMgbm90IHNldAojIENPTkZJR19DUllQVE9fU0VFRCBpcyBub3Qg
c2V0CiMgQ09ORklHX0NSWVBUT19TRVJQRU5UIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRP
X1RFQSBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19UV09GSVNIIGlzIG5vdCBzZXQKCiMK
IyBDb21wcmVzc2lvbgojCiMgQ09ORklHX0NSWVBUT19ERUZMQVRFIGlzIG5vdCBzZXQKIyBD
T05GSUdfQ1JZUFRPX1pMSUIgaXMgbm90IHNldAojIENPTkZJR19DUllQVE9fTFpPIGlzIG5v
dCBzZXQKIyBDT05GSUdfQ1JZUFRPX0xaNCBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19M
WjRIQyBpcyBub3Qgc2V0CgojCiMgUmFuZG9tIE51bWJlciBHZW5lcmF0aW9uCiMKIyBDT05G
SUdfQ1JZUFRPX0FOU0lfQ1BSTkcgaXMgbm90IHNldApDT05GSUdfQ1JZUFRPX0RSQkdfTUVO
VT15CkNPTkZJR19DUllQVE9fRFJCR19ITUFDPXkKIyBDT05GSUdfQ1JZUFRPX0RSQkdfSEFT
SCBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19EUkJHX0NUUiBpcyBub3Qgc2V0CkNPTkZJ
R19DUllQVE9fRFJCRz15CiMgQ09ORklHX0NSWVBUT19VU0VSX0FQSV9IQVNIIGlzIG5vdCBz
ZXQKIyBDT05GSUdfQ1JZUFRPX1VTRVJfQVBJX1NLQ0lQSEVSIGlzIG5vdCBzZXQKIyBDT05G
SUdfQ1JZUFRPX1VTRVJfQVBJX1JORyBpcyBub3Qgc2V0CkNPTkZJR19DUllQVE9fSFc9eQpD
T05GSUdfQ1JZUFRPX0RFVl9GU0xfQ0FBTT15CkNPTkZJR19DUllQVE9fREVWX0ZTTF9DQUFN
X0pSPXkKQ09ORklHX0NSWVBUT19ERVZfRlNMX0NBQU1fUklOR1NJWkU9OQojIENPTkZJR19D
UllQVE9fREVWX0ZTTF9DQUFNX0lOVEMgaXMgbm90IHNldApDT05GSUdfQ1JZUFRPX0RFVl9G
U0xfQ0FBTV9DUllQVE9fQVBJPXkKQ09ORklHX0NSWVBUT19ERVZfRlNMX0NBQU1fQUhBU0hf
QVBJPXkKQ09ORklHX0NSWVBUT19ERVZfRlNMX0NBQU1fUk5HX0FQST15CiMgQ09ORklHX0NS
WVBUT19ERVZfRlNMX0NBQU1fREVCVUcgaXMgbm90IHNldAojIENPTkZJR19DUllQVE9fREVW
X1RBTElUT1MgaXMgbm90IHNldAojIENPTkZJR19BU1lNTUVUUklDX0tFWV9UWVBFIGlzIG5v
dCBzZXQKQ09ORklHX1BQQ19MSUJfUkhFQVA9eQojIENPTkZJR19WSVJUVUFMSVpBVElPTiBp
cyBub3Qgc2V0Cg==
--------------010602030401010803000502--
