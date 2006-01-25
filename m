Return-Path: <lagrange@fr.oleane.com>
Received: from relay02s.clb.oleane.net (relay02s.clb.oleane.net
	[213.56.31.143]) by ozlabs.org (Postfix) with ESMTP id E00EF68A1B
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 26 Jan 2006 00:57:12 +1100 (EST)
Received: from smtp9.clb.oleane.net (smtp9.clb.oleane.net [213.56.31.31])
	by relay02s.clb.oleane.net with ESMTP id k0PDpOvn024757
	for <linuxppc-embedded@ozlabs.org>; Wed, 25 Jan 2006 14:51:43 +0100
Received: from GEG2400 ([194.3.133.184]) (authenticated)
	by smtp9.clb.oleane.net with ESMTP id k0PDgtL5004658
	for <linuxppc-embedded@ozlabs.org>; Wed, 25 Jan 2006 14:43:00 +0100
From: "Laurent Lagrange" <lagrange@fr.oleane.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: Misunderstanding with function cpm_dpalloc in Linux 2.6.x
Date: Wed, 25 Jan 2006 14:48:05 +0100
Message-ID: <000001c621b5$f8e45ab0$5201a8c0@GEG2400>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: 
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

I work on MPC boards with Linux 2.6.9 and I have a problem with the
cpm_dpalloc function.

In the file cpm2_common.c the function "uint cpm_dpalloc(uint size, uint
align)" is intended
to allocate a piece of memory in the dpram. This piece of memory has at
least "size" bytes
and I beleived that the returned address should be aligned on "align" bytes.

This function calls "void *rh_alloc(rh_info_t * info, int size, const char
*owner)" from rheap.c file.
In this function the alignment is only used to calculate the right size with
the formula :
size = (size + (info->alignment - 1)) & ~(info->alignment - 1);
It seems to be right but the alignment is not used to retreive an aligned
start address.

So if I do the following sequential calls, I have the following results :
cpm_dpalloc(16, 8)	-> 	0XC0		-> right aligned
cpm_dpalloc(64, 64)	-> 	0XD0		-> wrong aligned -> must be 0x100
cpm_dpalloc(16, 8)	-> 	0X110		-> right aligned but wrong to use
cpm_dpalloc(24, 8)	-> 	0X1200		-> right aligned but wrong to use

I can have the wanted values if instead of size, I try to allocate (size +
align - 1) bytes
but I don't think it is the solution.

Perhaps, I don't understand the allocation theory.
Any idea ?

Thanks all
Laurent
