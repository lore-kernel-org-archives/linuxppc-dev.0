Return-Path: <vantranbk@yahoo.com.au>
Received: from web33009.mail.mud.yahoo.com (web33009.mail.mud.yahoo.com
	[209.191.69.124]) by ozlabs.org (Postfix) with SMTP id F398EDDE34
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  3 Jan 2007 00:33:31 +1100 (EST)
Date: Wed, 3 Jan 2007 00:33:29 +1100 (EST)
From: tran vanle <vantranbk@yahoo.com.au>
Subject: ELDK4.0 net-snmp can not work with trapsink
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1456742139-1167744809=:55876"
Message-ID: <732221.55876.qm@web33009.mail.mud.yahoo.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0-1456742139-1167744809=:55876
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi all
I use net-snmp package in ELDK4.0 with board TQM8xxL .
I config it 
    ./configure \
        --host=$RPM_ARCH-linux                          \
        --enable-static --enable-shared                 \
        --with-cflags="$RPM_OPT_FLAGS -lcrypto"         \
        --with-ldflags="$LDFLAGS"                       \
        --with-sys-location="Unknown"                   \
        --with-logfile="/var/log/snmpd.log"             \
        --with-persistent-directory="/var/net-snmp"     \
        --with-endianness=$endianess                    \
        --with-default-snmp-version="2"                 \

        --with-mib-modules="host agentx smux "\

%if %{tcp_wrappers}
        --with-libwrap=%{_libdir}                       \
%endif
        --sysconfdir=%{_sysconfdir}                     \
        --enable-ucd-snmp-compatibility                 \
        --with-openssl                                  \
        --with-pic                                      \
        --with-sys-contact="root@localhost"

If I run snmpd with basic config file in /etc/snmp/snmpd.conf it run ok
But when I want to use trapsink , I add these line to /etc/snmp/snmpd.conf 
////////////////////////////////////
        #   arguments: 1 | 2   (1 = yes, 2 = no)
authtrapenable 1
# trapcommunity: Default trap sink community to use
#   arguments: community-string
trapcommunity abc
# trapsink: A SNMPv1 trap receiver
#   arguments: host [community] [portnum]
trapsink 192.168.1.7
# informsink: A SNMPv2c inform (acknowledged trap) receiver
#   arguments: host [community] [portnum]
informsink 192.168.1.15
# trap2sink: A SNMPv2c trap receiver
#   arguments: host [community] [portnum]
trap2sink 192.168.1.7
///////////////////////////////////
    and run snmpd with debug I receive 
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

Thanks for all


 Send instant messages to your online friends http://au.messenger.yahoo.com 
--0-1456742139-1167744809=:55876
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi all<br>I use net-snmp package in ELDK4.0 with board TQM8xxL .<br>I config it <br>&nbsp;&nbsp;&nbsp; ./configure \<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; --host=$RPM_ARCH-linux&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; --enable-static --enable-shared&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; --with-cflags="$RPM_OPT_FLAGS -lcrypto"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; --with-ldflags="$LDFLAGS"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 --with-sys-location="Unknown"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; --with-logfile="/var/log/snmpd.log"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; --with-persistent-directory="/var/net-snmp"&nbsp;&nbsp;&nbsp;&nbsp; \<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; --with-endianness=$endianess&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; --with-default-snmp-version="2"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; --with-mib-modules="host agentx smux "\<br><br>%if %{tcp_wrappers}<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 --with-libwrap=%{_libdir}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>%endif<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; --sysconfdir=%{_sysconfdir}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; --enable-ucd-snmp-compatibility&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; --with-openssl&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 --with-pic&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; --with-sys-contact="root@localhost"<br><br>If I run snmpd with basic config file in /etc/snmp/snmpd.conf it run ok<br>But when I want to use trapsink , I add these line to /etc/snmp/snmpd.conf <br>////////////////////////////////////<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;  #&nbsp;&nbsp; arguments: 1 | 2&nbsp;&nbsp; (1 = yes, 2 = no)<br>authtrapenable 1<br># trapcommunity: Default trap sink community to use<br>#&nbsp;&nbsp; arguments: community-string<br>trapcommunity abc<br># trapsink: A SNMPv1 trap receiver<br>#&nbsp;&nbsp; arguments: host [community] [portnum]<br>trapsink 192.168.1.7<br># informsink: A SNMPv2c inform (acknowledged trap) receiver<br>#&nbsp;&nbsp; arguments: host [community]
 [portnum]<br>informsink 192.168.1.15<br># trap2sink: A SNMPv2c trap receiver<br>#&nbsp;&nbsp; arguments: host [community] [portnum]<br>trap2sink 192.168.1.7<br>///////////////////////////////////<br>&nbsp;&nbsp;&nbsp; and run snmpd with debug I receive <br>.......<br>......<br>snmp_clean_persistent:&nbsp; removing old config file: /var/net-snmp/snmpd.0.conf<br>trace: netsnmp_send_traps(): agent_trap.c, 616:<br>trap: send_trap 0 0 NET-SNMP-MIB::netSnmpAgentOIDs.10trace: netsnmp_send_traps(): agent_trap.c, 618:<br>trap: <br>trace: snmp_call_callbacks(): callback.c, 209:<br>callback: START calling callbacks for maj=1 min=6<br>trace: snmp_call_callbacks(): callback.c, 223:<br>callback: calling a callback for maj=1 min=6<br>trace: send_notifications(): notification/snmpNotifyTable.c, 95:<br>send_notifications: starting: pdu=8086740, vars=0<br>Segmentation fault<br><br>What error I had and How can I fix it?<br><br>Thanks for all<br><br><p>&#32;Send instant messages to your
 online friends http://au.messenger.yahoo.com 
--0-1456742139-1167744809=:55876--
