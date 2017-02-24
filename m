Return-Path: <yc_chen@aspeedtech.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vV2hp2wmfzDqGv
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Feb 2017 18:26:18 +1100 (AEDT)
Received: from twspam01.aspeedtech.com (twspam01.aspeedtech.com
 [211.20.114.71]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vV2hn5JLtz9s7R
 for <linuxppc-dev@ozlabs.org>; Fri, 24 Feb 2017 18:26:17 +1100 (AEDT)
Received: from twspam01.aspeedtech.com (localhost [127.0.0.2])
 by twspam01.aspeedtech.com with ESMTP id v1O7InVA056918
 for <linuxppc-dev@ozlabs.org>; Fri, 24 Feb 2017 15:18:49 +0800 (CST)
 (envelope-from yc_chen@aspeedtech.com)
From: YC Chen <yc_chen@aspeedtech.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
CC: "airlied@redhat.com" <airlied@redhat.com>, "eich@suse.come"
 <eich@suse.come>, "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>, "YC
 Chen" <yc_chen@aspeedtech.com>
Subject: RE: [PATCH 02/12] drm/ast: Handle configuration without P2A bridge
Date: Fri, 24 Feb 2017 07:06:15 +0000
Message-ID: <02959276a43f4ac1af08fdb78815e124@TWMBX01.aspeed.com>
References: <20170223225357.9572-1-benh@kernel.crashing.org>
 <20170223225357.9572-2-benh@kernel.crashing.org>
In-Reply-To: <20170223225357.9572-2-benh@kernel.crashing.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Tested-by: Y.C. Chen <yc_chen@aspeedtech.com>

-----Original Message-----
From: Benjamin Herrenschmidt [mailto:benh@kernel.crashing.org]=20
Sent: Friday, February 24, 2017 6:54 AM
To: dri-devel@lists.freedesktop.org
Cc: YC Chen <yc_chen@aspeedtech.com>; airlied@redhat.com; eich@suse.come; l=
inuxppc-dev@ozlabs.org
Subject: [PATCH 02/12] drm/ast: Handle configuration without P2A bridge

From: Russell Currey <ruscur@russell.cc>

The ast driver configures a window to enable access into BMC memory space i=
n order to read some configuration registers.

If this window is disabled, which it can be from the BMC side, the ast driv=
er can't function.

Closing this window is a necessity for security if a machine's host side an=
d BMC side are controlled by different parties; i.e. a cloud provider offer=
ing machines "bare metal".

A recent patch went in to try to check if that window is open but it does s=
o by trying to access the registers in question and testing if the result i=
s 0xffffffff.

This method will trigger a PCIe error when the window is closed which on so=
me systems will be fatal (it will trigger an EEH for example on POWER which=
 will take out the device).

This patch improves this in two ways:

 - First, if the firmware has put properties in the device-tree containing =
the relevant configuration information, we use these.

 - Otherwise, a bit in one of the SCU scratch registers (which are readable=
 via the VGA register space and writeable by the BMC) will indicate if the =
BMC has closed the window. This bit has been defined by Y.C Chen from Aspee=
d.

If the window is closed and the configuration isn't available from the devi=
ce-tree, some sane defaults are used. Those defaults are hopefully sufficie=
nt for standard video modes used on a server.

Signed-off-by: Russell Currey <ruscur@russell.cc>
Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
