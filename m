Return-Path: <avi@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id CF4F3B713B
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Sep 2010 02:35:25 +1000 (EST)
Message-ID: <4CA21906.1080002@redhat.com>
Date: Tue, 28 Sep 2010 18:34:14 +0200
From: Avi Kivity <avi@redhat.com>
MIME-Version: 1.0
To: Robin Holt <holt@sgi.com>
Subject: Re: [PATCH 0/8] v2 De-Couple sysfs memory directories from memory
	sections
References: <4CA0EBEB.1030204@austin.ibm.com> <4CA1E338.6070201@redhat.com>
	<20100928151218.GJ14068@sgi.com>
In-Reply-To: <20100928151218.GJ14068@sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, Greg KH <greg@kroah.com>,
	linux-kernel@vger.kernel.org,
	Dave Hansen <dave@linux.vnet.ibm.com>, linux-mm@kvack.org,
	KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

  On 09/28/2010 05:12 PM, Robin Holt wrote:
> >  Why not update sysfs directory creation to be fast, for example by
> >  using an rbtree instead of a linked list.  This fixes an
> >  implementation problem in the kernel instead of working around it
> >  and creating a new ABI.
>
> Because the old ABI creates 129,000+ entries inside
> /sys/devices/system/memory with their associated links from
> /sys/devices/system/node/node*/ back to those directory entries.
>
> Thankfully things like rpm, hald, and other miscellaneous commands scan
> that information.  On our 8 TB test machine, hald runs continuously
> following boot for nearly an hour mostly scanning useless information
> from /sys/

I see - so the problem wasn't just kernel internal; the ABI itself was 
unsuitable.  Too bad this wasn't considered at the time it was added.

(129k entries / 1 hour = 35 entries/sec; not very impressive)

-- 
error compiling committee.c: too many arguments to function
