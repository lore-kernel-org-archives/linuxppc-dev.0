Return-Path: <jk@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sXhWm0lh5zDsMD
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Sep 2016 18:57:08 +1000 (AEST)
From: Jeremy Kerr <jk@ozlabs.org>
To: Corey Minyard <minyard@acm.org>, openipmi-developer@lists.sourceforge.net
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/4] ipmi: Make ipmi_demangle_device_id more generic
Date: Mon, 12 Sep 2016 16:55:35 +0800
Message-Id: <1473670537-26428-3-git-send-email-jk@ozlabs.org>
In-Reply-To: <1473670537-26428-1-git-send-email-jk@ozlabs.org>
References: <1473670537-26428-1-git-send-email-jk@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently, ipmi_demagle_device_id requires a full response buffer in its
data argument. This means we can't use it to parse a response in a
struct ipmi_recv_msg, which has the netfn and cmd as separate bytes.

This change alters the definition and users of ipmi_demangle_device_id
to use a split netfn, cmd and data buffer, so it can be used with
non-sequential responses.

Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
---
 drivers/char/ipmi/ipmi_si_intf.c |  3 ++-
 drivers/char/ipmi/ipmi_ssif.c    |  3 ++-
 include/linux/ipmi_smi.h         | 16 +++++++++-------
 3 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/ipmi_si_intf.c
index a112c01..745368d 100644
--- a/drivers/char/ipmi/ipmi_si_intf.c
+++ b/drivers/char/ipmi/ipmi_si_intf.c
@@ -2951,7 +2951,8 @@ static int try_get_dev_id(struct smi_info *smi_info)
 						  resp, IPMI_MAX_MSG_LENGTH);
 
 	/* Check and record info from the get device id, in case we need it. */
-	rv = ipmi_demangle_device_id(resp, resp_len, &smi_info->device_id);
+	rv = ipmi_demangle_device_id(msg[0], msg[1],
+			resp+2, resp_len-2, &smi_info->device_id);
 
 out:
 	kfree(resp);
diff --git a/drivers/char/ipmi/ipmi_ssif.c b/drivers/char/ipmi/ipmi_ssif.c
index 5673fff..29bbcaf 100644
--- a/drivers/char/ipmi/ipmi_ssif.c
+++ b/drivers/char/ipmi/ipmi_ssif.c
@@ -1461,7 +1461,8 @@ static int ssif_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	if (rv)
 		goto out;
 
-	rv = ipmi_demangle_device_id(resp, len, &ssif_info->device_id);
+	rv = ipmi_demangle_device_id(msg[0], msg[1],
+			resp+2, len-2, &ssif_info->device_id);
 	if (rv)
 		goto out;
 
diff --git a/include/linux/ipmi_smi.h b/include/linux/ipmi_smi.h
index f8cea14..bf2f489 100644
--- a/include/linux/ipmi_smi.h
+++ b/include/linux/ipmi_smi.h
@@ -167,22 +167,24 @@ struct ipmi_device_id {
    netfn << 2, the data should be of the format:
       netfn << 2, cmd, completion code, data
    as normally comes from a device interface. */
-static inline int ipmi_demangle_device_id(const unsigned char *data,
+static inline int ipmi_demangle_device_id(uint8_t netfn, uint8_t cmd,
+					  const unsigned char *data,
 					  unsigned int data_len,
 					  struct ipmi_device_id *id)
 {
-	if (data_len < 9)
+	if (data_len < 7)
 		return -EINVAL;
-	if (data[0] != IPMI_NETFN_APP_RESPONSE << 2 ||
-	    data[1] != IPMI_GET_DEVICE_ID_CMD)
+	if (netfn != IPMI_NETFN_APP_RESPONSE << 2 ||
+	    cmd != IPMI_GET_DEVICE_ID_CMD)
 		/* Strange, didn't get the response we expected. */
 		return -EINVAL;
-	if (data[2] != 0)
+	if (data[0] != 0)
 		/* That's odd, it shouldn't be able to fail. */
 		return -EINVAL;
 
-	data += 3;
-	data_len -= 3;
+	data++;
+	data_len--;
+
 	id->device_id = data[0];
 	id->device_revision = data[1];
 	id->firmware_revision_1 = data[2];
-- 
2.7.4
