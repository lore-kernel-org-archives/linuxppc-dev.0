Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tSTrq06DCzDvgt
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Nov 2016 14:42:35 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, Anton Blanchard <anton@samba.org>,
 Alan Modra <amodra@gmail.com>, Nick Clifton <nickc@redhat.com>,
 gustavold@linux.vnet.ibm.com
Subject: Re: [PATCH] powerpc/boot: request no dynamic linker for boot wrapper
In-Reply-To: <20161128230724.375227b4@roar.ozlabs.ibm.com>
References: <20161128014226.7656-1-npiggin@gmail.com>
 <87shqbrhfo.fsf@concordia.ellerman.id.au>
 <20161128230724.375227b4@roar.ozlabs.ibm.com>
Date: Tue, 29 Nov 2016 14:42:34 +1100
Message-ID: <87fumbq7dh.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Nicholas Piggin <npiggin@gmail.com> writes:
> On Mon, 28 Nov 2016 22:07:39 +1100
> Michael Ellerman <mpe@ellerman.id.au> wrote:
>> Nicholas Piggin <npiggin@gmail.com> writes:
>> > diff --git a/arch/powerpc/boot/wrapper b/arch/powerpc/boot/wrapper
>> > index 404b3aa..cd941a8 100755
>> > --- a/arch/powerpc/boot/wrapper
>> > +++ b/arch/powerpc/boot/wrapper
>> > @@ -181,6 +181,13 @@ case "$elfformat" in
>> >      elf32-powerpc)	format=elf32ppc	;;
>> >  esac
>> >  
>> > +# Do not include PT_INTERP segment when linking pie. Non-pie linking
>> > +# just ignores this option.
>> > +LD_VERSION=$(${CROSS}ld --version | $srctree/scripts/ld-version.sh)
>> > +LD_NO_DL_MIN_VERSION=$(echo 2.26 | $srctree/scripts/ld-version.sh)
>> > +if [ "$LD_VERSION" -ge "$LD_NO_DL_MIN_VERSION" ] ; then
>> > +	nodl="--no-dynamic-linker"
>> > +fi  
>> 
>> Some distros (RHEL at least?), ship the wrapper as a standalone script.
>> So I don't think we can call things in $srctree. Or at least I don't
>> know how that's supposed to work when it's shipped standalone.
>> We're also basically reinventing ld-option, which is a PITA.
>
> Okay I didn't realize that. It's already using mkuboot.sh, but only
> for uboot targets... I don't know, I don't have any good ideas at the
> moment.

That looks like a bug, but I guess no one runs Fedora/RHEL on those
machines? Previously it just called mkimage using $PATH.

The Fedora spec file does:

make DESTDIR=$RPM_BUILD_ROOT bootwrapper_install WRAPPER_OBJDIR=%{_libdir}/kernel-wrapper WRAPPER_DTSDIR=%{_libdir}/kernel-wrapper/dts

bootwrapper_install installs a bunch of files, and also calls:

quiet_cmd_install_wrapper = INSTALL $(patsubst $(DESTDIR)$(WRAPPER_BINDIR)/%,%,$@)
      cmd_install_wrapper = $(INSTALL)  -m0755 $(patsubst $(DESTDIR)$(WRAPPER_BINDIR)/%,$(srctree)/$(obj)/%,$@) $@ ;\
				sed -i $@ -e 's%^object=.*%object=$(WRAPPER_OBJDIR)%' \
					  -e 's%^objbin=.*%objbin=$(WRAPPER_BINDIR)%' \

ie. it seds the script. So we could probably just install ld-version.sh
into $(DESTDIR)$(WRAPPER_OBJDIR) and then sed $srctree maybe?

But it's old code and I'm not that across how it gets used in the wild.
CC'ing Gustavo who is our Fedora/RHEL/Power guy.

cheers
