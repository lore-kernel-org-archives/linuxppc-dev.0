Return-Path: <dave@linux.vnet.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5E929B71C0
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Sep 2010 01:17:58 +1000 (EST)
Received: from d01relay07.pok.ibm.com (d01relay07.pok.ibm.com [9.56.227.147])
	by e4.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id o8SF2H6D027981
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Sep 2010 11:02:17 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay07.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o8SFHhOS1900664
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Sep 2010 11:17:43 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o8SFHgjY018272
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Sep 2010 12:17:43 -0300
Subject: Re: [PATCH 0/8] v2 De-Couple sysfs memory directories from memory
	sections
From: Dave Hansen <dave@linux.vnet.ibm.com>
To: Avi Kivity <avi@redhat.com>
In-Reply-To: <4CA1E338.6070201@redhat.com>
References: <4CA0EBEB.1030204@austin.ibm.com>  <4CA1E338.6070201@redhat.com>
Content-Type: text/plain; charset="ANSI_X3.4-1968"
Date: Tue, 28 Sep 2010 08:17:36 -0700
Message-ID: <1285687056.19976.6155.camel@nimitz>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Greg KH <greg@kroah.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2010-09-28 at 14:44 +0200, Avi Kivity wrote:
> Why not update sysfs directory creation to be fast, for example by using 
> an rbtree instead of a linked list.  This fixes an implementation 
> problem in the kernel instead of working around it and creating a new ABI.
> 
> New ABIs mean old tools won't work, and new tools need to understand 
> both ABIs.

Just to be clear _these_ patches do not change the existing ABI.

They do add a new ABI: the end_phys_index file.  But, it is completely
redundant at the moment.  It could be taken out of these patches.

That said, fixing the directory creation speed is probably a worthwhile
endeavor too.

-- Dave
