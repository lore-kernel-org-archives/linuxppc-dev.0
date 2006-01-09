Return-Path: <hubert.loewenguth@thales-bm.com>
Message-ID: <43C29CFC.8030900@thales-bm.com>
Date: Mon, 09 Jan 2006 18:27:24 +0100
From: "hubert.loewenguth" <hubert.loewenguth@thales-bm.com>
MIME-Version: 1.0
To: Linuxppc-embedded@ozlabs.org
Content-Type: multipart/alternative;
	boundary="------------060303090009010305090103"
Subject: mpc8260 fcc enet transmit time out
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------060303090009010305090103
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

hi the community.
I have already posted a question about my problem but it seems that 
nobody has encounter the same matter.
So I have made numerous tests and researches and seeing that I still 
have not succeed in solving it, I try again tyo send you my bug.

I use a MPC8260 with linux 2.4.20.
The problem is with the fcc_enet driver.
I have no MII phy interrupt line with my LXT971 Phy in front of the powerpc.
Seeing that I have no interrupt line, I have configured the driver to be 
in half duplex, and the LXT971 too.
I'm sure that the driver is in half-duplex mode an the LXT971 too, and 
the auto-negociation is ok.
Everything works fine, but, if I do successive plugs/unplugs during 
important data transfert, The driver enter into an infinite loop:

/# NETDEV WATCHDOG: eth0: transmit timed out
eth0: transmit timed out.
 Ring data dump: cur_tx c019f748 tx_free 0 cur_rx c019f690.
 Tx @base c019f708 :
1c00 055c 011cd06a
5c00 003b 011cd86a
...
1c00 055c 011d486a
3c00 05ea 011d406a
 Rx @base c019f608 :
9c00 0040 01f3e000
9c00 0040 01f3e800
...
9c00 0040 01f3d000
bc00 0040 01f2f800
NETDEV WATCHDOG: eth0: transmit timed out
eth0: transmit timed out.
 Ring data dump: cur_tx c019f748 tx_free 0 cur_rx c019f698.
 Tx @base c019f708 :
1c00 055c 011cd06a
5c00 003b 011cd86a
1c00 05ea 011ce06a
.....

/I have found, on the linux-embended forum, a personn who has the same 
problem:
http://ozlabs.org/pipermail/linuxppc-embedded/2001-December/005714.html
But I'm sure about my pin connections ans so the reponse to this personn 
doesn't solve my problem

More interresting this one :
http://ozlabs.org/pipermail/linuxppc-embedded/2005-January/016539.html
This personn seems to have the same troubleshouting than me .
He has tried to apply the patch provided by freescale, but it doesn't 
seem to correct it.
/
/So I have had just a little piece of trace in order to see when this 
infernal loop appear.
I have added some trace in the fcc_enet_start_xmit .
has you know, after some kind of transmit errors, the transmitter need 
to be restarted, and so I have added some traces to see when it is restarted

    /* Some transmit errors cause the transmitter to shut
         * down.  We now issue a restart transmit.  Since the
         * errors close the BD and update the pointers, the restart
         * _should_ pick up without having to reset any of our
         * pointers either.  Also, To workaround 8260 device erratum
         * CPM37, we must disable and then re-enable the transmitter
         * following a Late Collision, Underrun, or Retry Limit error.
         */
   

# UNDERRUN ! ==> RESTART
CARRIER LOST !
CARRIER LOST !
 UNDERRUN ! ==> RESTART
CARRIER LOST !
CARRIER LOST !
UNDERRUN ! ==> RESTART
UNDERRUN ! ==> RESTART
CARRIER LOST !
........
CARRIER LOST !
CARRIER LOST !
UNDERRUN ! ==> RESTART
CARRIER LOST !
CARRIER LOST !
CARRIER LOST !
CARRIER LOST !
CARRIER LOST !
CARRIER LOST !
CARRIER LOST !
UNDERRUN ! ==> RESTART
/
N/ETDEV WATCHDOG: eth0: transmit timed out
eth0: transmit timed out.
 Ring data dump: cur_tx c019f778 tx_free 0 cur_rx c019f690.
 Tx @base c019f708 :
1c02 055c 012cd86a
9c00 05ea 012cd06a
9c00 05ea 012f706a
9c00 05ea 012cf06a
9c00 05ea 012cf86a
9c00 05ea 0118506a
/
/Some personns have said me to try with 2.6 drivers but it's exactly the 
same problem.
( even if I'm a little bit surprised to see that with the  2.6 version 
drivers seems to be uncompatible with boards wich use MDIO without PHY
interrupt.the #define PHY_INTERRUPT condition of the 2.4 drivers version has
disapeared => with this new drivers you can't use MDIO without PHY 
interrupt !!
it was possible in the 2.4 version.
- seeing that the "fep->link" value is enabled only on a PHY interrupt .
I can't have this condition OK without PHY interrupt.
 "fep->link" can be asserted in the mii_parse_sr function, but has it is
indicated in the comment in the drivers :
"/* Somehow does the 971 tell me that the link is down
 * the first read after power-up.
 * read here to get a valid value in ack_int */"
That's true, the LXT 971A tell that the link is down, and seeing that I
have no interrupt, the fep->link is never asserted again.
So, I have commented the first lines of the fcc_enet_start_xmit function
which verify the value of fep->link.
I have added a #ifdef PHY_INTERRUPT condition before installing the ISR
for this interrupt.
And thanks to that, I have been able to test the new driver 2.6 .
But unfortunetly this doesn't solve my problem.)

So 2.6 driver is not the solution of my problem.

I'm asking myself if this can be due to CPM21, or CPM22, or CPM119 known 
bugs on mpc8260 ?
(see http://www.freescale.com/files/32bit/doc/data_sheet/MPC8260CE.pdf ) 
but I don't think so.
Perhaps, I imagine that in fact the MPC8260 transmitter doesn't restart 
correctly ?
        (Also, To workaround 8260 device erratum
         * CPM37, we must disable and then re-enable the transmitter
         * following a Late Collision, Underrun, or Retry Limit error)

Is there anybody having encounter the same problem?
Is there anybody having done some test of  numerous plug/unplug  during 
important data transfert with a half-duplex connection on mpc8260?
Is there anybody having an idea to help me ?

Thanks to the community for any help, I'm really desepareted here

(PS : sorry for my bad english)




--------------060303090009010305090103
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
hi the community.<br>
I have already posted a question about my problem but it seems that
nobody has encounter the same matter.<br>
So I have made numerous tests and researches and seeing that I still
have not succeed in solving it, I try again tyo send you my bug.<br>
<br>
I use a MPC8260 with linux 2.4.20.<br>
The problem is with the fcc_enet driver.<br>
I have no MII phy interrupt line with my LXT971 Phy in front of the
powerpc.<br>
Seeing that I have no interrupt line, I have configured the driver to
be in half duplex, and the LXT971 too.<br>
I'm sure that the driver is in half-duplex mode an the LXT971 too, and
the auto-negociation is ok.<br>
Everything works fine, but, if I do successive plugs/unplugs during
important data transfert, The driver enter into an infinite loop:<br>
<br>
<i><small># NETDEV WATCHDOG: eth0: transmit timed out<br>
eth0: transmit timed out.<br>
&nbsp;Ring data dump: cur_tx c019f748 tx_free 0 cur_rx c019f690.<br>
&nbsp;Tx @base c019f708 :<br>
1c00 055c 011cd06a<br>
5c00 003b 011cd86a<br>
...<br>
1c00 055c 011d486a<br>
3c00 05ea 011d406a<br>
&nbsp;Rx @base c019f608 :<br>
9c00 0040 01f3e000<br>
9c00 0040 01f3e800<br>
...<br>
9c00 0040 01f3d000<br>
bc00 0040 01f2f800<br>
NETDEV WATCHDOG: eth0: transmit timed out<br>
eth0: transmit timed out.<br>
&nbsp;Ring data dump: cur_tx c019f748 tx_free 0 cur_rx c019f698.<br>
&nbsp;Tx @base c019f708 :<br>
1c00 055c 011cd06a<br>
5c00 003b 011cd86a<br>
1c00 05ea 011ce06a<br>
.....<br>
<br>
</small></i>I have found, on the linux-embended forum, a personn who
has the same
problem:<br>
<font color="#3333ff"><a class="moz-txt-link-freetext"
 href="http://ozlabs.org/pipermail/linuxppc-embedded/2001-December/005714.html">http://ozlabs.org/pipermail/linuxppc-embedded/2001-December/005714.html</a></font><br>
But I'm sure about my pin connections ans so the reponse to this
personn doesn't solve my problem<br>
<br>
More interresting this one :<br>
<font color="#3333ff"><a class="moz-txt-link-freetext"
 href="http://ozlabs.org/pipermail/linuxppc-embedded/2005-January/016539.html">http://ozlabs.org/pipermail/linuxppc-embedded/2005-January/016539.html</a></font><br>
This personn seems to have the same troubleshouting than me .<br>
He has tried to apply the patch provided by freescale, but it doesn't
seem to correct it.<br>
<i><small><br>
</small></i>So I have had just a little piece of trace in order to see
when this
infernal loop appear.<br>
I have added some trace in the fcc_enet_start_xmit .<br>
has you know, after some kind of transmit errors, the transmitter need
to be restarted, and so I have added some traces to see when it is
restarted<br>
<br>
&nbsp;&nbsp;&nbsp; /* Some transmit errors cause the transmitter to shut<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;* down.&nbsp; We now issue a restart transmit.&nbsp; Since the<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;* errors close the BD and update the pointers, the restart<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;* _should_ pick up without having to reset any of our<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;* pointers either.&nbsp; Also, To workaround 8260 device erratum <br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;* CPM37, we must disable and then re-enable the transmitter<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;* following a Late Collision, Underrun, or Retry Limit error.<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;*/<br>
&nbsp;&nbsp;&nbsp; <br>
<br>
<small><big><small><big><font color="#000000"><small>#</small></font></big></small></big></small><small><big><small><big><font
 color="#000000"><small>
UNDERRUN ! ==&gt; RESTART<br>
CARRIER LOST !<br>
CARRIER LOST !<br>
</small></font></big></small></big></small><small><big><small><big><font
 color="#000000"><small>&nbsp;UNDERRUN ! ==&gt; RESTART<br>
CARRIER LOST !<br>
CARRIER LOST !<br>
UNDERRUN ! ==&gt; RESTART<br>
UNDERRUN ! ==&gt; RESTART<br>
CARRIER LOST !<br>
........<br>
CARRIER LOST !<br>
CARRIER LOST !<br>
UNDERRUN ! ==&gt; RESTART<br>
CARRIER LOST !<br>
CARRIER LOST !<br>
CARRIER LOST !<br>
CARRIER LOST !<br>
CARRIER LOST !<br>
CARRIER LOST !<br>
CARRIER LOST !<br>
UNDERRUN ! ==&gt; RESTART<br>
<i><br>
N</i>ETDEV WATCHDOG: eth0: transmit timed out<br>
eth0: transmit timed out.<br>
&nbsp;Ring data dump: cur_tx c019f778 tx_free 0 cur_rx c019f690.<br>
&nbsp;Tx @base c019f708 :<br>
1c02 055c 012cd86a<br>
9c00 05ea 012cd06a<br>
9c00 05ea 012f706a<br>
9c00 05ea 012cf06a<br>
9c00 05ea 012cf86a<br>
9c00 05ea 0118506a</small></font></big></small></big></small><br>
<i><small><br>
</small></i>Some personns have said me to try with 2.6 drivers but it's
exactly the same problem. <br>
( even if I'm a little bit surprised to see that with the&nbsp; 2.6 version
drivers seems to be uncompatible with boards wich use MDIO without PHY<br>
interrupt.the #define PHY_INTERRUPT condition of the 2.4 drivers
version has<br>
disapeared =&gt; with this new drivers you can't use MDIO without PHY
interrupt !!<br>
it was possible in the 2.4 version.<br>
- seeing that the "fep-&gt;link" value is enabled only on a PHY
interrupt .<br>
I can't have this condition OK without PHY interrupt.<br>
&nbsp;"fep-&gt;link" can be asserted in the mii_parse_sr function, but has
it is<br>
indicated in the comment in the drivers :<br>
"/* Somehow does the 971 tell me that the link is down<br>
&nbsp;* the first read after power-up.<br>
&nbsp;* read here to get a valid value in ack_int */"<br>
That's true, the LXT 971A tell that the link is down, and seeing that I<br>
have no interrupt, the fep-&gt;link is never asserted again.<br>
So, I have commented the first lines of the fcc_enet_start_xmit function<br>
which verify the value of fep-&gt;link.<br>
I have added a #ifdef PHY_INTERRUPT condition before installing the ISR<br>
for this interrupt.<br>
And thanks to that, I have been able to test the new driver 2.6 .<br>
But unfortunetly this doesn't solve my problem.)<br>
<br>
So 2.6 driver is not the solution of my problem.<br>
<br>
I'm asking myself if this can be due to CPM21, or CPM22, or CPM119
known bugs on mpc8260 ?<br>
(see <a class="moz-txt-link-freetext"
 href="http://www.freescale.com/files/32bit/doc/data_sheet/MPC8260CE.pdf">http://www.freescale.com/files/32bit/doc/data_sheet/MPC8260CE.pdf</a>
) but I don't think so.<br>
Perhaps, I imagine that in fact the MPC8260 transmitter doesn't restart
correctly ?<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; (Also, To workaround 8260 device erratum <br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;* CPM37, we must disable and then re-enable the transmitter<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;* following a Late Collision, Underrun, or Retry Limit error)<br>
<br>
Is there anybody having encounter the same problem?<br>
Is there anybody having done some test of&nbsp; numerous plug/unplug&nbsp; during
important data transfert with a half-duplex connection on mpc8260?<br>
Is there anybody having an idea to help me ?<br>
<br>
Thanks to the community for any help, I'm really desepareted here<br>
<br>
(PS : sorry for my bad english)<br>
<br>
<br>
<br>
</body>
</html>

--------------060303090009010305090103--
