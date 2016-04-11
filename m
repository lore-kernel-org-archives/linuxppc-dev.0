Return-Path: <christophe.jaillet@wanadoo.fr>
Received: from smtp.smtpout.orange.fr (smtp05.smtpout.orange.fr
 [80.12.242.127])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qk5Cd30nhzDq9q
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Apr 2016 20:00:11 +1000 (AEST)
To: geoff@infradead.org, netdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, kernel-janitors@vger.kernel.org
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Inconsistent use of size argument in kzalloc and memcpy in
 'drivers/net/ethernet/toshiba/ps3_gelic_wireless.c'
Message-ID: <570B75A4.5070904@wanadoo.fr>
Date: Mon, 11 Apr 2016 12:00:04 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

while looking at potential clean-up, I ended on the following code which 
looks spurious to me.

We allocate 'be16_to_cpu(scan_info->size)' bytes, but then copy 
'scan_info->size'.
This is not consistent.


I don't know which one is the correct one.


CJ

--- drivers/net/ethernet/toshiba/ps3_gelic_wireless.c
+++ /tmp/cocci-output-24201-0dddbd-ps3_gelic_wireless.c
@@ -1616,13 +1616,10 @@ static void gelic_wl_scan_complete_event
          target->valid = 1;
          target->eurus_index = i;
          kfree(target->hwinfo);
-        target->hwinfo = kzalloc(be16_to_cpu(scan_info->size),
-                     GFP_KERNEL);
          if (!target->hwinfo)
              continue;

          /* copy hw scan info */
-        memcpy(target->hwinfo, scan_info, scan_info->size);
          target->essid_len = strnlen(scan_info->essid,
                          sizeof(scan_info->essid));
          target->rate_len = 0;
