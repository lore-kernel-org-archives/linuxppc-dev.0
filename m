Return-Path: <segher@kernel.crashing.org>
In-Reply-To: <20070808015150.GC20565@localhost.localdomain>
References: <20070730150648.GA5005@ru.mvista.com>
	<20070801020836.GB31391@localhost.localdomain>
	<65ff446478a9fd0a48061079d5f04f8f@kernel.crashing.org>
	<20070801050422.GI31391@localhost.localdomain>
	<20070801054751.GM31391@localhost.localdomain>
	<59e87834966d80bb143e1683fe751cd1@kernel.crashing.org>
	<20070807034136.GC13522@localhost.localdomain>
	<03211b7766f4a21c90889344f843a564@kernel.crashing.org>
	<20070808015150.GC20565@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <627e5728e1f0e475f3504529a79ee228@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 2/6] PowerPC 440EPx: Sequoia DTS
Date: Thu, 9 Aug 2007 22:00:47 +0200
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> For the JEDEC chips, we need a "vendor-id" and "device-id"
>> property at least (or similar names -- whatever is general
>> practice for this); both are a single byte, encoded as with
>> encode-int.
>
> Ok... should those really be separate properties, or should that go in
> compatible, i.e. something like:
> 	compatible = "amd,XXXXXX", "jedec,a4-b7", "jedec-flash";

Good question.  I think we want the separate bytes, if nothing
else then just for the benefit of drivers that have their own
table of those already.  But the "compatible" thing also has
its merits of course.  I'll ask some flash gurus about what's
special about JEDEC flash, and maybe even read a datasheet or
two.  We're in no hurry right, CFI flash is lots more common
nowadays ;-)

>>>> One thing though -- what _exactly_ does "read-only" signify?
>>>
>>> That's... a good question.
>>
>> Yeah.  It seems to me that the way it is currently used is
>> pure policy enforcement, which doesn't belong in the device
>> tree.
>
> Well.. not really policy enforcement, but a policy hint.

So it most likely doesn't belong there.  How the OS userland
wants to mount those partitions, if at all, and if they even
contain a filesystem -- that's all its own business and belongs
in /etc/fstab or whatever the newfangled thing is.

On most flash chips, you can actually write-protect some
sectors; "read-only" sounds more like that.  Although
"write-protected" would be a better name.

Or maybe "read-only" is useful and I just don't see why.  In
that case, please figure out what its semantics are :-)


Segher
