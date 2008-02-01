Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from outbound2-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 208A0DDF3F
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Feb 2008 06:32:29 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [RFC/PATCH v2] [POWERPC] bootwrapper: build multiple cuImages
Date: Fri, 1 Feb 2008 11:32:23 -0800
In-Reply-To: <20080201000706.18869.36903.stgit@trillian.secretlab.ca>
References: <20080201000706.18869.36903.stgit@trillian.secretlab.ca>
From: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
To: "Grant Likely" <grant.likely@secretlab.ca>, <jwboyer@gmail.com>,
	<linuxppc-dev@ozlabs.org>, <scotwood@freescale.com>,
	<galak@kernel.crashing.org>, <jochen@scram.de>,
	<geoffrey.levand@am.sony.com>
Message-Id: <20080201193225.67CFAAF0057@mail201-sin.bigfish.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

What if it was something like:

image-$(CONFIG_MPC832x_MDS)		+=3D cuImage.mpc832x_mds
image-$(CONFIG_MPC832x_RDB)		+=3D cuImage.mpc832x_rdb
image-$(CONFIG_MPC834x_ITX)		+=3D cuImage.mpc8349emitx \
					   cuImage.mpc8349emitxgp
platform-$(CONFIG_MPC83xx)		+=3D cuboot-83xx.o

$(obj)/cuImage.%: vmlinux $(dtstree)/%.dts $(wrapperbits) $(platform-y)
	$(call if_changed,wrap,$(platform-y),(dtstree)/$*.dts)

Which would eliminate making all the unnecessary bits of platform code
and enabling the smart bits to be factored out of the wrapper?  It would
also make the dependency between the board and the platform code
specific.It would also prevent building more than one platform at a
time, but I don't think that's really possibly anyway?

Steve
