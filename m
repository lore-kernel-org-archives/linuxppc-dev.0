Return-Path: <bharata.rao@gmail.com>
Received: from mail-ot0-x242.google.com (mail-ot0-x242.google.com
 [IPv6:2607:f8b0:4003:c0f::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zXmQk1zm0zDq8c
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Feb 2018 16:54:37 +1100 (AEDT)
Received: by mail-ot0-x242.google.com with SMTP id a2so7883878otf.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Feb 2018 21:54:37 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAKTCnz=gRT8xBjW6XMkdWDu79jkQ=-1qBxJgxrqMyKw=MCAu_A@mail.gmail.com>
References: <20180201181819.5723-1-bsingharora@gmail.com>
 <CAKTCnz=gRT8xBjW6XMkdWDu79jkQ=-1qBxJgxrqMyKw=MCAu_A@mail.gmail.com>
From: Bharata B Rao <bharata.rao@gmail.com>
Date: Fri, 2 Feb 2018 11:24:35 +0530
Message-ID: <CAGZKiBrN0PdCobR_cZz5t+gLQarE5i79CjMtXHomRPwxtNSAuQ@mail.gmail.com>
Subject: Re: [RFC] powerpc/mm/pgtable: Split mappings on hot-unplug
To: Balbir Singh <bsingharora@gmail.com>
Cc: "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 Aneesh Kumar KV <aneesh.kumar@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>
Content-Type: multipart/alternative; boundary="001a113d140cdce6cd05643458cc"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--001a113d140cdce6cd05643458cc
Content-Type: text/plain; charset="UTF-8"

On Fri, Feb 2, 2018 at 8:38 AM, Balbir Singh <bsingharora@gmail.com> wrote:

> On Thu, Feb 1, 2018 at 11:48 PM, Balbir Singh <bsingharora@gmail.com>
> wrote:
> > This patch splits the a linear mapping if the hot-unplug range
> > is smaller than the mapping size. The code detects if the mapping
> > needs to be split into a smaller size and if so, uses the stop
> > machine infrastructure to map the current linear mapping with
> > a smaller size mapping. Then the requested area is unmapped.
> >
> > A new API to do a local TLB flush is introduced and exported.
> > This API is used in stop mapping after clearing the larger
> > mapping and before creating the smaller mapping. There is also
> > a check to ensure that we don't overlap with kernel text
> > (the region that is being split) as it could cause the executing
> > text to fault.
> >
> > There are some caveats with this approach, as the unmapping can
> > cause reserved memory area to be freed up (memblock reserved
> > mappings and allocations as well), that can be a problem. There
> > could be a case where radix__map_kernel_page() may fault if the
> > area selected to unmap contains the process page table, this is
> > not a new problem created by the patch, but something to watch
> > out for while testing. The right approach to solving the hot-unplug
> > issue is to make the node/DIMM to be marked hotpluggable so that
> > all the memory in that is movable. Currently there is no method
> > of enforcing the hotpluggable property via libvirt or qemu.
>

In fact QEMU presents all the hotpluggable memory to the guest via
ibm,dynamic-reconfiguration-memory DT node. So guest kernel can easily mark
them as hotpluggable and that is what I tried in my earlier attempts.
However that won't fly with PowerVM for the reason described in
https://patchwork.ozlabs.org/patch/856015/

Regards,
Bharata.

--001a113d140cdce6cd05643458cc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Fri, Feb 2, 2018 at 8:38 AM, Balbir Singh <span dir=3D"ltr">&lt;<a href=
=3D"mailto:bsingharora@gmail.com" target=3D"_blank">bsingharora@gmail.com</=
a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><=
div class=3D"gmail-HOEnZb"><div class=3D"gmail-h5">On Thu, Feb 1, 2018 at 1=
1:48 PM, Balbir Singh &lt;<a href=3D"mailto:bsingharora@gmail.com">bsinghar=
ora@gmail.com</a>&gt; wrote:<br>
&gt; This patch splits the a linear mapping if the hot-unplug range<br>
&gt; is smaller than the mapping size. The code detects if the mapping<br>
&gt; needs to be split into a smaller size and if so, uses the stop<br>
&gt; machine infrastructure to map the current linear mapping with<br>
&gt; a smaller size mapping. Then the requested area is unmapped.<br>
&gt;<br>
&gt; A new API to do a local TLB flush is introduced and exported.<br>
&gt; This API is used in stop mapping after clearing the larger<br>
&gt; mapping and before creating the smaller mapping. There is also<br>
&gt; a check to ensure that we don&#39;t overlap with kernel text<br>
&gt; (the region that is being split) as it could cause the executing<br>
&gt; text to fault.<br>
&gt;<br>
&gt; There are some caveats with this approach, as the unmapping can<br>
&gt; cause reserved memory area to be freed up (memblock reserved<br>
&gt; mappings and allocations as well), that can be a problem. There<br>
&gt; could be a case where radix__map_kernel_page() may fault if the<br>
&gt; area selected to unmap contains the process page table, this is<br>
&gt; not a new problem created by the patch, but something to watch<br>
&gt; out for while testing. The right approach to solving the hot-unplug<br=
>
&gt; issue is to make the node/DIMM to be marked hotpluggable so that<br>
&gt; all the memory in that is movable. Currently there is no method<br>
&gt; of enforcing the hotpluggable property via libvirt or qemu.</div></div=
></blockquote></div><br></div><div class=3D"gmail_extra">In fact QEMU prese=
nts all the hotpluggable memory to the guest via ibm,dynamic-reconfiguratio=
n-memory DT node. So guest kernel can easily mark them as hotpluggable and =
that is what I tried in my earlier attempts. However that won&#39;t fly wit=
h PowerVM for the reason described in <a href=3D"https://patchwork.ozlabs.o=
rg/patch/856015/">https://patchwork.ozlabs.org/patch/856015/</a><br><br></d=
iv><div class=3D"gmail_extra">Regards,<br></div><div class=3D"gmail_extra">=
Bharata.<br></div></div>

--001a113d140cdce6cd05643458cc--
