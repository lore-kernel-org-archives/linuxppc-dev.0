Return-Path: <holt@sgi.com>
Received: from relay.sgi.com (relay2.sgi.com [192.48.179.30])
	by ozlabs.org (Postfix) with ESMTP id 07AC7B710D
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 11 Jan 2011 06:21:03 +1100 (EST)
Date: Mon, 10 Jan 2011 13:11:22 -0600
From: Robin Holt <holt@sgi.com>
To: Nathan Fontenot <nfont@austin.ibm.com>
Subject: Re: [PATCH 0/4] De-couple sysfs memory directories from memory
	sections
Message-ID: <20110110191122.GN2912@sgi.com>
References: <4D2B4B38.80102@austin.ibm.com> <20110110184416.GA18974@kroah.com>
	<4D2B543A.3070609@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4D2B543A.3070609@austin.ibm.com>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Robin Holt <holt@sgi.com>, linuxppc-dev@lists.ozlabs.org,
	KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> >> The root of this issue is in sysfs directory creation. Every time
> >> a directory is created a string compare is done against all sibling
> >> directories to ensure we do not create duplicates.  The list of
> >> directory nodes in sysfs is kept as an unsorted list which results
> >> in this being an exponentially longer operation as the number of
> >> directories are created.
> > 
> > Are you sure this is still an issue?  I thought we solved this last
> > kernel or so with a simple patch?
> 
> I'll go back and look at this again.

What I recall fixing is the symbolic linking from the node* to the
memory section.  In that case, we cached the most recent mem section
and since they always were added sequentially, the cache saved a rescan.

Of course, I could be remembering something completely unrelated.

Robin
