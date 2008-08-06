Return-Path: <wmb@firmworks.com>
Message-ID: <4899DAD5.9050209@firmworks.com>
Date: Wed, 06 Aug 2008 07:09:41 -1000
From: Mitch Bradley <wmb@firmworks.com>
MIME-Version: 1.0
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC/PATCH 2/3] of: add of_lookup_stdout() utility function
References: <20080806055214.30717.86092.stgit@trillian.secretlab.ca>	<20080806060239.30717.79273.stgit@trillian.secretlab.ca>	<20080805.233205.201125898.davem@davemloft.net>	<18585.31504.836857.829592@cargo.ozlabs.ibm.com>	<fa686aa40808060631k278e187ej965f0ac08c837937@mail.gmail.com>
	<C5C0AA60-C45F-4467-AC76-AA24A00CA4AC@kernel.crashing.org>
In-Reply-To: <C5C0AA60-C45F-4467-AC76-AA24A00CA4AC@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, devicetree-discuss@ozlabs.org,
	David Miller <davem@davemloft.net>, miltonm@bga.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



Segher Boessenkool wrote:
>> It's not what we do with flattened device trees blobs though.  In the
>> flattened tree we're not using a /chosen/stdout property, just the
>> linux,stdout-path one.
>>
>> The question that remains is; should there be?  Should the dt blobs
>> use /chosen/stdout also?  (I'm not familiar enough with real OF to
>> know the answer.  I'm assuming that an instance value is not the same
>> as a phandle).

The difference between a phandle and an ihandle is similar to the 
difference between (the inode of) an executable files on disk and (the 
process id of) a running process.  A phandle refers to the static 
information that describes a device, while an ihandle refers to a 
particular (out of potentially several) active instantiation of the OFW 
driver for that devices.  An "instance value" is a data item that can 
have a different value for each of the running instances of a given 
driver.  In the analogy, an instance value is like a data segment variable.

Given an ihandle, you can get the corresponding phandle with 
ihandle>phandle.  You can't go from phandle to ihandle, because that 
direction is one-to-many.

Why you you ever need more than one running instance of a given driver?  
For leaf devices, it is pretty rare to have multiple instances.  
Multiple instances are more often used for intermediate nodes.  The same 
intermediate node - for example a usb node - is often the parent of 
several leaf nodes that are active simultaneously.  When you open a 
device, its device tree parents up to the root are implicitly opened.  
Each such instance can hold dynamic state on behalf of its children.

>
> ihandles and phandles are not the same thing in OF.  Since in the
> "flat world" we cannot have instances, we should use phandles instead
> of ihandles for the things in /chosen.  I thought we agreed on that
> already, perhaps I am wrong?
>
>
> Segher
>
> _______________________________________________
> devicetree-discuss mailing list
> devicetree-discuss@ozlabs.org
> https://ozlabs.org/mailman/listinfo/devicetree-discuss
>
