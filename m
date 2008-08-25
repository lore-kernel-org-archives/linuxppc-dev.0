Return-Path: <lk.atwork@yahoo.com>
Received: from n66.bullet.mail.sp1.yahoo.com (n66.bullet.mail.sp1.yahoo.com
	[98.136.44.50]) by ozlabs.org (Postfix) with SMTP id 5AE88DE647
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 26 Aug 2008 02:58:40 +1000 (EST)
Date: Mon, 25 Aug 2008 09:51:58 -0700 (PDT)
From: Laxmikant Rashinkar <lk.atwork@yahoo.com>
Subject: Re: porting linux 2.6.27 to embedded powerpc board
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1761968134-1219683118=:963"
Message-ID: <181798.963.qm@web46309.mail.sp1.yahoo.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0-1761968134-1219683118=:963
Content-Type: text/plain; charset=us-ascii

Hi,

I now have the system booted all the up to the shell prompt.
However, my two NIC cards are not up.

When the system is booting, I get the following error:

TCP cubic registered
NET: Registered protocol family 17
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
24520:00 not found
eth0: Could not attach to PHY
IP-Config: Failed to open eth0
IP-Config: Device `eth0' not found.

here is the networking section from my .dts file

                mdio@24520 {
                        #address-cells = <1>;
                        #size-cells = <0>;
                        compatible = "fsl,gianfar-mdio";
                        reg = <0x24520 0x20>;

                        phy0: ethernet-phy@0 {
                                interrupt-parent = <&ipic>;
                                interrupts = <17 0x8>;
                                reg = <0x0>;
                                device_type = "ethernet-phy";
                        };
                        phy1: ethernet-phy@1 {
                                interrupt-parent = <&ipic>;
                                interrupts = <18 0x8>;
                                reg = <0x1>;
                                device_type = "ethernet-phy";
                        };
                };

                enet0: ethernet@24000 {
                        cell-index = <0>;
                        device_type = "network";
                        model = "TSEC";
                        compatible = "gianfar";
                        reg = <0x24000 0x1000>;
                        local-mac-address = [ 00 00 00 00 00 00 ];
                        interrupts = <32 0x8 33 0x8 34 0x8>;
                        interrupt-parent = <&ipic>;
                        phy-handle = <&phy0>;
                        linux,network-index = <0>;
                };

                enet1: ethernet@25000 {
                        cell-index = <1>;
                        device_type = "network";
                        model = "TSEC";
                        compatible = "gianfar";
                        reg = <0x25000 0x1000>;
                        local-mac-address = [ 00 00 00 00 00 00 ];
                        interrupts = <35 0x8 36 0x8 37 0x8>;
                        interrupt-parent = <&ipic>;
                        phy-handle = <&phy1>;
                        linux,network-index = <1>;
                };

Does anything here seem to be wrong?

thanks for your help
LK




----- Original Message ----
From: David Jander <david.jander@protonic.nl>
To: linuxppc-embedded@ozlabs.org
Cc: Laxmikant Rashinkar <lk.atwork@yahoo.com>
Sent: Thursday, August 21, 2008 2:43:45 AM
Subject: Re: porting linux 2.6.27 to embedded powerpc board

On Thursday 21 August 2008 01:24:46 Laxmikant Rashinkar wrote:
> Hi,
>
> I have an embedded PowerPC (MPC8347) board that works fine with uboot and
> Linux 2.6.15.
>
> I am trying to upgrade the kernel so that it runs on the latest release -
> Linux 2.6.27. So far, I have gotten the kernel to compile on my platform,
> but of course it does not boot.

Well, honestly I don't know where to look for information either (other than 
the source-code and examples from others), but here is a list with points to 
look out for (I have just done the same thing as you for a MPC5200B-based 
board):

1. Upgrade to latest u-boot first (recent git seems to be fine). There have 
been a lot of changes in u-boot lately about OF and device-tree related 
things. I suspect you need a fairly recent version of u-boot to go well with 
the latest kernel. It's also generally a good idea IMHO.

2. I assume you are porting to arch/powerpc (the old arch/ppc you used back in 
2.6.15 is obsolete and broken now).

3. Look at other platforms that use the same processor, and pick a simple one 
as starting point. Look out for the dts (device-tree-source file in 
arch/powerpc/boot/dts), copy and modify one to reflect your hardware. 
Recently a lot of changes happend in the kernel, changing device names, 
obsoleting "device-type" tags, etc..., so some of the current DTS sources 
included in the kernel might not even work (wrong device name, missing 
information, wrong use of "device-type", etc...), so watch out for these kind 
of issues too.

4. Be sure that the device(s) necessary to produce output on your console are 
correctly placed in the DT. Also make sure that u-boot knows about it 
(#define OF_STDOUT_PATH... in your u-boot board config file)

5. When compiling the device tree, it may be necessary to add some extra 
reserved entries to the compiled tree (I am using dtc -p 10240 -R 20, which 
might be slightly exaggerated), because u-boot may add something to it, and 
if it can't, linux won't boot.

6. Remember to always specify the "rootfstype=" option on the commandline if 
booting from anything other than NFS. This was not necessary back in the 
2.6.15-times AFAICR.

7. Boot with a device-tree (in u-boot: "bootm $addrofkernel - $addrofdtb", 
don't forget the dash if you are not using an initrd). If you don't do this, 
u-boot can't fix your DT, and the kernel probably won't find it either.

8. Be sure to use the correct version of the DTC (DT compiler) for your kernel 
(the sources are included nowadays, somewhere in arch/powerpc/boot IIRC). The 
command used to compile, should probably be something like this:

$ ./dtc -p 10240 -R 20 -I dts -o myplatform.dtb -O dtb -b 0 dts/myplatform.dts

Load the resulting .dtb file directly with u-boot (don't make an u-image out 
of it).

That's all I remember right now... hope it helps.

Regards,

-- 
David Jander



      
--0-1761968134-1219683118=:963
Content-Type: text/html; charset=us-ascii

<html><head><style type="text/css"><!-- DIV {margin:0px;} --></style></head><body><div style="font-family:times new roman, new york, times, serif;font-size:12pt"><div>Hi,<br><br>I now have the system booted all the up to the shell prompt.<br>However, my two NIC cards are not up.<br><br>When the system is booting, I get the following error:<br><br>TCP cubic registered<br>
NET: Registered protocol family 17<br>
RPC: Registered udp transport module.<br>
RPC: Registered tcp transport module.<br>
24520:00 not found<br>
eth0: Could not attach to PHY<br>
IP-Config: Failed to open eth0<br>
IP-Config: Device `eth0' not found.<br><br>here is the networking section from my .dts file<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mdio@24520 {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #address-cells = &lt;1&gt;;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #size-cells = &lt;0&gt;;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; compatible = "fsl,gianfar-mdio";<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg = &lt;0x24520
 0x20&gt;;<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; phy0: ethernet-phy@0 {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; interrupt-parent = &lt;&amp;ipic&gt;;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; interrupts = &lt;17 0x8&gt;;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg =
 &lt;0x0&gt;;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; device_type = "ethernet-phy";<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; };<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; phy1: ethernet-phy@1 {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; interrupt-parent = &lt;&amp;ipic&gt;;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 interrupts = &lt;18 0x8&gt;;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg = &lt;0x1&gt;;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; device_type = "ethernet-phy";<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; };<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; };<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enet0: ethernet@24000 {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 cell-index = &lt;0&gt;;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; device_type = "network";<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; model = "TSEC";<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; compatible = "gianfar";<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg = &lt;0x24000 0x1000&gt;;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; local-mac-address = [ 00 00 00 00 00 00
 ];<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; interrupts = &lt;32 0x8 33 0x8 34 0x8&gt;;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; interrupt-parent = &lt;&amp;ipic&gt;;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; phy-handle = &lt;&amp;phy0&gt;;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; linux,network-index = &lt;0&gt;;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; };<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enet1: ethernet@25000
 {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cell-index = &lt;1&gt;;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; device_type = "network";<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; model = "TSEC";<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; compatible = "gianfar";<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg = &lt;0x25000
 0x1000&gt;;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; local-mac-address = [ 00 00 00 00 00 00 ];<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; interrupts = &lt;35 0x8 36 0x8 37 0x8&gt;;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; interrupt-parent = &lt;&amp;ipic&gt;;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; phy-handle = &lt;&amp;phy1&gt;;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; linux,network-index =
 &lt;1&gt;;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; };<br><br>Does anything here seem to be wrong?<br><br>thanks for your help<br>LK<br><br></div><div style="font-family: times new roman,new york,times,serif; font-size: 12pt;"><br><div style="font-family: arial,helvetica,sans-serif; font-size: 12pt;">----- Original Message ----<br>From: David Jander &lt;david.jander@protonic.nl&gt;<br>To: linuxppc-embedded@ozlabs.org<br>Cc: Laxmikant Rashinkar &lt;lk.atwork@yahoo.com&gt;<br>Sent: Thursday, August 21, 2008 2:43:45 AM<br>Subject: Re: porting linux 2.6.27 to embedded powerpc board<br><br>
On Thursday 21 August 2008 01:24:46 Laxmikant Rashinkar wrote:<br>&gt; Hi,<br>&gt;<br>&gt; I have an embedded PowerPC (MPC8347) board that works fine with uboot and<br>&gt; Linux 2.6.15.<br>&gt;<br>&gt; I am trying to upgrade the kernel so that it runs on the latest release -<br>&gt; Linux 2.6.27. So far, I have gotten the kernel to compile on my platform,<br>&gt; but of course it does not boot.<br><br>Well, honestly I don't know where to look for information either (other than <br>the source-code and examples from others), but here is a list with points to <br>look out for (I have just done the same thing as you for a MPC5200B-based <br>board):<br><br>1. Upgrade to latest u-boot first (recent git seems to be fine). There have <br>been a lot of changes in u-boot lately about OF and device-tree related <br>things. I suspect you need a fairly recent version of u-boot to go well with <br>the latest kernel. It's also generally a good idea IMHO.<br><br>2. I
 assume you are porting to arch/powerpc (the old arch/ppc you used back in <br>2.6.15 is obsolete and broken now).<br><br>3. Look at other platforms that use the same processor, and pick a simple one <br>as starting point. Look out for the dts (device-tree-source file in <br>arch/powerpc/boot/dts), copy and modify one to reflect your hardware. <br>Recently a lot of changes happend in the kernel, changing device names, <br>obsoleting "device-type" tags, etc..., so some of the current DTS sources <br>included in the kernel might not even work (wrong device name, missing <br>information, wrong use of "device-type", etc...), so watch out for these kind <br>of issues too.<br><br>4. Be sure that the device(s) necessary to produce output on your console are <br>correctly placed in the DT. Also make sure that u-boot knows about it <br>(#define OF_STDOUT_PATH... in your u-boot board config file)<br><br>5. When compiling the device tree, it may be necessary to add
 some extra <br>reserved entries to the compiled tree (I am using dtc -p 10240 -R 20, which <br>might be slightly exaggerated), because u-boot may add something to it, and <br>if it can't, linux won't boot.<br><br>6. Remember to always specify the "rootfstype=" option on the commandline if <br>booting from anything other than NFS. This was not necessary back in the <br>2.6.15-times AFAICR.<br><br>7. Boot with a device-tree (in u-boot: "bootm $addrofkernel - $addrofdtb", <br>don't forget the dash if you are not using an initrd). If you don't do this, <br>u-boot can't fix your DT, and the kernel probably won't find it either.<br><br>8. Be sure to use the correct version of the DTC (DT compiler) for your kernel <br>(the sources are included nowadays, somewhere in arch/powerpc/boot IIRC). The <br>command used to compile, should probably be something like this:<br><br>$ ./dtc -p 10240 -R 20 -I dts -o myplatform.dtb -O dtb -b 0 dts/myplatform.dts<br><br>Load
 the resulting .dtb file directly with u-boot (don't make an u-image out <br>of it).<br><br>That's all I remember right now... hope it helps.<br><br>Regards,<br><br>-- <br>David Jander<br></div></div></div><br>



      </body></html>
--0-1761968134-1219683118=:963--
