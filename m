Return-Path: <lebon@lebon.org.ua>
Received: from b-mail.com.ua (b-mail.com.ua [195.68.202.242])
	by ozlabs.org (Postfix) with ESMTP id C74A2DDDA5
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Mar 2009 05:31:42 +1100 (EST)
Message-ID: <49B6B240.8030701@lebon.org.ua>
Date: Tue, 10 Mar 2009 20:32:32 +0200
From: Mikhail Zolotaryov <lebon@lebon.org.ua>
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc 4xx EMAC driver: device name reported on timeout
	is not correct
Content-Type: multipart/mixed; boundary="------------050304050205060400050305"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------050304050205060400050305
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

not critical problem here.

IBM EMAC driver performs device reset (drivers/net/ibm_newemac/core.c: 
emac_probe() -> emac_init_phy() -> emac_reset()) before registering 
appropriate net_device (emac_probe() -> register_netdev()), so 
net_device name contains raw format string during EMAC reset ("eth%d").

If the case of reset timeout, emac_report_timeout_error() function is 
called to report an error. The problem is this function uses net_device 
name to report device related, which is not correct, as a result in the 
kernel log buffer we see:

eth%d: reset timeout

The solution is to print device_node full_name instead. After applying 
the patch proposed, error string is like the following:

/plb/opb/ethernet@ef600e00: reset timeout


Signed-off-by: Mikhail Zolotaryov <lebon@lebon.org.ua>



--------------050304050205060400050305
Content-Type: text/plain;
 name="emac_report_timeout_error.patch"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="emac_report_timeout_error.patch"

LS0tIGxpbnV4LTIuNi9kcml2ZXJzL25ldC9pYm1fbmV3ZW1hYy9jb3JlLmMub3JpZwkyMDA5
LTAzLTEwIDIwOjI0OjEyLjAwMDAwMDAwMCArMDIwMAorKysgbGludXgtMi42L2RyaXZlcnMv
bmV0L2libV9uZXdlbWFjL2NvcmUuYwkJMjAwOS0wMy0xMCAyMDoyOToxMi4wMDAwMDAwMDAg
KzAyMDAKQEAgLTEzNCw3ICsxMzQsNyBAQAogCQkJCSAgRU1BQ19GVFJfNDQwRVBfUEhZX0NM
S19GSVgpKQogCQlEQkcoZGV2LCAiJXMiIE5MLCBlcnJvcik7CiAJZWxzZSBpZiAobmV0X3Jh
dGVsaW1pdCgpKQotCQlwcmludGsoS0VSTl9FUlIgIiVzOiAlc1xuIiwgZGV2LT5uZGV2LT5u
YW1lLCBlcnJvcik7CisJCXByaW50ayhLRVJOX0VSUiAiJXM6ICVzXG4iLCBkZXYtPm9mZGV2
LT5ub2RlLT5mdWxsX25hbWUsIGVycm9yKTsKIH0KIAogLyogRU1BQyBQSFkgY2xvY2sgd29y
a2Fyb3VuZDoK
--------------050304050205060400050305--
