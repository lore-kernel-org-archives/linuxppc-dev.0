Return-Path: <abounine@idt.com>
Received: from mxout1.idt.com (mxout1.idt.com [157.165.5.25])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mxout1.idt.com", Issuer "idt.com" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4B21D2C00ED
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Apr 2013 00:43:51 +1000 (EST)
From: Alexandre Bounine <alexandre.bounine@idt.com>
To: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0/3] rapidio: changes to enumeration/discovery
Date: Wed, 24 Apr 2013 10:31:56 -0400
Message-Id: <1366813919-13766-1-git-send-email-alexandre.bounine@idt.com>
Cc: Micha Nelissen <micha.nelissen@Prodrive.nl>,
 Andre van Herk <andre.van.herk@Prodrive.nl>,
 Alexandre Bounine <alexandre.bounine@idt.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Systems that use RapidIO fabric may need to implement their own enumeration
and discovery methods which are better suitable for needs of a target
application.

The following set of patches is intended to simplify process of introduction of
new RapidIO fabric enumeration/discovery methods.

The first patch offers ability to add new RapidIO enumeration/discovery methods
using kernel configuration options or loadable modules. The new configuration
option mechanism allows to select built-in or modular enumeration/discovery
method from the list of existing methods or use external module(s).

This patch also updates the currently existing enumeration/discovery code to be
used as built-in or modular method. The corresponding configuration option is
named "Basic enumeration/discovery" method. This is the only one built-in
configuration option available today but new methods are expected to be
introduced after adoption of provided patches.

The second patch address a long time complaint of RapidIO subsystem users
regarding fabric enumeration/discovery start sequence. Existing implementation
offers only a boot-time enumeration/discovery start which requires synchronized
boot of all endpoints in RapidIO network. While it works for small closed
configurations with limited number of endpoints, using this approach in systems
with large number of endpoints is quite challenging.

To eliminate requirement for synchronized start the second patch introduces
RapidIO enumeration/discovery start from user space.

For compatibility with the existing RapidIO subsystem implementation, automatic
boot time enumeration/discovery start can be configured in by selecting
CONFIG_RAPIDIO_ENUM_AUTO option.

Cc: Matt Porter <mporter@kernel.crashing.org>
Cc: Li Yang <leoli@freescale.com>
Cc: Kumar Gala <galak@kernel.crashing.org>
Cc: Andre van Herk <andre.van.herk@Prodrive.nl>
Cc: Micha Nelissen <micha.nelissen@Prodrive.nl>

Alexandre Bounine (3):
  rapidio: make enumeration/discovery configurable
  rapidio: add enumeration/discovery start from user space
  rapidio: documentation update for enumeration changes

 Documentation/rapidio/rapidio.txt |  137 ++++++++++++++++++++--
 Documentation/rapidio/sysfs.txt   |   17 +++
 drivers/rapidio/Kconfig           |   28 +++++
 drivers/rapidio/Makefile          |    3 +-
 drivers/rapidio/rio-driver.c      |    8 ++
 drivers/rapidio/rio-scan.c        |  195 ++++++++++--------------------
 drivers/rapidio/rio-sysfs.c       |   45 +++++++
 drivers/rapidio/rio.c             |  234 ++++++++++++++++++++++++++++++++++++-
 drivers/rapidio/rio.h             |   12 ++-
 include/linux/rio.h               |   17 +++
 include/linux/rio_drv.h           |    1 +
 11 files changed, 548 insertions(+), 149 deletions(-)

-- 
1.7.8.4
