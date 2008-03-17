Return-Path: <asmirnov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id A1200DDE21
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Mar 2008 23:10:49 +1100 (EST)
Message-ID: <47DE61E1.6060300@ru.mvista.com>
Date: Mon, 17 Mar 2008 15:19:45 +0300
From: Alexandr Smirnov <asmirnov@ru.mvista.com>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 1/4] Emerson ATCA-C125 bootwrapper
References: <20080314142220.GA8228@ru.mvista.com>
	<20080314142703.GB8228@ru.mvista.com>
	<20080315001036.GA3487@localhost.localdomain>
In-Reply-To: <20080315001036.GA3487@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David,
>> +	/* Unfortunately, the specific model number is encoded in the
>> +	 * soc node name in existing dts files -- once that is fixed,
>> +	 * this can do a simple path lookup.
>> +	 */
>>     
>
> Since this is a new board, couldn't you name the soc node /soc and
> dispense with this more complicated way of doing things?  Or would
> that break other versions of u-boot that are in use?
>   
As I understand you would like to rename /soc8548 node to /soc and make 
a simple path lookup like following:
- soc = find_node_by_devtype(NULL, "soc");
+ soc = finddevice("/soc");
Is this correct?

But fsl_soc code still uses of_find_node_by_type so we can't remove 
device_type property from node /soc and therefor simplify device tree.


Thanks,
Alexandr
