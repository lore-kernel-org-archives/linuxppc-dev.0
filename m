Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de [212.227.17.10])
	by ozlabs.org (Postfix) with ESMTP id C1D90B7D45
	for <linuxppc-dev@ozlabs.org>; Thu,  6 May 2010 23:45:08 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Takuya Yoshikawa <takuya.yoshikawa@gmail.com>
Subject: Re: [RFC][PATCH resend 8/12] asm-generic: bitops: introduce le bit
	offset macro
Date: Thu, 6 May 2010 15:38:54 +0200
References: <20100504215645.6448af8f.takuya.yoshikawa@gmail.com>
	<4BE04677.4060608@redhat.com>
	<20100505115924.7bb92036.takuya.yoshikawa@gmail.com>
In-Reply-To: <20100505115924.7bb92036.takuya.yoshikawa@gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201005061538.54326.arnd@arndb.de>
Cc: linux-arch@vger.kernel.org, x86@kernel.org, kvm@vger.kernel.org,
	kvm-ia64@vger.kernel.org, fernando@oss.ntt.co.jp,
	mtosatti@redhat.com, agraf@suse.de, kvm-ppc@vger.kernel.org,
	linux-kernel@vger.kernel.org, yoshikawa.takuya@oss.ntt.co.jp,
	linuxppc-dev@ozlabs.org, mingo@redhat.com, paulus@samba.org,
	Avi Kivity <avi@redhat.com>, hpa@zytor.com, tglx@linutronix.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wednesday 05 May 2010, Takuya Yoshikawa wrote:
> Date: 
> Yesterday 04:59:24
> > That's why the bitmaps are defined as little endian u64 aligned, even on 
> > big endian 32-bit systems.  Little endian bitmaps are wordsize agnostic, 
> > and u64 alignment ensures we can use long-sized bitops on mixed size 
> > systems.

Ok, I see.

> There was a suggestion to propose set_le_bit_user() kind of macros.
> But what I thought was these have a constraint you two explained and seemed to be
> a little bit specific to some area, like KVM.
> 
> So I decided to propose just the offset calculation macro.

I'm not sure I understand how this macro is going to be used though.
If you are just using this in kernel space, that's fine, please go for
it.

However, if the intention is to use the same macro in user space, putting
it into asm-generic/bitops/* is not going to help, because those headers
are not available in user space, and I wouldn't want to change that.

The definition of the macro is not part of the ABI, so just duplicate
it in KVM if you need it there.

	Arnd
