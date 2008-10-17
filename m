Return-Path: <mingo@elte.hu>
Received: from mx3.mail.elte.hu (mx3.mail.elte.hu [157.181.1.138])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E559DDDEFD
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Oct 2008 22:10:10 +1100 (EST)
Date: Fri, 17 Oct 2008 13:09:45 +0200
From: Ingo Molnar <mingo@elte.hu>
To: David Miller <davem@davemloft.net>
Subject: Re: powerpc allmodconfig
Message-ID: <20081017110945.GA32364@elte.hu>
References: <20081015213337.a99a9595.akpm@linux-foundation.org>
	<20081015.220247.262683261.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20081015.220247.262683261.davem@davemloft.net>
Cc: bzolnier@gmail.com, marek.vasut@gmail.com, tiwai@suse.de,
	netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org, ralf@linux-mips.org,
	mark.fasheh@oracle.com, linuxppc-dev@ozlabs.org,
	linux-ide@vger.kernel.org, akpm@linux-foundation.org,
	linux-ext4@vger.kernel.org, dwmw2@infradead.org,
	dan.j.williams@intel.com, mchehab@infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


* David Miller <davem@davemloft.net> wrote:

> > net/dccp/options.c: In function 'dccp_parse_options': 
> > net/dccp/options.c:67: warning: 'value' may be used uninitialized in 
> > this function
> 
> Known issue, not trivial to fix, gcc is just being incredibly silly 
> here as it can't see all of the control flow.

i just ran into this - do you have any objection against the patch 
below?

Should we have a cleaner annotation perhaps instead of 
uninitialized_var()? Something like:

 #define __used          __attribute__((used))

?

	Ingo

---------->
>From d917af0bd043eab40d57f79cba9cf7a7b265a205 Mon Sep 17 00:00:00 2001
From: Ingo Molnar <mingo@elte.hu>
Date: Fri, 17 Oct 2008 12:41:30 +0200
Subject: [PATCH] fix warning in net/dccp/options.c
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

fix this warning:

  net/dccp/options.c: In function ‘dccp_parse_options’:
  net/dccp/options.c:67: warning: ‘value’ may be used uninitialized in this function

This is a bogus GCC warning. The compiler does not recognize the relation
between "value" and "mandatory" variables: the code flow can ever reach
the "out_invalid_option:" label if 'mandatory' is set to 1, and when
'mandatory' is non-zero, we'll always have 'value' initialized.

Help out the compiler by annotating the variable.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 net/dccp/options.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/net/dccp/options.c b/net/dccp/options.c
index 0809b63..18dcfb9 100644
--- a/net/dccp/options.c
+++ b/net/dccp/options.c
@@ -64,7 +64,7 @@ int dccp_parse_options(struct sock *sk, struct dccp_request_sock *dreq,
 					(dh->dccph_doff * 4);
 	struct dccp_options_received *opt_recv = &dp->dccps_options_received;
 	unsigned char opt, len;
-	unsigned char *value;
+	unsigned char *uninitialized_var(value);
 	u32 elapsed_time;
 	__be32 opt_val;
 	int rc;
