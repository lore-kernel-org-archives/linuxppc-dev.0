Return-Path: <gerald.vanbaren@smiths-aerospace.com>
Received: from AGRXSUSMAILB.smiths.aero (host241-chi.smiths-group.com
	[65.216.75.241]) by ozlabs.org (Postfix) with ESMTP id 1A8B1DDEBC
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Apr 2007 22:27:36 +1000 (EST)
Message-ID: <46260EB6.6010506@smiths-aerospace.com>
Date: Wed, 18 Apr 2007 08:27:34 -0400
From: Jerry Van Baren <gerald.vanbaren@smiths-aerospace.com>
MIME-Version: 1.0
To: Jerry Van Baren <gvb.uboot@gmail.com>,  linuxppc-dev@ozlabs.org,
	jdl@jdl.com, David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH: dtc] Improve -S handling
References: <20070418020535.GA16224@dellserver.lan>	<20070418030528.GA27758@localhost.localdomain>
	<20070418064508.GC29312@localhost.localdomain>
In-Reply-To: <20070418064508.GC29312@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Gibson wrote:
> On Wed, Apr 18, 2007 at 01:05:28PM +1000, David Gibson wrote:
>> On Tue, Apr 17, 2007 at 10:05:35PM -0400, Jerry Van Baren wrote:
>>> If the user requests extra space, pad out the blob (previously the unused
>>>   data was undefined).
>>>
>>> Signed-off-by: Gerald Van Baren <vanbaren@cideas.com>
>>> ---
>>>
>>> Hi Jon, David, Milton,
>>>
>>> This improves the -S option to pad out the blob with zeros when the user
>>> asks for extra space.
>> Comment below
>>> diff --git a/flattree.c b/flattree.c
>>> index 151d16e..d2ee0dc 100644
>>> --- a/flattree.c
>>> +++ b/flattree.c
>>> @@ -310,6 +310,7 @@ static struct data flatten_reserve_list(struct reserve_info *reservelist,
>>>  	
>>>  	return d;
>>>  }
>>> +
>>>  static void make_bph(struct boot_param_header *bph,
>>>  		     struct version_info *vi,
>>>  		     int reservesize, int dtsize, int strsize,
>>> @@ -358,12 +359,15 @@ void dt_to_blob(FILE *f, struct boot_info *bi, int version,
>>>  {
>>>  	struct version_info *vi = NULL;
>>>  	int i;
>>> +	int size;
>>>  	struct data dtbuf = empty_data;
>>>  	struct data strbuf = empty_data;
>>>  	struct data reservebuf;
>>>  	struct boot_param_header bph;
>>>  	struct reserve_entry termre = {.address = 0, .size = 0};
>>>  
>>> +	size = 0;
>>> +
> 
> Oh, also, you shouldn't need this new variable to track the size.
> Just use whatever expression we used to use for totalsize before we
> forced it out to the minimum size.

It was simpler that way.  Much simpler.  With the calculated version, I 
had to know the header size and re-calculate all the alignment gaps. 
Ugly and nasty (respectively and collectively).

Best regards,
gvb
