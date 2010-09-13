Return-Path: <joe@perches.com>
Received: from mail.perches.com (mail.perches.com [173.55.12.10])
	by ozlabs.org (Postfix) with ESMTP id 9AEF8B70A7
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 14 Sep 2010 05:48:24 +1000 (EST)
From: Joe Perches <joe@perches.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 00/25] treewide-next: Use static const char arrays
Date: Mon, 13 Sep 2010 12:47:38 -0700
Message-Id: <cover.1284406638.git.joe@perches.com>
Cc: Amit Kumar Salecha <amit.salecha@qlogic.com>, linux-fbdev@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@suse.de>,
	James Smart <james.smart@emulex.com>, linux-mips@linux-mips.org,
	"VMware, Inc." <pv-drivers@vmware.com>,
	PJ Waskiewicz <peter.p.waskiewicz.jr@intel.com>,
	Shreyas Bhatewara <sbhatewara@vmware.com>,
	alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>,
	"J. Bruce Fields" <bfields@fieldses.org>,
	"James E.J. Bottomley" <James.Bottomley@suse.de>,
	Paul Mackerras <paulus@samba.org>, linux-i2c@vger.kernel.org,
	Brett Rudley <brudley@broadcom.com>, sparclinux@vger.kernel.org,
	Martin Schwidefsky <schwidefsky@de.ibm.com>,
	devel@driverdev.osuosl.org, linux-s390@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-scsi@vger.kernel.org,
	Florian Tobias Schandinat <FlorianSchandinat@gmx.de>,
	e1000-devel@lists.sourceforge.net,
	Trond Myklebust <Trond.Myklebust@netapp.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>, Neil Brown <neilb@suse.de>,
	Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
	linux-wireless@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
	linux-usb@vger.kernel.org, Len Brown <lenb@kernel.org>,
	Alex Duyck <alexander.h.duyck@intel.com>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Henry Ptasinski <henryp@broadcom.com>,
	Heiko Carstens <heiko.carstens@de.ibm.com>,
	Thomas Winischhofer <thomas@winischhofer.net>,
	Mauro Carvalho Chehab <mchehab@infradead.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	"Jean Delvare \(PC drivers, core\)" <khali@linux-fr.org>,
	mjpeg-users@lists.sourceforge.net,
	"Ben Dooks \(embedded platforms\)" <ben-linux@fluff.org>,
	linux-nfs@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Neela Syam Kolli <megaraidlinux@lsi.com>,
	Karsten Keil <isdn@linux-pingi.de>,
	Linus Walleij <linus.walleij@stericsson.com>, netdev@vger.kernel.org,
	Anirban Chakraborty <anirban.chakraborty@qlogic.com>,
	Bruce Allan <bruce.w.allan@intel.com>, Nohee Ko <noheek@broadcom.com>,
	Ralf Baechle <ralf@linux-mips.org>, Joseph Chan <JosephChan@via.com.tw>,
	John Ronciak <john.ronciak@intel.com>,
	Takashi Iwai <tiwai@suse.de>, linux-driver@qlogic.com,
	linux390@de.ibm.com, linux-media@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Using static const char foo[] = "bar" can save some
code and text space, so change the places where it's possible.

Also change the places that use
	char foo[] = "barX";
	...
	foo[3] = value + '0';
where X is typically changed
	char foo[sizeof("barX")];
	...
	sprintf(foo, "bar%c", value + '0');

Joe Perches (25):
  arch/mips: Use static const char arrays
  arch/powerpc: Use static const char arrays
  drivers/acpi: Use static const char arrays
  drivers/char: Use static const char arrays
  drivers/i2c: Use static const char arrays
  drivers/isdn: Use static const char arrays
  drivers/media: Use static const char arrays
  drivers/net/atl1c: Use static const char arrays
  drivers/net/atl1e: Use static const char arrays
  drivers/net/(intel): Use static const char arrays
  drivers/net/netxen: Use static const char arrays
  drivers/net/qlcnic: Use static const char arrays
  drivers/net/spider_net.c: Use static const char arrays
  drivers/net/vnxnet3: Use static const char arrays
  drivers/net/wireless/ipw2x00: Use static const char arrays
  drivers/s390/char: Use static const char arrays
  drivers/scsi: Use static const char arrays
  drivers/serial/suncore.c: Use static const char arrays
  drivers/staging: Use static const char arrays
  drivers/usb: Use static const char arrays
  drivers/video: Use static const char arrays
  net/dsa: Use static const char arrays
  net/sunrpc: Use static const char arrays
  sound: Use static const char arrays
  tools/perf/util: Use static const char arrays

 arch/mips/pnx8550/common/reset.c                   |    4 ++--
 arch/powerpc/boot/addnote.c                        |    4 ++--
 arch/powerpc/boot/cuboot-c2k.c                     |    4 ++--
 arch/powerpc/kernel/irq.c                          |    2 +-
 drivers/acpi/sleep.c                               |    4 ++--
 drivers/char/hvc_vio.c                             |    2 +-
 drivers/i2c/busses/i2c-stu300.c                    |    4 ++--
 drivers/isdn/hysdn/hycapi.c                        |    2 +-
 drivers/isdn/mISDN/dsp_cmx.c                       |    2 +-
 drivers/media/video/zoran/zoran_device.c           |    5 ++---
 drivers/net/atl1c/atl1c.h                          |    4 ++--
 drivers/net/atl1c/atl1c_main.c                     |    4 ++--
 drivers/net/atl1e/atl1e.h                          |    4 ++--
 drivers/net/atl1e/atl1e_main.c                     |    4 ++--
 drivers/net/e1000/e1000.h                          |    2 +-
 drivers/net/e1000/e1000_main.c                     |    4 ++--
 drivers/net/e1000e/e1000.h                         |    2 +-
 drivers/net/e1000e/netdev.c                        |    2 +-
 drivers/net/igb/igb.h                              |    4 ++--
 drivers/net/igb/igb_main.c                         |    4 ++--
 drivers/net/igbvf/igbvf.h                          |    2 +-
 drivers/net/igbvf/netdev.c                         |    2 +-
 drivers/net/ixgb/ixgb.h                            |    2 +-
 drivers/net/ixgb/ixgb_main.c                       |    2 +-
 drivers/net/ixgbe/ixgbe.h                          |    2 +-
 drivers/net/ixgbe/ixgbe_main.c                     |    4 ++--
 drivers/net/ixgbevf/ixgbevf.h                      |    2 +-
 drivers/net/ixgbevf/ixgbevf_main.c                 |    2 +-
 drivers/net/netxen/netxen_nic.h                    |    2 +-
 drivers/net/netxen/netxen_nic_main.c               |    2 +-
 drivers/net/qlcnic/qlcnic.h                        |    2 +-
 drivers/net/qlcnic/qlcnic_main.c                   |    2 +-
 drivers/net/spider_net.c                           |    2 +-
 drivers/net/vmxnet3/vmxnet3_drv.c                  |    2 +-
 drivers/net/vmxnet3/vmxnet3_int.h                  |    2 +-
 drivers/net/wireless/ipw2x00/ipw2100.c             |    2 +-
 drivers/net/wireless/ipw2x00/ipw2200.c             |    2 +-
 drivers/net/wireless/ipw2x00/libipw_module.c       |    2 +-
 drivers/s390/char/vmlogrdr.c                       |    4 ++--
 drivers/scsi/bnx2i/bnx2i_hwi.c                     |    6 +++---
 drivers/scsi/lpfc/lpfc_init.c                      |    2 +-
 drivers/scsi/megaraid/megaraid_mbox.c              |    6 +++---
 drivers/serial/suncore.c                           |    4 ++--
 drivers/staging/brcm80211/util/bcmutils.c          |    2 +-
 drivers/staging/comedi/drivers/comedi_bond.c       |    2 +-
 drivers/staging/cxt1e1/ossiRelease.c               |    2 +-
 drivers/staging/go7007/go7007-driver.c             |    2 +-
 drivers/staging/msm/mdp.c                          |    2 +-
 .../staging/rtl8192e/ieee80211/ieee80211_module.c  |    2 +-
 .../staging/rtl8192u/ieee80211/ieee80211_module.c  |    2 +-
 drivers/staging/tidspbridge/rmgr/dbdcd.c           |    6 +++---
 drivers/usb/atm/ueagle-atm.c                       |   14 +++++---------
 drivers/usb/otg/langwell_otg.c                     |    2 +-
 drivers/video/sh_mipi_dsi.c                        |    4 ++--
 drivers/video/sis/sis_main.c                       |   10 +++++-----
 drivers/video/via/viafbdev.c                       |    2 +-
 net/dsa/dsa.c                                      |    2 +-
 net/dsa/dsa_priv.h                                 |    2 +-
 net/sunrpc/auth_gss/gss_krb5_mech.c                |    2 +-
 sound/core/misc.c                                  |    5 ++++-
 tools/perf/util/ui/setup.c                         |    3 ++-
 tools/perf/util/ui/util.c                          |    3 ++-
 62 files changed, 98 insertions(+), 98 deletions(-)

-- 
1.7.3.rc1
