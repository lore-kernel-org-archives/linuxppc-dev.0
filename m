Return-Path: <daniel.gutson@motorola.com>
Received: from mail119.messagelabs.com (mail119.messagelabs.com
	[216.82.241.179]) by ozlabs.org (Postfix) with SMTP id 2A233DECAF
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 16 Apr 2008 02:25:21 +1000 (EST)
Received: from az33exr02.mot.com (az33exr02.mot.com [10.64.251.232])
	by motgate5.mot.com (8.12.11/Motorola) with ESMTP id m3FGPIS1013948
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 15 Apr 2008 09:25:18 -0700 (MST)
Received: from az10vts04.mot.com (az10vts04.mot.com [10.64.251.245])
	by az33exr02.mot.com (8.13.1/Vontu) with SMTP id m3FGPHXg025152
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 15 Apr 2008 11:25:18 -0500 (CDT)
Received: from ct11exm66.ds.mot.com (ct11exm66.am.mot.com [10.177.8.54])
	by az33exr02.mot.com (8.13.1/8.13.0) with ESMTP id m3FGPGZw025132
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 15 Apr 2008 11:25:17 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: io_block_mapping & ioremap question
Date: Tue, 15 Apr 2008 12:25:14 -0400
Message-ID: <0539F2514A979C4B9386FF81809203FF016B6540@ct11exm66.ds.mot.com>
From: "Gutson Daniel-ADG035" <daniel.gutson@motorola.com>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,
	I'm doing some work on 2.6.10, and got this problem:
- there are some io_block_mapping calls in the setup_io_mapping
callback, that use the BATs, and passing same va and pa each one.
Problem arises later when vmallocs gets a a pointer within the mapped
ranges. In other words, seems like the VMM is not aware of the BATs
mapping.

So what I did is: called first ioremap and then io_block_mapping in the
callback thus not hardcoding the va, something like:
	va =3D ioremap(pa, size);
	io_block_mapping(pa, va, size);

Questions:
	1) Is it right?
	2) Should I unmap that address sometime later? (i.e. after
mem_init_done).

Thanks!
	Daniel.

=20
Daniel F. Gutson
Software Engineer
Motorola GSG Argentina
Tel =3D (54)-351-420-9218
Fax =3D (54)-351-420-9202
=20
iProtect Classification
[x] Public
[ ] Internal
[ ] Motorola Confidential Restricted

=20
"we made a big mistake in coming down from the trees in the first place"
- D. Adams
