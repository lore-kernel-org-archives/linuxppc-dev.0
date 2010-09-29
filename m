Return-Path: <holt@sgi.com>
Received: from relay.sgi.com (relay2.sgi.com [192.48.179.30])
	by ozlabs.org (Postfix) with ESMTP id B9753B6F07
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Sep 2010 05:28:33 +1000 (EST)
Date: Wed, 29 Sep 2010 14:28:30 -0500
From: Robin Holt <holt@sgi.com>
To: Nathan Fontenot <nfont@austin.ibm.com>
Subject: Re: [PATCH 0/8] v2 De-Couple sysfs memory directories from memory
	sections
Message-ID: <20100929192830.GK14068@sgi.com>
References: <4CA0EBEB.1030204@austin.ibm.com> <20100928123848.GH14068@sgi.com>
	<4CA2313D.2030508@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4CA2313D.2030508@austin.ibm.com>
Cc: linux-mm@kvack.org, Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
	Dave Hansen <dave@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org,
	Robin Holt <holt@sgi.com>,
	KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Sep 28, 2010 at 01:17:33PM -0500, Nathan Fontenot wrote:
> On 09/28/2010 07:38 AM, Robin Holt wrote:
> > I was tasked with looking at a slowdown in similar sized SGI machines
> > booting x86_64.  Jack Steiner had already looked into the memory_dev_init.
> > I was looking at link_mem_sections().
> > 
> > I made a dramatic improvement on a 16TB machine in that function by
> > merely caching the most recent memory section and checking to see if
> > the next memory section happens to be the subsequent in the linked list
> > of kobjects.
> > 
> > That simple cache reduced the time for link_mem_sections from 1 hour 27
> > minutes down to 46 seconds.
> 
> Nice!
> 
> > 
> > I would like to propose we implement something along those lines also,
> > but I am currently swamped.  I can probably get you a patch tomorrow
> > afternoon that applies at the end of this set.
> 
> Should this be done as a separate patch?  This patch set concentrates on
> updates to the memory code with the node updates only being done due to the
> memory changes.
> 
> I think its a good idea to do the caching and have no problem adding on to
> this patchset if no one else has any objections.

I am sorry.  I had meant to include you on the Cc: list.  I just posted a
set of patches (3 small patches) which implement the cache most recent bit
I aluded to above.  Search for a subject of "Speed up link_mem_sections
during boot" and you will find them.  I did add you to the Cc: list for
the next time I end up sending the set.

My next task is to implement a x86_64 SGI UV specific chunk of code
to memory_block_size_bytes().  Would you consider adding that to your
patch set?  I expect to have that either later today or early tomorrow.

Robin
