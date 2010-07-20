Return-Path: <dave@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id BB53BB6F06
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Jul 2010 05:10:48 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e35.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id o6KJ2b9Y002641
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Jul 2010 13:02:37 -0600
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o6KJAWAO102934
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Jul 2010 13:10:33 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id o6KJABGR002611
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Jul 2010 13:10:11 -0600
Subject: Re: [PATCH 2/8] v3 Add new phys_index properties
From: Dave Hansen <dave@linux.vnet.ibm.com>
To: Nathan Fontenot <nfont@austin.ibm.com>
In-Reply-To: <4C45A3AB.6090407@austin.ibm.com>
References: <4C451BF5.50304@austin.ibm.com>
	<4C451D92.6020406@austin.ibm.com>  <4C45A3AB.6090407@austin.ibm.com>
Content-Type: text/plain; charset="ANSI_X3.4-1968"
Date: Tue, 20 Jul 2010 12:10:04 -0700
Message-ID: <1279653004.9207.296.camel@nimitz>
Mime-Version: 1.0
Cc: linux-mm@kvack.org, greg@kroah.com, linux-kernel@vger.kernel.org,
	KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2010-07-20 at 08:24 -0500, Nathan Fontenot wrote:
> Update the 'phys_index' properties of a memory block to include a
> 'start_phys_index' which is the same as the current 'phys_index' property.
> This also adds an 'end_phys_index' property to indicate the id of the
> last section in th memory block.
> 
> Patch updated to keep the name of the phys_index property instead of
> renaming it to start_phys_index.

KAME is right on this.  We should keep the old one if at all possible.  

The only other thing we might want to do is move 'phys_index' to
'start_phys_index', and make a new 'phys_index' that does a WARN_ONCE(),
gives a deprecated warning, then calls the new 'start_phys_index' code.

So, basically make the new, more clear name, but keep the old one for a
while and deprecate it.  Maybe we could get away with removing it in ten
years. :)

-- Dave
