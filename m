Return-Path: <guilherme@gpiccoli.net>
Received: from mail-io0-x242.google.com (mail-io0-x242.google.com
 [IPv6:2607:f8b0:4001:c06::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 419Bjt6cpDzDrbK
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jun 2018 01:30:23 +1000 (AEST)
Received: by mail-io0-x242.google.com with SMTP id t5-v6so579658ioa.8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jun 2018 08:30:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180618165706.42679-1-danielwa@cisco.com>
References: <20180618165706.42679-1-danielwa@cisco.com>
From: Guilherme Piccoli <kernel@gpiccoli.net>
Date: Tue, 19 Jun 2018 12:29:41 -0300
Message-ID: <CALJn8nPbTy3Ne2a7L71c2YZ06Ccr2j0zs6TdptfRc7O-N9u=Yg@mail.gmail.com>
Subject: Re: [PATCH] arch: powerpc: pci-common: fix wrong return value check
 on phd_id
To: Daniel Walker <danielwa@cisco.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, xe-kernel@external.cisco.com,
 Gavin Shan <gwshan@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Ian Munsie <imunsie@au1.ibm.com>,
 linuxppc-dev@lists.ozlabs.org,
 Mauro Rodrigues <maurosr@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jun 18, 2018 at 1:57 PM, Daniel Walker <danielwa@cisco.com> wrote:
> Cisco has a couple platforms which depend on the domain values getting
> set a certain way. We discovered our machines not detecting the pci
> devices, and traced it back to this commit,
>
> 63a7228 powerpc/pci: Assign fixed PHB number based on device-tree
> properties
>
> It seems that the code is expecting the return value of of_property_read_u64()
> to be the opposite of what it actually is.. It returns zero on success, and a
> negative return value on error. So if you only check when it's non-zero your
> going to set Opal for all platforms but Opal, which I assume is not what was
> expected.

Hi Daniel, thanks for exposing a potential issue and trying to fix.
(And thanks Mauro to point this message, since my email changed).

I disagree with your patch Daniel, I think it's wrong.
Since the logic of my original patch is kind of convoluted, for improve
(even my own) understanding, I tried to over-comment the logic here:
https://pastebin.ubuntu.com/p/4DNvd9b2bY

Please, take a look and see if you agree with the logic now.


Regarding your issue, I'm interested - I think perhaps you have some FW
flaw that might be exposing duplicated "reg" or "ibm,opal-phbid" properties.
Or maybe you somehow rely on the old incremental PHB setting and your
software stack is not working properly with the DT-based PHB values.

Please, elaborate the issue a bit more in order we can try to figure
out. And also, you could try reverting the below two patches and boot
the kernel to be sure it works:

61e8a0d5a02 powerpc/pci: Fix endian bug in fixed PHB numbering
63a72284b15 powerpc/pci: Assign fixed PHB number based on device-tree properties

*Notice* the first is a fix to my patch, and both should be tested together.
Be sure your current kernel has _both or neither_ these patches!

Cheers,


Guilherme
