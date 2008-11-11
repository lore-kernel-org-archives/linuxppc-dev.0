Return-Path: <miltonm@bga.com>
In-Reply-To: <C3A583FA-6DE9-4B3E-96FE-43AE936DFE2C@watson.ibm.com>
References: <25b7edabcd3d50a8d399ac5208a7ecb6@bga.com>
	<C3A583FA-6DE9-4B3E-96FE-43AE936DFE2C@watson.ibm.com>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <25ce35b3d6051225f812829aaae2f6bf@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: dtc: Add python source code output
Date: Tue, 11 Nov 2008 09:54:54 -0600
To: Jimi Xenidis <jimix@watson.ibm.com>
Cc: linux-ppc <linuxppc-dev@ozlabs.org>, devicetree-discuss@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Nov 10, 2008, at 11:00 AM, Jimi Xenidis wrote:
> On Nov 10, 2008, at 10:11 AM, Milton Miller wrote:
>> On 2008-11-07 at 02:31:40, David Gibson wrote:
>>> On Thu, Nov 06, 2008 at 06:55:44PM +1100, Michael Ellerman wrote:
>>>> This commit adds an output format, which produces python
>>>> code. When run, the python produces a data structure that
>>>> can then be inspected in order to do various things.
>> ...
>>>> I'm not sure if this is generally useful (or sane) but it was for 
>>>> me so
>>>> I thought I'd post it.
>>>
>>> Hrm, well the idea of langauge source output seems reasonable.  But
>>> the actual data structure emitted, and the method of construction in
>>> Python both seem a bit odd to me.
>>>
>>>> I have a dts that I want to use to configure a simulator, and this
>>>> seemed like the nicest way to get there. dtc spits out the 
>>>> pythonised
>>>> device tree, and then I have a 10 line python script that does the
>>>> configuring.
>>
>> [snip]
>>> These branches also result in the value having different Python types
>>> depending on the context.  That's not necessarily a bad thing, but
>>> since which Python type is chosen depends on a heuristic only, it
>>> certainly needs some care.  You certainly need to be certain that you
>>> can always deduce the exact, byte-for-byte correct version of the
>>> property value from whatever you put into the Python data structure.
...
>>> So, emitting Python procedural code to build up the data structure,
>>> rather than a great big Python literal that the Python parser will
>>> just turn into the right thing seems a bit of a roundabout way of
>>> doing this.
>>
>> I would think so too.   I haven't looked at the output, only at 
>> Davids comments.  If the data structure is ambiguous, then I do think 
>> more thought is needed.
>
> There is value in the DTC (optionally) emitting a python library and 
> then having the DTC result use it.

I'm not sure what you are trying to say here, Jimi.   Are you asking 
that dtc emit dtlib.py?  And then have it parse the python later?

> It would allow for python to easily, at runtime, be able to modify the 
> contents and not have to inline-edit, emit, compile a DTS.

Are you saying you want to modify a device tree in some python-specific 
syntax, and just dump it and have dtc understand that format so we 
don't have to translate to a dts?

Admittedly this is not the impression I got when I interrogated you 
over chat.  But its still how I'm parsing this email.

> BTW: it would also be nice if the python library to dump the dts (or 
> even dtb)

Ok so you want to see the standard output too.

>> Have you considered just parsing the flat tree binary?   Either 
>> creating a python binding to libfdt or even just parsing the dtb 
>> directly?

I know that just parsing the dtb in python (and even changing and 
emitting a changed dtb) will be easier than teaching dtc to read 
something that looks like python code.  Because I have written the perl 
and have dabbled in others python code (but I don't plan on writing the 
python version).


Based on my experience with parsing dtb in perl, I think handling 
property conversion in python, where one can explicitly request type 
conversion by how one intends to use the property value, is preferable 
to emitting the data structure in another language and relying on 
heuristics to guess the right type based on its value.   I'm saying 
lets add decode_string / decode_int (direct translations to pack and 
unpack, or just call them explicitly) to interpret the properties 
rather than expect a translated python string but get a byte array 
because it had some special character, or worse expect an integer or 
byte array but get a string because its value happened to look like a 
string.  Doing these heuristics when creating a dts is ok because the 
result will still compile correctly back to a dtb -- it just makes it 
harder for the human to read, not the machine to parse, but expecting 
another language environment to use the result without having 
encode/decode available is likely to lead to data dependent bugs.

So then the question becomes what is the value to emit a python tree 
structure more natively for python to read  versus decoding dtb and 
building the tree in python?

milton
