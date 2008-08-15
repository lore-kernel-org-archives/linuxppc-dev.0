Return-Path: <liranrazlinux@gmail.com>
Received: from qb-out-0506.google.com (qb-out-0506.google.com [72.14.204.225])
	by ozlabs.org (Postfix) with ESMTP id DED96DE243
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 16 Aug 2008 00:23:31 +1000 (EST)
Received: by qb-out-0506.google.com with SMTP id d11so1118557qbd.39
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 15 Aug 2008 07:23:30 -0700 (PDT)
Message-ID: <e3b3ab5c0808150723o5a4ff1f4je677c7a4475f89b7@mail.gmail.com>
Date: Fri, 15 Aug 2008 10:23:29 -0400
From: "liran raz" <liranrazlinux@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: flash partitioning
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_79193_29835615.1218810209347"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_79193_29835615.1218810209347
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

hi,
Using the following configuration in the
dts file (mpc8272ads.dts):

 localbus@f0010100 {
  compatible = "fsl,mpc8272-localbus",
               "fsl,pq2-localbus";
  #address-cells = <2>;
  #size-cells = <1>;
  reg = <f0010100 40>;

  ranges = <0 0 fc000000 04000000>;
        };

flash@fc000000 {
                device_type = "rom";
                compatible = "direct-mapped";
                probe-type = "CFI";
  reg = <fc000000 04000000>;
  bank-width = <4>;
  device-width = <2>;
  #address-cells = <1>;
  #size-cells = <1>;
                partitions = <0 200000
                              2000000 a00000
                              c000000 a00000
                              16000000 600000
                              1c000000 e00000
                              2a000000 600000
                              30000000 e00000
                              3e000000 100000
                              3f000000 80000
                              3f800000 40000
                              3fc00000 40000>;
                partition-names =
"part01","part02","part03","part04","part05","part06","part07","part08","part09","part10","part11";
 };

I can't see the different partitions linked to the /dev/mtd<x>
devices in the startup messages. When testing the devices
I see that only /dev/mtd0 is actually linked to the beginning
of the flash. (other /dev/mtd1 etc.. can't be opened).
I included below also the relevant startup messages.
Does anyone have any idea what is wrong with my flash
configuration format?
Thanks, Liran.

Linux version: 2.6.24
Processor: mpc8272
Startup messages:
physmap platform flash device: 04000000 at fc000000
physmap-flash.0: Found 2 x16 devices at 0x0 in 32-bit bank
 Amd/Fujitsu Extended Query Table at 0x0040
physmap-flash.0: CFI does not contain boot bank location. Assuming top.
number of CFI chips: 1
cfi_cmdset_0002: Disabling erase-suspend-program due to code brokenness.

------=_Part_79193_29835615.1218810209347
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<p>hi,<br>Using the following configuration in the<br>dts file (mpc8272ads.dts):</p>
<p>&nbsp;<a href="mailto:localbus@f0010100">localbus@f0010100</a> {<br>&nbsp;&nbsp;compatible = &quot;fsl,mpc8272-localbus&quot;,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;fsl,pq2-localbus&quot;;<br>&nbsp;&nbsp;#address-cells = &lt;2&gt;;<br>&nbsp;&nbsp;#size-cells = &lt;1&gt;;<br>
&nbsp;&nbsp;reg = &lt;f0010100 40&gt;;</p>
<p>&nbsp;&nbsp;ranges = &lt;0 0 fc000000 04000000&gt;;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; };</p>
<p><a href="mailto:flash@fc000000">flash@fc000000</a> {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; device_type = &quot;rom&quot;;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; compatible = &quot;direct-mapped&quot;;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; probe-type = &quot;CFI&quot;;<br>&nbsp;&nbsp;reg = &lt;fc000000 04000000&gt;;<br>
&nbsp;&nbsp;bank-width = &lt;4&gt;;<br>&nbsp;&nbsp;device-width = &lt;2&gt;;<br>&nbsp;&nbsp;#address-cells = &lt;1&gt;;<br>&nbsp;&nbsp;#size-cells = &lt;1&gt;;</p>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; partitions = &lt;0 200000<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2000000 a00000<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; c000000 a00000<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 16000000 600000<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1c000000 e00000<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2a000000 600000<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 30000000 e00000<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3e000000 100000<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3f000000 80000<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3f800000 40000<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3fc00000 40000&gt;;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; partition-names = &quot;part01&quot;,&quot;part02&quot;,&quot;part03&quot;,&quot;part04&quot;,&quot;part05&quot;,&quot;part06&quot;,&quot;part07&quot;,&quot;part08&quot;,&quot;part09&quot;,&quot;part10&quot;,&quot;part11&quot;;<br>
&nbsp;};</div>
<div><br>I can&#39;t see the different partitions linked to the /dev/mtd&lt;x&gt;<br>devices in the startup messages. When testing the devices<br>I see that only /dev/mtd0 is actually linked to the beginning<br>of the flash. (other /dev/mtd1 etc.. can&#39;t be opened).<br>
I included below also the relevant startup messages.<br>Does anyone have any idea what is wrong with my flash<br>configuration format?<br>Thanks, Liran.</div>
<p>Linux version: 2.6.24<br>Processor: mpc8272<br>Startup messages:<br>physmap platform flash device: 04000000 at fc000000<br>physmap-flash.0: Found 2 x16 devices at 0x0 in 32-bit bank<br>&nbsp;Amd/Fujitsu Extended Query Table at 0x0040<br>
physmap-flash.0: CFI does not contain boot bank location. Assuming top.<br>number of CFI chips: 1<br>cfi_cmdset_0002: Disabling erase-suspend-program due to code brokenness.<br></p>

------=_Part_79193_29835615.1218810209347--
