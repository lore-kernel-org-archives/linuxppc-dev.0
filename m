Return-Path: <suzuki@in.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp04.au.ibm.com",
	Issuer "GeoTrust SSL CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 07D00B6F88
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 18 Jul 2011 14:05:07 +1000 (EST)
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [202.81.31.247])
	by e23smtp04.au.ibm.com (8.14.4/8.13.1) with ESMTP id p6I3wlnV001274
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Jul 2011 13:58:47 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p6I44Z8S1036434
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Jul 2011 14:04:35 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p6I45237002936
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Jul 2011 14:05:04 +1000
Message-ID: <4E23B0EB.2050301@in.ibm.com>
Date: Mon, 18 Jul 2011 09:34:59 +0530
From: Suzuki Poulose <suzuki@in.ibm.com>
MIME-Version: 1.0
To: Benjammin Herrenschmidt <benh@kernel.crashing.org>,
	Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v2] powerpc32: Kexec support for PPC440X chipsets
References: <20110712064356.28567.48722.stgit@suzukikp.in.ibm.com>
In-Reply-To: <20110712064356.28567.48722.stgit@suzukikp.in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Michal Simek <monstr@monstr.eu>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	kexec <kexec@lists.infradead.org>, lkml <linux-kernel@vger.kernel.org>,
	Josh Boyer <jwboyer@linux.vnet.ibm.com>, Vivek Goyal <vgoyal@redhat.com>,
	"Suzuki K. Poulose" <suzuki@in.ibm.com>,
	linux ppc dev <linuxppc-dev@lists.ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/12/11 12:14, Suzuki K. Poulose wrote:
> Changes from V1: Uses a tmp mapping in the other address space to setup
> 		 the 1:1 mapping (suggested by Sebastian Andrzej Siewior).
>
> Note: Should we do the same for kernel entry code for PPC44x ?
>
> This patch adds kexec support for PPC440 based chipsets.This work is based
> on the KEXEC patches for FSL BookE.
>
> The FSL BookE patch and the code flow could be found at the link below:
>
> 	http://patchwork.ozlabs.org/patch/49359/
>
> Steps:
>
> 1) Invalidate all the TLB entries except the one this code is run from
> 2) Create a tmp mapping for our code in the other address space and jump to it
> 3) Invalidate the entry we used
> 4) Create a 1:1 mapping for 0-2GiB in blocks of 256M
> 5) Jump to the new 1:1 mapping and invalidate the tmp mapping
>
> I have tested this patches on Ebony, Sequoia boards and Virtex on QEMU.
> It would be great if somebody could test this on the other boards.

Forgot to mention:

You would need the current snapshot of kexec-tools, available at

git://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git

The following commits(in the current tree) are needed for the support of ppc32.


commit 13f6d71bdf9836b90ae4ec21209383f1a3c56b0f
kexec-tools: ppc32: Fixup ThreadPointer for purgatory code

commit 9ec3fac7e8840fb31891ba49a626c5dd33e09e86
kexec-tools: powerpc: Use the #address-cells information to parsememory/reg

commit 806ef8870539a6c74a2a98188d0207a038b16f77
Fix memory errors on ppc


Thanks

Suzuki
