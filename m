Return-Path: <panto@intracom.gr>
Received: from mailserv.intranet.gr (mailserv.intranet.GR [146.124.14.106])
	by ozlabs.org (Postfix) with ESMTP id 1A14F67A33
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  5 Apr 2005 17:19:46 +1000 (EST)
Received: from mailserv.intranet.gr (localhost [127.0.0.1])
	by mailserv.intranet.gr (8.13.1/8.13.1) with ESMTP id j357Ni4I029935
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 5 Apr 2005 10:23:46 +0300 (EEST)
Message-ID: <4252397C.2050308@intracom.gr>
Date: Tue, 05 Apr 2005 10:08:44 +0300
From: Pantelis Antoniou <panto@intracom.gr>
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
References: <20050404191718.GA30281@logos.cnet>
	<20050404200922.GC30252@logos.cnet>
In-Reply-To: <20050404200922.GC30252@logos.cnet>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Paul Mackerras <paulus@samba.org>,
	linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: 8xx v2.6 TLB problems and suggested workaround
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Marcelo Tosatti wrote:
> Hum,
> 
> The machine seems to be acting strange, but it boots normally 
> and applications run (more importantly there is no TLB entry 
> which could cause dcbst fault strangeness).
> 
> Some "dd" hangs till I press "ctrl+c", others just work. Really strange. 
> 
> G'night, I'll look at it tomorrow.
>  
> [root@(none) /]# time dd if=/dev/zero of=file bs=16k count=400
> 400+0 records in
> 400+0 records out
>                                                                                         
> real    0m4.261s
> user    0m0.040s
> sys     0m1.240s
> [root@(none) /]# time dd if=/dev/zero of=file bs=32k count=400
>                                                                                         
>                                                                                         
> real    0m50.369s
> user    0m0.040s
> sys     0m1.680s  (ctrl+c)
> [root@(none) /]# 
> 
> 

I can confirm that the patch works.

I no longer need the tlbie in update_mmu_cache.

/tmp # time dd if=/dev/zero of=file bs=16k count=400
400+0 records in
400+0 records out
real    0m 0.55s
user    0m 0.01s
sys     0m 0.52s

/tmp is tmpfs

Well done Marcelo!

Regards

Pantelis

P.S. CPU errata perhaps?
