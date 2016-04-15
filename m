Return-Path: <alessio.bogani@elettra.eu>
Received: from spamalot.elettra.eu (spamalot.elettra.trieste.it
 [140.105.206.208])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qmcmj6VGYzDq62
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Apr 2016 22:49:02 +1000 (AEST)
Received: from spamalot.elettra.eu (localhost.localdomain [127.0.0.1])
 by localhost (Email Security Appliance) with SMTP id AA63A440E3B_710E33AB
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Apr 2016 12:48:58 +0000 (GMT)
Received: from mail-qk0-f178.google.com (mail-qk0-f178.google.com
 [209.85.220.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (verified OK))
 by spamalot.elettra.eu (Sophos Email Appliance) with ESMTPSA id
 3C29543E071_710E33AF
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Apr 2016 12:48:58 +0000 (GMT)
Received: by mail-qk0-f178.google.com with SMTP id r184so37756268qkc.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Apr 2016 05:48:58 -0700 (PDT)
MIME-Version: 1.0
Date: Fri, 15 Apr 2016 14:48:56 +0200
Message-ID: <CAPk1OjHi26s6=pMqW4OgyK7ooo=0sQrWC-gjoE0P+paOs_cT2w@mail.gmail.com>
Subject: Ran out of outbound PCI ATMUs for IO resource
From: Alessio Igor Bogani <alessio.bogani@elettra.eu>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

I run into this message "Ran out of outbound PCI ATMUs for IO
resource". The only solution I found so far is to replace few lines in this way:

pci0: pcie@f1008000 {
reg = <0xf1008000 0x1000>;
- ranges = <0x02000000 0x0 0x80000000 0x80000000 0x0 0x10000000
-                   0x42000000 0x0 0x90000000 0x90000000 0x0 0x40000000
+ ranges = <0x02000000 0x0 0x80000000 0x80000000 0x0 0x50000000
                      0x01000000 0x0 0x00000000 0xf0000000 0x0 0x00800000>;
pcie@0 {
ranges = <0x02000000 0x0 0x80000000
 0x02000000 0x0 0x80000000
-  0x0 0x10000000
-
-  0x42000000 0x0 0x90000000
-  0x42000000 0x0 0x90000000
-  0x0 0x40000000
+  0x0 0x50000000

 0x01000000 0x0 0x00000000
 0x01000000 0x0 0x00000000
 0x0 0x00800000>;
};
};


I'm wondering if this is the right thing to do in this case.

Thank you very much!

Ciao,
Alessio
