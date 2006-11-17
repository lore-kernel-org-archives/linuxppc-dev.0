Return-Path: <Geert.Uytterhoeven@sonycom.com>
Date: Fri, 17 Nov 2006 06:21:12 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Paul Mackerras <paulus@samba.org>, Jeremy Kerr <jk@ozlabs.org>
Subject: Re: [PATCH] setup_kcore(): Fix incorrect function name in panic()
	call.
In-Reply-To: <Pine.LNX.4.62.0611170506510.16998@pademelon.sonytel.be>
Message-ID: <Pine.LNX.4.62.0611170620240.16998@pademelon.sonytel.be>
References: <Pine.LNX.4.62.0611170446250.16998@pademelon.sonytel.be>
	<200611171458.11245.jk@ozlabs.org>
	<Pine.LNX.4.62.0611170506510.16998@pademelon.sonytel.be>
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

On Fri, 17 Nov 2006, Geert Uytterhoeven wrote:
> On Fri, 17 Nov 2006, Jeremy Kerr wrote:
> > 
> > > -			panic("mem_init: kmalloc failed\n");
> > > +			panic("setup_kcore: kmalloc failed\n");
> > 
> > How about:
> > 	
> > 	panic("%s: kmalloc_failed\n", __FUNCTION__);
> > 
> > To prevent this happening again?
> 
> You're right, thanks for the suggestion!

Updated patch below:
---

Subject: [PATCH] setup_kcore(): Fix incorrect function name in panic() call.

setup_kcore(): Fix incorrect function name in panic() call.

Signed-Off-By: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>

--- linux-ps3-geert.orig/arch/powerpc/mm/init_64.c	2006-11-15 10:05:17.000000000 +0900
+++ linux-ps3-geert/arch/powerpc/mm/init_64.c	2006-11-17 12:36:49.000000000 +0900
@@ -130,7 +130,7 @@ static int __init setup_kcore(void)
 		/* GFP_ATOMIC to avoid might_sleep warnings during boot */
 		kcore_mem = kmalloc(sizeof(struct kcore_list), GFP_ATOMIC);
 		if (!kcore_mem)
-			panic("mem_init: kmalloc failed\n");
+			panic("%s: kmalloc failed\n", __FUNCTION__);
 
 		kclist_add(kcore_mem, __va(base), size);
 	}


Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Sony Network and Software Technology Center Europe (NSCE)
Geert.Uytterhoeven@sonycom.com ------- The Corporate Village, Da Vincilaan 7-D1
Voice +32-2-7008453 Fax +32-2-7008622 ---------------- B-1935 Zaventem, Belgium
