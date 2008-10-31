Return-Path: <mditto@consentry.com>
Received: from tidalnetworks.net (mail.consentry.com [75.35.230.10])
	by ozlabs.org (Postfix) with ESMTP id CFE6DDDDEF
	for <linuxppc-dev@ozlabs.org>; Sat,  1 Nov 2008 08:19:48 +1100 (EST)
Message-ID: <490B7672.3040904@consentry.com>
Date: Fri, 31 Oct 2008 14:19:46 -0700
From: Mike Ditto <mditto@consentry.com>
MIME-Version: 1.0
To: Jochen Friedrich <jochen@scram.de>
Subject: Re: [PATCH] i2c-cpm: Add flexibility for I2C clock frequency and
	filter.
References: <490A84F8.20403@consentry.com> <490AEEBF.9000707@scram.de>
In-Reply-To: <490AEEBF.9000707@scram.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, i2c@lm-sensors.org,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jochen Friedrich wrote:
> What needs to be done though is to document this change in
> Documentation/powerpc/dts-bindings/fsl/cpm_qe/cpm/i2c.txt.

How about the below?

I'll wait for David to comment on the property name and for any suggestions
on the documentation below, then I'll submit a new patch.


--- linux/Documentation/powerpc/dts-bindings/fsl/cpm_qe/cpm/i2c.txt	11 Oct 2008 02:49:31 -0000	1.1.1.1
+++ linux/Documentation/powerpc/dts-bindings/fsl/cpm_qe/cpm/i2c.txt	31 Oct 2008 21:15:06 -0000
@@ -10,8 +10,12 @@
 - #address-cells : Should be one. The cell is the i2c device address with
   the r/w bit set to zero.
 - #size-cells : Should be zero.
-- clock-frequency : Can be used to set the i2c clock frequency. If
-  unspecified, a default frequency of 60kHz is being used.
+- clock-frequency : Can be used to set the desired i2c clock frequency (in Hz).
+  If unspecified, a default of 60 kHz is being used.  The actual frequency may
+  be somewhat higher than this value, depending on how the BRG_CLK and dividers
+  work out.
+- clock-filter : boolean; if defined, indicates that this controller
+  should enable the SCL digital filter.
 The following two properties are deprecated. They are only used by legacy
 i2c drivers to find the bus to probe:
 - linux,i2c-index : Can be used to hard code an i2c bus number. By default,
