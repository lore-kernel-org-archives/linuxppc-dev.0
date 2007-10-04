Return-Path: <jacmet@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.191])
	by ozlabs.org (Postfix) with ESMTP id 47B1CDDDFF
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  4 Oct 2007 21:21:42 +1000 (EST)
Received: by nf-out-0910.google.com with SMTP id c10so131648nfd
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 04 Oct 2007 04:21:39 -0700 (PDT)
To: Bruce_Leonard@selinc.com
Subject: Re: Device tree and external RTC
References: <OFFFD4BE8F.17F6E427-ON88257369.006D8651-88257369.00736D96@selinc.com>
From: Peter Korsgaard <jacmet@sunsite.dk>
Date: Thu, 04 Oct 2007 13:21:10 +0200
In-Reply-To: <OFFFD4BE8F.17F6E427-ON88257369.006D8651-88257369.00736D96@selinc.com>
	(Bruce Leonard's message of "Wed\, 3 Oct 2007 14\:00\:49 -0700")
Message-ID: <87ve9nw2ft.fsf@macbook.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: Peter Korsgaard <jacmet@gmail.com>
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

>>>>> "Bruce" == Bruce Leonard <Bruce_Leonard@selinc.com> writes:

Hi,

 Bruce> I'm seriously confused by how things are supposed to work now
 Bruce> with device trees on the PowerPC arch.  I'm bringing up our
 Bruce> custom HW which is bassed on the mpc8347e, with an m41t00 RTC
 Bruce> hanging off the i2c bus, U-boot is 1.2.0, kernel is 2.6.22.
 Bruce> My problem is I can't get the kernel to access the RTC.  It
 Bruce> works fine in U-boot, but nothing in the kernel.
 Bruce> I've searched through all the device tree files that come with
 Bruce> the kernel 

 Bruce> and I can't find any that explicitly show an external device
 Bruce> as a child node to a SoC I2C controller but it sure seems to
 Bruce> me that the purpose of the device tree is to describe to the
 Bruce> kernel all the hardware in the system.  Therefore it seems to
 Bruce> me that there should be something like the following in the
 Bruce> device tree:

 Bruce> <snip>
 Bruce> i2c@3000 {
 Bruce>         device_type = "i2c";
 Bruce>         compatible = "fsl-i2c";
 Bruce>         reg = <3000 100>;
 Bruce>         interrupts = <e 8>;
 Bruce>         interrupt-parent = < &ipic >;
 Bruce>         dfsrr;

You need to add #address/size-cells to the I2C node, E.G.:
+			#address-cells = <1>;
+			#size-cells = <0>;

 Bruce>         rtc@54 {
 Bruce>                 device_type = "rtc";
 Bruce>                 something;
 Bruce>                 something;
 Bruce>                 something;
 Bruce>         }
 Bruce> }
 Bruce> <snip>

You need to set compatible and reg, E.G.
			rtc@54 {
				device_type = "rtc";
				compatible = "stm,m41t00";
				reg = <54>;
			};

And it should get picked up automatically by
fsl_soc.c:of_find_i2c_driver().

Notice that you will need to use galak's git tree
(git://git.kernel.org/pub/scm/linux/kernel/git/galak/powerpc.git) or
apply the following patch:

http://ozlabs.org/pipermail/linuxppc-dev/2007-September/042896.html

As it isn't in mainline yet.

-- 
Bye, Peter Korsgaard
