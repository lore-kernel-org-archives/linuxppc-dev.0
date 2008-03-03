Return-Path: <jschopp@austin.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A23A2DDEB7
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Mar 2008 10:36:55 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m23NamDA007779
	for <linuxppc-dev@ozlabs.org>; Mon, 3 Mar 2008 18:36:48 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m23Namtx191920
	for <linuxppc-dev@ozlabs.org>; Mon, 3 Mar 2008 16:36:48 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m23NamYf022637
	for <linuxppc-dev@ozlabs.org>; Mon, 3 Mar 2008 16:36:48 -0700
Message-ID: <47CC8BB6.9090607@austin.ibm.com>
Date: Mon, 03 Mar 2008 17:37:26 -0600
From: Joel Schopp <jschopp@austin.ibm.com>
MIME-Version: 1.0
To: Manish Ahuja <ahuja@austin.ibm.com>
Subject: Re: [PATCH 0/8] pseries: phyp dump: hypervisor-assisted dump
References: <47B90F55.2080606@austin.ibm.com>	<1203641584.15378.2.camel@concordia.ozlabs.ibm.com>
	<47C74A66.1060105@austin.ibm.com>
In-Reply-To: <47C74A66.1060105@austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, Linas Vepstas <linasvepstas@gmail.com>,
	paulus <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This looks like it is to a stable usable point now.  In my opinion it is 
ready to be merged into the next tree for 2.6.26.

Reviewed-by: Joel Schopp <jschopp@austin.ibm.com>


Manish Ahuja wrote:
> Changes from previous version:
>
> The only changes are in patch 2.
> moved early_init_dt_scan_phyp_dump from rtas.c to phyp_dump.c
> Added dummy function in phyp_dump.h
>
> Patch 3 required repatching due to changes to patch 2.
> Resubmitting all patches to avoid confusion.
>
> Thanks,
> Manish
>
>
> Michael Ellerman wrote:
>   
>> On Sun, 2008-02-17 at 22:53 -0600, Manish Ahuja wrote:
>>     
>>> The following series of patches implement a basic framework
>>> for hypervisor-assisted dump. The very first patch provides 
>>> documentation explaining what this is  :-) . Yes, its supposed
>>> to be an improvement over kdump.
>>>
>>> A list of open issues / todo list is included in the documentation.
>>> It also appears that the not-yet-released firmware versions this was tested 
>>> on are still, ahem, incomplete; this work is also pending.
>>>
>>> I have included most of the changes requested. Although, I did find
>>> one or two, fixed in a later patch file rather than the first location
>>> they appeared at.
>>>       
>> This series still doesn't build on !CONFIG_RTAS configs:
>> http://kisskb.ellerman.id.au/kisskb/head/629/
>>
>> This solution is to move early_init_dt_scan_phyp_dump() into
>> arch/powerpc/platforms/pseries/phyp_dump.c and provide a dummy
>> implementation in asm-powerpc/phyp_dump.c for the !CONFIG_PHYP_DUMP
>> case.
>>
>> cheers
>>
>>     
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>   
