Return-Path: <nfont@austin.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 09251B7176
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Sep 2010 03:39:52 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e4.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id o82HOlNY025329
	for <linuxppc-dev@ozlabs.org>; Thu, 2 Sep 2010 13:24:47 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o82Hdn7X080940
	for <linuxppc-dev@ozlabs.org>; Thu, 2 Sep 2010 13:39:49 -0400
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id o82HdmQG026134
	for <linuxppc-dev@ozlabs.org>; Thu, 2 Sep 2010 11:39:48 -0600
Message-ID: <4C7FE163.4000906@austin.ibm.com>
Date: Thu, 02 Sep 2010 12:39:47 -0500
From: Nathan Fontenot <nfont@austin.ibm.com>
MIME-Version: 1.0
To: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH 0/8] v5 De-couple sysfs memory directories from memory
	sections
References: <4C60407C.2080608@austin.ibm.com> <20100831215745.GA7641@kryten>
In-Reply-To: <20100831215745.GA7641@kryten>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Greg KH <greg@kroah.com>,
	linux-kernel@vger.kernel.org,
	Dave Hansen <dave@linux.vnet.ibm.com>, linux-mm@kvack.org,
	akpm@linux-foundation.org,
	KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/31/2010 04:57 PM, Anton Blanchard wrote:
> 
> Hi Nathan,
> 
>> This set of patches de-couples the idea that there is a single
>> directory in sysfs for each memory section.  The intent of the
>> patches is to reduce the number of sysfs directories created to
>> resolve a boot-time performance issue.  On very large systems
>> boot time are getting very long (as seen on powerpc hardware)
>> due to the enormous number of sysfs directories being created.
>> On a system with 1 TB of memory we create ~63,000 directories.
>> For even larger systems boot times are being measured in hours.
>>
>> This set of patches allows for each directory created in sysfs
>> to cover more than one memory section.  The default behavior for
>> sysfs directory creation is the same, in that each directory
>> represents a single memory section.  A new file 'end_phys_index'
>> in each directory contains the physical_id of the last memory
>> section covered by the directory so that users can easily
>> determine the memory section range of a directory.
> 
> I tested this on a POWER7 with 2TB memory and the boot time improved from
> greater than 6 hours (I gave up), to under 5 minutes. Nice!

Thanks for testing this out.  I was able to test this on a 1 TB system
and saw memory sysfs creation times go from 10 minutes to a few seconds.
It's good to see the difference for a 2 TB system.

-Nathan
