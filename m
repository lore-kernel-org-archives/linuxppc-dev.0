Return-Path: <dave@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 815EEB710C
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 21 Jan 2011 04:09:25 +1100 (EST)
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
	[9.17.195.107])
	by e31.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id p0KGt1p1028062
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jan 2011 09:55:01 -0700
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p0KH96xW042552
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jan 2011 10:09:06 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id p0KH957M025633
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jan 2011 10:09:06 -0700
Subject: Re: [PATCH 0/4] De-couple sysfs memory directories from memory
	sections
From: Dave Hansen <dave@linux.vnet.ibm.com>
To: Greg KH <greg@kroah.com>
In-Reply-To: <20110120164555.GA30922@kroah.com>
References: <4D386498.9080201@austin.ibm.com>
	<20110120164555.GA30922@kroah.com>
Content-Type: text/plain; charset="ANSI_X3.4-1968"
Date: Thu, 20 Jan 2011 09:09:01 -0800
Message-ID: <1295543341.9039.588.camel@nimitz>
Mime-Version: 1.0
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, Robin Holt <holt@sgi.com>,
	linuxppc-dev@lists.ozlabs.org,
	KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2011-01-20 at 08:45 -0800, Greg KH wrote:
> On Thu, Jan 20, 2011 at 10:36:40AM -0600, Nathan Fontenot wrote:
> > The root of this issue is in sysfs directory creation. Every time
> > a directory is created a string compare is done against sibling
> > directories ( see sysfs_find_dirent() ) to ensure we do not create 
> > duplicates.  The list of directory nodes in sysfs is kept as an
> > unsorted list which results in this being an exponentially longer
> > operation as the number of directories are created.
> 
> Again, are you sure about this?  I thought we resolved this issue in the
> past, but you were going to check it.  Did you?

Just to be clear, simply reducing the number of kobjects can make these
patches worthwhile on their own.  I originally figured that the
SECTION_SIZE would go up over time as systems got larger, and _that_
would keep the number of sections and number of sysfs objects down.
Well, that turned out to be wrong, and we're eating up a ton of memory
now.  We can't fix the SECTION_SIZE easily, but we can reduce the number
of kobjects that we need to track the sections.  *That* is the main
benefit I see from these patches.

I think there's a problem worth fixing, even ignoring the directory
creation issue (if it still exists).

-- Dave
