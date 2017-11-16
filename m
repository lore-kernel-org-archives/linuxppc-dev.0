Return-Path: <bharata.rao@gmail.com>
Received: from mail-oi0-x241.google.com (mail-oi0-x241.google.com
 [IPv6:2607:f8b0:4003:c06::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ycqlF3xc2zDqs4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Nov 2017 16:37:44 +1100 (AEDT)
Received: by mail-oi0-x241.google.com with SMTP id a75so12043170oib.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Nov 2017 21:37:44 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <150850568437.9118.13945089249591962212.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
References: <150850568437.9118.13945089249591962212.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
From: Bharata B Rao <bharata.rao@gmail.com>
Date: Thu, 16 Nov 2017 11:07:40 +0530
Message-ID: <CAGZKiBqX+Y==jK1XRcsS=ewr+sPATcOe0MEYduKqfX78jJxasQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] powerpc: Support ibm,dynamic-memory-v2 property
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Aneesh Kumar <aneesh.kumar@linux.vnet.ibm.com>
Content-Type: multipart/alternative; boundary="001a113dee6cc254f9055e130483"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--001a113dee6cc254f9055e130483
Content-Type: text/plain; charset="UTF-8"

On Fri, Oct 20, 2017 at 6:51 PM, Nathan Fontenot <nfont@linux.vnet.ibm.com>
wrote:

> This patch set provides a set of updates to de-couple the LMB information
> provided in the ibm,dynamic-memory device tree property from the device
> tree property format. A part of this patch series introduces a new
> device tree property format for dynamic memory, ibm-dynamic-meory-v2.
> By separating the device tree format from the information provided by
> the device tree property consumers of this information need not know
> what format is currently being used and provide multiple parsing routines
> for the information.
>
> The first two patches update the of_get_assoc_arrays() and
> of_get_usable_memory() routines to look up the device node for the
> properties they parse. This is needed because the calling routines for
> these two functions will not have the device node to pass in in
> subsequent patches.
>
> The third patch adds a new kernel structure, struct drmem_lmb, that
> is used to represent each of the possible LMBs specified in the
> ibm,dynamic-memory* device tree properties. The patch adds code
> to parse the property and build the LMB array data, and updates prom.c
> to use this new data structure instead of parsing the device tree directly.
>
> The fourth and fifth patches update the numa and pseries hotplug code
> respectively to use the new LMB array data instead of parsing the
> device tree directly.
>
> The sixth patch moves the of_drconf_cell struct to drmem.h where it
> fits better than prom.h
>
> The seventh patch introduces support for the ibm,dynamic-memory-v2
> property format by updating the new drmem.c code to be able to parse
> and create this new device tree format.
>
> The last patch in the series updates the architecture vector to indicate
> support for ibm,dynamic-memory-v2.


Here we are consolidating LMBs into LMB sets but still end up working with
individual LMBs during hotplug. Can we instead start working with LMB sets
together during hotplug ? In other words

- The RTAS calls involved during DRC acquire stage can be done only once
per LMB set.
- One configure-connector call for the entire LMB set.

I think this should help hotplugging of large amounts of memory. Other than
that, if we choose to use LMB representation for PMEM, it will be useful
there too to handle all the LMBs of a PMEM range as one set.

Regards,
Bharata.

--001a113dee6cc254f9055e130483
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote">On F=
ri, Oct 20, 2017 at 6:51 PM, Nathan Fontenot <span dir=3D"ltr">&lt;<a href=
=3D"mailto:nfont@linux.vnet.ibm.com" target=3D"_blank">nfont@linux.vnet.ibm=
.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">This patch set=
 provides a set of updates to de-couple the LMB information<br>
provided in the ibm,dynamic-memory device tree property from the device<br>
tree property format. A part of this patch series introduces a new<br>
device tree property format for dynamic memory, ibm-dynamic-meory-v2.<br>
By separating the device tree format from the information provided by<br>
the device tree property consumers of this information need not know<br>
what format is currently being used and provide multiple parsing routines<b=
r>
for the information.<br>
<br>
The first two patches update the of_get_assoc_arrays() and<br>
of_get_usable_memory() routines to look up the device node for the<br>
properties they parse. This is needed because the calling routines for<br>
these two functions will not have the device node to pass in in<br>
subsequent patches.<br>
<br>
The third patch adds a new kernel structure, struct drmem_lmb, that<br>
is used to represent each of the possible LMBs specified in the<br>
ibm,dynamic-memory* device tree properties. The patch adds code<br>
to parse the property and build the LMB array data, and updates prom.c<br>
to use this new data structure instead of parsing the device tree directly.=
<br>
<br>
The fourth and fifth patches update the numa and pseries hotplug code<br>
respectively to use the new LMB array data instead of parsing the<br>
device tree directly.<br>
<br>
The sixth patch moves the of_drconf_cell struct to drmem.h where it<br>
fits better than prom.h<br>
<br>
The seventh patch introduces support for the ibm,dynamic-memory-v2<br>
property format by updating the new drmem.c code to be able to parse<br>
and create this new device tree format.<br>
<br>
The last patch in the series updates the architecture vector to indicate<br=
>
support for ibm,dynamic-memory-v2.</blockquote></div><br></div><div class=
=3D"gmail_extra">Here we are consolidating LMBs into LMB sets but still end=
 up working with individual LMBs during hotplug. Can we instead start worki=
ng with LMB sets together during hotplug ? In other words<br><br></div><div=
 class=3D"gmail_extra">- The RTAS calls involved during DRC acquire stage c=
an be done only once per LMB set.<br></div><div class=3D"gmail_extra">- One=
 configure-connector call for the entire LMB set.<br><br></div><div class=
=3D"gmail_extra">I think this should help hotplugging of large amounts of m=
emory. Other than that, if we choose to use LMB representation for PMEM, it=
 will be useful there too to handle all the LMBs of a PMEM range as one set=
.<br><br></div><div class=3D"gmail_extra">Regards,<br></div><div class=3D"g=
mail_extra">Bharata.<br></div></div>

--001a113dee6cc254f9055e130483--
