Return-Path: <nfont@austin.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4671EB7103
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 21 Jan 2011 03:51:52 +1100 (EST)
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
	[9.17.195.226])
	by e32.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id p0KGfjxB024111
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jan 2011 09:41:45 -0700
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
	by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP
	id p0KGpkAp156610
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jan 2011 09:51:46 -0700
Received: from d03av05.boulder.ibm.com (loopback [127.0.0.1])
	by d03av05.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id p0KGpja4028708
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jan 2011 09:51:46 -0700
Message-ID: <4D386820.5080902@austin.ibm.com>
Date: Thu, 20 Jan 2011 10:51:44 -0600
From: Nathan Fontenot <nfont@austin.ibm.com>
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 0/4] De-couple sysfs memory directories from memory
	sections
References: <4D386498.9080201@austin.ibm.com>
	<20110120164555.GA30922@kroah.com>
In-Reply-To: <20110120164555.GA30922@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1
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

On 01/20/2011 10:45 AM, Greg KH wrote:
> On Thu, Jan 20, 2011 at 10:36:40AM -0600, Nathan Fontenot wrote:
>> The root of this issue is in sysfs directory creation. Every time
>> a directory is created a string compare is done against sibling
>> directories ( see sysfs_find_dirent() ) to ensure we do not create 
>> duplicates.  The list of directory nodes in sysfs is kept as an
>> unsorted list which results in this being an exponentially longer
>> operation as the number of directories are created.
> 
> Again, are you sure about this?  I thought we resolved this issue in the
> past, but you were going to check it.  Did you?
> 

Yes, the string compare is still present in the sysfs code.  There was
discussion around this sometime last year when I sent a patch out that
stored the directory entries in something other than a linked list.
That patch was rejected but it was agreed that something should be done.

-Nathan
