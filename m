Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by ozlabs.org (Postfix) with ESMTP id ECF1EB7CC1
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 20 Jan 2010 21:42:33 +1100 (EST)
Subject: Re: linux-next: kvm tree build warning
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <20100120174814.43195995.sfr@canb.auug.org.au>
Date: Wed, 20 Jan 2010 11:42:28 +0100
Message-Id: <3727B46C-0197-47A4-AF41-023517C15752@suse.de>
References: <20100120174814.43195995.sfr@canb.auug.org.au>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Marcelo Tosatti <mtosatti@redhat.com>,
	ppc-dev <linuxppc-dev@lists.ozlabs.org>,
	linux-next@vger.kernel.org, Avi Kivity <avi@qumranet.com>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 20.01.2010, at 07:48, Stephen Rothwell wrote:

> [Not sure what happened to the previous versions To/CC lists, sorry]
>=20
> Hi all,
>=20
> Today's linux-next build (powerpc allyesconfig) produced this warning:
>=20
> arch/powerpc/kvm/book3s.c: In function '__kvmppc_vcpu_run':
> arch/powerpc/kvm/book3s.c:1102: warning: 'ext_bkp.vrsave' may be used =
uninitialized in this function
>=20
> Introduced by commit 2609c1d06b6a7952273fb33b33ad32aff0628146 ("KVM: =
PPC:
> Add support for FPU/Altivec/VSX").  This *may* be a false positive but
> will be a problem for normal builds where warnings are treated as =
errors
> in arch/powerpc.


This is odd. The same function saves and restores ext_bkp.vrsave under a =
common condition:

        if (save_vec) {
                if (current->thread.regs->msr & MSR_VEC)
                        giveup_altivec(current);
                memcpy(ext_bkp.vr, current->thread.vr, =
sizeof(ext_bkp.vr));
                ext_bkp.vscr =3D current->thread.vscr;
                ext_bkp.vrsave =3D current->thread.vrsave;
        }


[...]

        if (save_vec && current->thread.used_vr) {
                memcpy(current->thread.vr, ext_bkp.vr, =
sizeof(ext_bkp.vr));
                current->thread.vscr =3D ext_bkp.vscr;
                current->thread.vrsave =3D ext_bkp.vrsave;
        }


So there can't be a case where ext_bkp.vrsave is read, but not written =
to before, which is what this warning implies, right?
Also, why doesn't gcc complain about vscr too then? They're both used in =
the very same if statement.

Additionally, while compiling locally I looked for warnings and didn't =
spot any. So apparently our compiler versions / options don't match. =
Which version of gcc are you using? I assume a gcc bug.

$ gcc --version
gcc (SUSE Linux) 4.3.2 [gcc-4_3-branch revision 141291]


Alex=
