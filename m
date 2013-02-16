Return-Path: <phileas-fogg@mail.ru>
Received: from smtp33.i.mail.ru (smtp33.i.mail.ru [94.100.177.93])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 9EE982C008C
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 Feb 2013 08:14:39 +1100 (EST)
Message-ID: <512004CB.5050108@mail.ru>
Date: Sat, 16 Feb 2013 23:14:35 +0100
From: Phileas Fogg <phileas-fogg@mail.ru>
MIME-Version: 1.0
To: Phileas Fogg <phileas-fogg@mail.ru>
Subject: Re: PS3: Strange issue with kexec and FreeBSD loader
References: <1360365046.495584377@f356.mail.ru> <511F652F.4090508@mail.ru>
In-Reply-To: <511F652F.4090508@mail.ru>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Phileas Fogg wrote:
> I was able to capture the debug output from the purgatory code and it's very odd.
>
> This the SHA256 digest calculated by kexec-tools:
>
> root@ps3-linux:~# kexec -l loader.ps3
> Warning: append= option is not passed. Using the first kernel root partition
> Modified cmdline:
> Unable to find /proc/device-tree//chosen/linux,stdout-path, printing from
> purgatory is diabled
> segment[0].mem:0x131d000 memsz:262144
> segment[1].mem:0x135d000 memsz:36864
> segment[2].mem:0x7fff000 memsz:4096
> sha256_digest: 77 d5 30 a7 67 5f 67 93 f1 e0 ce 84 bd 4e 1b ec 3c 4a 9e 86 5c a1
> 33 87 9e b1 5f c8 91 ce e8 61
>
>
> And this is the debug output i'm always getting from the purgatory code:
>
> I'm in purgatory
> sha256 digests do not match :(
>         digest: fd 4f df a8 af 5b e1 6b bc 51 5d b8 ab be 75 fb 76 fd 64 64 26
> 3e a8 9f 46 ec 91 de 05 4e 72 78
> sha256_digest: 00 39 e3 b2 45 0d 20 68 74 c2 4e ee e4 4a cf ec c3 78 4f 1c 65 ff
> a8 76 73 68 5d 01 70 0b b6 50
>
> regards
>
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev

I was able to analyze the problem more and found out that the device tree memory 
region gets corrupted. I slightly modified kexec-tools and made it first compute 
a checksum of the first segment only where the new kernel is located.
And the checksum was always verified as correct in the purgatoroy code.
Then i made kexec-tools compute the checksum of the 3rd segment only where a 
device tree is stored. And this time the verify function in the purgatory failed 
always.

Output form the purgatory code:
--------------------------------

I'm in purgatory
sha256 digests do not match :(
        digest: e3 b0 c4 42 98 fc 1c 14 9a fb f4 c8 99 6f b9 24 27 ae 41 e4 64 
9b 93 4c a4 95 99 1b 78 52 b8 55
sha256_digest: 57 08 81 e7 62 c3 22 2f d9 1d 94 a5 d0 f7 53 8f fe 69 64 84 4d 71 
2d aa e2 07 45 b3 78 79 6e 26
sha256_regions:
start=0x0000000007fff000 len=0x0000000000001000

The sha256_digest is actually the correct SHA256 checksum precomputed by 
kexec-tools when the new kernel was given to the old kernel.

I will try to analyze the problem more later.

regards
