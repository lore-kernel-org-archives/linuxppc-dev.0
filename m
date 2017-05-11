Return-Path: <msuchanek@suse.de>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wNxLP1zkBzDqBJ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 May 2017 01:07:56 +1000 (AEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id A77EAABF2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 May 2017 15:07:53 +0000 (UTC)
Date: Thu, 11 May 2017 17:07:53 +0200
From: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v5 2/2] powerpc/fadump: update documentation about
 'fadump_append=' parameter
Message-ID: <20170511170753.66afcd12@kitsune.suse.cz>
In-Reply-To: <e1485f4d-f346-fea6-ee2a-9c7a6b2f6587@linux.vnet.ibm.com>
References: <149383572199.1694.10940679065871920087.stgit@hbathini.in.ibm.com>
 <149383576571.1694.13692135068122879322.stgit@hbathini.in.ibm.com>
 <20170510180132.1fa0c1ec@kitsune.suse.cz>
 <e1485f4d-f346-fea6-ee2a-9c7a6b2f6587@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 11 May 2017 02:00:11 +0530
Hari Bathini <hbathini@linux.vnet.ibm.com> wrote:

> Hello Michal,
>=20
> On Wednesday 10 May 2017 09:31 PM, Michal Such=C3=A1nek wrote:
> > Hello,
> >
> > On Wed, 03 May 2017 23:52:52 +0530
> > Hari Bathini <hbathini@linux.vnet.ibm.com> wrote:
> > =20
> >> With the introduction of 'fadump_append=3D' parameter to pass
> >> additional parameters to fadump (capture) kernel, update
> >> documentation about it.
> >>
> >> Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>
> >> ---
> >>
> >> Changes from v4:
> >> * Based on top of patchset that includes
> >>    https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git=
/commit/?h=3Dakpm&id=3D05f383cdfba8793240e73f9a9fbff4e25d66003f
> >>
> >>
> >>   Documentation/powerpc/firmware-assisted-dump.txt |   10
> >> +++++++++- 1 file changed, 9 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/Documentation/powerpc/firmware-assisted-dump.txt
> >> b/Documentation/powerpc/firmware-assisted-dump.txt index
> >> 8394bc8..6327193 100644 ---
> >> a/Documentation/powerpc/firmware-assisted-dump.txt +++
> >> b/Documentation/powerpc/firmware-assisted-dump.txt @@ -162,7
> >> +162,15 @@ How to enable firmware-assisted dump (fadump):
> >>   1. Set config option CONFIG_FA_DUMP=3Dy and build kernel.
> >>   2. Boot into linux kernel with 'fadump=3Don' kernel cmdline option.
> >> -3. Optionally, user can also set 'crashkernel=3D' kernel cmdline
> >> +3. A user can pass additional command line parameters as a comma
> >> +   separated list through 'fadump_append=3D' parameter, to be
> >> enforced
> >> +   when fadump is active. For example, if parameters like
> >> nr_cpus=3D1,
> >> +   numa=3Doff & udev.children-max=3D2 are to be enforced when fadump
> >> is
> >> +   active, 'fadump_append=3Dnr_cpus=3D1,numa=3Doff,udev.children-max=
=3D2'
> >> +   can be passed in command line, which will be replaced with
> >> +   "nr_cpus=3D1 numa=3Doff udev.children-max=3D2" when fadump is acti=
ve.
> >> +   This helps in reducing memory consumption during dump capture.
> >> +4. Optionally, user can also set 'crashkernel=3D' kernel cmdline
> >>      to specify size of the memory to reserve for boot memory dump
> >>      preservation.
> >>  =20
> >> =20
> > Writing your own deficient parser for comma separated arguments when
> > perfectly fine parser for space separated quoted arguments exists in
> > the kernel and the bootloader does not seem like a good idea to
> > me. =20
>=20
>=20
> Couple of things that prompted me for v5 are:
>    1. Using parse_early_options() limits the kind of parameters
>       that can be passed to fadump capture kernel. Passing parameters
>       like systemd.unit=3D & udev.childern.max=3D has no effect with v4.=
=20
> Updating
>       boot_command_line parameter, when fadump is active, seems a
> better alternative.
>=20
>    2. Passing space-separated quoted arguments is not working
>       as intended with lilo. Updating bootloader with the below
>       entry in /etc/lilo.conf file results in a missing append
>       entry in /etc/yaboot.conf file.
>=20
>         append =3D "quiet sysrq=3D1 insmod=3Dsym53c8xx insmod=3Dipr=20
> crashkernel=3D512M-:256M fadump_append=3D\"nr_cpus=3D1 numa=3Doff=20
> udev.children-max=3D2\""

Meaning that a script that emulates LILO semantics on top of yaboot
which is completely capable of passing qouted space separated arguments
fails. IMHO it is more reasonable to fix the script or whatever
adaptation layer or use yaboot directly than working around bug in said
script by introducing a new argument parser in the kernel.

Thanks

Michal
