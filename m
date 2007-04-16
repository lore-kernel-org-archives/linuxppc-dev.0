Return-Path: <gvb.linuxppc.dev@gmail.com>
Received: from rwcrmhc14.comcast.net (rwcrmhc14.comcast.net [216.148.227.154])
	by ozlabs.org (Postfix) with ESMTP id 0D813DDE38
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Apr 2007 10:27:28 +1000 (EST)
Message-ID: <4622C226.1070304@gmail.com>
Date: Sun, 15 Apr 2007 20:24:06 -0400
From: Jerry Van Baren <gvb.linuxppc.dev@gmail.com>
MIME-Version: 1.0
To: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH dtc take 2] Fix reserve map output for asm format.
References: <aa6a7bd73be20ea11e3e98f87a66e478@bga.com>
In-Reply-To: <aa6a7bd73be20ea11e3e98f87a66e478@bga.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, Jon Loeliger <jdl@jdl.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Milton Miller wrote:
> Sometime around Sun Apr 15 12:29:14 EST 2007, Jerry Van Baren wrote:
>> Add extra reserve map slots output for asm format (previously done for 
>> dtb
>>   output).
>>
>> Signed-off-by: Gerald Van Baren <vanbaren at cideas.com>
>> ---
>>
>> Hi Jon, David,
>>
>> Here is a patch that fixes the asm output without the (unnecessary)
>> calloc change.
>>
>> Best regards,
>> gvb
> 
> 
> The previous description had
>> Use cmalloc to pre-zero memory (for dtb input) and handle dtb (binary)
>>   input being shorter than the total blob length (result of putting
>>   extra space in the blob).
> 
> 
> Which at least said in the description the unrelated things it was 
> doing.

That was my added comment WRT the change from malloc to cmalloc.  David 
wasn't wild about using cmalloc, so I removed it.  Using cmalloc is not 
necessary.

>>         while (sizeleft) {
>> -               if (feof(f))
>> -                       die("EOF before reading %d bytes of DT blob\n",
>> -                           totalsize);
>> +               if (feof(f)) {
>> +                       WARNMSG("EOF after reading %d of %d bytes of 
>> DT blob, assuming there is extra space in the blob.\n",
>> +                           totalsize - sizeleft, totalsize);
>> +                       break;
>> +               }
> 
> I thnk the above should be an ERROR and cause failure without
> the -f (force) option.
> 
> The total_size says how much data should be copied.  Anything
> less and there is data missing.   Assuming zeros is wrong for
> most sections (the exception being the memory reserve list
> that had a terminating 0 entry within the read portion).
> 
> milton

The reason total_size is bigger than the actual size is because I 
created the blob with extra space using the -S parameter.  It is 
intentionally bigger.  The extra space is ignored by dtc when creating a 
dts/asm format output which is why cmalloc() is unnecessary.

I suppose we could require a -f force but I'm not wild about creating a 
nanny program.  There is nothing wrong with the blob - it parses just 
fine.  If there were problems with the blob contents, other errors would 
be raised.

Best regards,
gvb
