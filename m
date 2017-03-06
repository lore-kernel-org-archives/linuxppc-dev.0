Return-Path: <msuchanek@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vcNl96mKBzDqKf
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Mar 2017 02:20:21 +1100 (AEDT)
Date: Mon, 6 Mar 2017 16:20:14 +0100
From: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au
Subject: Re: [PATCH V3 08/10] powerpc/mm/hash: Increase VA range to 128TB
Message-ID: <20170306162014.66f4ee2f@kitsune.suse.cz>
In-Reply-To: <87y3wjcbxv.fsf@skywalker.in.ibm.com>
References: <1487498837-12017-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1487498837-12017-9-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20170303170013.3f5bfd12@kitsune.suse.cz>
 <8760jndt6v.fsf@skywalker.in.ibm.com>
 <87y3wjcbxv.fsf@skywalker.in.ibm.com>
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

On Mon, 06 Mar 2017 09:07:48 +0530
"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> wrote:

> "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> writes:
>=20
> > Michal Such=C3=A1nek <msuchanek@suse.de> writes:
> > =20
> >> Hello,
> >>
> >> On Sun, 19 Feb 2017 15:37:15 +0530
> >> "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> wrote:
> >> =20
> >>> We update the hash linux page table layout such that we can
> >>> support 512TB. But we limit the TASK_SIZE to 128TB. We can switch
> >>> to 128TB by default without conditional because that is the max
> >>> virtual address supported by other architectures. We will later
> >>> add a mechanism to on-demand increase the application's effective
> >>> address range to 512TB.
> >>>=20
> >>> Having the page table layout changed to accommodate 512TB  makes
> >>> testing large memory configuration easier with less code changes
> >>> to kernel
> >>>=20
> >>> Signed-off-by: Aneesh Kumar K.V
> >>> <aneesh.kumar@linux.vnet.ibm.com> =20
> >
> > ....
> > =20
> >> index b64daf124fee..c7ca70dc3ba5 100644 =20
> >>> --- a/arch/powerpc/kernel/paca.c
> >>> +++ b/arch/powerpc/kernel/paca.c
> >>> @@ -253,8 +253,15 @@ void copy_mm_to_paca(struct mm_struct *mm)
> >>>  	get_paca()->mm_ctx_id =3D context->id;
> >>>  #ifdef CONFIG_PPC_MM_SLICES
> >>>  	get_paca()->mm_ctx_low_slices_psize =3D
> >>> context->low_slices_psize;
> >>> +	/*
> >>> +	 * We support upto 128TB for now. Hence copy only 128/2
> >>> bytes.
> >>> +	 * Later when we support tasks with different max
> >>> effective
> >>> +	 * address, we can optimize this based on mm->task_size.
> >>> +	 */
> >>> +	BUILD_BUG_ON(TASK_SIZE_USER64 !=3D TASK_SIZE_128TB); =20
> >>
> >> Can this be handled by KConfig?
> >> Above I see  =20
> >
> > I am reworking the series so that we depend on mm->task_size. Will
> > send a new version soon.
> >
> >
> > =20
> >>> +#ifdef CONFIG_PPC_BOOK3S_64
> >>> +#define TASK_SIZE_USER64 TASK_SIZE_128TB
> >>> +#else
> >>> +#define TASK_SIZE_USER64 TASK_SIZE_64TB
> >>> +#endif =20
> >> and  =20
> >>> #ifdef CONFIG_PPC_MM_SLICES
> >>> ILD_BUG_ON(TASK_SIZE_USER64 !=3D TASK_SIZE_128TB) =20
> >>
> >> which boils down to
> >> #ifndef CONFIG_PPC_BOOK3S_64
> >> #ifdef CONFIG_PPC_MM_SLICES
> >> #error TASK_SIZE_USER64 !=3D TASK_SIZE_128TB
> >>
> >> =20
> >>>  	memcpy(&get_paca()->mm_ctx_high_slices_psize,
> >>> -	       &context->high_slices_psize, SLICE_ARRAY_SIZE);
> >>> +	       &context->high_slices_psize, TASK_SIZE_128TB >>
> >>> 41); =20
> >>
> >> Can we avoid magic numbers, please?
> >> =20
> >
> > Since array is 4 bytes per each TB which is documented else where. =20
>=20
> 4 bits per teach TB.
>=20
It is certainly nicer to have a macro for it. You can then see what the
number is from the macro name or grep it and find the definition and
the explanation.

Thanks

Michal
