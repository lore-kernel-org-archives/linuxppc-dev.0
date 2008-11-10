Return-Path: <jimix@watson.ibm.com>
Message-Id: <C3A583FA-6DE9-4B3E-96FE-43AE936DFE2C@watson.ibm.com>
From: Jimi Xenidis <jimix@watson.ibm.com>
To: Milton Miller <miltonm@bga.com>
In-Reply-To: <25b7edabcd3d50a8d399ac5208a7ecb6@bga.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: dtc: Add python source code output
Date: Mon, 10 Nov 2008 11:00:49 -0600
References: <25b7edabcd3d50a8d399ac5208a7ecb6@bga.com>
Cc: linux-ppc <linuxppc-dev@ozlabs.org>, devicetree-discuss@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Nov 10, 2008, at 10:11 AM, Milton Miller wrote:

> On 2008-11-07 at 02:31:40, David Gibson wrote:
>> On Thu, Nov 06, 2008 at 06:55:44PM +1100, Michael Ellerman wrote:
>>> This commit adds an output format, which produces python
>>> code. When run, the python produces a data structure that
>>> can then be inspected in order to do various things.
> ...
>>> I'm not sure if this is generally useful (or sane) but it was for  
>>> me so
>>> I thought I'd post it.
>>
>> Hrm, well the idea of langauge source output seems reasonable.  But
>> the actual data structure emitted, and the method of construction in
>> Python both seem a bit odd to me.
>>
>>> I have a dts that I want to use to configure a simulator, and this
>>> seemed like the nicest way to get there. dtc spits out the  
>>> pythonised
>>> device tree, and then I have a 10 line python script that does the
>>> configuring.
>
> [snip]
>> These branches also result in the value having different Python types
>> depending on the context.  That's not necessarily a bad thing, but
>> since which Python type is chosen depends on a heuristic only, it
>> certainly needs some care.  You certainly need to be certain that you
>> can always deduce the exact, byte-for-byte correct version of the
>> property value from whatever you put into the Python data structure.
>>> +
>>> +out:
>>> +     fprintf(f, "    n.properties.append(p)\n");
>>
>> So, emitting Python procedural code to build up the data structure,
>> rather than a great big Python literal that the Python parser will
>> just turn into the right thing seems a bit of a roundabout way of
>> doing this.
>
> I would think so too.   I haven't looked at the output, only at  
> Davids comments.  If the data structure is ambiguous, then I do  
> think more thought is needed.

There is value in the DTC (optionally) emitting a python library and  
then having the DTC result use it.
It would allow for python to easily, at runtime, be able to modify the  
contents and not have to inline-edit, emit, compile a DTS.

BTW: it would also be nice if the python library to dump the dts (or  
even dtb)

>
>
> Have you considered just parsing the flat tree binary?   Either  
> creating a python binding to libfdt or even just parsing the dtb  
> directly?
>
> I have written perl code to parse a dtb and query it for nodes and  
> properties, it wasn't too bad.  I need to look at a bug report by  
> another user and comment it, then I should seek the okays post it.   
> It is currently read-only and iterative callback based (like the  
> kernels early-scan-flat-tree stuff), but I have planned creating a  
> tree for querying, editing, and re-flattening.  Perl strings are  
> counted length binary blobs, so property contents are interpreted  
> with pack and unpack.  The library has been used to search a dtb to  
> build a list of cpu instances and memory blocks, and it has been  
> used to query the properties of a known node in the tree.
>
> milton
>
> _______________________________________________
> devicetree-discuss mailing list
> devicetree-discuss@ozlabs.org
> https://ozlabs.org/mailman/listinfo/devicetree-discuss
>
