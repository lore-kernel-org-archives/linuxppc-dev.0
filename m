Return-Path: <greg@kroah.com>
Received: from coco.kroah.org (kroah.org [198.145.64.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "coco.kroah.org", Issuer "Greg KH" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 21FD3B718B
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 21 Jan 2011 04:27:03 +1100 (EST)
Date: Thu, 20 Jan 2011 09:25:26 -0800
From: Greg KH <greg@kroah.com>
To: Nathan Fontenot <nfont@austin.ibm.com>
Subject: Re: [PATCH 0/4] De-couple sysfs memory directories from memory
	sections
Message-ID: <20110120172526.GC21643@kroah.com>
References: <4D386498.9080201@austin.ibm.com>
	<20110120164555.GA30922@kroah.com>
	<4D386820.5080902@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4D386820.5080902@austin.ibm.com>
Cc: linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
	Robin Holt <holt@sgi.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jan 20, 2011 at 10:51:44AM -0600, Nathan Fontenot wrote:
> On 01/20/2011 10:45 AM, Greg KH wrote:
> > On Thu, Jan 20, 2011 at 10:36:40AM -0600, Nathan Fontenot wrote:
> >> The root of this issue is in sysfs directory creation. Every time
> >> a directory is created a string compare is done against sibling
> >> directories ( see sysfs_find_dirent() ) to ensure we do not create 
> >> duplicates.  The list of directory nodes in sysfs is kept as an
> >> unsorted list which results in this being an exponentially longer
> >> operation as the number of directories are created.
> > 
> > Again, are you sure about this?  I thought we resolved this issue in the
> > past, but you were going to check it.  Did you?
> > 
> 
> Yes, the string compare is still present in the sysfs code.  There was
> discussion around this sometime last year when I sent a patch out that
> stored the directory entries in something other than a linked list.
> That patch was rejected but it was agreed that something should be done.

Ah, ok, thanks for verifying.

greg k-h
