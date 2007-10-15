Return-Path: <mike.koss@ngc.com>
Received: from xmrt0101.northgrum.com (xmrt0101.northgrum.com [208.20.220.55])
	by ozlabs.org (Postfix) with ESMTP id 74F82DE330
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 16 Oct 2007 05:17:31 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Linux booting problem on Xilinx ppc
Date: Mon, 15 Oct 2007 15:17:28 -0400
Message-ID: <E57AD4B83B37CA45A2BA1F0C5E4CD2EE02C92F49@XMBVAD02.northgrum.com>
In-Reply-To: <13219154.post@talk.nabble.com>
References: <12694083.post@talk.nabble.com><fa686aa40709152009k2b27ffc9kfb3fd0848f6b16d@mail.gmail.com><12696686.post@talk.nabble.com>
	<13219154.post@talk.nabble.com>
From: "Koss, Mike (Mission Systems)" <mike.koss@ngc.com>
To: "aauer1" <aauer1@gmx.at>,
	<linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In house we use the gcc 4.1.2, glibc 2.3.6 combo with success.

-- Mike

-----Original Message-----
From: aauer1 [mailto:aauer1@gmx.at]=20
Sent: Monday, October 15, 2007 2:47 PM
To: linuxppc-embedded@ozlabs.org
Subject: Re: Linux booting problem on Xilinx ppc


Hello

I'm also working with ML403 board from Xilinx and have the same problem
as you. The boot process stops after decompressing with the message "Now
booting the kernel". We also used gcc-4.1.0 for the cross compilation.
So, I would be glad to know, which gcc version have you used to get a
working kernel!

Thanks,
Andreas



Junqiang Hu wrote:
>=20
>=20
> Hi Grant,
>=20
>    Thank you so much for the reply!  Fortunately I got it work now --=20
> it's the crosstool compiler problem.  Originally I was using=20
> gcc-4.1.0, yet when compiling kernel 2.6.22, I noticed that it says=20
> gcc-4.1.0 will miscompile the kernel, so I changed to another version,

> and now I can let it go!
>=20
>   Right now still not fully booted because of the SystemACE problem,=20
> or maybe the partition is not correct.  I'm still working on it,=20
> hopefully to get it solved soon :-)
>=20
> Thanks,
> -J.
>=20
>=20
> Grant Likely-2 wrote:
>>=20
>> On 9/15/07, Junqiang Hu <jqhu936@yahoo.com> wrote:
>>>
>>>
>>> Dear friends,
>>>
>>>    I'm trying to run Linux in AvNet (Memec)=20
>>> Xilinx-XC2VP50-EVKT-FF1152  board.  The Linux version I'm using is=20
>>> 2.4; the cross-compiler is gcc-4.1.0, glibc 2.3.6.  When booting the
kernel, it shows:
>>>       loaded at:     00400000 004B51E4
>>>       board data at: 00000000 00000018
>>>       relocated to:  0040526C 00405284
>>>       zimage at:     00405B2B 004B177C
>>>       avail ram:     004B6000 60000000
>>=20
>> I strongly recommend moving to a 2.6 kernel.  Recent mainline has=20
>> support for the Xilinx ppc built in.
>>>
>>>       Linux/PPC load: console=3DttyS0,9600=20
>>> root=3D/dev/xsysace/disc0/part3 rw
>>>       Uncompressing Linux...done.
>>>       Now booting the kernel
>>>
>>> Then it hangs. First it seems to me that the "avail ram" is not=20
>>> correct, since I configured only 32MB SDRAM.  Moreover, if it's=20
>>> first powered on, the end address of "avail ram" would be FFD9FBED.=20
>>> Then I tried to investigate the problem using xmd.  When  launched,=20
>>> it says:
>>=20
>> (If you're using u-boot) You might have a mismatch between the board=20
>> info structure used by u-boot and the one used by Linux.
>>=20
>> Also, you should use your debugger to inspect the __log_buf memory of

>> the kernel.  A common problem is the kernel starts booting, but the=20
>> console is setup incorrectly and so you see nothing.  But, you can=20
>> read the console output directly from memory if you look at the=20
>> __log_buf region (find the address in the System.map file; you might=20
>> need to subtract 0xC0000000 from the address to view the memory)
>>=20
>> Cheers,
>> g.
>>=20
>> --
>> Grant Likely, B.Sc., P.Eng.
>> Secret Lab Technologies Ltd.
>> grant.likely@secretlab.ca
>> (403) 399-0195
>> _______________________________________________
>> Linuxppc-embedded mailing list
>> Linuxppc-embedded@ozlabs.org
>> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>>=20
>>=20
>=20
>=20

--
View this message in context:
http://www.nabble.com/Linux-booting-problem-on-Xilinx-ppc-tf4449060.html
#a13219154
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
