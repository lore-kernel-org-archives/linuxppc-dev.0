Return-Path: <anton@ozlabs.org>
Date: Wed, 1 Sep 2010 07:57:45 +1000
From: Anton Blanchard <anton@samba.org>
To: Nathan Fontenot <nfont@austin.ibm.com>
Subject: Re: [PATCH 0/8] v5 De-couple sysfs memory directories from memory
	sections
Message-ID: <20100831215745.GA7641@kryten>
References: <4C60407C.2080608@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4C60407C.2080608@austin.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Greg KH <greg@kroah.com>,
	linux-kernel@vger.kernel.org,
	Dave Hansen <dave@linux.vnet.ibm.com>, linux-mm@kvack.org,
	akpm@linux-foundation.org,
	KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi Nathan,

> This set of patches de-couples the idea that there is a single
> directory in sysfs for each memory section.  The intent of the
> patches is to reduce the number of sysfs directories created to
> resolve a boot-time performance issue.  On very large systems
> boot time are getting very long (as seen on powerpc hardware)
> due to the enormous number of sysfs directories being created.
> On a system with 1 TB of memory we create ~63,000 directories.
> For even larger systems boot times are being measured in hours.
> 
> This set of patches allows for each directory created in sysfs
> to cover more than one memory section.  The default behavior for
> sysfs directory creation is the same, in that each directory
> represents a single memory section.  A new file 'end_phys_index'
> in each directory contains the physical_id of the last memory
> section covered by the directory so that users can easily
> determine the memory section range of a directory.

I tested this on a POWER7 with 2TB memory and the boot time improved from
greater than 6 hours (I gave up), to under 5 minutes. Nice!

Tested-by: Anton Blanchard <anton@samba.org>

Anton
