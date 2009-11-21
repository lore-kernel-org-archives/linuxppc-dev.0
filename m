Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 71A9CB6F00
	for <linuxppc-dev@ozlabs.org>; Sun, 22 Nov 2009 06:54:46 +1100 (EST)
In-Reply-To: <2a27d3730911200123i23fa6dd1td9e19944d1737e73@mail.gmail.com>
References: <1258441832-20133-1-git-send-email-leoli@freescale.com>
	<8543954E-619A-4A78-A934-CDC326027FD2@kernel.crashing.org>
	<3A45394FD742FA419B760BB8D398F9EDCBC1F2@zch01exm26.fsl.freescale.net>
	<1258707833.2140.865.camel@pasglop>
	<2a27d3730911200123i23fa6dd1td9e19944d1737e73@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <DFC7BA62-6CF0-4A08-8DD1-11825A638262@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC] powerpc/mm: honor O_SYNC flag for memory map
Date: Sat, 21 Nov 2009 21:01:04 +0100
To: Li Yang <leoli@freescale.com>
Cc: Li Yang-R58472 <r58472@freescale.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>> You need to be a bit more careful tho. You must not allow RAM  
>> managed by
>> the kernel to be mapped non-cachable.
>
> Even if the user explicitly sets the O_SYNC flag?  IMHO, it's a bug of
> the application if it uses O_SYNC on main memory to be mmap'ed later.
> And we don't need to cover up the bug.

Is that "embedded thinking"?  Conflicts like this cause machine  
checks or
checkstops on many PowerPC implementations, we do not normally allow  
such
to be caused by userland.


Segher
