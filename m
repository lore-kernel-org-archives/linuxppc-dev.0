Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id CE4EEB6F10
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 13 Jul 2010 11:43:23 +1000 (EST)
Date: Tue, 13 Jul 2010 11:43:22 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linus <torvalds@linux-foundation.org>, Michal Marek <mmarek@suse.cz>
Subject: [PATCH] kbuild: Enable building defconfigs from Kconfig files
Message-Id: <20100713114322.57c8b166.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	ppc-dev <linuxppc-dev@lists.ozlabs.org>,
	LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

After this change, doing a "make xxx_defconfig" will check first for
a file called arch/<arch>/configs/Kconfig.xxx and use that to generate
the .config (effectively starting from an allnoconfig).  If that file
doesn't exist, it will use arch/<ARCH>/configs/xxx_defconfig as now.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 scripts/kconfig/Makefile |   14 +++++++++++++-
 1 files changed, 13 insertions(+), 1 deletions(-)

Hi Linus,

Is this more the direction you want to take?

There are still 2 main problems with is approach:

	- there are some config options that are globally and
unconditionally enabled that some platforms may not want.  The only way
currently to turn them off is to reproduce the config entry with the
different default.  I am not sure if we need a wa to turn them off or to
just change them to being neede to be selected by those that do want them.
	- we have no way to select options that are neither bool or
tristate to suitable values.  Again the only way to do that currently is
to reproduce the config entry with a different default value.

I am currently working towards using this to recreate the PowerPC
defconfigs, but it is a slow process as they have some much stuff enabled
in them and some of it is probably actually not relevant.

This process is made easier by the recent commit "kbuild: Warn on
selecting symbols with unmet direct dependencies" that is in the kbuild
tree (and linux-next).

diff --git a/scripts/kconfig/Makefile b/scripts/kconfig/Makefile
index 7ea649d..1ab8f45 100644
--- a/scripts/kconfig/Makefile
+++ b/scripts/kconfig/Makefile
@@ -117,9 +117,21 @@ else
 	$(Q)$< -D arch/$(SRCARCH)/configs/$(KBUILD_DEFCONFIG) $(Kconfig)
 endif
 
-%_defconfig: $(obj)/conf
+configs_dir := $(srctree)/arch/$(SRCARCH)/configs
+# We check a level of sub directories because arch/powerpc
+# has its defconfig files arranged that way
+old_defconfigs := $(patsubst $(configs_dir)/%,%,\
+	$(wildcard $(configs_dir)/*_defconfig) \
+	$(wildcard $(configs_dir)/*/*_defconfig))
+defconfigs := $(patsubst $(configs_dir)/Kconfig.%,%_defconfig,\
+	$(wildcard $(configs_dir)/Kconfig.*))
+
+$(old_defconfigs): %_defconfig: $(obj)/conf
 	$(Q)$< -D arch/$(SRCARCH)/configs/$@ $(Kconfig)
 
+$(defconfigs): %_defconfig: $(obj)/conf
+	$(Q)$< -n arch/$(SRCARCH)/configs/Kconfig.$*
+
 # Help text used by make help
 help:
 	@echo  '  config	  - Update current config utilising a line-oriented program'
-- 
1.7.1

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
