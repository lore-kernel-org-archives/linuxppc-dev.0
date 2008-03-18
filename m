Return-Path: <dgibson@ozlabs.org>
Date: Tue, 18 Mar 2008 12:28:18 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexandr Smirnov <asmirnov@ru.mvista.com>
Subject: Re: [PATCH 1/4] Emerson ATCA-C125 bootwrapper
Message-ID: <20080318012818.GB18217@localhost.localdomain>
References: <20080314142220.GA8228@ru.mvista.com>
	<20080314142703.GB8228@ru.mvista.com>
	<20080315001036.GA3487@localhost.localdomain>
	<47DE61E1.6060300@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <47DE61E1.6060300@ru.mvista.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Mar 17, 2008 at 03:19:45PM +0300, Alexandr Smirnov wrote:
> David,
>>> +	/* Unfortunately, the specific model number is encoded in the
>>> +	 * soc node name in existing dts files -- once that is fixed,
>>> +	 * this can do a simple path lookup.
>>> +	 */
>>>     
>>
>> Since this is a new board, couldn't you name the soc node /soc and
>> dispense with this more complicated way of doing things?  Or would
>> that break other versions of u-boot that are in use?
>>   
> As I understand you would like to rename /soc8548 node to /soc and make a 
> simple path lookup like following:
> - soc = find_node_by_devtype(NULL, "soc");
> + soc = finddevice("/soc");
> Is this correct?

That's right.

> But fsl_soc code still uses of_find_node_by_type so we can't remove 
> device_type property from node /soc and therefor simplify device
> tree.

It does?  Grrr...  I thought that had been fixed and the only reason
the device_type was still needed was because some u-boot versions
needed it.  But you're right, that's not the case.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
