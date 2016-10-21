Return-Path: <shreyasbp@gmail.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t0lSR002XzDt0m
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Oct 2016 23:32:38 +1100 (AEDT)
MIME-Version: 1.0
In-Reply-To: <20161021090305.GA3809@fergus.ozlabs.ibm.com>
References: <20161021090305.GA3809@fergus.ozlabs.ibm.com>
From: "Shreyas B. Prabhu" <shreyasbp@gmail.com>
Date: Fri, 21 Oct 2016 08:32:35 -0400
Message-ID: <CAAVMmb40vaLuWndMnmF6gLcTjmq2LukNnm5NrSt_q7AHGZ2TUA@mail.gmail.com>
Subject: Re: [PATCH 1/2] powerpc/64: Re-fix race condition between going idle
 and entering guest
To: Paul Mackerras <paulus@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
Content-Type: multipart/alternative; boundary=001a113cefcab29124053f5f3c49
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--001a113cefcab29124053f5f3c49
Content-Type: text/plain; charset=UTF-8

On Fri, Oct 21, 2016 at 5:03 AM, Paul Mackerras <paulus@ozlabs.org> wrote:

> Commit 8117ac6a6c2f ("powerpc/powernv: Switch off MMU before entering
> nap/sleep/rvwinkle mode", 2014-12-10) fixed a race condition where one
> thread entering a KVM guest could switch the MMU context to the guest
> while another thread was still in host kernel context with the MMU on.
> That commit moved the point where a thread entering a power-saving
> mode set its kvm_hstate.hwthread_state field in its PACA to
> KVM_HWTHREAD_IN_IDLE from a point where the MMU was on to after the
> MMU had been switched off.  That commit also added a comment
> explaining that we have to switch to real mode before setting
> hwthread_state to avoid this race.
>
> Nevertheless, commit 4eae2c9ae54a ("powerpc/powernv: Make
> pnv_powersave_common more generic", 2016-07-08) subsequently moved
> the setting of hwthread_state back to a point where the MMU is on,
> thus reintroducing the race, despite the comment saying that this
> should not be done being included in full in the context lines of
> the patch that did it.
>
> This fixes the race again and adds a bigger and shoutier comment
> explaining the potential race condition.
>
> Cc: stable@vger.kernel.org # v4.8
> Fixes: 4eae2c9ae54a
> Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
> ---
>

Serious oversight on my part. Thanks for fixing this.

Reviewed-by: Shreyas B. Prabhu <shreyasbp@gmail.com>

Thanks,
Shreyas

--001a113cefcab29124053f5f3c49
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Fri, Oct 21, 2016 at 5:03 AM, Paul Mackerras <span dir=3D"ltr">&lt;<=
a href=3D"mailto:paulus@ozlabs.org" target=3D"_blank">paulus@ozlabs.org</a>=
&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0=
 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Commit 8117ac6a6c2f (&=
quot;powerpc/powernv: Switch off MMU before entering<br>
nap/sleep/rvwinkle mode&quot;, 2014-12-10) fixed a race condition where one=
<br>
thread entering a KVM guest could switch the MMU context to the guest<br>
while another thread was still in host kernel context with the MMU on.<br>
That commit moved the point where a thread entering a power-saving<br>
mode set its kvm_hstate.hwthread_state field in its PACA to<br>
KVM_HWTHREAD_IN_IDLE from a point where the MMU was on to after the<br>
MMU had been switched off.=C2=A0 That commit also added a comment<br>
explaining that we have to switch to real mode before setting<br>
hwthread_state to avoid this race.<br>
<br>
Nevertheless, commit 4eae2c9ae54a (&quot;powerpc/powernv: Make<br>
pnv_powersave_common more generic&quot;, 2016-07-08) subsequently moved<br>
the setting of hwthread_state back to a point where the MMU is on,<br>
thus reintroducing the race, despite the comment saying that this<br>
should not be done being included in full in the context lines of<br>
the patch that did it.<br>
<br>
This fixes the race again and adds a bigger and shoutier comment<br>
explaining the potential race condition.<br>
<br>
Cc: <a href=3D"mailto:stable@vger.kernel.org">stable@vger.kernel.org</a> # =
v4.8<br>
Fixes: 4eae2c9ae54a<br>
Signed-off-by: Paul Mackerras &lt;<a href=3D"mailto:paulus@ozlabs.org">paul=
us@ozlabs.org</a>&gt;<br>
---<br></blockquote><div><br></div><div>Serious oversight on my part. Thank=
s for fixing this.</div><div><br></div><div>Reviewed-by: Shreyas B. Prabhu =
&lt;<a href=3D"mailto:shreyasbp@gmail.com">shreyasbp@gmail.com</a>&gt;</div=
><div><br></div><div>Thanks,</div><div>Shreyas</div></div>
</div></div>

--001a113cefcab29124053f5f3c49--
