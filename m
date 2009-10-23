Return-Path: <memorylost@tin.it>
Received: from smtp-out01.alice.it (smtp-out01.alice.it [85.33.2.12])
	by ozlabs.org (Postfix) with ESMTP id 37BD8B7BBC
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 23 Oct 2009 21:00:13 +1100 (EST)
Message-ID: <4AE17E97.40907@tin.it>
Date: Fri, 23 Oct 2009 11:59:51 +0200
From: LD <memorylost@tin.it>
MIME-Version: 1.0
To: Chen Hongjun-R66092 <hong-jun.chen@freescale.com>
Subject: Re: MPC5121e DIU driver - kernel crash writing alpha component
References: <4AE1585E.60002@tin.it>
	<3A45394FD742FA419B760BB8D398F9ED8F6CF3@zch01exm26.fsl.freescale.net>
In-Reply-To: <3A45394FD742FA419B760BB8D398F9ED8F6CF3@zch01exm26.fsl.freescale.net>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Linux ppc mailing list <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Chen,
many thanks for your very fast answer.

If I understand well, the situation is as follows:

32 bits mode, plane1 - if I write any alpha component != 0 I have a system hang
; writing alpha components in any other plane is ok.

- -----

- From my first tries I had lockups also in 16 bits 5-6-5 modes, but in this
moment I cannot precisely track down things.
Is there something I cannot do in plane1 in 16 bits modes ?

- -----

With the previous processor stepping I was not experiencing this problem ; is it
something specific from 0M36P ?

- -----

- From this, if I cannot write something in plane1 I would think about a kernel
display driver patch: a user program ->can not<- lock the system by writing
something wrong.
So... two paths:

- - do not "publish" plane1 as /dev/fb0, but plane2 will be /dev/fb0
or
- - see suggestion about double buffering and filtering alpha components

Thanks,
best regards

Lucio Dona'

Chen Hongjun-R66092 wrote:
>> Hi, 
> 
>> Pls refer to my comment embedded. 
> 
> 
> The board is booting ok (NFS), but my user space app keeps 
> crashing the kernel.
> 
> If, from user space, I write some alpha component != 0 in 
> this plane then I have a complete system crash.
> The reference pdf says "There is no alpha component defined 
> for plane1 because there are no planes behind it."
> 
> 
>> Sure, panel0 doesn't support alpha function, so you can't operate it.
> 
> 
>> You can replace panel0 with panel1, which can support alpha function.
> 

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iD8DBQFK4X6XvxHCsvXy9okRApsxAJ40VJ+2/+sP4XW1qoviZlQm6m+0HQCgjkmB
p2zNmK+Eyf++r9w0fEQxZxs=
=HWm0
-----END PGP SIGNATURE-----
