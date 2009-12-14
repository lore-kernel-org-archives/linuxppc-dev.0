Return-Path: <agraf@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 53102B6F0E
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 14 Dec 2009 21:03:25 +1100 (EST)
Subject: Re: powerpc/kvm tree build failure
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <20091214173512.91e4e39a.sfr@canb.auug.org.au>
Date: Mon, 14 Dec 2009 11:03:15 +0100
Message-Id: <50AF206B-218A-404E-BC8A-F56434073999@suse.de>
References: <20091214173512.91e4e39a.sfr@canb.auug.org.au>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
	Hollis Blanchard <hollisb@us.ibm.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 14.12.2009, at 07:35, Stephen Rothwell wrote:

> Hi all,
>=20
> A powerpc allmodconfig fails like this:
>=20
> arch/powerpc/kvm/built-in.o:(.toc1+0x18): undefined reference to =
`kvm_debugfs_dir'
>=20
> This is because CONFIG_KVM_EXIT_TIMING is a bool while
> CONFIG_KVM_BOOK3S_64 is tristate. This causes =
arch/powerpc/kvm/timing.o
> (which references kvm_debugfs_dir) to be built in, but
> virt/kvm/kvm_main.o (which defines it) to be modular.

Ouch.

EXIT_TIMING could be used by BookE and Book3S KVM support. BookE can't =
be built as a module, while Book3S can.

So what's the usual / best way to fix this? Make EXIT_TIMING a tristate =
too, but only on Book3S? Maybe by defining it as dependent on Book3S or =
BookE KVM support?

The easiest thing for now would probably be to just make it depend on =
BookE support, since we don't have support for exit timing in Book3S =
yet. But I'm not sure which approach is the best to take :-).

Alex=
