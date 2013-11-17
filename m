Return-Path: <geyslan@gmail.com>
Received: from mail-ie0-x22a.google.com (mail-ie0-x22a.google.com
 [IPv6:2607:f8b0:4001:c03::22a])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 81F672C00C7
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Nov 2013 06:10:31 +1100 (EST)
Received: by mail-ie0-f170.google.com with SMTP id to1so7698952ieb.29
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 Nov 2013 11:10:27 -0800 (PST)
MIME-Version: 1.0
Date: Sun, 17 Nov 2013 17:10:27 -0200
Message-ID: <CAGG-pUTye8ovBDvryN7GNPPCUmPJf9VhQ_hCbxJ9ABmz787H8A@mail.gmail.com>
Subject: [RFC] possible null dereference in 'pm121_create_sys_fans()'
From: =?ISO-8859-1?Q?Geyslan_Greg=F3rio_Bem?= <geyslan@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Benjamin,

In file 'windfarm_pm121'.c:

If this branch is true:

    if (param == NULL) {
        printk(KERN_WARNING "pm121: %s fan config not found "
               " for this machine model\n",
               loop_names[loop_id]);
        goto fail;
    }

control that is NULL will suffer a dereference attempt:

fail:
    /* note that this is not optimal since another loop may still
       control the same control */
    printk(KERN_WARNING "pm121: failed to set up %s loop "
           "setting \"%s\" to max speed.\n",
           loop_names[loop_id], control->name);


Reported-by: Geyslan G. Bem <geyslan@gmail.com>

-- 
Regards,

Geyslan G. Bem
hackingbits.com
