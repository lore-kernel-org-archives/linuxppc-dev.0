Return-Path: <gustavold@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tTSY73mPNzDvx8
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Dec 2016 04:47:22 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uAUHigbq147314
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Nov 2016 12:47:20 -0500
Received: from e24smtp04.br.ibm.com (e24smtp04.br.ibm.com [32.104.18.25])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2722hcucb7-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Nov 2016 12:47:19 -0500
Received: from localhost
 by e24smtp04.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gustavold@linux.vnet.ibm.com>;
 Wed, 30 Nov 2016 15:47:17 -0200
Received: from d24relay03.br.ibm.com (d24relay03.br.ibm.com [9.18.232.225])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id 0ACED1DC0070
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Nov 2016 12:47:16 -0500 (EST)
Received: from d24av03.br.ibm.com (d24av03.br.ibm.com [9.8.31.95])
 by d24relay03.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uAUHlFA334013198
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Nov 2016 15:47:15 -0200
Received: from d24av03.br.ibm.com (localhost [127.0.0.1])
 by d24av03.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uAUHlFf7020062
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Nov 2016 15:47:15 -0200
From: Gustavo Luiz Duarte <gustavold@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, Anton Blanchard <anton@samba.org>,
 Alan Modra <amodra@gmail.com>, Nick Clifton <nickc@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] powerpc/boot: request no dynamic linker for boot wrapper
References: <20161128014226.7656-1-npiggin@gmail.com>
 <87shqbrhfo.fsf@concordia.ellerman.id.au>
 <20161128230724.375227b4@roar.ozlabs.ibm.com>
 <87fumbq7dh.fsf@concordia.ellerman.id.au>
Date: Wed, 30 Nov 2016 15:47:11 -0200
MIME-Version: 1.0
In-Reply-To: <87fumbq7dh.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Message-Id: <3426479d-38fc-df8c-6642-8c50bca63f33@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 11/29/2016 01:42 AM, Michael Ellerman wrote:
> Nicholas Piggin <npiggin@gmail.com> writes:
> > On Mon, 28 Nov 2016 22:07:39 +1100
> > Michael Ellerman <mpe@ellerman.id.au> wrote:
> >> Nicholas Piggin <npiggin@gmail.com> writes:
> >>> diff --git a/arch/powerpc/boot/wrapper b/arch/powerpc/boot/wrapper
> >>> index 404b3aa..cd941a8 100755
> >>> --- a/arch/powerpc/boot/wrapper
> >>> +++ b/arch/powerpc/boot/wrapper
> >>> @@ -181,6 +181,13 @@ case "$elfformat" in
> >>>      elf32-powerpc)    format=elf32ppc    ;;
> >>>  esac
> >>>
> >>> +# Do not include PT_INTERP segment when linking pie. Non-pie linking
> >>> +# just ignores this option.
> >>> +LD_VERSION=$(${CROSS}ld --version | $srctree/scripts/ld-version.sh)
> >>> +LD_NO_DL_MIN_VERSION=$(echo 2.26 | $srctree/scripts/ld-version.sh)
> >>> +if [ "$LD_VERSION" -ge "$LD_NO_DL_MIN_VERSION" ] ; then
> >>> +    nodl="--no-dynamic-linker"
> >>> +fi
> >>
> >> Some distros (RHEL at least?), ship the wrapper as a standalone script.
> >> So I don't think we can call things in $srctree. Or at least I don't
> >> know how that's supposed to work when it's shipped standalone.
> >> We're also basically reinventing ld-option, which is a PITA.
> >
> > Okay I didn't realize that. It's already using mkuboot.sh, but only
> > for uboot targets... I don't know, I don't have any good ideas at the
> > moment.
>
> That looks like a bug, but I guess no one runs Fedora/RHEL on those
> machines? Previously it just called mkimage using $PATH.
>
> The Fedora spec file does:
>
> make DESTDIR=$RPM_BUILD_ROOT bootwrapper_install WRAPPER_OBJDIR=%{_libdir}/kernel-wrapper WRAPPER_DTSDIR=%{_libdir}/kernel-wrapper/dts
>
> bootwrapper_install installs a bunch of files, and also calls:
>
> quiet_cmd_install_wrapper = INSTALL $(patsubst $(DESTDIR)$(WRAPPER_BINDIR)/%,%,$@)
>       cmd_install_wrapper = $(INSTALL)  -m0755 $(patsubst $(DESTDIR)$(WRAPPER_BINDIR)/%,$(srctree)/$(obj)/%,$@) $@ ;\
>                 sed -i $@ -e 's%^object=.*%object=$(WRAPPER_OBJDIR)%' \
>                       -e 's%^objbin=.*%objbin=$(WRAPPER_BINDIR)%' \
>
> ie. it seds the script. So we could probably just install ld-version.sh
> into $(DESTDIR)$(WRAPPER_OBJDIR) and then sed $srctree maybe?
>
> But it's old code and I'm not that across how it gets used in the wild.
> CC'ing Gustavo who is our Fedora/RHEL/Power guy.

I don't know either how (or if) boot wrapper is used in Fedora as stand-alone. I think Michael's suggestion to use sed to replace $srctree should be fine.

[]'s
Gustavo

>
> cheers
>
