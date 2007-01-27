Return-Path: <vantranbk@yahoo.com.au>
Received: from web33008.mail.mud.yahoo.com (web33008.mail.mud.yahoo.com
	[209.191.69.123]) by ozlabs.org (Postfix) with SMTP id CD6A3DE0C1
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 27 Jan 2007 21:39:52 +1100 (EST)
Date: Sat, 27 Jan 2007 21:39:51 +1100 (EST)
From: tran vanle <vantranbk@yahoo.com.au>
Subject: Segmentation fault when start net-snmp
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-259917520-1169894391=:70768"
Message-ID: <511175.70768.qm@web33008.mail.mud.yahoo.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0-259917520-1169894391=:70768
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi all
I use board TQM8xxL , kernel 2.6.11.7 with Marcelo Tosatti  patch and Ramdisk in ELDK 4.0.
I only rebuild net-snmp-5.2.1.2-1_1.src.rpm package (rebuild , not edit any thing)
If I run snmpd with basic configuration
//smnpd.conf
####################
syslocation TQM8xxL  
sysservices 79
syscontact VCS
####################
It run OK

But when I want to use trapsink like (edit snmpd.conf):
//snmpd.conf
####################################
syslocation TQM8xxL  
 sysservices 79
 syscontact VCS
# authtrapenable: Should we send traps when authentication failures occur
#   arguments: 1 | 2   (1 = yes, 2 = no)
authtrapenable 1
# trapcommunity: Default trap sink community to use
#   arguments: community-string
trapcommunity abc
# trapsink: A SNMPv1 trap receiver
#   arguments: host [community] [portnum]
trapsink 192.168.1.7
# informsink: A SNMPv2c inform  (acknowledged trap) receiver
#   arguments: host [community] [portnum]
informsink 192.168.1.15
# trap2sink: A SNMPv2c trap receiver
#   arguments: host [community] [portnum]
trap2sink 192.168.1.7

####################################
I run snmpd with debug , I receive

.......
......
snmp_clean_persistent:  removing old config file: /var/net-snmp/snmpd.0.conf
trace: netsnmp_send_traps(): agent_trap.c, 616:
trap: send_trap 0 0 NET-SNMP-MIB::netSnmpAgentOIDs.10trace: netsnmp_send_traps(): agent_trap.c, 618:
trap: 
trace: snmp_call_callbacks(): callback.c, 209:
callback: START calling callbacks for maj=1 min=6
trace: snmp_call_callbacks(): callback.c, 223:
callback: calling a callback for maj=1 min=6
trace: send_notifications(): notification/snmpNotifyTable.c, 95:
send_notifications: starting: pdu=8086740, vars=0
Segmentation fault


What error I had and How can I fix it?
Is
 net-snmp-5.2.1.2-1_1 package in ELDK 4.0 do not support trapsink?
Does anyone have a patch?
Thanks for all

 Send instant messages to your online friends http://au.messenger.yahoo.com 
--0-259917520-1169894391=:70768
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi all<br>I use board TQM8xxL , kernel 2.6.11.7 with Marcelo Tosatti&nbsp; patch and Ramdisk in ELDK 4.0.<br>I only rebuild net-snmp-5.2.1.2-1_1.src.rpm package (rebuild , not edit any thing)<br>If I run snmpd with basic configuration<br>//smnpd.conf<br>####################<br>syslocation TQM8xxL  <br>sysservices 79<br>syscontact VCS<br>####################<br>It run OK<br><br>But when I want to use trapsink like (edit snmpd.conf):<br>//snmpd.conf<br>####################################<br>syslocation TQM8xxL  <br> sysservices 79<br> syscontact VCS<br># authtrapenable: Should we send traps when authentication failures occur<br>#&nbsp;&nbsp; arguments: 1 | 2&nbsp;&nbsp; (1 = yes, 2 = no)<br>authtrapenable 1<br># trapcommunity: Default trap sink community to use<br>#&nbsp;&nbsp; arguments: community-string<br>trapcommunity abc<br># trapsink: A SNMPv1 trap receiver<br>#&nbsp;&nbsp; arguments: host [community] [portnum]<br>trapsink 192.168.1.7<br># informsink: A SNMPv2c inform 
 (acknowledged trap) receiver<br>#&nbsp;&nbsp; arguments: host [community] [portnum]<br>informsink 192.168.1.15<br># trap2sink: A SNMPv2c trap receiver<br>#&nbsp;&nbsp; arguments: host [community] [portnum]<br>trap2sink 192.168.1.7<br><br>####################################<br>I run snmpd with debug , I receive<br><pre>.......<br>......<br>snmp_clean_persistent:  removing old config file: /var/net-snmp/snmpd.0.conf<br>trace: netsnmp_send_traps(): agent_trap.c, 616:<br>trap: send_trap 0 0 NET-SNMP-MIB::netSnmpAgentOIDs.10trace: netsnmp_send_traps(): agent_trap.c, 618:<br>trap: <br>trace: snmp_call_callbacks(): callback.c, 209:<br>callback: START calling callbacks for maj=1 min=6<br>trace: snmp_call_callbacks(): callback.c, 223:<br>callback: calling a callback for maj=1 min=6<br>trace: send_notifications(): notification/snmpNotifyTable.c, 95:<br>send_notifications: starting: pdu=8086740, vars=0<br>Segmentation fault<br><br><br>What error I had and How can I fix it?<br>Is<br>
 net-snmp-5.2.1.2-1_1 package in ELDK 4.0 do not support trapsink?<br>Does anyone have a patch?<br>Thanks for all</pre><p>&#32;Send instant messages to your online friends http://au.messenger.yahoo.com 
--0-259917520-1169894391=:70768--
