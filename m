Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D0AD2DDFB1
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Apr 2009 03:16:30 +1000 (EST)
In-Reply-To: <20090409232104.60d25d26@manatee.lan>
References: <2c4bcf8d1d7083ff53ce5b556765e96676a007fb.1239165378.git.tony@bakeyournoodle.com>
	<1239167335.10104.26.camel@localhost>
	<20090408055126.GG16602@bilbo.ozlabs.org>
	<1239173283.10104.38.camel@localhost>
	<20090408134736.682bd56d@manatee.lan>
	<20090409000112.GI16602@bilbo.ozlabs.org>
	<20090409232104.60d25d26@manatee.lan>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <4A5D7C01-B59C-47CB-A990-076A55CC8972@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] Quieten arch/powerpc in a allmodconfig build.
Date: Fri, 10 Apr 2009 19:19:45 +0200
To: Nathan Lynch <ntl@pobox.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> /scratch/tony/working/arch/powerpc/kernel/cacheinfo.c: In function  
>> 'associativity_show':
>> /scratch/tony/working/arch/powerpc/kernel/cacheinfo.c:562:  
>> warning: 'associativity' may be used uninitialized in this function
>> /scratch/tony/working/arch/powerpc/kernel/cacheinfo.c: In function  
>> 'size_show':
>> /scratch/tony/working/arch/powerpc/kernel/cacheinfo.c:513:  
>> warning: 'size_kb' may be used uninitialized in this function
>
> Thanks.
>
> So I think I've convinced myself that the warnings are incorrect and
> that uninitialized use is not possible.

Strictly speaking the warnings aren't incorrect: the variables
"may be used uninitialized", they just never are.  I agree this
isn't very helpful.

> But I find it odd that gcc gives warnings for these sites but not  
> others
> in the file that use the same idiom (e.g. line_size_show,
> nr_sets_show).

Yeah.

> I'd guess that inlining is implicated somehow.  Would I
> be justified in worrying that this version of gcc is generating
> incorrect code?

Not really.  Sub-optimal code perhaps, but not incorrect.

> If not, then I'm fine with the uninitialized_var() changes, but do
> please include the warnings and the compiler version in the changelog.

If this happens with a non-ancient GCC version, can we have a bugreport
please?


Segher
