Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5B1CCDDE21
	for <linuxppc-dev@ozlabs.org>; Mon,  7 Jul 2008 15:48:22 +1000 (EST)
Subject: Re: [PATCH 1/2] elf loader support for auxvec base platform string
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Roland McGrath <roland@redhat.com>
In-Reply-To: <20080704021929.5E9EF1541F5@magilla.localdomain>
References: <20080703234140.GC9594@localdomain>
	<20080704021929.5E9EF1541F5@magilla.localdomain>
Content-Type: text/plain
Date: Mon, 07 Jul 2008 15:48:13 +1000
Message-Id: <1215409693.8970.79.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Nathan Lynch <ntl@pobox.com>,
	linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2008-07-03 at 19:19 -0700, Roland McGrath wrote:
> Why not just use ELF_HWCAP for this?  It looks like powerpc only has 3 bits
> left there (keeping it to 32), but 3 is not 0.  If not that, why not use
> dsocaps?  That is, some magic in the vDSO, which glibc already supports on
> all machines where it uses the vDSO.  (For how it works, see the use in
> arch/x86/vdso/vdso32/note.S for CONFIG_XEN.)

Well, we use strings to represent the platforms already (ie, the actual
CPU microarchitecture). Fitting those into bits would be annoying, it
makes sense to have AT_BASE_PLATFORM to be the "base" variant of
AT_PLATFORM.

_However_ there is a bug in that this patch adds an entry without
bumping the number of entries in the cached array (ie.
AT_VECTOR_SIZE_BASE needs to be updated).

Ben.
