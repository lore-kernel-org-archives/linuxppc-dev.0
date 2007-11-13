Return-Path: <alan@akb.net>
Received: from el-out-1112.google.com (el-out-1112.google.com [209.85.162.178])
	by ozlabs.org (Postfix) with ESMTP id 0C5A1DDE04
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Nov 2007 10:39:07 +1100 (EST)
Received: by el-out-1112.google.com with SMTP id r27so633712ele
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Nov 2007 15:39:06 -0800 (PST)
Message-ID: <bfa0697f0711131539n228f9f21q7b2acc896499b80d@mail.gmail.com>
Date: Tue, 13 Nov 2007 16:39:05 -0700
From: "Alan Bennett" <embedded@akb.net>
Sender: alan@akb.net
To: "Scott Wood" <scottwood@freescale.com>, linuxppc-dev@ozlabs.org
Subject: I2C on mpc8248 / device tree
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_21228_31249243.1194997145893"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

------=_Part_21228_31249243.1194997145893
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I've got four devices on i2c that I need to read.  Simple thermal and
voltage monitors.  I2c works fine in uboot, and now I'm trying to get things
to work in linux.

In the kernel .config I enable
  I2C
and
  I2C_MPC

During the platform boot code:
I init the IO ports for i2c, (same as ep8248e code)
    {3, 14, CPM_PIN_INPUT | CPM_PIN_SECONDARY},
    {3, 15, CPM_PIN_INPUT | CPM_PIN_SECONDARY},

__Do I need to configure a brg for the i2c along with the other devices ?
i.e. cpm2_clk_setup ?


Next, I'm sure my device tree needs work, but my first stab adds i2c onto
the SOC @ 11860  (immr+11860= I2c mode register) and interrupt 1.
       soc@e0000000 {
               ...
               cpm@119c0 {
               ...
               i2c@11860 {
                   device_type = "i2c";
                   compatible = "fsl-i2c";
                   reg = <11860 18>;
                   interrupts = <1 3>;
                   interrupt-parent = <&PIC>;
               };

After Cleaning up these routines and descriptions, would I be expected to
continue using the /dev/i2c- entries?

-Alan

------=_Part_21228_31249243.1194997145893
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I&#39;ve got four devices on i2c that I need to read.&nbsp; Simple thermal and voltage monitors.&nbsp; I2c works fine in uboot, and now I&#39;m trying to get things to work in linux.<br><br>In the kernel .config I enable <br>&nbsp; I2C<br>
and<br>&nbsp; I2C_MPC<br><br>During the platform boot code:<br>I init the IO ports for i2c, (same as ep8248e code)<br>&nbsp;&nbsp;&nbsp; {3, 14, CPM_PIN_INPUT | CPM_PIN_SECONDARY},<br>&nbsp;&nbsp;&nbsp; {3, 15, CPM_PIN_INPUT | CPM_PIN_SECONDARY},<br><br>__Do I need to configure a brg for the i2c along with the other devices ?&nbsp; 
i.e. cpm2_clk_setup ?<br><br><br>Next, I&#39;m sure my device tree needs work, but my first stab adds i2c onto the SOC @ 11860&nbsp; (immr+11860= I2c mode register) and interrupt 1.<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; soc@e0000000 {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ...
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cpm@119c0 {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ...<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i2c@11860 {&nbsp; <br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; device_type = &quot;i2c&quot;;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; compatible = &quot;fsl-i2c&quot;;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg = &lt;11860 18&gt;;
<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; interrupts = &lt;1 3&gt;;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; interrupt-parent = &lt;&amp;PIC&gt;;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; };<br><br>After Cleaning up these routines and descriptions, would I be expected to continue using the /dev/i2c- entries?
<br><br>-Alan<br><br>

------=_Part_21228_31249243.1194997145893--
