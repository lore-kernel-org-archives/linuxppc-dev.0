Return-Path: <peter@hurleysoftware.com>
Received: from n23.mail01.mtsvc.net (mailout32.mail01.mtsvc.net [216.70.64.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EE8601A003B
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Sep 2014 22:31:19 +1000 (EST)
Message-ID: <5409AD0A.5090305@hurleysoftware.com>
Date: Fri, 05 Sep 2014 08:31:06 -0400
From: Peter Hurley <peter@hurleysoftware.com>
MIME-Version: 1.0
To: David Laight <David.Laight@ACULAB.COM>,
 "'paulmck@linux.vnet.ibm.com'" <paulmck@linux.vnet.ibm.com>
Subject: Re: bit fields && data tearing
References: <54079B70.4050200@hurleysoftware.com>
 <1409785893.30640.118.camel@pasglop>
 <21512.10628.412205.873477@gargle.gargle.HOWL>
 <20140904090952.GW17454@tucnak.redhat.com>
 <540859EC.5000407@hurleysoftware.com>
 <20140904175044.4697aee4@alan.etchedpixels.co.uk>
 <5408C0AB.6050801@hurleysoftware.com>
 <20140905001751.GL5001@linux.vnet.ibm.com>
 <1409883098.5078.14.camel@jarvis.lan> <5409243C.4080704@hurleysoftware.com>
 <20140905040645.GO5001@linux.vnet.ibm.com>
 <063D6719AE5E284EB5DD2968C1650D6D17487F66@AcuExch.aculab.com>
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6D17487F66@AcuExch.aculab.com>
Content-Type: text/plain; charset=utf-8
Cc: Jakub Jelinek <jakub@redhat.com>,
 One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>,
 Tony Luck <tony.luck@intel.com>,
 "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
 Mikael Pettersson <mikpelinux@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Oleg Nesterov <oleg@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 Paul Mackerras <paulus@samba.org>,
 "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
 linux-arm@vger.kernel.org,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Miroslav Franc <mfranc@redhat.com>, Richard Henderson <rth@twiddle.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

[ +cc linux-arm ]

Hi David,

On 09/05/2014 04:30 AM, David Laight wrote:
> I've seen gcc generate 32bit accesses for 16bit structure members on arm.
> It does this because of the more limited range of the offsets for the 16bit access.
> OTOH I don't know if it ever did this for writes - so it may be moot.

Can you recall the particulars, like what ARM config or what code?

I tried an overly-simple test to see if gcc would bump up to the word load for
the 12-bit offset mode, but it stuck with register offset rather than immediate
offset. [I used the compiler options for allmodconfig and a 4.8 cross-compiler.]

Maybe the test doesn't generate enough register pressure on the compiler?

Regards,
Peter Hurley

#define ARRAY_SIZE(x)  (sizeof(x)/sizeof((x)[0]))

struct x {
	long unused[64];
	short b[12];
	int unused2[10];
	short c;
};

void store_c(struct x *p, short a[]) {
	int i;

	for (i = 0; i < ARRAY_SIZE(p->b); i++)
		p->b[i] = a[i];
	p->c = 2;
}


void store_c(struct x *p, short a[]) {
   0:	e1a0c00d 	mov	ip, sp
   4:	e3a03000 	mov	r3, #0
   8:	e92dd800 	push	{fp, ip, lr, pc}
   c:	e24cb004 	sub	fp, ip, #4
	int i;

	for (i = 0; i < ARRAY_SIZE(p->b); i++)
		p->b[i] = a[i];
  10:	e191c0b3 	ldrh	ip, [r1, r3]
  14:	e0802003 	add	r2, r0, r3
  18:	e2822c01 	add	r2, r2, #256	; 0x100
  1c:	e2833002 	add	r3, r3, #2
  20:	e3530018 	cmp	r3, #24
  24:	e1c2c0b0 	strh	ip, [r2]
  28:	1afffff8 	bne	10 <store_c+0x10>
	p->c = 2;
  2c:	e3a03d05 	mov	r3, #320	; 0x140
  30:	e3a02002 	mov	r2, #2
  34:	e18020b3 	strh	r2, [r0, r3]
  38:	e89da800 	ldm	sp, {fp, sp, pc}
