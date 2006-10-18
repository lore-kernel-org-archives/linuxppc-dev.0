Return-Path: <nd@bplan-gmbh.de>
Received: from natklopstock.rzone.de (natklopstock.rzone.de [81.169.145.174])
	by ozlabs.org (Postfix) with ESMTP id 03209679F0
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Oct 2006 15:54:10 +1000 (EST)
Message-ID: <4535C0F8.1070905@bplan-gmbh.de>
Date: Wed, 18 Oct 2006 07:51:52 +0200
From: Nicolas DET <nd@bplan-gmbh.de>
MIME-Version: 1.0
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] enable RTAS /proc for PowerPC/CHRP platform
References: <4534BE9D.7030908@bplan-gmbh.de> <20061017132243.GA6773@lst.de>
In-Reply-To: <20061017132243.GA6773@lst.de>
Content-Type: multipart/mixed; boundary="------------090401030109080607050908"
Cc: akpm@osdl.org, linuxppc-dev@ozlabs.org, Sven Luther <sl@bplan-gmbh.de>,
	tilmann@bitterberg.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------090401030109080607050908
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Christoph Hellwig wrote:
 >> --- a/arch/powerpc/kernel/rtas-proc.c    2006-10-14 
05:34:03.000000000 +0200
 >> +++ b/arch/powerpc/kernel/rtas-proc.c    2006-10-16 
10:46:16.000000000 +0200
 >> @@ -253,43 +253,70 @@ static void get_location_code(struct seq
 >>  static void check_location_string(struct seq_file *m, char *c);
 >>  static void check_location(struct seq_file *m, char *c);
 >>
 >> +#ifdef CONFIG_PPC64
 >> +#define PROCRTAS_ROOT "ppc64"
 >> +#else
 >> +#define PROCRTAS_ROOT "ppc"
 >
 > Please don't do any pathname changes.  Even if ppc64 isn't correct it's
 > what applications expect and what we should provide for a coherent user
 > interface.

Humm, ok.
However, in this case 'ppc' (could be 32 or 64 as it is not specified) 
is more generic than 'ppc64'.

 > This should be the only change you need, and it should follow kernel
 > coding style, aka:
 >
 >     if (!machine_is(pseries) && !machine_is(chrp))
 >         return -ENODEV;
 >
 >>      rtas_node = of_find_node_by_name(NULL, "rtas");
 >>      if (rtas_node == NULL)
 >>          return -ENODEV;
 >
 > And given this check I wonder why we need the platform check at all.  It
 > should be safe to just remove it.
 >
 >

Indeed, however I can only test on CHRP. I'll remove the check in the 
upcomming patch.

The patch also include a small code to create the /proc/ppc/rtas entry. 
Should this be done here, or somewhere in arch/powerpc/chrp/setup.c ?

I will re submit a patch as soon as I can.

--------------090401030109080607050908
Content-Type: text/x-vcard; charset=utf-8;
 name="nd.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="nd.vcf"

begin:vcard
fn:Nicolas DET ( bplan GmbH )
n:DET;Nicolas
org:bplan GmbH
adr:;;;;;;Germany
email;internet:nd@bplan-gmbh.de
title:Software Entwicklung
tel;work:+49 6171 9187 - 31
x-mozilla-html:FALSE
url:http://www.bplan-gmbh.de
version:2.1
end:vcard


--------------090401030109080607050908--
