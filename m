Return-Path: <nfont@austin.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 15F2FB6EE8
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  2 Oct 2010 04:56:59 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e32.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id o91ImBMW016234
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Oct 2010 12:48:11 -0600
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	o91Iuveo259018
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Oct 2010 12:56:57 -0600
Received: from d03av05.boulder.ibm.com (loopback [127.0.0.1])
	by d03av05.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id o91IuuBj009046
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Oct 2010 12:56:57 -0600
Message-ID: <4CA62EF6.8000204@austin.ibm.com>
Date: Fri, 01 Oct 2010 13:56:54 -0500
From: Nathan Fontenot <nfont@austin.ibm.com>
MIME-Version: 1.0
To: Robin Holt <holt@sgi.com>
Subject: Re: [PATCH 4/9] v3 Allow memory blocks to span multiple memory
	sections
References: <4CA62700.7010809@austin.ibm.com> <4CA62917.80008@austin.ibm.com>
	<20101001185250.GK14064@sgi.com>
In-Reply-To: <20101001185250.GK14064@sgi.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Greg KH <greg@kroah.com>, steiner@sgi.com, linux-kernel@vger.kernel.org,
	Dave Hansen <dave@linux.vnet.ibm.com>, linux-mm@kvack.org,
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

On 10/01/2010 01:52 PM, Robin Holt wrote:
> On Fri, Oct 01, 2010 at 01:31:51PM -0500, Nathan Fontenot wrote:
>> Update the memory sysfs code such that each sysfs memory directory is now
>> considered a memory block that can span multiple memory sections per
>> memory block.  The default size of each memory block is SECTION_SIZE_BITS
>> to maintain the current behavior of having a single memory section per
>> memory block (i.e. one sysfs directory per memory section).
>>
>> For architectures that want to have memory blocks span multiple
>> memory sections they need only define their own memory_block_size_bytes()
>> routine.
>>
>> Signed-off-by: Nathan Fontenot <nfont@austin.ibm.com>
>>
>> ---
>>  drivers/base/memory.c |  155 ++++++++++++++++++++++++++++++++++----------------
>>  1 file changed, 108 insertions(+), 47 deletions(-)
>>
>> Index: linux-next/drivers/base/memory.c
>> ===================================================================
>> --- linux-next.orig/drivers/base/memory.c	2010-09-30 14:13:50.000000000 -0500
>> +++ linux-next/drivers/base/memory.c	2010-09-30 14:46:00.000000000 -0500
> ...
>> +static unsigned long get_memory_block_size(void)
>> +{
>> +	u32 block_sz;
>         ^^^
> 
> I think this should be unsigned long.  u32 will work, but everything
> else has been changed to use unsigned long.  If you disagree, I will
> happily acquiesce as nothing is currently broken.  If SGI decides to make
> memory_block_size_bytes more dynamic, we will fix this up at that time.

You're right, that should have been made an unsigned long also.  I'll attach a new
patch with that corrected.

-Nathan
