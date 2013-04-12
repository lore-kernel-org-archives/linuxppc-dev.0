Return-Path: <j.glisse@gmail.com>
Received: from mail-qa0-f46.google.com (mail-qa0-f46.google.com
 [209.85.216.46])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4A7D82C00A7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Apr 2013 23:52:34 +1000 (EST)
Received: by mail-qa0-f46.google.com with SMTP id j8so876617qah.19
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Apr 2013 06:52:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1365685994-32603-1-git-send-email-lucaskt@linux.vnet.ibm.com>
References: <1365685994-32603-1-git-send-email-lucaskt@linux.vnet.ibm.com>
Date: Fri, 12 Apr 2013 09:52:30 -0400
Message-ID: <CAH3drwZK4S5OCLnvwyz9Jw5Hy7XpmedZJghq6JfDqw6Rvq6eDg@mail.gmail.com>
Subject: Re: [PATCHv3 0/2] Speed Cap fixes for ppc64
From: Jerome Glisse <j.glisse@gmail.com>
To: Lucas Kannebley Tavares <lucaskt@linux.vnet.ibm.com>
Content-Type: multipart/alternative; boundary=20cf306f732ad925ff04da2a36ea
Cc: David Airlie <airlied@linux.ie>, Brian King <brking@linux.vnet.ibm.com>,
 dri-devel@lists.freedesktop.org,
 Kleber Sacilotto de Souza <klebers@linux.vnet.ibm.com>,
 Alex Deucher <alexander.deucher@amd.com>, Jerome Glisse <jglisse@redhat.com>,
 Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>,
 Bjorn Helgaas <bhelgaas@google.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--20cf306f732ad925ff04da2a36ea
Content-Type: text/plain; charset=ISO-8859-1

On Thu, Apr 11, 2013 at 9:13 AM, Lucas Kannebley Tavares <
lucaskt@linux.vnet.ibm.com> wrote:

> After all the comments in the last patch series, I did a refactoring of
> what I was proposing and came up with this. Basically, now:
>   1. max_bus_speed is used to set the device to gen2 speeds
>   2. on power there's no longer a conflict between the pseries call and
> other architectures, because the overwrite is done via a ppc_md hook
>   3. radeon is using bus->max_bus_speed instead of
> drm_pcie_get_speed_cap_mask for gen2 capability detection
>
> The first patch consists of some architecture changes, such as adding a
> hook on powerpc for pci_root_bridge_prepare, so that pseries will
> initialize it to a function, while all other architectures get a NULL
> pointer. So that whenever whenever pci_create_root_bus is called, we'll get
> max_bus_speed properly setup from OpenFirmware.
>
> The second patch consists of simple radeon changes not to call
> drm_get_pcie_speed_cap_mask anymore. I assume that on x86 machines, the
> max_bus_speed property will be properly set already.
>

The radeon changes are :

Reviewed-by: Jerome Glisse <jglisse@redhat.com>


>
> Lucas Kannebley Tavares (2):
>   ppc64: perform proper max_bus_speed detection
>   radeon: use max_bus_speed to activate gen2 speeds
>
>  arch/powerpc/include/asm/machdep.h     |    2 +
>  arch/powerpc/kernel/pci-common.c       |    8 +++++
>  arch/powerpc/platforms/pseries/pci.c   |   51
> ++++++++++++++++++++++++++++++++
>  arch/powerpc/platforms/pseries/setup.c |    4 ++
>  drivers/gpu/drm/radeon/evergreen.c     |    9 +----
>  drivers/gpu/drm/radeon/r600.c          |    8 +----
>  drivers/gpu/drm/radeon/rv770.c         |    8 +----
>  7 files changed, 69 insertions(+), 21 deletions(-)
>
> --
> 1.7.4.4
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> http://lists.freedesktop.org/mailman/listinfo/dri-devel
>

--20cf306f732ad925ff04da2a36ea
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">On Thu, Apr 11, 2013 at 9:13 AM, Lucas Kannebley=
 Tavares <span dir=3D"ltr">&lt;<a href=3D"mailto:lucaskt@linux.vnet.ibm.com=
" target=3D"_blank">lucaskt@linux.vnet.ibm.com</a>&gt;</span> wrote:<br><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #=
ccc solid;padding-left:1ex">
After all the comments in the last patch series, I did a refactoring of wha=
t I was proposing and came up with this. Basically, now:<br>
=A0 1. max_bus_speed is used to set the device to gen2 speeds<br>
=A0 2. on power there&#39;s no longer a conflict between the pseries call a=
nd other architectures, because the overwrite is done via a ppc_md hook<br>
=A0 3. radeon is using bus-&gt;max_bus_speed instead of drm_pcie_get_speed_=
cap_mask for gen2 capability detection<br>
<br>
The first patch consists of some architecture changes, such as adding a hoo=
k on powerpc for pci_root_bridge_prepare, so that pseries will initialize i=
t to a function, while all other architectures get a NULL pointer. So that =
whenever whenever pci_create_root_bus is called, we&#39;ll get max_bus_spee=
d properly setup from OpenFirmware.<br>

<br>
The second patch consists of simple radeon changes not to call drm_get_pcie=
_speed_cap_mask anymore. I assume that on x86 machines, the max_bus_speed p=
roperty will be properly set already.<br></blockquote><div><br>The radeon c=
hanges are :<br>
<br>Reviewed-by: Jerome Glisse &lt;<a href=3D"mailto:jglisse@redhat.com">jg=
lisse@redhat.com</a>&gt;<br>=A0</div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
Lucas Kannebley Tavares (2):<br>
=A0 ppc64: perform proper max_bus_speed detection<br>
=A0 radeon: use max_bus_speed to activate gen2 speeds<br>
<br>
=A0arch/powerpc/include/asm/machdep.h =A0 =A0 | =A0 =A02 +<br>
=A0arch/powerpc/kernel/pci-common.c =A0 =A0 =A0 | =A0 =A08 +++++<br>
=A0arch/powerpc/platforms/pseries/pci.c =A0 | =A0 51 ++++++++++++++++++++++=
++++++++++<br>
=A0arch/powerpc/platforms/pseries/setup.c | =A0 =A04 ++<br>
=A0drivers/gpu/drm/radeon/evergreen.c =A0 =A0 | =A0 =A09 +----<br>
=A0drivers/gpu/drm/radeon/r600.c =A0 =A0 =A0 =A0 =A0| =A0 =A08 +----<br>
=A0drivers/gpu/drm/radeon/rv770.c =A0 =A0 =A0 =A0 | =A0 =A08 +----<br>
=A07 files changed, 69 insertions(+), 21 deletions(-)<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
--<br>
1.7.4.4<br>
<br>
_______________________________________________<br>
dri-devel mailing list<br>
<a href=3D"mailto:dri-devel@lists.freedesktop.org">dri-devel@lists.freedesk=
top.org</a><br>
<a href=3D"http://lists.freedesktop.org/mailman/listinfo/dri-devel" target=
=3D"_blank">http://lists.freedesktop.org/mailman/listinfo/dri-devel</a><br>
</font></span></blockquote></div><br>

--20cf306f732ad925ff04da2a36ea--
