Message-Id: <6.0.0.22.0.20031211104617.01e7ae80@dns.struinfo.it>
Date: Thu, 11 Dec 2003 11:03:48 +0100
To: linuxppc-embedded@lists.linuxppc.org
From: llandre <r&d@wawnet.biz>
Subject: UCD-SNMP 4.2.1 and SNMP v3
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all,

I tried to run the snmpd daemon of UCD-SNMP 4.2.1 on a PPC405EP-based
system equipped with Linux 2.4.20. I built the package directly on the
target (no cross compilation) with the ELDK 2.0.2. The version of the
openssl libraries is 0.9.6b-8. Everything works fine with v1 and v2
operations but I have authentication problems with the v3 operations. The
same daemon, with the same configuration files, works fine on a PC (Red Hat
7.2).

Here is the snippet of the dump:

dumpv_recv:            String:
trace: sc_hash(): scapi.c, 328
trace: sc_get_properlength(): scapi.c, 81
trace: get_enginetime(): lcd_time.c, 152
lcd_get_enginetime: engineID 80 00 07 E5 80 11 65 9F 88 00 00 0F 37 :
boots=15, time=10
trace: usm_get_user(): snmpusm.c, 2553
usm: getting user mtek
trace: sc_check_keyed_hash(): scapi.c, 408
sc_check_keyed_hash():    key=0x73b5f6979b89bf1ef0ebec2cf7e9a80e (16)
trace: sc_generate_keyed_hash(): scapi.c, 218
trace: sc_get_properlength(): scapi.c, 81
trace: usm_process_in_msg(): snmpusm.c, 2244
usm: Verification failed.
trace: snmpv3_parse(): snmp_api.c, 2953
dumph_recv:       ScopedPDU
trace: snmpv3_scopedPDU_parse(): snmp_api.c, 3577
dumph_recv:         contextEngineID
dumpx_recv:          04 0D 80 00 07 E5 80 11 65 9F 88 00 00 0F 37
dumpv_recv:            String:  ......e.....7
trace: snmpv3_scopedPDU_parse(): snmp_api.c, 3599
dumph_recv:         contextName
dumpx_recv:          04 00
dumpv_recv:            String:
trace: snmpv3_parse(): snmp_api.c, 2958
dumph_recv:         PDU-GET
trace: snmp_pdu_parse(): snmp_api.c, 3385
dumph_recv:           request_id
dumpx_recv:            02 04 41 4C 9C F6


The key calculated by the sc_check_keyed_hash function is to the one I read
in the /var/ucd-snmp/snmpd.conf.
I suspect the problem is referred to either the PPC architecture (missing a
compiler flag?) or the openssl libraries.

Anybody can help me?


Thanx in advance,

llandre


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
