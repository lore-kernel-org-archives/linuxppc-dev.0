Return-Path: <pku.leo@gmail.com>
Received: from mail-pw0-f50.google.com (mail-pw0-f50.google.com
	[209.85.160.50]) by ozlabs.org (Postfix) with ESMTP id AFCAF1007D4
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Nov 2009 21:00:25 +1100 (EST)
Received: by pwi6 with SMTP id 6so2142518pwi.9
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Nov 2009 02:00:23 -0800 (PST)
MIME-Version: 1.0
Sender: pku.leo@gmail.com
In-Reply-To: <19215.14808.476221.223143@drongo.ozlabs.ibm.com>
References: <1258441832-20133-1-git-send-email-leoli@freescale.com>
	<8543954E-619A-4A78-A934-CDC326027FD2@kernel.crashing.org>
	<3A45394FD742FA419B760BB8D398F9EDCBC1F2@zch01exm26.fsl.freescale.net>
	<1258707833.2140.865.camel@pasglop>
	<2a27d3730911200123i23fa6dd1td9e19944d1737e73@mail.gmail.com>
	<DFC7BA62-6CF0-4A08-8DD1-11825A638262@kernel.crashing.org>
	<2a27d3730911250007s62f31673p3358631996e8a451@mail.gmail.com>
	<20091125113023.GC12738@iram.es>
	<2a27d3730911252343j6a938d99n7152b7cc8d01c0bf@mail.gmail.com>
	<19215.14808.476221.223143@drongo.ozlabs.ibm.com>
Date: Mon, 30 Nov 2009 18:00:23 +0800
Message-ID: <2a27d3730911300200t35d1d5eob152a1a9f465465b@mail.gmail.com>
Subject: Re: [RFC] powerpc/mm: honor O_SYNC flag for memory map
From: Li Yang <leoli@freescale.com>
To: Paul Mackerras <paulus@samba.org>
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

On Fri, Nov 27, 2009 at 10:30 AM, Paul Mackerras <paulus@samba.org> wrote:
> Li Yang writes:
>
>> That's my concern too. =C2=A0But after all mmap without O_SYNC on I/O
>> devices should be deprecated.
>
> It should? =C2=A0Why?
>
> Shouldn't the onus rather be on those proposing an incompatible change
> to the kernel ABI, such as this is, to show why the change is
> absolutely essential?

In addition to the performance issue I stated earlier in this thread.
There was also cache paradoxes problem too.  If a memory region is
shared between two cores/OS'es and Linux can't map the region with the
same cacheable property as the other OS had mapped, there will be a
problem.  The best solution for this problem is to make the
cacheablity controllable.

And it seems to be generic issue which does not only exist on powerpc
platforms.  So it might be better dealt with the already existed
O_SYNC flag which was meant to deal with this kind of thing.  I agree
with your comment in another email that device tree could be used, but
that solution is not generic enough though.

- Leo
