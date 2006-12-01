Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (unknown [80.88.33.193])
	by ozlabs.org (Postfix) with ESMTP id 7B62567BB2
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Dec 2006 01:25:15 +1100 (EST)
Date: Fri, 1 Dec 2006 15:25:08 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: linux-sparse@vger.kernel.org
Subject: cast truncates bits from constant value (8000000000000000 becomes 0)
In-Reply-To: <4563D00D.4010704@am.sony.com>
Message-ID: <Pine.LNX.4.62.0612011516120.28210@pademelon.sonytel.be>
References: <4563D00D.4010704@am.sony.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 21 Nov 2006, Geoff Levand wrote:
> +enum ps3_vendor_id {
> +	PS3_VENDOR_ID_NONE = 0,
> +	PS3_VENDOR_ID_SONY = 0x8000000000000000UL,
> +};

I've just ran `make C=1' (PPC in 64-bit mode, and sparse is called with -m64),
and noticed that sparse (cloned from
git://git.kernel.org/pub/scm/devel/sparse/sparse.git a few minutes ago)
complains about the second value with:

| warning: cast truncates bits from constant value (8000000000000000 becomes 0)

Section 6.7.2.2.4 of C99 says:

| Each enumerated type shall be compatible with char, a signed integer type, or
| an unsigned integer type. The choice of type is implementation-defined, but
| shall be capable of representing the values of all the members of the
| enumeration.

The code snippet

| u64 x = PS3_VENDOR_ID_SONY;
| printk("PS3_VENDOR_ID_SONY = %lu\n", x);

does print the expected (i.e. non-zero) result.

Hence this looks like a bug in sparse.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Sony Network and Software Technology Center Europe (NSCE)
Geert.Uytterhoeven@sonycom.com ------- The Corporate Village, Da Vincilaan 7-D1
Voice +32-2-7008453 Fax +32-2-7008622 ---------------- B-1935 Zaventem, Belgium
