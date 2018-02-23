Return-Path: <bharata.rao@gmail.com>
Received: from mail-io0-x22f.google.com (mail-io0-x22f.google.com
 [IPv6:2607:f8b0:4001:c06::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3znmGl5JhrzF1jN
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Feb 2018 20:32:44 +1100 (AEDT)
Received: by mail-io0-x22f.google.com with SMTP id g21so9181644ioj.5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Feb 2018 01:32:44 -0800 (PST)
MIME-Version: 1.0
From: Bharata B Rao <bharata.rao@gmail.com>
Date: Fri, 23 Feb 2018 15:02:40 +0530
Message-ID: <CAGZKiBoy5kZxijbGg0VaRr_HbgPyoHS-UnkXyhHt15sCpcT4ow@mail.gmail.com>
Subject: Hotplug + Reboot is crashing HPT guest with HPT resizing enabled
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc: David Gibson <david@gibson.dropbear.id.au>
Content-Type: multipart/alternative; boundary="089e082ce9a08555570565ddd775"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--089e082ce9a08555570565ddd775
Content-Type: text/plain; charset="UTF-8"

Hi,

Rebooting a hash guest after hotplugging memory to it is crashing the
guest. This is seen only when HPT resizing is enabled. I see guest crashing
at multiple places, but this location is fairly commonly seen:

kernel BUG at mm/slub.c:3912!

Testing with latest guest kernel and ppc-for-2.12 branch of QEMU.

A bit of debugging shows me that when memory is added, the guest kernel
tries to resize HPT to a htab_shift value lesser than the value with which
the guest has booted. For eg. a 8GB guest boots with htab_shift of 26. When
1G is hot-added,
arch/powerpc/mm/hash_utils_64.c:resize_hpt_for_hotplug() ends up assigning
24 to target_hpt_shift. This looks suspicious as we are increasing the
memory, but kernel is asking for shrinking the HPT size. HPT resizing
requests fail though, but next reboot crashes the guest.

Regards,
Bharata.
-- 
http://raobharata.wordpress.com/

--089e082ce9a08555570565ddd775
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<br><br>Rebooting a hash guest after hotplugging memory=
 to it is crashing the guest. This is seen only when HPT resizing is enable=
d. I see guest crashing at multiple places, but this location is fairly com=
monly seen:<br><br>kernel BUG at mm/slub.c:3912!<br><br>Testing with latest=
 guest kernel and ppc-for-2.12 branch of QEMU.<br><br>A bit of debugging sh=
ows me that when memory is added, the guest kernel tries to resize HPT to a=
 htab_shift value lesser than the value with which the guest has booted. Fo=
r eg. a 8GB guest boots with htab_shift of 26. When 1G is hot-added,<br>arc=
h/powerpc/mm/hash_utils_64.c:resize_hpt_for_hotplug() ends up assigning 24 =
to target_hpt_shift. This looks suspicious as we are increasing the memory,=
 but kernel is asking for shrinking the HPT size. HPT resizing requests fai=
l though, but next reboot crashes the guest.<br><br>Regards,<br>Bharata.<br=
 clear=3D"all">-- <br><div class=3D"gmail_signature"><a href=3D"http://raob=
harata.wordpress.com/" target=3D"_blank">http://raobharata.wordpress.com/</=
a></div>
</div>

--089e082ce9a08555570565ddd775--
