Return-Path: <nfont@austin.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7C805B6F14
	for <linuxppc-dev@ozlabs.org>; Mon,  9 Aug 2010 23:56:47 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e31.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id o79Dibwu023901
	for <linuxppc-dev@ozlabs.org>; Mon, 9 Aug 2010 07:44:37 -0600
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	o79Du44o099818
	for <linuxppc-dev@ozlabs.org>; Mon, 9 Aug 2010 07:56:06 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id o79DttSp026410
	for <linuxppc-dev@ozlabs.org>; Mon, 9 Aug 2010 07:55:57 -0600
Message-ID: <4C6008EA.8040601@austin.ibm.com>
Date: Mon, 09 Aug 2010 08:55:54 -0500
From: Nathan Fontenot <nfont@austin.ibm.com>
MIME-Version: 1.0
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Subject: Re: [PATCH 4/9] v4  Add mutex for add/remove of memory blocks
References: <4C581A6D.9030908@austin.ibm.com>	<4C581C26.5080007@austin.ibm.com>
	<20100805135314.7229d07c.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20100805135314.7229d07c.kamezawa.hiroyu@jp.fujitsu.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-mm@kvack.org, Dave Hansen <dave@linux.vnet.ibm.com>,
	Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/04/2010 11:53 PM, KAMEZAWA Hiroyuki wrote:
> On Tue, 03 Aug 2010 08:39:50 -0500
> Nathan Fontenot <nfont@austin.ibm.com> wrote:
> 
>> Add a new mutex for use in adding and removing of memory blocks.  This
>> is needed to avoid any race conditions in which the same memory block could
>> be added and removed at the same time.
>>
>> Signed-off-by: Nathan Fontenot <nfont@austin.ibm.com>
> 
> Acked-by: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
> 
> But a nitpick (see below)
> 
>> ---
>>  drivers/base/memory.c |    9 +++++++++
>>  1 file changed, 9 insertions(+)
>>
>> Index: linux-2.6/drivers/base/memory.c
>> ===================================================================
>> --- linux-2.6.orig/drivers/base/memory.c	2010-08-02 13:35:00.000000000 -0500
>> +++ linux-2.6/drivers/base/memory.c	2010-08-02 13:45:34.000000000 -0500
>> @@ -27,6 +27,8 @@
>>  #include <asm/atomic.h>
>>  #include <asm/uaccess.h>
>>  
>> +static struct mutex mem_sysfs_mutex;
>> +
> 
> For static symbol of mutex, we usually do
> 	static DEFINE_MUTEX(mem_sysfs_mutex);
> 
> Then, extra calls of mutex_init() is not required.
> 

ok,  fixed in the next version of the patches.

-Nathan
