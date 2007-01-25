Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.183]) by ozlabs.org (Postfix) with ESMTP id 2BCD4DDEE1
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Jan 2007 17:19:56 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 8/14] ps3: bind interrupt to cpu
Date: Thu, 25 Jan 2007 07:19:40 +0100
References: <45B8188A.5070900@am.sony.com>
In-Reply-To: <45B8188A.5070900@am.sony.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200701250719.40808.arnd@arndb.de>
Cc: paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 25 January 2007 03:40, Geoff Levand wrote:
> +struct ps3_bmp {
> +=A0=A0=A0=A0=A0=A0=A0struct {
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0unsigned long status;
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0unsigned long unused_1[3];
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0unsigned long mask;
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0unsigned long unused_2[3];
> +=A0=A0=A0=A0=A0=A0=A0} __attribute__ ((aligned (64)));
> +
> +=A0=A0=A0=A0=A0=A0=A0spinlock_t lock;
> +=A0=A0=A0=A0=A0=A0=A0unsigned long ipi_debug_brk_mask;
> +};
> +
> +struct ps3_private {
> +=A0=A0=A0=A0=A0=A0=A0struct ps3_bmp bmp;
> +=A0=A0=A0=A0=A0=A0=A0unsigned long node;
> +=A0=A0=A0=A0=A0=A0=A0unsigned int cpu;
> +};

This layout has some unnecessary padding in it. It turns out as:

status
unused_1
mask
unused_2
lock
/* 4 bytes pad */
ipi_debug_brk_mask
/* 48 bytes pad */
node
cpu

which you probably did not indent.

If 'status' needs to be aligned by 64 bytes, you can better express
this as

struct ps3_bmp {
       struct {
               unsigned long status;
               unsigned long unused_1[3];
               unsigned long mask;
               unsigned long unused_2[3];
       };

       unsigned long ipi_debug_brk_mask;
       spinlock_t lock;
};

struct ps3_private {
       struct ps3_bmp bmp __attribute__ ((aligned (64)));
       unsigned long node;
       unsigned int cpu;
};

which should reduce the size of your structure from 192 bytes to 64.

	Arnd <><
