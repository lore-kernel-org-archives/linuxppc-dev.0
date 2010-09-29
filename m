Return-Path: <kay.sievers@vrfy.org>
Received: from mail-iw0-f170.google.com (mail-iw0-f170.google.com
	[209.85.214.170]) by ozlabs.org (Postfix) with ESMTP id 30039B710B
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Sep 2010 23:40:15 +1000 (EST)
Received: by iwn37 with SMTP id 37so1216000iwn.15
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Sep 2010 06:40:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20100929123752.GA18865@kroah.com>
References: <4CA0EBEB.1030204@austin.ibm.com> <4CA1E338.6070201@redhat.com>
	<20100928151218.GJ14068@sgi.com> <20100929025035.GA13096@kroah.com>
	<4CA2F9A2.3090202@redhat.com> <20100929123752.GA18865@kroah.com>
From: Kay Sievers <kay.sievers@vrfy.org>
Date: Wed, 29 Sep 2010 15:39:58 +0200
Message-ID: <AANLkTi=uqVA5XGNKLg8=saXzWM5FA6KNP9fsAj80si_q@mail.gmail.com>
Subject: Re: [PATCH 0/8] v2 De-Couple sysfs memory directories from memory
	sections
To: Greg KH <greg@kroah.com>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	Dave Hansen <dave@linux.vnet.ibm.com>, linux-mm@kvack.org,
	Avi Kivity <avi@redhat.com>,
	KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
	Robin Holt <holt@sgi.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Sep 29, 2010 at 14:37, Greg KH <greg@kroah.com> wrote:
> On Wed, Sep 29, 2010 at 10:32:34AM +0200, Avi Kivity wrote:
>> =C2=A0On 09/29/2010 04:50 AM, Greg KH wrote:
>>> >
>>> > =C2=A0Because the old ABI creates 129,000+ entries inside
>>> > =C2=A0/sys/devices/system/memory with their associated links from
>>> > =C2=A0/sys/devices/system/node/node*/ back to those directory entries=
.
>>> >
>>> > =C2=A0Thankfully things like rpm, hald, and other miscellaneous comma=
nds scan
>>> > =C2=A0that information.
>>>
>>> Really? =C2=A0Why? =C2=A0Why would rpm care about this? =C2=A0hald is d=
ead now so we
>>> don't need to worry about that anymore,
>>
>> That's not what compatiblity means. =C2=A0We can't just support
>> latest-and-greatest userspace on latest-and-greatest kernels.
>
> Oh, I know that, that's not what I was getting at at all here, sorry if
> it came across that way.
>
> I wanted to know so we could go fix programs that are mucking around in
> these files, as odds are, the shouldn't be doing that in the first
> place.
>
> Like rpm, why would it matter what the memory in the system looks like?

HAL does many inefficient things, but I don't think it's using
/sys/system/, besides that it may check the cpufreq govenors state
there.

Kay
