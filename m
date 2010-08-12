Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id EF7ABB70CE
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Aug 2010 05:08:30 +1000 (EST)
Date: Thu, 12 Aug 2010 12:08:16 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Nathan Fontenot <nfont@austin.ibm.com>
Subject: Re: [PATCH 0/8] v5 De-couple sysfs memory directories from memory
	sections
Message-Id: <20100812120816.e97d8b9e.akpm@linux-foundation.org>
In-Reply-To: <4C60407C.2080608@austin.ibm.com>
References: <4C60407C.2080608@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Greg KH <greg@kroah.com>,
	linux-kernel@vger.kernel.org,
	Dave Hansen <dave@linux.vnet.ibm.com>, linux-mm@kvack.org,
	KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 09 Aug 2010 12:53:00 -0500
Nathan Fontenot <nfont@austin.ibm.com> wrote:

> This set of patches de-couples the idea that there is a single
> directory in sysfs for each memory section.  The intent of the
> patches is to reduce the number of sysfs directories created to
> resolve a boot-time performance issue.  On very large systems
> boot time are getting very long (as seen on powerpc hardware)
> due to the enormous number of sysfs directories being created.
> On a system with 1 TB of memory we create ~63,000 directories.
> For even larger systems boot times are being measured in hours.

And those "hours" are mainly due to this problem, I assume.

> This set of patches allows for each directory created in sysfs
> to cover more than one memory section.  The default behavior for
> sysfs directory creation is the same, in that each directory
> represents a single memory section.  A new file 'end_phys_index'
> in each directory contains the physical_id of the last memory
> section covered by the directory so that users can easily
> determine the memory section range of a directory.

What you're proposing appears to be a non-back-compatible
userspace-visible change.  This is a big issue!

It's not an unresolvable issue, as this is a must-fix problem.  But you
should tell us what your proposal is to prevent breakage of existing
installations.  A Kconfig option would be good, but a boot-time kernel
command line option which selects the new format would be much better.

However you didn't mention this issue at all, and it's the most
important one.


> Updates for version 5 of the patchset include the following:
> 
> Patch 4/8 Add mutex for add/remove of memory blocks
> - Define the mutex using DEFINE_MUTEX macro.
> 
> Patch 8/8 Update memory-hotplug documentation
> - Add information concerning memory holes in phys_index..end_phys_index.

And you forgot to tell us how long those machines boot with the
patchset applied, which is the entire point of the patchset!
