Return-Path: <shawnxjin@gmail.com>
Received: from mail-iw0-f170.google.com (mail-iw0-f170.google.com
	[209.85.214.170]) by ozlabs.org (Postfix) with ESMTP id 95A071007D3
	for <linuxppc-dev@ozlabs.org>; Mon,  2 Aug 2010 16:34:41 +1000 (EST)
Received: by iwn36 with SMTP id 36so4057269iwn.15
	for <linuxppc-dev@ozlabs.org>; Sun, 01 Aug 2010 23:34:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <AANLkTim0pD9LWEgWjX4QvqUkZkYO3YOeELz_XjNJPDft@mail.gmail.com>
References: <AANLkTinKb8E_McVAv5epg+4acb8H1+8HNsKHJYDr9B10@mail.gmail.com>
	<20100730120424.6db4139f@schlenkerla.am.freescale.net>
	<AANLkTim0pD9LWEgWjX4QvqUkZkYO3YOeELz_XjNJPDft@mail.gmail.com>
Date: Sun, 1 Aug 2010 23:34:39 -0700
Message-ID: <AANLkTi=mq_vnUkrdmTeKjtfO3DQLKRESxzEBiK3jeTpV@mail.gmail.com>
Subject: Re: ramdisk size is larger than 4MB
From: Shawn Jin <shawnxjin@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: ppcdev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>> It should be fine to just change it locally. =A0It would be a problem to
>> change it upstream for all boards, since some supported boards have
>> only 16MB (or even 8MB) of RAM.
>
> I'll definitely try to change it locally first. Would a configurable
> base address for the bootwrapper an acceptable solution?

I found the link_address in the wrapper shell script sets the _start
address. But after changing it to 0x800000, the kernel failed to boot,
shown below. There must be something also needs proper adjustment.
What would that be?

=3D> bootm 4000000
## Booting image at 04000000 ...
   Image Name:   Linux-2.6.33.5
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    1757356 Bytes =3D  1.7 MB
   Load Address: 00800000
   Entry Point:  00800554
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
Memory <- <0x0 0x8000000> (128MB)
ENET0: local-mac-address <- 00:09:9b:01:58:64
CPU clock-frequency <- 0x7270e00 (120MHz)
CPU timebase-frequency <- 0x7270e0 (8MHz)
CPU bus-frequency <- 0x3938700 (60MHz)

zImage starting: loaded at 0x00800000 (sp: 0x07d1cbd0)
Allocating 0x3a15a4 bytes for kernel ...
gunzipping (0x00000000 <- 0x0080c000:0x00bd702c)...done 0x3886ec bytes

Linux/PowerPC load: root=3D/dev/ram
Finalizing device tree... flat tree at 0xbe4300

Thanks a lot,
-Shawn.
