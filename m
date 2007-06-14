Return-Path: <segher@kernel.crashing.org>
In-Reply-To: <20070614042906.GC11177@localhost.localdomain>
References: <7878cf1aec340b976b90b86b9e83bf18@kernel.crashing.org>
	<20070612044246.GC4198@localhost.localdomain>
	<9fbd7a7f5cdde58768569ab23c7aec7c@kernel.crashing.org>
	<20070613061254.GG16148@localhost.localdomain>
	<bc98b5372977d171b0075074bfce7747@kernel.crashing.org>
	<20070613091904.GA30948@localhost.localdomain>
	<791ab8b82c5b5d2b3ae4827a891a43ea@kernel.crashing.org>
	<20070614042906.GC11177@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <468c8d125e1e35a985aee2a21676ce2f@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Create "rom" (MTD) device prpmc2800
Date: Thu, 14 Jun 2007 10:00:45 +0200
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> I think some binary partition table format that can be
>> used by _all_ MTD consumers should be defined.  How
>> that table should be communicated to the kernel in the
>> device tree case we can discuss later, then.  Maybe
>> something as simple as storing it in flash, and have a
>> "partition-table-offset" property or something like that.
>>
>> This is something the MTD people will have to buy into
>> of course.
>
> I tought I saw some config option implying that there already existed
> an on-device partition table format for flashes.

Interesting.

> Doesn't help us for
> existing boards which don't expect such a setup, of course.

If they don't use a device tree yet, I don't see much
of a problem.  If they do already, that can be fixed,
too -- gradually.

> Incidentally, with either the partitions-described-by-properties, or
> the revised more-flexible partitions-described-by-subnodes format, I'm
> not seeing it as required that the whole of the flash address space be
> described.

Indeed.  It is fine to simply tell the OS "there is
some flash here, you figure out what to use it for".

> So it would certainly be possible to *only* describe the
> sections of the flash used by firmware.  But I'm suggesting that we
> optionally allow other partitions to be described for boards / systems
> which have strong conventions about how the flash is divided and where
> we don't have any other way of recording the partition layout short of
> hardcoding.

As long as it's optional there should be no harm in
that, of course.


Segher
