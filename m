Return-Path: <mathieu.malaterre@gmail.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sb8GD13WjzDsZk
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Sep 2016 18:53:56 +1000 (AEST)
Received: from mail-wm0-x22d.google.com (mail-wm0-x22d.google.com
 [IPv6:2a00:1450:400c:c09::22d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3sb8GC2bQ8z9sC3
 for <linuxppc-dev@ozlabs.org>; Fri, 16 Sep 2016 18:53:55 +1000 (AEST)
Received: by mail-wm0-x22d.google.com with SMTP id b187so25100766wme.1
 for <linuxppc-dev@ozlabs.org>; Fri, 16 Sep 2016 01:53:55 -0700 (PDT)
MIME-Version: 1.0
Sender: mathieu.malaterre@gmail.com
From: Mathieu Malaterre <malat@debian.org>
Date: Fri, 16 Sep 2016 10:53:31 +0200
Message-ID: <CA+7wUsyNQFLj=-vKxCe5CU5o7gUavUVof1hEngX_-YKXZc+ZVg@mail.gmail.com>
Subject: i2c i2c-3: i2c-powermac: modalias failure on
 /uni-n@f8000000/i2c@f8001000/cereal@1c0
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi there,

Would anyone know why I am getting the following error message in
`dmesg` on my PowerMac/Mac Mini G4:

[...]
[    2.090226] PowerMac i2c bus pmu 2 registered
[    2.095691] PowerMac i2c bus pmu 1 registered
[    2.101016] PowerMac i2c bus mac-io 0 registered
[    2.106135] PowerMac i2c bus uni-n 1 registered
[    2.111094] i2c i2c-3: i2c-powermac: modalias failure on
/uni-n@f8000000/i2c@f8001000/cereal@1c0
[    2.116261] PowerMac i2c bus uni-n 0 registered
[...]


Looking at the code I see:

static bool i2c_powermac_get_type(struct i2c_adapter *adap,
                                            struct device_node *node,
                                            u32 addr, char *type, int type_size)
{
[...]
        dev_err(&adap->dev, "i2c-powermac: modalias failure"
                " on %s\n", node->full_name);
        return false;


However I also do see the 'cereal' should be part of the 'supported' one:

static u32 i2c_powermac_get_addr(struct i2c_adapter *adap,
                                           struct pmac_i2c_bus *bus,
                                           struct device_node *node)
{
[...]
        /* Now handle some devices with missing "reg" properties */
        if (!strcmp(node->name, "cereal"))
                return 0x60;


I would appreciate if someone could confirm this case could be handle
by `i2c-powermac` before filling a bug report.

Regards.
