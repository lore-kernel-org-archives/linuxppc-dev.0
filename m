Return-Path: <rpjday@crashcourse.ca>
Received: from smtp485.redcondor.net (smtp485.redcondor.net [208.80.204.85])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r27m64NSszDqBh
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 May 2016 22:50:29 +1000 (AEST)
Received: from astoria.ccjclearline.com ([64.235.106.9])
 by smtp485.redcondor.net ({3be039ea-4351-44b0-a8af-642c38b25916})
 via TCP (outbound) with ESMTPS id 20160507124000148_0485
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 07 May 2016 12:40:00 +0000
Received: from [216.191.234.70] (port=26251 helo=crashcourse.ca)
 by astoria.ccjclearline.com with esmtpsa (TLSv1:AES256-SHA:256)
 (Exim 4.80) (envelope-from <rpjday@crashcourse.ca>)
 id 1az1Y3-0002jN-E3
 for linuxppc-dev@lists.ozlabs.org; Sat, 07 May 2016 08:41:31 -0400
Date: Sat, 7 May 2016 08:39:33 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
To: Linux PPC Mailing List <linuxppc-dev@lists.ozlabs.org>
Subject: MPC8360, quicc engine, bus-frequency and brg-frequency
Message-ID: <alpine.LFD.2.20.1605070824370.4477@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


  currently working on a project porting linux (4.1 kernel right now)
to MPC8360-based target board and, recently, was handed the following
patch to apply to that board's DTS file:

@@ -168,8 +168,8 @@
                compatible = "fsl,qe", "simple-bus";
                ranges = <0 0xf0100000 0x00100000>;
                reg = <0xf0100000 0x480>;
-               brg-frequency = <0>;
-               bus-frequency = <0xFBC5200>; // 264Mhz
+               brg-frequency = <198000000>;
+               bus-frequency = <396000000>;
                fsl,qe-num-riscs = <2>;
                fsl,qe-num-snums = <28>;


to get the result:

        qe@f0100000 {
                #address-cells = <1>;
                #size-cells = <1>;
                device_type = "qe";
                compatible = "fsl,qe", "simple-bus";
                ranges = <0 0xf0100000 0x00100000>;
                reg = <0xf0100000 0x480>;
                brg-frequency = <198000000>;              <-----
                bus-frequency = <396000000>;              <-----
                fsl,qe-num-riscs = <2>;
                fsl,qe-num-snums = <28>;


but there was no explanation that came with the patch and i'm trying
to guess the rationale.

  first, regarding brg-frequency, if i examine the collection of PPC
.dts files in the kernel source right now, i see this:

$ grep -r brg-frequency *
fsl/mpc8568si-post.dtsi:	brg-frequency = <0>;
fsl/mpc8569si-post.dtsi:	brg-frequency = <0>;
kmeter1.dts:			brg-frequency = <0>;	/* Filled in by U-Boot */
mpc832x_mds.dts:		brg-frequency = <0>;
mpc832x_rdb.dts:		brg-frequency = <0>;
mpc836x_mds.dts:		brg-frequency = <0>;
mpc836x_rdk.dts:			brg-frequency = <0>;
mpc866ads.dts:			brg-frequency = <0>;
p1021mds.dts:		brg-frequency = <0>;
p1021rdb-pc_32b.dts:                brg-frequency = <0>;
p1021rdb-pc_36b.dts:                brg-frequency = <0>;
p1025rdb_32b.dts:		brg-frequency = <0>;
p1025twr.dts:		brg-frequency = <0>;
tqm8xx.dts:			brg-frequency = <0>;
$

  so, based on the above, no one else is setting brg-frequency, and
kmeter1.dts even makes it clear that that value is filled in by
u-boot, so what is even a *possible* rationale for setting it
explicitly rather than letting u-boot look after it?

  as for bus-frequency, another sweeping grep exposes this in
mpc836x.dts:

... snip ...

        cpus {
                #address-cells = <1>;
                #size-cells = <0>;

                PowerPC,8360@0 {
                        device_type = "cpu";
                        reg = <0x0>;
                        d-cache-line-size = <32>;       // 32 bytes
                        i-cache-line-size = <32>;       // 32 bytes
                        d-cache-size = <32768>;         // L1, 32K
                        i-cache-size = <32768>;         // L1, 32K
                        timebase-frequency = <66000000>;
                        bus-frequency = <264000000>;

... snip ...

        qe@e0100000 {
                #address-cells = <1>;
                #size-cells = <1>;
                device_type = "qe";
                compatible = "fsl,qe";
                ranges = <0x0 0xe0100000 0x00100000>;
                reg = <0xe0100000 0x480>;
                brg-frequency = <0>;
                bus-frequency = <396000000>;
                fsl,qe-num-riscs = <2>;
                fsl,qe-num-snums = <28>;

... snip ...


where i can see that the system (?) bus is set to 264MHz, but the QE
bus is set to 396MHz. i'm in no way an authority on PowerPC -- this
looks like someone accidentally set the QE bus speed originally to a
valid value for the system bus, and just realized that, oops, it
should have been 396MHz all along.

  anyway, to recap, just trying to understand what this patch under
"qe@f0100000" might mean:

-               brg-frequency = <0>;
-               bus-frequency = <0xFBC5200>; // 264Mhz
+               brg-frequency = <198000000>;
+               bus-frequency = <396000000>;

thank you kindly.

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
