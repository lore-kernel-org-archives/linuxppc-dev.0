Return-Path: <batsayan.das@tcs.com>
In-Reply-To: <20060111203434.1D928352B1E@atlas.denx.de>
To: Wolfgang Denk <wd@denx.de>
MIME-Version: 1.0
From: batsayan.das@tcs.com
Message-ID: <OF08F91C71.313412E8-ON652570F4.001BB5F4-652570F4.001CF070@tcs.com>
Date: Thu, 12 Jan 2006 10:46:05 +0530
Content-Type: multipart/alternative;
	boundary="=_alternative 001CF011652570F4_="
Cc: Linuxppc-embedded@ozlabs.org
Subject: Re: Ethernet not initialized: Help req
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multipart message in MIME format.
--=_alternative 001CF011652570F4_=
Content-Type: text/plain; charset="US-ASCII"


Hi,

We got the correct value of CLK9 and CLK10. We found out a bug in the 
function fcc_enet_open(). Our setting was CONFIG_USE_MDIO. In this mode, 
the board is able to get packets from out side, but was unable to send 
packets. 

Now we changed the code like this. 

                fep->link = 1;
                netif_start_queue(dev);
                mii_do_cmd(dev, phy_cmd_config);  /* display configuration 
*/
                return 0; 

Originally the code was ( Line no 2174)

                netif_start_queue(dev);
                return 0;               /* Success */

Now the ethernet works perfectly. 

BTW, is there any tool/test case available to test the ethernet driver for 
a long period of time? 

Thanks
Batsayan Das




Wolfgang Denk <wd@denx.de> 
Sent by: wd@denx.de
01/12/2006 02:04 AM

To
batsayan.das@tcs.com
cc
Linuxppc-embedded@ozlabs.org
Subject
Re: Ethernet not initialized: Help req






In message 
<OFDC66830E.1EDE14C4-ON652570F3.00265CDF-652570F3.00297A66@tcs.com> you 
wrote:
> 
> In our MPC8260 based customs board the CLK9 is for transmit and CLK10 is 

> for receive. The ELDK tree uses  CLK12 is receive, CLK11 is transmit and 


This is not correct. The ELDK does not do this. The  ELDK  is  not  a
Linux source tree.

Also, this setting is hardware dependent and differs  from  board  to
board.

> We got CLK9  and CLK10 from U-Boot tree and set those varables, but 
> ethernet does not work. 

Then   probably   other   changes   /   initializations   (port   pin
configurations) are needed as well.

> My question is what value shall I use for CLK9 and CLK10? 

This idepends on your hardware. Study the schematics.

> What else setting we need to change to make Ethernet work?

Compare U-Boot code and other board definitions.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
A secure program has to be robust: it  must  be  able  to  deal  with
conditions  that "can't happen", whether user input, program error or
library/etc. This is basic damage  control.  Buffer  overflow  errors
have nothing to do with security, but everything with stupidity.
                 -- Wietse Venema in <5cnqm3$8r9@spike.porcupine.org>

ForwardSourceID:NT00008EB6 


Notice: The information contained in this e-mail message and/or attachments to it may contain confidential or privileged information.   If you are not the intended recipient, any dissemination, use, review, distribution, printing or copying of the information contained in this e-mail message and/or attachments to it are strictly prohibited.   If you have received this communication in error, please notify us by reply e-mail or telephone and immediately and permanently delete the message and any attachments.  Thank you
--=_alternative 001CF011652570F4_=
Content-Type: text/html; charset="US-ASCII"


<br><font size=2 face="sans-serif">Hi,</font>
<br>
<br><font size=2 face="sans-serif">We got the correct value of CLK9 and
CLK10. We found out a bug in the function fcc_enet_open(). Our setting
was CONFIG_USE_MDIO. In this mode, the board is able to get packets from
out side, but was unable to send packets. </font>
<br>
<br><font size=2 face="sans-serif">Now we changed the code like this. </font>
<br>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; fep-&gt;link = 1;</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; netif_start_queue(dev);</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; mii_do_cmd(dev, phy_cmd_config); &nbsp;/* display configuration
*/</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; return 0; </font>
<br>
<br><font size=2 face="sans-serif">Originally the code was ( Line no 2174)</font>
<br>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; netif_start_queue(dev);</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; return 0; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
/* Success */</font>
<br>
<br><font size=2 face="sans-serif">Now the ethernet works perfectly. </font>
<br>
<br><font size=2 face="sans-serif">BTW, is there any tool/test case available
to test the ethernet driver for a long period of time? </font>
<br>
<br><font size=2 face="sans-serif">Thanks<br>
Batsayan Das<br>
</font>
<br>
<br>
<br>
<table width=100%>
<tr valign=top>
<td width=40%><font size=1 face="sans-serif"><b>Wolfgang Denk &lt;wd@denx.de&gt;</b>
</font>
<br><font size=1 face="sans-serif">Sent by: wd@denx.de</font>
<p><font size=1 face="sans-serif">01/12/2006 02:04 AM</font>
<td width=59%>
<table width=100%>
<tr valign=top>
<td>
<div align=right><font size=1 face="sans-serif">To</font></div>
<td><font size=1 face="sans-serif">batsayan.das@tcs.com</font>
<tr valign=top>
<td>
<div align=right><font size=1 face="sans-serif">cc</font></div>
<td><font size=1 face="sans-serif">Linuxppc-embedded@ozlabs.org</font>
<tr valign=top>
<td>
<div align=right><font size=1 face="sans-serif">Subject</font></div>
<td><font size=1 face="sans-serif">Re: Ethernet not initialized: Help req</font></table>
<br>
<table>
<tr valign=top>
<td>
<td></table>
<br></table>
<br>
<br>
<br><font size=2><tt>In message &lt;OFDC66830E.1EDE14C4-ON652570F3.00265CDF-652570F3.00297A66@tcs.com&gt;
you wrote:<br>
&gt; <br>
&gt; In our MPC8260 based customs board the CLK9 is for transmit and CLK10
is <br>
&gt; for receive. The ELDK tree uses &nbsp;CLK12 is receive, CLK11 is transmit
and <br>
<br>
This is not correct. The ELDK does not do this. The &nbsp;ELDK &nbsp;is
&nbsp;not &nbsp;a<br>
Linux source tree.<br>
<br>
Also, this setting is hardware dependent and differs &nbsp;from &nbsp;board
&nbsp;to<br>
board.<br>
<br>
&gt; We got CLK9 &nbsp;and CLK10 from U-Boot tree and set those varables,
but <br>
&gt; ethernet does not work. <br>
<br>
Then &nbsp; probably &nbsp; other &nbsp; changes &nbsp; / &nbsp; initializations
&nbsp; (port &nbsp; pin<br>
configurations) are needed as well.<br>
<br>
&gt; My question is what value shall I use for CLK9 and CLK10? <br>
<br>
This idepends on your hardware. Study the schematics.<br>
<br>
&gt; What else setting we need to change to make Ethernet work?<br>
<br>
Compare U-Boot code and other board definitions.<br>
<br>
Best regards,<br>
<br>
Wolfgang Denk<br>
<br>
-- <br>
Software Engineering: &nbsp;Embedded and Realtime Systems, &nbsp;Embedded
Linux<br>
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de<br>
A secure program has to be robust: it &nbsp;must &nbsp;be &nbsp;able &nbsp;to
&nbsp;deal &nbsp;with<br>
conditions &nbsp;that &quot;can't happen&quot;, whether user input, program
error or<br>
library/etc. This is basic damage &nbsp;control. &nbsp;Buffer &nbsp;overflow
&nbsp;errors<br>
have nothing to do with security, but everything with stupidity.<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; -- Wietse Venema
in &lt;5cnqm3$8r9@spike.porcupine.org&gt;<br>
</tt></font>
<br><font size=1 color=white face="sans-serif">ForwardSourceID:NT00008EB6
&nbsp; &nbsp;</font>
<br>
<table><tr><td bgcolor=#ffffff><font color=#000000>Notice: The information contained in this e-mail message and/or attachments to it may contain confidential or privileged information.   If you are not the intended recipient, any dissemination, use, review, distribution, printing or copying of the information contained in this e-mail message and/or attachments to it are strictly prohibited.   If you have received this communication in error, please notify us by reply e-mail or telephone and immediately and permanently delete the message and any attachments.  Thank you<br>
</font></td></tr></table>
--=_alternative 001CF011652570F4_=--
