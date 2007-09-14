Return-Path: <akpm@linux-foundation.org>
Received: from smtp2.linux-foundation.org (smtp2.linux-foundation.org
	[207.189.120.14])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 6F7ACDDD0B
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Sep 2007 09:32:34 +1000 (EST)
Date: Fri, 14 Sep 2007 16:32:23 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: travis@sgi.com
Subject: Re: [PATCH 00/10] x86: Reduce Memory Usage and Inter-Node message
	traffic (v3)
Message-Id: <20070914163223.20759e54.akpm@linux-foundation.org>
In-Reply-To: <20070912015644.927677070@sgi.com>
References: <20070912015644.927677070@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-mm@kvack.org, Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, sparclinux@vger.kernel.org,
	Christoph Lameter <clameter@sgi.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 11 Sep 2007 18:56:44 -0700
travis@sgi.com wrote:

> Changes for version v3:
> 
> cpu_sibling_map has been converted to a per_cpu data array to fix
> build errors on ia64, ppc64 and sparc64 to accomodate references in
> block/blktrace.c and kernel/sched.c when CONFIG_SCHED_SMT is defined.
> 
> Warning: ppc64 and sparc64 have not yet been built nor tested.

These patches all seem to be unaltered from what I had.

The first patch (x86: remove x86_cpu_to_log_apicid array) is in Andi's
tree as x86_64-mm-remove-x86_cpu_to_log_apicid.patch so I don't apply that.

The sparc64/ppc64/ia64 convert-cpu_sibling_map-to-a-per_cpu-data-array
patches need to be folded into the base patch so that we don't break the build
at any stage.

So what I ended up with was

x86-fix-cpu_to_node-references.patch
x86-convert-cpu_core_map-to-be-a-per-cpu-variable.patch
convert-cpu_sibling_map-to-be-a-per-cpu-variable.patch
convert-cpu_sibling_map-to-a-per_cpu-data-array-ia64.patch
convert-cpu_sibling_map-to-a-per_cpu-data-array-ppc64.patch
convert-cpu_sibling_map-to-a-per_cpu-data-array-sparc64.patch
x86-convert-x86_cpu_to_apicid-to-be-a-per-cpu-variable.patch
x86-convert-cpu_llc_id-to-be-a-per-cpu-variable.patch

where the four convert-cpu_sibling_map-to-* will be clumped into a
single diff.
