Return-Path: <richard@nod.at>
Received: from radon.swed.at (a.ns.miles-group.at [95.130.255.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EB6651A02EE
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Mar 2015 10:26:30 +1100 (AEDT)
Message-ID: <550CAB0A.8070402@nod.at>
Date: Sat, 21 Mar 2015 00:19:38 +0100
From: Richard Weinberger <richard@nod.at>
MIME-Version: 1.0
To: Laurent Dufour <ldufour@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Jeff Dike <jdike@addtoit.com>,
 Guan Xuetao <gxt@mprc.pku.edu.cn>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>,
 "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
 Arnd Bergmann <arnd@arndb.de>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-s390@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
 user-mode-linux-user@lists.sourceforge.net, linux-arch@vger.kernel.org,
 linux-mm@kvack.org
Subject: Re: [PATCH 1/2] mm: Introducing arch_remap hook
References: <cover.1426866405.git.ldufour@linux.vnet.ibm.com>
 <503499aae380db1c4673f146bcba6ad095021257.1426866405.git.ldufour@linux.vnet.ibm.com>
In-Reply-To: <503499aae380db1c4673f146bcba6ad095021257.1426866405.git.ldufour@linux.vnet.ibm.com>
Content-Type: text/plain; charset=iso-8859-15
Cc: criu@openvz.org, cov@codeaurora.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Am 20.03.2015 um 16:53 schrieb Laurent Dufour:
> Some architecture would like to be triggered when a memory area is moved
> through the mremap system call.
> 
> This patch is introducing a new arch_remap mm hook which is placed in the
> path of mremap, and is called before the old area is unmapped (and the
> arch_unmap hook is called).
> 
> To no break the build, this patch adds the empty hook definition to the
> architectures that were not using the generic hook's definition.

Just wanted to point out that I like that new hook as UserModeLinux can benefit from it.
UML has the concept of stub pages where the UML host process can inject commands to guest processes.
Currently we play nasty games in the TLB code to make all this work.
arch_unmap() could make this stuff more clear and less error prone.

Thanks,
//richard
