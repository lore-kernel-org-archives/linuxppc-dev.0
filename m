Return-Path: <glikely@secretlab.ca>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.230])
	by ozlabs.org (Postfix) with ESMTP id 6E274DDF00
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 20 Oct 2007 00:38:12 +1000 (EST)
Received: by nz-out-0506.google.com with SMTP id i1so64927nzh
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 19 Oct 2007 07:38:11 -0700 (PDT)
Message-ID: <fa686aa40710190738q1211a266lced10ac8767e5071@mail.gmail.com>
Date: Fri, 19 Oct 2007 08:38:09 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Wolfgang Grandegger" <wg@grandegger.com>
Subject: Re: FDT bindings for I2C devices
In-Reply-To: <4718BB40.2050901@grandegger.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <4718BB40.2050901@grandegger.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 10/19/07, Wolfgang Grandegger <wg@grandegger.com> wrote:
> Hello,
>
> is it forseen to define and configure devices like RTC, temperature
> sensors or EEPROM on the I2C bus with the Flat Device Tree? If yes, how
> would the DTS entries look like?

booting-without-of.txt has some information about describing the controller.

Scott Wood made an attempt at defining a device binding for I2C
devices, but it has not been merged into booting-without-of.txt yet.
I've copied what he wrote below.  I would add to his definition the
following:
- If compatible is missing, driver should *not* fall back to the device name.
- 'compatible' list should include the exact device in the form "<mfg>,<part>"

Cheers,
g.

Here's the thread and an excerpt from Scott's original post:

http://patchwork.ozlabs.org/linuxppc/patch?id=11223

+   e2) I2C Devices
+
+   Required properties :
+
+    - reg : Unshifted 7-bit I2C address for the device
+
+   Recommended properties :
+
+    - compatible : The name of the Linux device driver that
+      handles this device.  If unspecified, the name of the
+      node will be used.
+    - interrupts : <a b> where a is the interrupt number and b is a
+      field that represents an encoding of the sense and level
+      information for the interrupt.  This should be encoded based on
+      the information in section 2) depending on the type of interrupt
+      controller you have.
+    - interrupt-parent : the phandle for the interrupt controller that
+      services interrupts for this device.
+
+   Example :
+
+       rtc@68 {
+               device_type = "rtc";
+               compatible = "ds1374";
+               reg = <68>;
+               interrupts = <13 8>;
+               interrupt-parent = <700>;
+       };

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
