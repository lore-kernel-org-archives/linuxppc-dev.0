Return-Path: <bharata.rao@gmail.com>
Received: from mail-ot0-x242.google.com (mail-ot0-x242.google.com
 [IPv6:2607:f8b0:4003:c0f::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ydQgV5KZrzDrK2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Nov 2017 15:51:34 +1100 (AEDT)
Received: by mail-ot0-x242.google.com with SMTP id g104so1097460otg.7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Nov 2017 20:51:34 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <77eae60c-a406-dd8c-acb5-9e137153ce7a@linux.vnet.ibm.com>
References: <150850568437.9118.13945089249591962212.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
 <CAGZKiBqX+Y==jK1XRcsS=ewr+sPATcOe0MEYduKqfX78jJxasQ@mail.gmail.com>
 <77eae60c-a406-dd8c-acb5-9e137153ce7a@linux.vnet.ibm.com>
From: Bharata B Rao <bharata.rao@gmail.com>
Date: Fri, 17 Nov 2017 10:21:31 +0530
Message-ID: <CAGZKiBq-QszDXcKoQwPTq1D5dfXcXHAp0an7CRd6m8Oey0s=Sg@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] powerpc: Support ibm,dynamic-memory-v2 property
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Aneesh Kumar <aneesh.kumar@linux.vnet.ibm.com>
Content-Type: multipart/alternative; boundary="f4030435ac8c8bc60e055e267d9c"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--f4030435ac8c8bc60e055e267d9c
Content-Type: text/plain; charset="UTF-8"

On Thu, Nov 16, 2017 at 9:31 PM, Nathan Fontenot <nfont@linux.vnet.ibm.com>
wrote:

>
>
> On 11/15/2017 11:37 PM, Bharata B Rao wrote:
> > On Fri, Oct 20, 2017 at 6:51 PM, Nathan Fontenot <
> nfont@linux.vnet.ibm.com <mailto:nfont@linux.vnet.ibm.com>> wrote:
> >
> >     This patch set provides a set of updates to de-couple the LMB
> information
> >     provided in the ibm,dynamic-memory device tree property from the
> device
> >     tree property format. A part of this patch series introduces a new
> >     device tree property format for dynamic memory, ibm-dynamic-meory-v2.
> >     By separating the device tree format from the information provided by
> >     the device tree property consumers of this information need not know
> >     what format is currently being used and provide multiple parsing
> routines
> >     for the information.
> >
> >     The first two patches update the of_get_assoc_arrays() and
> >     of_get_usable_memory() routines to look up the device node for the
> >     properties they parse. This is needed because the calling routines
> for
> >     these two functions will not have the device node to pass in in
> >     subsequent patches.
> >
> >     The third patch adds a new kernel structure, struct drmem_lmb, that
> >     is used to represent each of the possible LMBs specified in the
> >     ibm,dynamic-memory* device tree properties. The patch adds code
> >     to parse the property and build the LMB array data, and updates
> prom.c
> >     to use this new data structure instead of parsing the device tree
> directly.
> >
> >     The fourth and fifth patches update the numa and pseries hotplug code
> >     respectively to use the new LMB array data instead of parsing the
> >     device tree directly.
> >
> >     The sixth patch moves the of_drconf_cell struct to drmem.h where it
> >     fits better than prom.h
> >
> >     The seventh patch introduces support for the ibm,dynamic-memory-v2
> >     property format by updating the new drmem.c code to be able to parse
> >     and create this new device tree format.
> >
> >     The last patch in the series updates the architecture vector to
> indicate
> >     support for ibm,dynamic-memory-v2.
> >
> >
> > Here we are consolidating LMBs into LMB sets but still end up working
> with individual LMBs during hotplug. Can we instead start working with LMB
> sets together during hotplug ? In other words
>
> In a sense we do do this when handling memory DLPAR indexed-count
> requests. This takes a starting
> drc index for a LMB and adds/removes the following <count> contiguous
> LMBs. This operation is
> all-or-nothing, if any LMB fails to add/remove we revert back to the
> original state.
>

I am aware of count-indexed and we do use it for memory hotplug/unplug for
KVM on Power. However the RTAS and configure-connector calls there are
still per-LMB.


> Thi isn't exactly what you're asking for but...
> >
> > - The RTAS calls involved during DRC acquire stage can be done only once
> per LMB set.
> > - One configure-connector call for the entire LMB set.
>
> these two interfaces work on a single drc index, not a set of drc indexes.
> Working on a set
> of LMBs would require extending the current rtas calls or creating new
> ones.
>

Yes.


>
> One thing we can look into doing for indexed-count requests is to perform
> each of the
> steps for all LMBs in the set at once, i.e. make the acquire call for
> LMBs, then make the
> configure-connector calls for all the LMBs...
>

That is what I am hinting at to check the feasibility of such a mechanism.
Given that all the LMBs of the set are supposed to have similar attributes
(like node associativity etc), it makes sense to have a single DRC acquire
call and single configure-connector call for the entire set.


> The only drawback is this approach would make handling failures and
> backing out of the
> updates a bit messier, but I've never really thought that optimizing for
> the failure
> case to be as important.
>

Yes, error recovery can be messy given that we have multiple calls under
DRC acquire call (get-sensor-state and set-indicator).

BTW I thought this reorganization involving ibm,drc-info and
ibm,dynamic-memory-v2 was for representing and hotplugging huge amounts of
memory efficiently and quickly. So you have not yet found the per-LMB calls
to be hurting when huge amount of memory is involved ?

Regards,
Bharata.

--f4030435ac8c8bc60e055e267d9c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Thu, Nov 16, 2017 at 9:31 PM, Nathan Fontenot <span dir=3D"ltr">&lt;<a h=
ref=3D"mailto:nfont@linux.vnet.ibm.com" target=3D"_blank">nfont@linux.vnet.=
ibm.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D=
"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><br>
<br>
On 11/15/2017 11:37 PM, Bharata B Rao wrote:<br>
<div><div class=3D"h5">&gt; On Fri, Oct 20, 2017 at 6:51 PM, Nathan Fonteno=
t &lt;<a href=3D"mailto:nfont@linux.vnet.ibm.com">nfont@linux.vnet.ibm.com<=
/a> &lt;mailto:<a href=3D"mailto:nfont@linux.vnet.ibm.com">nfont@linux.vnet=
.ibm.<wbr>com</a>&gt;&gt; wrote:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0This patch set provides a set of updates to de-coup=
le the LMB information<br>
&gt;=C2=A0 =C2=A0 =C2=A0provided in the ibm,dynamic-memory device tree prop=
erty from the device<br>
&gt;=C2=A0 =C2=A0 =C2=A0tree property format. A part of this patch series i=
ntroduces a new<br>
&gt;=C2=A0 =C2=A0 =C2=A0device tree property format for dynamic memory, ibm=
-dynamic-meory-v2.<br>
&gt;=C2=A0 =C2=A0 =C2=A0By separating the device tree format from the infor=
mation provided by<br>
&gt;=C2=A0 =C2=A0 =C2=A0the device tree property consumers of this informat=
ion need not know<br>
&gt;=C2=A0 =C2=A0 =C2=A0what format is currently being used and provide mul=
tiple parsing routines<br>
&gt;=C2=A0 =C2=A0 =C2=A0for the information.<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0The first two patches update the of_get_assoc_array=
s() and<br>
&gt;=C2=A0 =C2=A0 =C2=A0of_get_usable_memory() routines to look up the devi=
ce node for the<br>
&gt;=C2=A0 =C2=A0 =C2=A0properties they parse. This is needed because the c=
alling routines for<br>
&gt;=C2=A0 =C2=A0 =C2=A0these two functions will not have the device node t=
o pass in in<br>
&gt;=C2=A0 =C2=A0 =C2=A0subsequent patches.<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0The third patch adds a new kernel structure, struct=
 drmem_lmb, that<br>
&gt;=C2=A0 =C2=A0 =C2=A0is used to represent each of the possible LMBs spec=
ified in the<br>
&gt;=C2=A0 =C2=A0 =C2=A0ibm,dynamic-memory* device tree properties. The pat=
ch adds code<br>
&gt;=C2=A0 =C2=A0 =C2=A0to parse the property and build the LMB array data,=
 and updates prom.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0to use this new data structure instead of parsing t=
he device tree directly.<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0The fourth and fifth patches update the numa and ps=
eries hotplug code<br>
&gt;=C2=A0 =C2=A0 =C2=A0respectively to use the new LMB array data instead =
of parsing the<br>
&gt;=C2=A0 =C2=A0 =C2=A0device tree directly.<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0The sixth patch moves the of_drconf_cell struct to =
drmem.h where it<br>
&gt;=C2=A0 =C2=A0 =C2=A0fits better than prom.h<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0The seventh patch introduces support for the ibm,dy=
namic-memory-v2<br>
&gt;=C2=A0 =C2=A0 =C2=A0property format by updating the new drmem.c code to=
 be able to parse<br>
&gt;=C2=A0 =C2=A0 =C2=A0and create this new device tree format.<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0The last patch in the series updates the architectu=
re vector to indicate<br>
&gt;=C2=A0 =C2=A0 =C2=A0support for ibm,dynamic-memory-v2.<br>
&gt;<br>
&gt;<br>
&gt; Here we are consolidating LMBs into LMB sets but still end up working =
with individual LMBs during hotplug. Can we instead start working with LMB =
sets together during hotplug ? In other words<br>
<br>
</div></div>In a sense we do do this when handling memory DLPAR indexed-cou=
nt requests. This takes a starting<br>
drc index for a LMB and adds/removes the following &lt;count&gt; contiguous=
 LMBs. This operation is<br>
all-or-nothing, if any LMB fails to add/remove we revert back to the origin=
al state.<br></blockquote><div><br></div><div>I am aware of count-indexed a=
nd we do use it for memory hotplug/unplug for KVM on Power. However the RTA=
S and configure-connector calls there are still per-LMB.<br><br></div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #cc=
c solid;padding-left:1ex">
<br>
Thi isn&#39;t exactly what you&#39;re asking for but...<br>
<span class=3D"">&gt;<br>
&gt; - The RTAS calls involved during DRC acquire stage can be done only on=
ce per LMB set.<br>
&gt; - One configure-connector call for the entire LMB set.<br>
<br>
</span>these two interfaces work on a single drc index, not a set of drc in=
dexes. Working on a set<br>
of LMBs would require extending the current rtas calls or creating new ones=
.<br></blockquote><div><br></div><div>Yes.<br>=C2=A0<br></div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;=
padding-left:1ex">
<br>
One thing we can look into doing for indexed-count requests is to perform e=
ach of the<br>
steps for all LMBs in the set at once, i.e. make the acquire call for LMBs,=
 then make the<br>
configure-connector calls for all the LMBs...<br></blockquote><div><br></di=
v><div>That is what I am hinting at to check the feasibility of such a mech=
anism. Given that all the LMBs of the set are supposed to have similar attr=
ibutes (like node associativity etc), it makes sense to have a single DRC a=
cquire call and single configure-connector call for the entire set.<br><br>=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-l=
eft:1px #ccc solid;padding-left:1ex">
<br>
The only drawback is this approach would make handling failures and backing=
 out of the<br>
updates a bit messier, but I&#39;ve never really thought that optimizing fo=
r the failure<br>
case to be as important.<br></blockquote><div><br></div><div>Yes, error rec=
overy can be messy given that we have multiple calls under DRC acquire call=
 (get-sensor-state and set-indicator).<br><br></div><div>BTW I thought this=
 reorganization involving ibm,drc-info and ibm,dynamic-memory-v2 was for re=
presenting and hotplugging huge amounts of memory efficiently and quickly. =
So you have not yet found the per-LMB calls to be hurting when huge amount =
of memory is involved ?<br><br></div><div>Regards,<br></div><div>Bharata.</=
div></div><br></div></div>

--f4030435ac8c8bc60e055e267d9c--
