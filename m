Return-Path: <mditto@consentry.com>
Received: from tidalnetworks.net (mail.consentry.com [75.35.230.10])
	by ozlabs.org (Postfix) with ESMTP id 39B86DDF7D
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Oct 2008 12:05:04 +1100 (EST)
Message-ID: <48F7E1E6.4040701@consentry.com>
Date: Thu, 16 Oct 2008 17:52:54 -0700
From: Mike Ditto <mditto@consentry.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: device tree variations
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I'm building a kernel that can run on a handful of hardware
configurations, all using OF-unaware U-Boot.  I know how to make a
static device tree (dts file) that works on one of these hardware
variations, and how to add nodes and modify properties in the platform
init code.  But I don't see a nice way to deal with nodes that should be
present on only some hardware configurations.

I could have the dts file contain only the common elements, and add all
the variable elements in the startup code.  But that means the bulk of
the device tree will be expressed as relatively ugly C source instead of
the much more readable and maintainable dts notation.  I would much
rather have the dts file contain the union of all platforms and have the
platform init code delete the nodes that are not applicable, but I don't
see an API to do those deletions.

I suppose I could instead compile N different dts files and have the
platform init code pick the appropriate dtb blob to pass to fdt_init().

Any suggestions for the best way to do this?

					-=] Mike [=-
