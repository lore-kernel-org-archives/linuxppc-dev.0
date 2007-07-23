Return-Path: <clameter@sgi.com>
Received: from relay.sgi.com (netops-testserver-3-out.sgi.com [192.48.171.28])
	by ozlabs.org (Postfix) with ESMTP id 557A1DDE25
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 24 Jul 2007 06:41:58 +1000 (EST)
Date: Mon, 23 Jul 2007 13:34:50 -0700
From: Christoph Lameter <clameter@sgi.com>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [Bugme-new] [Bug 8778] New: Ocotea board: kernel reports access
	of bad area during boot with DEBUG_SLAB=y
Message-ID: <20070723133450.3de91b33@schroedinger.engr.sgi.com>
In-Reply-To: <20070718095537.d344dc0a.akpm@linux-foundation.org>
References: <bug-8778-10286@http.bugzilla.kernel.org/>
	<20070718005253.942f0464.akpm@linux-foundation.org>
	<20070718083425.GA29722@gate.ebshome.net>
	<1184766070.3699.2.camel@zod.rchland.ibm.com>
	<20070718155940.GB29722@gate.ebshome.net>
	<20070718095537.d344dc0a.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: netdev@vger.kernel.org, bart.vanassche@gmail.com, linux-mm@kvack.org,
	"bugme-daemon@kernel-bugs.osdl.org" <bugme-daemon@bugzilla.kernel.org>,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, 18 Jul 2007 09:55:37 -0700
Andrew Morton <akpm@linux-foundation.org> wrote:

> hm.  It should be the case that providing SLAB_HWCACHE_ALIGN at
> kmem_cache_create() time will override slab-debugging's offsetting
> of the returned addresses.


That is true for SLUB but not in SLAB. SLAB has always ignored
SLAB_HWCACHE_ALIGN when debugging is on because of the issues involved
in placing the redzone values etc.  Could be fun to fix.
