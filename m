Return-Path: <computersforpeace@gmail.com>
Received: from mail-wy0-f170.google.com (mail-wy0-f170.google.com
	[74.125.82.170]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id DC8AAB6F76
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Aug 2011 05:42:21 +1000 (EST)
Received: by wyf23 with SMTP id 23so184099wyf.15
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Aug 2011 12:42:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1313507201.2679.2.camel@sauron>
References: <1312350638-25566-1-git-send-email-b35362@freescale.com>
	<1313507201.2679.2.camel@sauron>
Date: Tue, 16 Aug 2011 12:42:15 -0700
Message-ID: <CAN8TOE8sD3cPjkTrLWMXFH58gURTuiBWYDFA+XLK_MKDMb9-5g@mail.gmail.com>
Subject: Re: [PATCH] mtd-utils: fix corrupt cleanmarker with flash_erase -j
	command
From: Brian Norris <computersforpeace@gmail.com>
To: dedekind1@gmail.com
Content-Type: text/plain; charset=ISO-8859-1
Cc: b35362@freescale.com, linuxppc-dev@linux.freescale.net,
	linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org, dwmw2@infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Aug 16, 2011 at 8:06 AM, Artem Bityutskiy <dedekind1@gmail.com> wrote:
> On Wed, 2011-08-03 at 13:50 +0800, b35362@freescale.com wrote:
>> From: Liu Shuo <b35362@freescale.com>
>>
>> Flash_erase -j should fill discrete freeoob areas with required bytes
>> of JFFS2 cleanmarker in jffs2_check_nand_cleanmarker(). Not just fill
>> the first freeoob area.
>
> Hmm, shouldn't we instead make MTD_OOB_AUTO be available for userspace
> via an ioctl instead and make flash_eraseall use it instead?

`nandwrite -o' does a similar thing, where it uses MEMGETOOBSEL to
find open spaces in OOB. Both MEMGETOOBSEL and ECCGETLAYOUT have been
declared obsolete. Plus, the code that uses any of these is somewhat
complicated and duplicated, so I agree that new code probably should
use some form of the internal MTD_OOB_AUTO.

Perhaps this can just be integrated into the new ioctl I'm writing as
a "mode" choice? See the thread:
http://lists.infradead.org/pipermail/linux-mtd/2011-August/037316.html

Brian
