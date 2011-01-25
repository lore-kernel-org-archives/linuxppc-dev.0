Return-Path: <mitsutaka.amano@gmail.com>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 31E5DB7120
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 25 Jan 2011 13:17:36 +1100 (EST)
Received: by bwz10 with SMTP id 10so4289797bwz.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 24 Jan 2011 18:17:31 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4D3E3004.2040308@windriver.com>
References: <AANLkTin0RHAF8ieFqv12dFfOr_N3g3w6VVUTGOvH47uq@mail.gmail.com>
	<4D3D20D4.5040902@windriver.com>
	<AANLkTi=wfBzUUPqByQQK=UYiXN6CXrzferePCeM3TGpn@mail.gmail.com>
	<4D3E3004.2040308@windriver.com>
Date: Tue, 25 Jan 2011 11:17:31 +0900
Message-ID: <AANLkTimNmtqV3uO1+oiODeJmrDoyK570Vpb6n5AFnTKF@mail.gmail.com>
Subject: Re: About mpc85xx flash memory allocation
From: Mitsutaka Amano <mitsutaka.amano@gmail.com>
To: "tiejun.chen" <tiejun.chen@windriver.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jan 25, 2011 at 11:05 AM, tiejun.chen <tiejun.chen@windriver.com> w=
rote:
> Mitsutaka Amano wrote:
>> On Mon, Jan 24, 2011 at 3:48 PM, tiejun.chen <tiejun.chen@windriver.com>=
 wrote:
>>> Mitsutaka Amano wrote:
>>>> Hi all,
>>>>
>>>> I'm testing the ppc platform is based on mpc85xx. 256MB Flash memory
>>>> has been installed. Then I found this entries.
>>>>
>>>> /proc/vmallocinfo
>>>> ~~~
>>>> 0xc9100000-0xd9101000 268439552 of_flash_probe+0x290/0x814 ioremap
>>>>
>>>> physmap_of allocated 268MB over to the vmalloc. vmalloc space is tight=
.
>>>>
>>>> Why does we need mpc platforms to flash memory allocation? I know
>>> This should not be dedicated to so-called mpc platform. And we always u=
se
>>> ioremap() to map the device space. And on PPC ioremap also use the same=
 space as
>>> vmalloc(). While bootstrap you also can see this associated message lik=
e the
>>> follows,
>>> ------
>>> ......
>>> =A0* 0xd1000000..0xffbe9000 =A0: vmalloc & ioremap
>> Yeah. My platform says the follow message.
>>
>> =A0 * 0xc9000000..0xdf000000 =A0: vmalloc & ioremap
>
> Any reason why you don't access > 0xdf000000?

Higher than 0xdf000000 has to map TLB for using other peripherals.
it's 400MB over.

>
>>
>> The default vmalloc & ioremap space was about 200MB. so I increased
>> that by decreasing lowmem.
>> But If possible, I hope to keep default maps. So I don't want to use
>> vmalloc & ioremap
>>
>>>> other architectures don't allocate to the vmalloc.
>>>> The design of the hardware? or Is there the way to use the flash
>>> You can open /dev/mem then mmap() with a appropriate offset to access t=
he device
>>> space including flash.
>> I use the device tree(dts) and define flash partitions. Also I use CFI
>> driver and CFI_PHYSMAP_OF for device tree.
>> Is there the reference driver in what uses mmap() kernel tree? I think
>> I have to write a driver what can support dts and mmap() with a
>> appropriate offset to access the device.
>
> You should not write anything again. And you can access any physical addr=
ess
> directly via /dev/mem from the user space like the following:
>
> fd =3D open(/dev/mem,);
> mmap(fd + offset);

Thanks for letting me know. I want to use in combination with device
tree. So I'll write a driver based on physmap_of.c(such as mmap_of.c)

Thanks,
Mitsutaka

>
> Tiejun
>
>>
>> Thanks,
>> Mitsutaka
>>
>>> Tiejun
>>>
>>>> memory without vmalloc?
>>>>
>>>> Thanks,
>>>> Mitsutaka
>
>
