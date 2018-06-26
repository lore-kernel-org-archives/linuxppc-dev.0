Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-ot0-f196.google.com (mail-ot0-f196.google.com
 [74.125.82.196])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41FGL075T9zF1PD
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jun 2018 16:27:20 +1000 (AEST)
Received: by mail-ot0-f196.google.com with SMTP id l15-v6so17802540oth.6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jun 2018 23:27:20 -0700 (PDT)
MIME-Version: 1.0
References: <20180622192718.24242-1-malat@debian.org>
 <b41b244e-78b8-c85f-9122-427ad04cccf8@c-s.fr>
 <20180623194716.GY16221@gate.crashing.org>
In-Reply-To: <20180623194716.GY16221@gate.crashing.org>
From: Mathieu Malaterre <malat@debian.org>
Date: Tue, 26 Jun 2018 08:27:06 +0200
Message-ID: <CA+7wUsx4wpiP+q7NusNgFYfAM3gbnvOOPgrjq4QV7iA510noCg@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH=5D_powerpc=2Fxmon=3A_avoid_warnings_about_varia?=
 =?UTF-8?Q?bles_that_might_be_clobbered_by_=E2=80=98longjmp=E2=80=99?=
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Christophe LEROY <christophe.leroy@c-s.fr>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Yisheng Xie <xieyisheng1@huawei.com>, Vaibhav Jain <vaibhav@linux.vnet.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, LKML <linux-kernel@vger.kernel.org>,
 Paul Mackerras <paulus@samba.org>, Breno Leitao <leitao@debian.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Jun 23, 2018 at 9:47 PM Segher Boessenkool
<segher@kernel.crashing.org> wrote:
>
> On Sat, Jun 23, 2018 at 06:59:27PM +0200, christophe leroy wrote:
> >
> >
> > Le 22/06/2018 =C3=A0 21:27, Mathieu Malaterre a =C3=A9crit :
> > >Move initialization of variables after data definitions. This silence
> > >warnings treated as error with W=3D1:
> > >
> > >   arch/powerpc/xmon/xmon.c:3389:14: error: variable =E2=80=98name=E2=
=80=99 might be
> > >   clobbered by =E2=80=98longjmp=E2=80=99 or =E2=80=98vfork=E2=80=99 [=
-Werror=3Dclobbered]
> > >   arch/powerpc/xmon/xmon.c:3100:22: error: variable =E2=80=98tsk=E2=
=80=99 might be
> > >   clobbered by =E2=80=98longjmp=E2=80=99 or =E2=80=98vfork=E2=80=99 [=
-Werror=3Dclobbered]
> >
> > Is that an invalid warning ?
>
> No, both are correct warnings.  GCC can not see which functions it only
> has a declaration of can call longjmp.

I assumed those were false positive warnings, given how easy it was to
defeat them. Let give it another try.

> > Otherwise, I'd expect one to fix the warning, not just cheat on GCC.
>
> Yes, the patch seems to change the code in such a way that some versions
> of GCC will no longer warn.  Which does not make to code any more correct=
.
>
> Either restructure the code, or make the var non-automatic, or make it
> volatile.
>
>
> Segher
