Return-Path: <gvb.uboot@gmail.com>
Message-ID: <4620D009.1000800@gmail.com>
Date: Sat, 14 Apr 2007 08:58:49 -0400
From: Jerry Van Baren <gvb.uboot@gmail.com>
MIME-Version: 1.0
To: Linuxppc-dev@ozlabs.org
Subject: Re: [PATCH dtc] Implement the -R option and add a -S option.
References: <20070405020433.GA13891@dellserver.lan>
	<20070405161113.GA28063@ld0162-tx32.am.freescale.net>
	<46152D90.5070209@smiths-aerospace.com>
	<20070412065152.GA26210@localhost.localdomain>
In-Reply-To: <20070412065152.GA26210@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Gibson wrote:
> On Thu, Apr 05, 2007 at 01:10:40PM -0400, Jerry Van Baren wrote:
>> Scott Wood wrote:
>>> On Wed, Apr 04, 2007 at 10:04:33PM -0400, Jerry Van Baren wrote:
>>>> Implement the -R <number> option to add memory reserve slots.
>>>> Add a -S <size> option makes the blob at least this number of bytes.
>>> Wouldn't it be better to just specify the amount of extra space, instead
>>> of the minimum total space?  That way, you only need to know what you
>>> intend to add, not how much is already there.
>>>
>>> -Scott
>> I thought briefly about this, but decided to implement a fixed size so 
>> that someone could allocate, say, 8K of memory in their memory map 
>> (likely flash) and know their blob would fit.
>>
>> Maybe we need a little -s option to say "add -s bytes".
> 
> I think having both options would be a good idea.  It would also be
> nice to have options to do this from the dts file (something similar
> to /memreserve/).
> 
>> Jon suggested a --stats option to print out the important statistics. 
>> That would also be a good enhancement.
> 
> Ok.  How would you envisage this working?
> 
> I've thought for some time that it would be a good idea to add an
> "info" output mode.  In that mode instead of outputting a converted
> device tree, it would give various bits of info on the input tree.
> This would include things like the header field debugging information
> that's currently output as pseudo-error messages when using dtb input.
> 
> I'm not sure to what extent your "--stats" idea would overlap with
> that.

Hi David,

Well, that was Jon's suggestion/idea so I have not thought about it 
much.  It would probably overlap 100% with your --info idea, with the 
exception that Jon's suggestion would also put out the blob.

Since the dtc puts out the blob to sdtout, this actually is problematic. 
  I presume that is why you suggest inhibiting output.  Using stderr 
would sorta bypass that problem, but is not ideal (IMHO).

Is there any reason we don't have a -o option to direct the compiled 
blob output to a file?  Since the usual use is to write to a file, it 
would free up stdout for (info/stats) outputs.

On an unrelated related note, I don't believe my -R additions are 
actually putting out additional reserve map slots (easiest to see using 
the asm format output).  I'm still trying to understand why not, it 
seemed pretty straight-forward.  When I implemented it, I was looking at 
hexdumps of the dtb binary format and looking at the header and thought 
I had it working... using it with my u-boot mods shows no extra reserved 
slots.  I'm looking into where I went wrong.

Best regards,
gvb
