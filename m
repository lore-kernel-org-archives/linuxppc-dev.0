Return-Path: <pku.leo@gmail.com>
Received: from mail-pw0-f50.google.com (mail-pw0-f50.google.com
	[209.85.160.50]) by ozlabs.org (Postfix) with ESMTP id AF3361007D1
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Nov 2009 18:43:17 +1100 (EST)
Received: by pwi6 with SMTP id 6so353631pwi.9
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Nov 2009 23:43:15 -0800 (PST)
MIME-Version: 1.0
Sender: pku.leo@gmail.com
In-Reply-To: <20091125113023.GC12738@iram.es>
References: <1258441832-20133-1-git-send-email-leoli@freescale.com>
	<8543954E-619A-4A78-A934-CDC326027FD2@kernel.crashing.org>
	<3A45394FD742FA419B760BB8D398F9EDCBC1F2@zch01exm26.fsl.freescale.net>
	<1258707833.2140.865.camel@pasglop>
	<2a27d3730911200123i23fa6dd1td9e19944d1737e73@mail.gmail.com>
	<DFC7BA62-6CF0-4A08-8DD1-11825A638262@kernel.crashing.org>
	<2a27d3730911250007s62f31673p3358631996e8a451@mail.gmail.com>
	<20091125113023.GC12738@iram.es>
Date: Thu, 26 Nov 2009 15:43:15 +0800
Message-ID: <2a27d3730911252343j6a938d99n7152b7cc8d01c0bf@mail.gmail.com>
Subject: Re: [RFC] powerpc/mm: honor O_SYNC flag for memory map
From: Li Yang <leoli@freescale.com>
To: Gabriel Paubert <paubert@iram.es>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, Li Yang-R58472 <r58472@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Nov 25, 2009 at 7:30 PM, Gabriel Paubert <paubert@iram.es> wrote:
> On Wed, Nov 25, 2009 at 04:07:46PM +0800, Li Yang wrote:
>> On Sun, Nov 22, 2009 at 4:01 AM, Segher Boessenkool
>> <segher@kernel.crashing.org> wrote:
>> >>> You need to be a bit more careful tho. You must not allow RAM manage=
d by
>> >>> the kernel to be mapped non-cachable.
>> >>
>> >> Even if the user explicitly sets the O_SYNC flag? =C2=A0IMHO, it's a =
bug of
>> >> the application if it uses O_SYNC on main memory to be mmap'ed later.
>> >> And we don't need to cover up the bug.
>> >
>> > Is that "embedded thinking"? =C2=A0Conflicts like this cause machine c=
hecks or
>> > checkstops on many PowerPC implementations, we do not normally allow s=
uch
>> > to be caused by userland.
>>
>> So what you are saying is that if the kernel has mapped a physical
>> page as cacheable while user application is trying to map it as
>> non-cacheable, there will be machine checks and checkstops rather than
>> just performance drop? =C2=A0This is new to me. =C2=A0Could you elaborat=
e a bit?
>
> That's called cache paradoxes. And yes they may be a problem.

Thanks.  I will prevent this from happening.

>
> Besides that, existing =C2=A0application may have used mmap without O_SYN=
C on
> I/O devices, knowing that the kernel would map them uncached. Your
> patch would break them by using cached accesses (and it can cause
> really hard to debug lockups, I've seen this, probably caused by
> infinite retries on the PCI bus).

That's my concern too.  But after all mmap without O_SYNC on I/O
devices should be deprecated.  A warning message in deprecation period
could reduce potential problem caused by this change.

- Leo
