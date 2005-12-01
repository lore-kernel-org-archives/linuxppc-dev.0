Return-Path: <lagrange@fr.oleane.com>
Received: from relay03s.clb.oleane.net (relay03s.clb.oleane.net
	[213.56.31.144]) by ozlabs.org (Postfix) with ESMTP id 7235A6885E
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  2 Dec 2005 04:54:37 +1100 (EST)
Received: from smtp4.clb.oleane.net (smtp4.clb.oleane.net [213.56.31.20])
	by relay03s.clb.oleane.net with ESMTP id jB1HsWvT003139
	for <linuxppc-embedded@ozlabs.org>; Thu, 1 Dec 2005 18:54:35 +0100
Received: from GEG2400 ([62.160.30.216]) (authenticated)
	by smtp4.clb.oleane.net with ESMTP id jB1HhibN001378
	for <linuxppc-embedded@ozlabs.org>; Thu, 1 Dec 2005 18:43:49 +0100
From: "Laurent Lagrange" <lagrange@fr.oleane.com>
To: <linuxppc-embedded@ozlabs.org>
Date: Thu, 1 Dec 2005 18:47:46 +0100
Message-ID: <000001c5f69f$580e6ae0$5201a8c0@GEG2400>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: 
Subject: PPC 32bits and big RAM mapping problem
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hello,

I have a PPC board with an address width fixed to 32bits, so I can address
4GB.

   M          M        M         M          M          M           M
  0          0        0         0          0          1           e
 0          2        8         c          e          e           f
 ---------------------------------------------------------------------------
---
 | Physical |        | PCI     | Kernel   | Kernel   | User      |
Peripheral |
 | RAM      | unused | memory  | memory   | reserved | memory    | mapping
|
 |          |        |         | kmalloc  |          | vmalloc   |
|
 | ex 512MB |        | ex 1GB  | ex 512MB | 16MB     |           | ex 32MB
|
 |      2GB max      | 1GB max | max ?    |          | 464MB max |
|
 ---------------------------------------------------------------------------
---
                              (0)                   (1)         (2)

00M stand for 0x00000000
(0) kernel_base
(1) vmalloc_start
(2) vmalloc_end

The exemple above shows a classical(?) mapping with a physical RAM of 512MB.
The physical RAM can growth up to 2GB, but if the kernel maps a Kernel
memory
of 2GB, there is no more place for the other items. The 4GB are eated.

Even with only 512MB of RAM, the kernel can't fully vmalloc it for user.

I know that the kernel and drivers kmalloc in Kernel memory which has the
full
space but when the users wants more RAM, it is for vmallocations.
Now when the physical RAM increases, the User memory is reduced for vmalloc.
And I don't talk about Peripheral mappings which also reduce the User
memory.

So I'm under the impression to be cornered in my shoes.
Any idea, book, article, prediction would be welcome.

Thanks
Laurent
